import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              ClipOval(
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: Image.asset(
                    'assets/revv.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(''),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey!',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Poppin'),
              ),
              SizedBox(height: 1.0),
              Text(
                "Let's Get Started.",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Poppin'),
              ),
              SizedBox(height: 10),
              Text(
                'Please enter your mobile number to Sign Up with us and begin revision!',
                style: TextStyle(fontSize: 15, fontFamily: 'Poppin'),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mobile Number',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Poppin'),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide(color:Colors.blue,width: 1.0),
                  ),
                  hintText: 'Enter your mobile number',
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(context,MaterialPageRoute(builder: (context)=> _HomeState()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                      side: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'GET OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Or'),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(context,MaterialPageRoute(builder: (context)=> _HomeState()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                      side: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                  ),
                  child: Text(
                    'LOGIN HERE',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
