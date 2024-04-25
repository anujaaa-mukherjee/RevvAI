import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revvai/login/auth_methods.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthMethods auth = AuthMethods();

  late String selectedClass;
  late String selectedExam;
  late String gender;
  late String mobileNumber;
  late String email;
  int age = 0;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = "";
    selectedClass = "Class 11";
    selectedExam = "JEE";
    gender = "Male";
    mobileNumber = "";
  }

  void _refreshForm() {
    setState(() {
      _formKey.currentState?.reset();
      nameController.clear();
      age = 0;
      selectedClass = "Class 11";
      selectedExam = "JEE";
      gender = "Male";
      mobileNumber = "";
      email = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: SizedBox(
              width: 60.67,
              height: 160.0,
              child: Image.asset('assets/images/revv.png'),
            ),
          ),
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome,',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "A few more and you're all set!", // Additional text
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Name', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Name Here',
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
                                'Age', // Heading
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                width: 120.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      age = int.parse(value);
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
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
                                      setState(() {
                                        gender = value!;
                                      });
                                    },
                                  ),
                                  const Text('Male'),
                                  const SizedBox(width: 20),
                                  Radio(
                                    value: 'Female',
                                    groupValue: gender,
                                    onChanged: (String? value) {
                                      setState(() {
                                        gender = value!;
                                      });
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
                        'Class', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            setState(() {
                              selectedClass = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Select Class',
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
                        'Focus Exam', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: selectedExam,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedExam = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Select your target exam',
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
                        'Mobile Number', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              mobileNumber = value;
                            });
                          },
                          maxLength: 10,
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Mobile Number',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Email ID', // Heading
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Email Id',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 27.0),
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
                              icon: const Icon(Icons.refresh),
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (selectedClass == "" ||
                                    selectedExam == "" ||
                                    gender == "" ||
                                    mobileNumber == "" ||
                                    nameController.text == "" ||
                                    age == 0) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                                "All fields are required"),
                                            content: const Text(
                                                "Please fill all the fields."),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("OK"),
                                              ),
                                            ],
                                          ));
                                  return;
                                } else {
                                  print(nameController.text);
                                  print(age);
                                  print(gender);
                                  print(selectedClass);
                                  print(selectedExam);
                                  print("+91$mobileNumber");
                                  print(email);
                                  auth.register(
                                    context,
                                    nameController.text,
                                    age,
                                    gender,
                                    selectedClass,
                                    selectedExam,
                                    "+91$mobileNumber",
                                    email,
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blueAccent),
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
            ]),
          ),
        ));
  }
}
