import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kx_store/screens/decide_role_screen.dart';
import 'package:kx_store/screens/login_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          Object? _user = snapshot.data;
          if (_user != null) {
            return DecideRoleScreen();
          } else {
            return LoginScreen();
          }
        }
    );
  }
}