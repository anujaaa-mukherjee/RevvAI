// profile //

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedClass;
  String? selectedStatus;
  String? gender;
  String? occupation;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  bool isEditing = false; // Flag to track whether the form is in edit mode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Define what happens when the back arrow button is pressed
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.white, fontSize: 30),
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
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Color.fromARGB(235, 252, 207, 73),
                            width: 0.0,
                          ),
                        ),
                        child: TextFormField(
                          enabled: isEditing, // Toggle editability
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Name*',
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
                                'Age*', // Heading
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                width: 120.0,
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(235, 252, 207, 73),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: Color.fromARGB(235, 252, 207, 73),
                                    width: 0.0,
                                  ),
                                ),
                                child: TextFormField(
                                  enabled: isEditing, // Toggle editability
                                  keyboardType: TextInputType
                                      .number, // Set keyboard type to number
                                  controller: ageController,
                                  decoration: InputDecoration(
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
                                'Gender*', // Heading
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
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
                        'Class*', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Color.fromARGB(235, 252, 207, 73),
                            width: 0.0,
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
                            hintText: '11th Standard',
                            border: InputBorder.none,
                          ),
                          items: <String>['11th Standard', '12th Standard']
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
                        'Focus Exam*', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Color.fromARGB(235, 252, 207, 73),
                            width: 0.0,
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
                            hintText: 'Select your focus exam',
                            border: InputBorder.none,
                          ),
                          items: <String>['JEE', 'NEET']
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
                        'Occupation*', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Color.fromARGB(235, 252, 207, 73),
                            width: 0.0,
                          ),
                        ),
                        child: TextFormField(
                          enabled: isEditing, // Toggle editability
                          controller: occupationController,
                          onChanged: (value) {
                            occupation = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter Your occupation',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      const Text(
                        'Contact*', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Color.fromARGB(235, 252, 207, 73),
                            width: 0.0,
                          ),
                        ),
                        child: TextFormField(
                          enabled: isEditing, // Toggle editability
                          keyboardType: TextInputType
                              .number, // Set keyboard type to number
                          controller: contactController,
                          decoration: const InputDecoration(
                            hintText: '+91 1234567890', // Placeholder text
                            border: InputBorder.none, // Remove border
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = true; // Enable editing mode
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // Button color
                                onPrimary: Colors.white, // Font color
                              ),
                              child: Text(
                                '                   Edit Details                                ',
                                style: TextStyle(
                                    color: Colors.white), // Font color
                              ),
                            ),
                            SizedBox(height: 5.0),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = false; // Disable editing mode
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // Button color
                                onPrimary: Colors.white, // Font color
                              ),
                              child: Text(
                                '                       Done                                    ',
                                style: TextStyle(
                                    color: Colors.white), // Font color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(ProfileScreen());
}
