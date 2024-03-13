import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key, required String title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                          //fontWeight: FontWeight.normal,
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
                      //const SizedBox(height: 1),
                      const TextField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: '   Enter Your OTP'),
                      ),
                      const SizedBox(height: 25),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
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
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            minimumSize: const Size(500, 30),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 130, 187, 233)),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                          ),
                          child: const Text(
                            'RESEND OTP',
                            style: TextStyle(
                                color: Color.fromARGB(255, 130, 187, 233)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(' Resend OTP in'),
                          ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'Change Mobile Number',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      )
                    ]))));
  }
}
