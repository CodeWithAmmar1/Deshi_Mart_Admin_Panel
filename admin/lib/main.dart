import 'package:admin/bottomnav.dart';
import 'package:admin/category.dart';
import 'package:admin/firebase_options.dart';
import 'package:admin/splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
// imagesUrl
// https://media.istockphoto.com/id/1763021094/photo/ripe-honeycrisp-apples-and-apple-slice-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=LWtYDNfUHQERqfSbyN0lm2X2IN7zmAlmjcd5zqd58qQ=
// https://media.istockphoto.com/id/157375066/photo/banana.jpg?s=612x612&w=0&k=20&c=3v7si4IY-VZRIiUnG2fUodH2kIF4ipt06YnrtBCF3nc=