import 'package:cracker_app/auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(CrackerApp());

class CrackerApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(uri: 'https://cracker.red/api');
    ValueNotifier<GraphQLClient> client =
        ValueNotifier(GraphQLClient(cache: InMemoryCache(), link: httpLink));

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Cracker app',
        home: Auth0App(),
      ),
    );
  }
}
