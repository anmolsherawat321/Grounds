import 'package:flutter/material.dart';
import 'Screens/ground_list.dart';
import 'Screens/ground_details.dart';
import 'Screens/welcome.dart';
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grounds',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Welcome(),
    );
  }
}