import 'package:flutter/material.dart';
import '../models/user.dart';
import './profile.dart';
import './friend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  String data = '';
  SharedPreferences sharedPreferences;

  Future<String> get _localPath async {
	    final directory = await getApplicationDocumentsDirectory();
	    // For your reference print the AppDoc directory
	    return directory.path;
	  }
	
	  Future<File> get _localFile async {
	    final path = await _localPath;
	    return File('$path/data.txt');
	  }
	
	  Future<String> readcontent() async {
	    try {
	      final file = await _localFile;
	      // Read the file
	      String contents = await file.readAsString();
	      this.data = contents;
	      return this.data;
	    } catch (e) {
	      // If there is an error reading, return a default String
	      return 'Error';
	    }
	  }
	
	  @override
	  void setState(fn) {
	    super.setState(fn);
	    readcontent();
	  }
	
  @override
  Widget build(BuildContext context) {
    User user = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Center(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Hello ${user.name}',
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  subtitle: Text(
	                'this is my quote  "${user.quote != null ? user.quote : "today is my day"}"'),
                ),
                RaisedButton(
                  child: Text("PROFILE SETUP"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(user: user),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("MY FRIENDS"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendScreen(user: user),
                      ),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("SIGN OUT"),
                  onPressed: () async {
                    sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString("username", null);
                    sharedPreferences.setString("password", null);
                    Navigator.pushReplacementNamed(context, '/');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
