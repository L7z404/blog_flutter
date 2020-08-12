import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Methods
  void _logoutUser() {}

  //Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: Container(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          margin: const EdgeInsets.only(left: 70.0, right: 70.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                iconSize: 50.0,
                color: Colors.white,
                onPressed: _logoutUser,
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                iconSize: 40.0,
                color: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
