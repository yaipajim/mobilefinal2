import 'package:flutter/material.dart';
import './ui/login.dart';
import './ui/register.dart';
import './ui/home.dart';
import './ui/profile.dart';
import './ui/friend.dart';
import './ui/friendInfo.dart';

void main() => runApp(MyApp());
const MaterialColor myColor = const MaterialColor(
  0xff64b5f6,
  const <int, Color>{
    50: const Color(0xff64b5f6),
    100: const Color(0xff64b5f6),
    200: const Color(0xff64b5f6),
    300: const Color(0xff64b5f6),
    400: const Color(0xff64b5f6),
    500: const Color(0xff64b5f6),
    600: const Color(0xff64b5f6),
    700: const Color(0xff64b5f6),
    800: const Color(0xff64b5f6),
    900: const Color(0xff64b5f6),
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revision',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: myColor,
        // appBarTheme: AppBarTheme(color: Color(0xfff06292))
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/friend': (context) => FriendScreen(),
        // '/friendInfo': (context) => FriendInfoScreen(),
      },
    );
  }
}