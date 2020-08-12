import 'package:flutter/material.dart';
import 'package:blog_flutter/HomePage.dart';
import 'package:blog_flutter/loginRegisterPage.dart';

void main() {
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blog App",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
