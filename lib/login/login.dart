import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
              child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              textfieldcustom("Name?"),
              SizedBox(
                height: 10,
              ),
              textfieldcustom("Password?"),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: null,
                child: Text("Login"),
              )
            ],
          )),
        ),
      ),
    );
  }
}

Widget textfieldcustom(a) {
  return TextField(
    decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 2),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        hintText: a,
        prefixIcon: Icon(Icons.verified_user)),
    onChanged: (value) {
      // print(value);
    },
  );
}
