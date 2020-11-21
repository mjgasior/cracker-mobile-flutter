import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String readVersion = """
    {
    getVersion
  }
""";

class Version extends StatelessWidget {
  final isLoggedIn;
  final accessToken;

  const Version(this.isLoggedIn, this.accessToken);

  @override
  Widget build(BuildContext context) {
    var message = "Logged in";

    if (this.accessToken != null) {
      return Query(
        options: QueryOptions(
          documentNode: gql(readVersion),
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.loading) {
            return Text('Loading');
          }

          return Text("Got the version ${result.data['getVersion']}");
        },
      );
    }

    return Text(message);
  }
}
