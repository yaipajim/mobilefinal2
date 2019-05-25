import 'package:flutter/material.dart';
import '../models/user.dart';
import '../ui/home.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  final User user;
  ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController userid = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController quote = TextEditingController();
  UserProvider userProvider = UserProvider();
   Future<String> get _localPath async {
	    final directory = await getApplicationDocumentsDirectory();
	    return directory.path;
	  }
	
	  Future<File> get _localFile async {
	    final path = await _localPath;
	    return File('$path/data.txt');
	  }
	
	  Future<File> writeContent(String data) async {
	    final file = await _localFile;
	    file.writeAsString('${data}');
	  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  @override
  void initState() {
    super.initState();
    userProvider.open('member.db').then((r) {
      print("open success");
    });
  }

  @override
  Widget build(BuildContext context) {
    User myself = widget.user;
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: userid,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "User Id",
                    hintText: "User Id must be 6-12 character",
                    ),
                  validator: (value) {
                    if (value.length < 6 || value.length > 12)
                      return "User Id must be 6-12 character";
                  },
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: "Name",
                    hintText: "Ex. Tom Hanks",
                  ),
                  validator: (value) {
                    int count = 0;
                    for (int i = 0; i < value.length; i++) {
                      if (value[i] == " ") {
                        count = 1;
                      }
                    }
                    if (count == 0) {
                      return "Please fill name correctly";
                    }
                  },
                ),
                TextFormField(
                  controller: age,
                  decoration: InputDecoration(
                    icon: Icon(Icons.date_range),
                    labelText: "Age",
                    hintText: "Age must be between 10 and 80",
                  ),
                  validator: (value) {
                    if (!isNumeric(value)) 
                      return "Age incorrect";
                    if (int.parse(value) < 10 || int.parse(value) > 80)
                      return "Age must be between 10 and 80";
                  },
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "Password",
                    hintText: "Password must be be more than 6 character",
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.length < 6) 
                      return "Password must be more than 6";
                  },
                ),
                TextFormField(
                  controller: quote,
                  maxLines: 6,
                  decoration: InputDecoration(
                    icon: Icon(Icons.mood),
                    labelText: "Quote"),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        child: Text("Save"),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            if (userid.text != "") {
                              myself.userid = userid.text;
                            }
                            if (name != "") {
                              myself.name = name.text;
                            }
                            if (age.text != "") {
                              myself.age = age.text;
                            }
                            if (password.text != "") {
                              myself.password = password.text;
                            }
                            if (quote.text != "") {
                              myself.quote = quote.text;
                            }
                            userProvider.updateUser(myself).then((r) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(user: myself),
                                ),
                              );
                            });
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}