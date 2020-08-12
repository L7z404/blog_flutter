import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

enum FormType { login, register }

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = '';
  String _password = '';

  //Methods
  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  //Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Flutter Blog App"),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
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
        validator: (value) {
          return value.isEmpty ? 'Email is required' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'Password is required' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  List<Widget> _createButtons() {
    if (_formType == FormType.login) {
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
    } else {
      return [
        RaisedButton(
          child: Text(
            "Create Account",
            style: TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: validateAndSave,
        ),
        FlatButton(
          child: Text(
            "Already have an Account? Login",
            style: TextStyle(fontSize: 14.0),
          ),
          textColor: Colors.blue,
          color: Colors.white,
          onPressed: moveToLogin,
        )
      ];
    }
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
