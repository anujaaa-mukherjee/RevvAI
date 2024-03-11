// registration screen //


import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedClass;
  String? selectedStatus;
  String? gender;
  String? occupation;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void _refreshForm() {
    _formKey.currentState?.reset();
    nameController.clear();
    ageController.clear();
    selectedClass = null;
    selectedStatus = null;
    gender = null;
    occupation = null;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Container(
              child: SizedBox(
                width: 60.67,
                height: 160.0,
                child: Image.asset('assets/images/revv.png'),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome,',
                            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16.0),
                          const Text(
                            "A few more and you're all set!", // Additional text
                            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 20.0),
                          const Text(
                            'Name', // Heading
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter Your Name Here',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Age', // Heading
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    width: 120.0,
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: const TextField(
                                      keyboardType: TextInputType.number, // Set keyboard type to number
                                      decoration: InputDecoration(
                                        hintText: 'Enter Age in Years',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Gender', // Heading
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 'Male',
                                        groupValue: gender,
                                        onChanged: (String? value) {
                                          // Handle radio button selection
                                          gender = value;
                                        },
                                      ),
                                      Text('Male'),
                                      SizedBox(width: 20),
                                      Radio(
                                        value: 'Female',
                                        groupValue: gender,
                                        onChanged: (String? value) {
                                          // Handle radio button selection
                                          gender = value;
                                        },
                                      ),
                                      Text('Female'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          const Text(
                            'Class', // Heading
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: selectedClass,
                              onChanged: (String? newValue) {
                                // Handle dropdown value change
                                selectedClass = newValue;
                              },
                              onSaved: (value) {
                                selectedClass = value;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Select Status',
                                border: InputBorder.none,
                              ),
                              items: <String>['Class 11', 'Class 12']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          const Text(
                            'Focus Exam', // Heading
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: selectedStatus,
                              onChanged: (String? newValue) {
                                // Handle dropdown value change
                                selectedStatus = newValue;
                              },
                              onSaved: (value) {
                                selectedStatus = value;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Select Blood Group',
                                border: InputBorder.none,
                              ),
                              items: <String>['A+', 'B+', 'O+', 'AB+']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          const Text(
                            'Occupation', // Heading
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                occupation = value;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter Your occupation',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 27.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  onPressed: _refreshForm,
                                  icon: Icon(Icons.refresh),
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      // Handle submit button press
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.blueAccent),
                                  ),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          ),
        )
    );
  }
}

void main() {
  runApp(WelcomeScreen());
}