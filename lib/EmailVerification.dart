import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'CreatNewPassword.dart';



class CodeVerfication extends StatefulWidget {

  final String responseBody;

  const CodeVerfication({super.key, required this.responseBody});

  @override
  _CodeVerificationState createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerfication> {
  late String verificationCode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView(
        children: [
          SizedBox(height: 100,),
          Container(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // Code to handle navigation when the back icon is clicked
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Color(0xFF717579),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Email Verification',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF717579),
                  ),
                ),
                SizedBox(
                  width: 140,
                ),
              ],
            ),
          ),
        Container(
            margin: const EdgeInsets.fromLTRB(50, 50, 30, 0),

            child:   Text("Verify Email Address",   style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,

          ),)
        ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80,),
                const Text(
                  "Enter the verification code sent to your phone number",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30,),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: const Color(0xFF006C81),
                  fillColor: const Color(0xFF006C81).withOpacity(0.1),
                  filled: true,
                  showFieldAsBox: true,
                  onSubmit: (String code) {
                    print("code" + code);
                    verificationCode = code;

                    if (verificationCode == widget.responseBody) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateNewPassword()),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Incorrect Code"),
                            content: const Text("The entered code is incorrect."),
                          );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),


                const SizedBox(
                  height: 40,
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFF006C81), // Set the background color
                //       // Set the text color
                //     ),
                //     child: const Text("Next"),
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => CreateNewPassword()),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
