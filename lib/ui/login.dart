import 'package:flutter/material.dart';
import '../models/user.dart';
import './home.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController userid = TextEditingController();
  TextEditingController password = TextEditingController();
  UserProvider userProvider = UserProvider();
  List<User> currentUsers = List();
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    userProvider.open('member.db').then((r) async {
      getUsers();
      print("open success");
    });
  }

  void getUsers() {
userProvider.getUsers().then((r) async {
	      currentUsers = r;
	      sharedPreferences = await SharedPreferences.getInstance();
	      String userchk = sharedPreferences.getString('username');
	      String passwordchk = sharedPreferences.getString('password');
	      if (userchk != "" && userchk != null) {
	        for (int i = 0; i < currentUsers.length; i++) {
	          if (userchk == currentUsers[i].userid &&
	              passwordchk == currentUsers[i].password) {
	            Navigator.pushReplacement(
	              context,
	              MaterialPageRoute(
	                builder: (context) => HomeScreen(user: currentUsers[i]),
	              ),
	            );
            }
          }
        }
    });
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Image.network(
              "http://www.myiconfinder.com/uploads/iconsets/256-256-87cc0576629f9e533cd1d331fd98d8bc.png",
              height: 200,
            ),
            TextFormField(
              controller: userid,
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                labelText: "User Id",
                hintText: "User Id",
              ),
              validator: (value) {
                if (value.isEmpty) return "Please fill out this form";
              },
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "Password",
                hintText: "Password",
              ),
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) return "Please fill out this form";
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Text("LOGIN"),
                    onPressed: () async {
                      bool flag = false;
                      if (_formkey.currentState.validate()) {
                        for (int i = 0; i < currentUsers.length; i++) {
                          if (userid.text == currentUsers[i].userid &&
                              password.text == currentUsers[i].password) {
                            flag = true;
                            sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString(
                                "username", currentUsers[i].userid);
                            sharedPreferences.setString(
                                "password", currentUsers[i].password);
                            // prefs.setInt('id', currentUsers[i].userid);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(user: currentUsers[i]),
                              ),
                            );
                          }
                        }
                        if (!flag) {
                          Toast.show("Invalid user or password", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text("Register New Account"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: loginForm());
  }
}
