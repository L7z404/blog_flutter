import 'package:blog_flutter/Mapping.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      home: MappingPage(
        auth: Auth(),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', 'ES'),
      ],
    );
  }
}
