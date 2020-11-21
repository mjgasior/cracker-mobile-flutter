import 'package:cracker_app/auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(CrackerApp());

class CrackerApp extends StatefulWidget {
  @override
  _CrackerAppState createState() => _CrackerAppState();
}

class _CrackerAppState extends State<CrackerApp> {
  ValueNotifier<GraphQLClient> client;

  void initializeAuth(accessToken) {
    final HttpLink httpLink = HttpLink(uri: 'https://cracker.red/api');
    final authLink = AuthLink(
      getToken: () async => 'Bearer $accessToken',
    );

    final link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> newClient =
        ValueNotifier(GraphQLClient(cache: InMemoryCache(), link: link));

    setState(() {
      client = newClient;
    });
  }

  @override
  void initState() {
    final HttpLink httpLink = HttpLink(uri: 'https://cracker.red/api');
    ValueNotifier<GraphQLClient> newClient =
        ValueNotifier(GraphQLClient(cache: InMemoryCache(), link: httpLink));

    setState(() {
      client = newClient;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (client == null) {
      return Text("Loading...");
    }

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: Text('Cracker app'),
              ),
              body: Auth0App(this.initializeAuth))),
    );
  }
}
