import 'package:androidsidang/page/Daftarsidangpage.dart';
import 'package:androidsidang/page/FormPengajuan.dart';
import 'package:androidsidang/page/FormTambahuser.dart';
import 'package:androidsidang/page/Homepage.dart';
import 'package:flutter/material.dart';
import 'page/Loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Loginpage(),
    );
  }
}


