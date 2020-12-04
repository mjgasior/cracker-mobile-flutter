import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            border:
                Border.all(color: Color.fromRGBO(254, 203, 0, 1), width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(picture ?? ''),
            ),
          ),
        ),
        SizedBox(height: 2.0),
        Text(name),
        SizedBox(height: 7.0),
        RaisedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text(AppLocalizations.of(context).logOut),
        ),
      ],
    );
  }
}
