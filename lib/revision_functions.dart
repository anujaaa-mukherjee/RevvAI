import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const openaiEndpoint = 'https://api.openai.com/v1/chat/completions';
User? user = FirebaseAuth.instance.currentUser;

generateContentForTopic(String topic, int type) async {
  try {
    String prompt;
    switch (type) {
      case 0:
        prompt =
            'Generate a detailed and simplified reading material on $topic for revision purpose related to IIT-JEE and after that give 5 questions based on that topic. give it in 2 keys in json format,  1st key is material which will be a map that contains 3 keys in which 1st key is introduction which will be a string value for introduction of that topic, 2nd key is explanation which will be a string that will contain explanation of that topic and 3rd key is real-life_example and it will be a string that contains a real life example that explains the topic better. and 2nd key in the main json map is short-quizze which is a list of maps for questions related to this topic and the inside map contains 4 keys 1st is question which is a string of question, 2nd is options which is a list of options for that question, 3rd is correct_answer which is a string of the correct answer from the options and 4th is explanation which is a string of detailed explanation of the answer. just directly give these 2 key as instructed in the json format. and give exactly what is instructed and how it is formated dont event change the names or spellings or the keys just give it as instructed and while giving the response take care of escape sequence also';
        break;
      case 1:
        prompt =
            'Provide real-life examples and previous year questions related to $topic for revision purpose related to IIT-JEE and give 5 questions and their answers with their explanation. Give it in 2 keys in the json format, 1st is real-life_examples which will be an array of strings of detailed explained real life examples to be understood by the student and 2nd is previous_year_questions which is a list of maps and the inside map contains 4 keys 1st is question which is a string of question, 2nd is options which is a list of options for that question, 3rd is correct_answer which is a string of the correct answer from the options and 4th is explanation which is a string of detailed explanation of the answer. just directly give these 2 key as instructed in the json format. and give exactly what is instructed and how it is formated dont event change the names or spellings or the keys just give it as instructed and while giving the response take care of escape sequence also';
        break;
      case 2:
        prompt =
            'Create quizzes related to $topic for revision purpose related to IIT-JEE and the quize should contain 10 multiple choice questions and also give their options and correct answer and its explanation too. give it in 1 key in json format that is questions which will be a list of maps and inside each map it will contain 4 keys, 1st is question which is a string of question, 2nd is options which is a list of options for that question, 3rd is correct_answer which is a string of the correct answer from the options and 4th is explanation which is a string of detailed explanation of the answer. just directly give that 1 key as instructed in the json format. and give exactly what is instructed and how it is formated dont event change the names or spellings or the keys just give it as instructed and while giving the response take care of escape sequence also';
        break;
      default:
        throw Exception('Invalid content type');
    }

    var url = Uri.parse(openaiEndpoint);

    final res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['token']}'
        },
        body: jsonEncode({
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a helpful assistant designed to output in json format. And you are helping for revisions of IIT-JEE preperation. Generate the response at once and Give the complete response fast at once only and dont give the response in chunks.",
            },
            {"role": "user", "content": prompt},
          ],
          "model": "gpt-3.5-turbo",
          "max_tokens": 4096,
          "temperature": 1,
          "top_p": 1,
        }));

    print(res.body);

    if (res.statusCode == 200) {
      final responseBody = res.bodyBytes;
      String response = utf8.decode(responseBody);
      print(response);
      final jsonResponse = jsonDecode(response);
      final finalresponse = jsonResponse['choices'][0]['message']['content'];
      print(finalresponse);
      await Future.delayed(const Duration(seconds: 2), () {});
      return [finalresponse, topic, type];
    }
  } catch (error) {
    throw Exception('Failed to generate content for $topic: $error');
  }
}

proficiency(double score, String topic, bool isQuestion) async {
  final data = await FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("topics")
      .doc(topic)
      .get();

  double count = data.data()!["revisionCount"].toDouble();
  int type = data.data()!["type"] == 2 ? 0 : data.data()!["type"] + 1;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

  if (isQuestion) {
    double oldProficiency = data.data()!["proficiency"].toDouble();

    double newProficiency = ((oldProficiency * count) + score) / (count + 1);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("topics")
        .doc(topic)
        .update({
      "proficiency": newProficiency,
      "revisionCount": count + 1,
      "type": type,
      "lastRevisionDate" : date,
    });
  } else {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("topics")
        .doc(topic)
        .update({
      "revisionCount": count + 1,
      "type": type,
      "lastRevisionDate" : date,
    });
  }
}
