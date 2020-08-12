import 'package:flutter/material.dart';
import 'package:pagina_inicio_login/loginRegisterPage.dart';

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
      home: LoginRegisterPage(),
    );
  }
}
