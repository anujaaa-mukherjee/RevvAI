import 'dart:convert';
import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
// import "package:google_fonts/google_fonts.dart";

class AssistanceScreen extends StatefulWidget {
  const AssistanceScreen({Key? key}) : super(key: key);

  @override
  State<AssistanceScreen> createState() => _AssistanceScreenState();
}

class _AssistanceScreenState extends State<AssistanceScreen> {
  late TextEditingController controller;
  String response = "";
  List<QnA> qnaList = [QnA(question: "Hii", answer: "How can i help you?")];
  String history = "";

   @override
  void initState() {
    controller = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Text(
              'Assistance',
              // style: GoogleFonts.lato(
              //   fontSize: 28.0,
              //   color: Colors.white,
              // ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2F80EC),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), // Adjust the value as needed
          ),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          response == "Loading" ? const Text("Loading....") : const SizedBox(),
          Expanded(
            child: ListView.builder(
                reverse: true,
                itemCount: qnaList.length,
                itemBuilder: ((context, index) {
                  const SizedBox(height: 10,);
                  return QnAContainer(qna: qnaList[index]);
                })),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: "Input",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              TextButton(
                  onPressed: () {
                    callapi(controller.text);
                    controller.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.black,
                  )),
            ],
          ),
        ]),
    );
  }


   callapi(String input) async {
    setState(() {
      response = "Loading...";
    });
    for (var i in qnaList) {
      history = '$history\n${i.question}';
    }
    var url = Uri.parse("https://api.openai.com/v1/chat/completions");

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
                  "You are a helpful assistant designed to output in paras or sentense.",
            },
            {
              "role" : "system",
              "content" : "Answer according to the previous questions and those are given each question is seperated by '\n' $history"
            },
            {"role": "user", "content": input},
          ],
          "model": "gpt-3.5-turbo",
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        }));

    print(res.body);

    if (res.statusCode == 200) {
      final jasonResponse = json.decode(res.body);
      setState(() {
        response = jasonResponse['choices'][0]['message']['content'];
        qnaList.insert(0, QnA(question: input, answer: response));
      });
    }
  }
}

class QnA {
  String question;
  String  answer;
  QnA({required this.question, required this.answer});
}

class QnAContainer extends StatelessWidget {
  final QnA qna;
  const QnAContainer({super.key, required this.qna});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 254, 215, 76),
      elevation: 0,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_circle_rounded, size: 25,color: Colors.black,),
              Expanded(child: Text(qna.question, textAlign: TextAlign.left, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_circle),
              const SizedBox(width: 2,),
              Expanded(child: Text(qna.answer, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black),)),
            ],
          ),
        ],
      ),
    );
  }
}
