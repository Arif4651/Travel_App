import 'package:flutter/material.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/welcome.dart';
import 'package:travel_app/login.dart';
import 'package:travel_app/signup.dart';
void main()
{
  runApp(mainapp());
}


class mainapp extends StatelessWidget {
  const mainapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false
      ,
      home: Signup(),


    );
  }
}


