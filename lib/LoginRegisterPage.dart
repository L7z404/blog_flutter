import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  //Methods
  void validateAndSave() {}
  void moveToRegister() {}

  //Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Blog App"),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _createInputs() + _createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> _createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      _logo(),
      SizedBox(
        height: 20.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  List<Widget> _createButtons() {
    return [
      RaisedButton(
        child: Text(
          "Login",
          style: TextStyle(fontSize: 20.0),
        ),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: validateAndSave,
      ),
      FlatButton(
        child: Text(
          "Not have an Account? Create Account?",
          style: TextStyle(fontSize: 14.0),
        ),
        textColor: Colors.blue,
        color: Colors.white,
        onPressed: moveToRegister,
      )
    ];
  }

  Widget _logo() {
    return Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 110.0,
          child: Image.asset('assets/logothing.jpg'),
        ));
  }
}
