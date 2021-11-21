import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kx_store/widgets/background_widget.dart';

class OTPScreen extends StatefulWidget {
  final String? phoneNumber;

  OTPScreen({this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _verificationCode = '';
  String pin = '';
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + widget.phoneNumber.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationID, int? resendToken) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
      timeout: Duration(seconds: 120),
    );
  }

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            BackgroundWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/logo.png',
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'OTP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.grey[400]!,
                        offset: Offset(0, 5.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -10),
                          blurRadius: 10.0,
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),

                    // borderRadius: BorderRadius.only(topRight:Radius.circular(50),bottomRight:Radius.circular(50)),

                    child: TextFormField(
                        autofocus: true,
                        maxLength: 6,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.dialpad_rounded,
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 35),
                          hintText: 'Enter OTP',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            pin = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: RawMaterialButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signInWithCredential(
                                PhoneAuthProvider.credential(
                                    verificationId: _verificationCode,
                                    smsCode: pin));
                            Navigator.pop(context);
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => PersonalInfoForm(),
                            //   ),
                            // );
                          } catch (e) {
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Invalid OTP')));
                          }
                        },
                        fillColor: Colors.blue[400],
                        hoverColor: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done,
                            size: 40.0,
                            color: Colors.white,
                          ),
                        ),
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
