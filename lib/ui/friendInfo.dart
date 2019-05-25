import 'package:flutter/material.dart';
import './todo.dart';
import '../models/user.dart';
import './friend.dart';

// class FriendInfoScreen extends StatefulWidget {
//   int id;
//   String name;
//   final User user;
//   FriendInfoScreen({Key key, this.id, this.name, this.user}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() {
//     return FriendInfoScreenState();
//   }
// }

// class FriendInfoScreenState extends State<FriendInfoScreen> {
//   @override
//   Widget build(BuildContext context) {
//     int id = widget.id;
//     String name = widget.name;
//     User myself = widget.user;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Info"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               "${id} : ${name}",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   flex: 1,
//                   child: RaisedButton(
//                     child: Text("TODOS"),
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               TodoScreen(id: id, name: name, user: myself),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   flex: 1,
//                   child: RaisedButton(
//                     child: Text("Back"),
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => FriendScreen(user: myself),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
