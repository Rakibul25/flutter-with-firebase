import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class HomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('Logout'),
          onPressed: () {
            auth.signOut();
            Get.to(LoginScreen());
          },
        ),
      ),
    );
  }
}
