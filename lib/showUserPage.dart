import 'package:firebase_application_1/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loginController.dart';

class ShowUserPage extends StatefulWidget {
  @override
  _ShowUserPageState createState() => _ShowUserPageState();
}

class _ShowUserPageState extends State<ShowUserPage> {
  List<UserModel> allData = [];
  final cont = Get.put(LoginController());
  // @override
  // void initState() {
  //   DatabaseReference ref = FirebaseDatabase.instance.reference();
  //   ref.child('user').once().then((DataSnapshot snap) {
  //     var keys = snap.value.keys;
  //     var data = snap.value;
  //     allData.clear();
  //     for (var key in keys) {
  //       UserModel d = new UserModel();
  //    d.name=   data[key]['name'];
  //     d.mobile=data[key]['mobile'];
  //     d.address= data[key]['address'];
  //
  //
  //       allData.add(d);
  //     }
  //     setState(() {
  //       print('Length : ${allData.length}');
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    cont.showUser();
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Firebase Data'),
      ),
      body: new Container(
          child: cont.allData.length == 0
              ? new Text(' No Data is Available')
              : new ListView.builder(
                  itemCount: cont.allData.length,
                  itemBuilder: (_, index) {
                    return viewUI(
                      cont.allData[index].name,
                      cont.allData[index].mobile,
                      cont.allData[index].address,
                    );
                  },
                )),
    );
  }

  Widget viewUI(String name, String mobile, String address) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Name : $name',
              style: Theme.of(context).textTheme.title,
            ),
            new Text('Profession : $mobile'),
            new Text('Message : $address'),
          ],
        ),
      ),
    );
  }
}
