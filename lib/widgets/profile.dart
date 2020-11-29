import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(picture ?? ''),
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Text('Name: $name'),
        SizedBox(height: 18.0),
        RaisedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
