import 'package:flutter/material.dart';
import 'package:tutorial/src/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutorial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.light,
          primarySwatch: Colors.purple,
          backgroundColor: Colors.blueGrey,
          errorColor: Colors.red,
        ),
      ),
      home: const login_screen(),
    );
  }
}
