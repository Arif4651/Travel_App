import 'package:flutter/material.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/welcome.dart';

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
      home: welcome(),


    );
  }
}


