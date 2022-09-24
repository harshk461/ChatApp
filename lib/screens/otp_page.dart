import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class OTPPAge extends StatelessWidget {
  final String otp;
  OTPPAge({super.key, required this.otp});
  final otpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Verification Code",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "We Texted you a code\nPlease enter it below",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Colors.cyan,
                  showFieldAsBox: true,
                  onSubmit: (String verificationCode) {
                    otpcontroller.text = verificationCode;
                  }, // end onSub
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          const Size(200.0, 50.0),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepPurple),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        )),
                    onPressed: () {
                      print(otp);
                      if (otp == otpcontroller.text.toString().trim()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Failure")));
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
