import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kx_store/widgets/background_widget.dart';

import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPhoneValid = false;
  final _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

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
                  'Login',
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
                            color: Colors.grey.shade300)
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        // errorText:
                        //     isPhoneValid == false ? 'Enter a valid phone number' : null,
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 35),
                        prefixText: '+91 ',
                        hintText: 'Phone number',
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
                    ),
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
                        onPressed: () {
                          setState(() {
                            isPhoneValid = _controller.text.isEmpty ||
                                    _controller.text.length < 10
                                ? false
                                : true;
                          });
                          if (isPhoneValid) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    OTPScreen(phoneNumber: _controller.text),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter a valid phone number'),
                              ),
                            );
                          }
                        },
                        fillColor: Colors.blue[400],
                        hoverColor: Colors.blue,
                        child: Icon(
                          Icons.navigate_next_rounded,
                          size: 55.0,
                          color: Colors.white,
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
