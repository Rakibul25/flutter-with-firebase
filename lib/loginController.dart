import 'package:firebase_application_1/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db_helper.dart';

class LoginController extends GetxController {
  final username = TextEditingController().obs;
  final usermobile = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final emailid = TextEditingController().obs;
  final pass = TextEditingController().obs;

  var userModel = UserModel().obs;

  final userList = List<UserModel>().obs;

  var isUpdate = false.obs;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  DatabaseReference _counterRef;

  @override
  void onInit() {
    // TODO: implement onInit
    getCurentUser();
    getUserlist();
    super.onInit();
  }

  void saveOrUpdate() {
    isUpdate.value == false ? saveUser() : userUpdate();
  }

  void getCurentUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user);
  }

  void saveUser() async {
    UserModel model = new UserModel();
    model.name = username.value.text;
    model.mobile = usermobile.value.text;
    model.address = addressController.value.text;
    model.email = emailid.value.text;
    model.password = pass.value.text;
    // var a = await DatabaseHelper.insert(model);
    // print(a.toString());

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "name": model.name,
      "mobile": model.mobile,
      "address": model.address,
    };
    ref.child('user').push().set(data).then((v) {});
    // final databaseRef = FirebaseDatabase._instance_.reference(); //database reference object
    //
    // void addData(String data) {
    //   databaseRef.push().set({'name': data, 'comment': 'A good season'});
    // }

    getUserlist();

    print(userList);
    reset();
  }

  void userUpdate() async {
    UserModel model = new UserModel();
    model.name = username.value.text;
    model.mobile = usermobile.value.text;
    model.address = addressController.value.text;
    model.email = emailid.value.text;
    model.password = pass.value.text;
    model.id = userModel.value.id;
    var u = await DatabaseHelper.update(model);
    reset();
    getUserlist();
  }

  void getUserlist() async {
    List<Map<String, dynamic>> list = await DatabaseHelper.userList();

    userList.assignAll(list.map((e) => UserModel.fromJson(e)).toList());

    print(userList.toList());
  }

  void deleteUser(UserModel user) async {
    await DatabaseHelper.delete(user);
    getUserlist();
  }

  void edituser(UserModel user) {
    reset();
    isUpdate.value = true;
    username.value.text = user.name;
    usermobile.value.text = user.mobile;
    addressController.value.text = user.address;
    emailid.value.text = user.email;
    pass.value.text = user.password;
    userModel.value = user;
    isUpdate.value = true;
  }

  void reset() {
    // this.isUpdate.value= false;
    emailid.value.text = "";
    pass.value.text = "";
    username.value.text = "";
    usermobile.value.text = "";
    addressController.value.text = "";
    isUpdate.value = false;
  }

  void createUser() async {
    UserModel model = new UserModel();
    // model.name = username.value.text;
    // model.mobile = usermobile.value.text;
    // // model.address = addressController.value.text;
    model.email = emailid.value.text;
    model.password = pass.value.text;

    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: model.email, password: model.password);
      // if(user.){}

    } catch (e) {
      print(e.toString());
    }
  }

  List<UserModel> allData = [];

  void showUser() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('user').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      // print(data);
      print(keys);
      allData.clear();
      for (var key in keys) {
        UserModel d = new UserModel();

        d.name = data[key]['name'];
        d.mobile = data[key]['mobile'];
        d.address = data[key]['address'];

        allData.add(d);
      }
    });
  }

  // deleteTodo(String key, int index) {
  //   final FirebaseDatabase _database = FirebaseDatabase.instance;
  //   // DatabaseReference ref = FirebaseDatabase.instance.reference();
  //   _database.reference().child("user").child(key).remove().then((_) {
  //     print("Delete $todoId successful");
  //     setState(() {
  //       _todoList.removeAt(index);
  //     });
  //   });
  // }

}
