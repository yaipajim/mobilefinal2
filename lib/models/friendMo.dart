import 'package:http/http.dart' as http;
import 'dart:convert';

class Friend {
  int id;  
  String name;
  String email;
  String phone;
  String website;

  Friend({this.id, this.name, this.email, this.phone, this.website});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return new Friend(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}

class FriendLs {
  final List<Friend> friends;
  FriendLs({
    this.friends,
  });
  factory FriendLs.fromJson(List<dynamic> parsedJson) {
    List<Friend> friends = new List<Friend>();
    friends = parsedJson.map((i) => Friend.fromJson(i)).toList();

    return new FriendLs(
      friends: friends,
    );
  }
}

class FriendProvider {
  Future<List<Friend>> loadDatas(String url) async {
    http.Response resp = await http.get(url);
    final jresp = json.decode(resp.body);
    FriendLs friendList = FriendLs.fromJson(jresp);
    return friendList.friends;
  }
}