import "dart:async";
import "dart:developer";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:revvai/initial_screen.dart";
import "package:revvai/login/login_screen.dart";

class OtpScreen extends StatefulWidget {
  final String verificationid;
  final bool register;
  final String name;
  final int age;
  final String gender;
  final String selectedClass;
  final String selectedExam;
  final String mobileNumber;
  final String email;
  const OtpScreen({
    super.key,
    required this.verificationid,
    required this.register,
    required this.name,
    required this.age,
    required this.selectedClass,
    required this.selectedExam,
    required this.gender,
    required this.mobileNumber,
    required this.email,
  });

  @override
  State<OtpScreen> createState() => _OTPState();
}

class _OTPState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  String otp = '';
  Timer? _timer;
  int _countDown = 30;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), ((timer) {
      setState(() {
        if (_countDown == 0) {
          _countDown--;
        } else {
          canResend = true;
          _timer?.cancel();
        }
      });
    }));
  }

  void resendotp() {
    if (canResend) {
      setState(() {
        _countDown = 30;
        canResend = false;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Image.asset(
                          'assets/images/revv.png',
                          width: 90,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ]),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter OTP',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Please enter the OTP sent to your Adhaar Linked mobile number.',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '   Enter OTP',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: '   Enter Your OTP'),
                      ),
                      const SizedBox(height: 25),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: widget.verificationid,
                                      smsCode: otpController.text.toString());

                              FirebaseAuth.instance
                                  .signInWithCredential(credential)
                                  .then((value) {
                                if (widget.register == true) {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                      print(user!.uid);
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user.uid)
                                      .set({
                                    "name": widget.name,
                                    "age": widget.age,
                                    "gender": widget.gender,
                                    "selectedClass": widget.selectedClass,
                                    "selectedExam": widget.selectedExam,
                                    "mobileNumber": widget.mobileNumber,
                                    "email": widget.email,
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const InitialScreen(newRegister: true,))));
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const InitialScreen(newRegister: false,))));
                                }
                                
                              });
                            } catch (ex) {
                              log(ex.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size(500, 10),
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: const Text(
                            'VERIFY',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Center(
                          child: canResend
                              ? ElevatedButton(
                                  onPressed: () {
                                    resendotp();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    minimumSize: const Size(500, 30),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 130, 187, 233)),
                                    backgroundColor: Colors.blueAccent,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                  ),
                                  child: const Text(
                                    'RESEND OTP',
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : ElevatedButton(
                                  onPressed: () {
                                    // resendotp();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    minimumSize: const Size(500, 30),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 130, 187, 233)),
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                  ),
                                  child: const Text(
                                    'RESEND OTP',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 130, 187, 233)),
                                  ))),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(' Resend OTP in'),
                          Text(
                            '00:${_countDown.toString()}',
                            style: const TextStyle(color: Colors.blue),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: const Text(
                                'Change Mobile Number',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue),
                              ))
                        ],
                      )
                    ]))));
  }
}
