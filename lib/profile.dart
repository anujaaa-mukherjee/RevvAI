import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revvai/provider/app_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedClass;
  String? selectedExam;
  String? gender;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isEditing = false; // Flag to track whether the form is in edit mode

  assignValues(context) {
    final provider = Provider.of<AppProvider>(context);

    selectedClass = provider.data.selectedClass;
    nameController.text = provider.data.name;
    ageController.text = provider.data.age.toString();
    contactController.text = provider.data.mobileNumber;
    gender = provider.data.gender;
    selectedExam = provider.data.selectedExam;
    emailController.text = provider.data.email;
  }

  @override
  Widget build(BuildContext context) {
    assignValues(context);
    return Scaffold(      
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Define what happens when the back arrow button is pressed
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color.fromARGB(235, 252, 207, 73),
                            width: 0.0,
                          ),
                        ),
                        child: TextFormField(
                          enabled: isEditing, // Toggle editability
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Name*',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
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
                              const SizedBox(height: 10.0),
                              Container(
                                width: 120.0,
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(235, 252, 207, 73),
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    color: const Color.fromARGB(235, 252, 207, 73),
                                    width: 0.0,
                                  ),
                                ),
                                child: TextFormField(
                                  enabled: isEditing, // Toggle editability
                                  keyboardType: TextInputType
                                      .number, // Set keyboard type to number
                                  controller: ageController,
                                  decoration: const InputDecoration(
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
                              const SizedBox(height: 10.0),
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
                                  const Text('Male'),
                                  const SizedBox(width: 20),
                                  Radio(
                                    value: 'Female',
                                    groupValue: gender,
                                    onChanged: (String? value) {
                                      // Handle radio button selection
                                      gender = value;
                                    },
                                  ),
                                  const Text('Female'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Class*', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color.fromARGB(235, 252, 207, 73),
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
                          items: <String>['Class 11', 'Class 12']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Focus Exam*', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color.fromARGB(235, 252, 207, 73),
                            width: 0.0,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: selectedExam,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedExam = newValue;
                            });
                          },
                          onSaved: (value) {
                            selectedExam = value;
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
                      const SizedBox(height: 20.0),
                      const Text(
                        'Occupation*', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color.fromARGB(235, 252, 207, 73),
                            width: 0.0,
                          ),
                        ),
                        child: TextFormField(
                          enabled: isEditing, // Toggle editability
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Email ID',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Contact*', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(235, 252, 207, 73),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: const Color.fromARGB(235, 252, 207, 73),
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
                      const SizedBox(height: 5.0),
                      Container(
                        padding: const EdgeInsets.all(20),
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
                              child: const Text(
                                '                   Edit Details                                ',
                                style: TextStyle(
                                    color: Colors.white), // Font color
                              ),
                            ),
                            const SizedBox(height: 5.0),
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
                              child: const Text(
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
      );
  }
}
