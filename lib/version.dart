import 'package:flutter/material.dart';

class Version extends StatelessWidget {
  final isLoggedIn;
  final accessToken;

  const Version(this.isLoggedIn, this.accessToken);

  @override
  Widget build(BuildContext context) {
    var message = "Logged in";

    if (this.accessToken != null) {
      message += this.accessToken;
    }

    return Text(message);
  }
}
