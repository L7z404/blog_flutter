import 'package:blog_flutter/Posts.dart';
import 'package:blog_flutter/UploadFoto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'dart:async';
import 'Posts.dart';

class HomePage extends StatefulWidget {
  HomePage({
    this.auth,
    this.onSignedOut,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> postsList = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Publicaciones");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postsList.clear();
      for (var individualKey in KEYS) {
        Posts posts = Posts(
            DATA[individualKey]['imagen'],
            DATA[individualKey]['descripcion'],
            DATA[individualKey]['fecha'],
            DATA[individualKey]['hora']);
        postsList.add(posts);
      }
      setState(() {
        print('Length : ${postsList.length}');
      });
    });
  }

  //Methods
  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  //Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Inicio"),
      ),
      body: Container(
        child: postsList.length == 0
            ? Text("No hay publicaciones disponibles")
            : ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (_, index) {
                  return postsUI(
                    postsList[index].imagen,
                    postsList[index].descripcion,
                    postsList[index].fecha,
                    postsList[index].hora,
                  );
                }),
      ),
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return UploadFotoPage();
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget postsUI(String imagen, String descripcion, String fecha, String hora) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fecha,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  hora,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Image.network(
              imagen,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              descripcion,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
