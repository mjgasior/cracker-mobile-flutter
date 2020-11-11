import 'package:flutter/material.dart';

void main() => runApp(CrackerApp());

class CrackerApp extends StatefulWidget {
  @override
  _CrackerAppState createState() => _CrackerAppState();
}

class _CrackerAppState extends State<CrackerApp> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage;
  String name;
  String picture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth0 Demo'),
        ),
        body: Center(
          child: Text('Implement User Authentication'),
        ),
      ),
    );
  }
}
