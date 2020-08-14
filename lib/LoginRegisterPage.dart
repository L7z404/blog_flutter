import 'package:blog_flutter/DialogBox.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'dart:async';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({this.auth, this.onSignedIn});
  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

enum FormType { login, register }

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  DialogBox dialogBox = new DialogBox();

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

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.SignIn(_email, _password);
          dialogBox.information(
              context, 'Bienvenido', 'Ha iniciado sesión con exito');
          print("login userId =" + userId);
        } else {
          String userId = await widget.auth.SignUp(_email, _password);
          dialogBox.information(
              context, 'Feliciades', "Tu cuenta ha sido creada con exito!");
          print("Register userId =" + userId);
        }

        widget.onSignedIn();
      } catch (e) {
        dialogBox.information(context, 'Error = ', e.toString());
        print("Error = " + e.toString());
      }
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
        decoration: InputDecoration(labelText: 'Correo'),
        validator: (value) {
          return value.isEmpty ? 'El correo es obligatorio' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Contraseña'),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'La contraseña es obligatoria' : null;
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
            "Iniciar Sesión",
            style: TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text(
            "¿No tienes una cuenta? ¿Crear una cuenta?",
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
            "Crear cuenta",
            style: TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text(
            "¿Ya tienes una cuenta? Inicia sesión",
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
