import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginauth/Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please type an email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              validator: (input) {
                if (input.length < 6) {
                  return 'Your password needs to be atleast  6 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              textColor: Colors.blueGrey,
              child: Text('Sign in '),
            ),
          ],
        ),
      ),
    );
  }
}

//SUCHITRA
Future<FirebaseUser> signIn() async {
  String _email;
  String _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  BuildContext context;
  final _formState = _formkey.currentState;
  if (_formState.validate()) {
    print ('Form is valid');
    _formState.save();
    try {
      final FirebaseUser = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password))
          .user;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Home(user: FirebaseUser)));
    } catch (e) {
      print(e.message);
    }
  }
}

//SUSHMITA
//Future<void> signIn() async {
//  final _formState = _formkey.currentState;
//  if (_formKey.currentState.validate()) {
//    formState.save();
//    try {
//      FirebaseUser user = await FirebaseAuth.instance
//          .signInWithEmailAndPassword(email: _email, password: _password);
//      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
//    } catch (e) {
//      print(e.message);
//    }
//  }
//}
