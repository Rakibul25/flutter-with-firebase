import 'package:firebase_application_1/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loginController.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key key, this.user, this.callback}) : super(key: key);

  final VoidCallback callback;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final LoginController cont = Get.find();
    return Container(
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(user.email.toString()),
            Text(user.password.toString()),
            Text(user.name),
            Text(user.mobile),
            Text(user.address),
            InkWell(
              onTap: () {
                cont.edituser(user);
              },
              child: Icon(Icons.edit),
            ),
            InkWell(
              onTap: () {
                cont.deleteUser(user);
              },
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
