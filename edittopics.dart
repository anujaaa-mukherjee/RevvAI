import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dialogTheme: DialogTheme(
          backgroundColor: Color(0xFFFED74C),
        ),
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  'Edit topics for revision',
                  style: GoogleFonts.lato(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: Color(0xFF2F80EC),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
          body: TopicSelection(),
        ),
      ),
    );
  }
}

class TopicSelection extends StatefulWidget {
  @override
  _TopicSelectionState createState() => _TopicSelectionState();
}

class _TopicSelectionState extends State<TopicSelection> {
  String? selectedSubject;
  String? selectedTopic;
  TextEditingController _textFieldController = TextEditingController();
  Map<String, List<String>> subjectsAndTopics = {
    'Physics': ['Topic 1', 'Topic 2', 'Topic 3'],
    'Chemistry': ['Topic A', 'Topic B', 'Topic C'],
    'Maths': ['Topic X', 'Topic Y', 'Topic Z'],
  };

  bool isEditingTopics = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Select Subject:',
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: subjectsAndTopics.keys.map<Widget>((String subject) {
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedSubject = subject;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedSubject == subject ? Color(0xFFFFD740) : Colors.white,
              ),
              child: Text(subject),
            );
          }).toList(),
        ),
        if (selectedSubject != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Topic for $selectedSubject:',
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TypeAheadField<String?>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        hintText: 'Select or type topic',
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return subjectsAndTopics[selectedSubject!]!.where((topic) => topic.toLowerCase().contains(pattern.toLowerCase())).toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion!),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        selectedTopic = suggestion;
                        _textFieldController.text = suggestion!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),
        if (isEditingTopics)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(320, 40),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Are you sure you want to confirm the selected topics :'),
                              SizedBox(height: 10),
                              Text(selectedTopic ?? 'None'),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isEditingTopics = true;
                                });
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: Text(
                                'Edit Topics',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: Text('Confirm',style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(320, 40),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
