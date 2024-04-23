import 'package:flutter/material.dart';
import 'package:iot_garden/ui/screen/home_screen.dart';

void main(){
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
        primarySwatch: Colors.teal
      ),
      home: HomeScreen(),

    );
  }
}
