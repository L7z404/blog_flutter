import 'dart:io';
import 'package:blog_flutter/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

class UploadFotoPage extends StatefulWidget {
  @override
  _UploadFotoPageState createState() => _UploadFotoPageState();
}

class _UploadFotoPageState extends State<UploadFotoPage> {
  File sampleImage;
  String _myValue;
  String url;
  final formKey = new GlobalKey<FormState>();
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = File(pickedFile.path);
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Publicar Imagenes");
      var timekey = new DateTime.now();
      final StorageUploadTask uploadTask =
          postImageRef.child(timekey.toString() + ".jpg").putFile(sampleImage);

      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = ImageUrl.toString();
      print("Image Url = " + url);
      goToHomePage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url) {
    var currentTime = new DateTime.now();
    //var formatDate = new DateFormat('d MMM, yyyy');
    var formatDate = new DateFormat.d('es_ES').add_MMM().addPattern("yyyy");
    //var formatTime = new DateFormat('EEEE, hh:mm aaa');
    var formatTime = new DateFormat.EEEE('es_ES').add_jm().addPattern("aaa");

    String date = formatDate.format(currentTime);
    String time = formatTime.format(currentTime);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "imagen": url,
      "descripcion": _myValue,
      "fecha": date,
      "hora": time,
    };
    ref.child("Publicaciones").push().set(data);
  }

  void goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Subir Foto"),
      ),
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: sampleImage == null
            ? Text("Selecciona una imagen")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Agregar Imagen',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            Image.file(
              sampleImage,
              height: 330.0,
              width: 660.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                return value.isEmpty ? 'La descripción es obligatoria' : null;
              },
              onSaved: (value) {
                return _myValue = value;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              elevation: 10.0,
              child: Text("Agregar una nueva entrada"),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: uploadStatusImage,
            )
          ],
        ),
      ),
    );
  }
}
