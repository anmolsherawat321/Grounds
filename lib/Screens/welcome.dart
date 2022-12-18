import 'dart:ui';

import 'package:flutter/material.dart';
import 'ground_list.dart';
import 'ground_details.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child:ClipRRect(
                child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),
                child:Image(image: AssetImage('images/edengardens.jpg',),),
                ),
              ),
            ),
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Column(
                children: [
                Text('Hi',style: TextStyle(fontSize: 25.0,color: Colors.black),),
                Text("Let's get started",style: TextStyle(fontSize: 20.0,color: Colors.black),),
                Padding(padding: EdgeInsets.all(20.0)),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: TextField(
                    decoration: InputDecoration(label: Text('Enter Phone')),
                  ),
                ),
                Padding(padding: EdgeInsets.all(100.0)),
                MaterialButton(
                  color: Color.fromARGB(255, 62, 174, 180),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GroundList()));
               },
               minWidth: 140.0,
              ),
                ],
              )
              
            ),
          ],
        ),
      ),
    );
  }
}