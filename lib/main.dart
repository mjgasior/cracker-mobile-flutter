import 'package:cracker_app/auth0_app.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(CrackerApp());

class CrackerApp extends StatefulWidget {
  @override
  _CrackerAppState createState() => _CrackerAppState();
}

const $API_ADDRESS = 'https://cracker.red/api';

class _CrackerAppState extends State<CrackerApp> {
  ValueNotifier<GraphQLClient> client;

  void initializeClientWithToken(accessToken) {
    final HttpLink httpLink = HttpLink(uri: $API_ADDRESS);
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

  void initializeClient() {
    final HttpLink httpLink = HttpLink(uri: $API_ADDRESS);
    ValueNotifier<GraphQLClient> newClient =
        ValueNotifier(GraphQLClient(cache: InMemoryCache(), link: httpLink));

    setState(() {
      client = newClient;
    });
  }

  @override
  void initState() {
    this.initializeClient();

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
              body: Auth0App(
                  this.initializeClientWithToken, this.initializeClient))),
    );
  }
}
