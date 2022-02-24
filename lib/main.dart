import 'package:flutter/material.dart';


import 'Screen/class/apidata get.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/LogInScreen',
      routes: {
        '/LogInScreen': (context) =>Quiz(),


      },
    );
  }
}

