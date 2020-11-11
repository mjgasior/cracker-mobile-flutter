import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CrackerApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(uri: 'https://cracker.red/api');
    ValueNotifier<GraphQLClient> client =
        ValueNotifier(GraphQLClient(cache: InMemoryCache(), link: httpLink));

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Cracker app',
        home: Markers(),
      ),
    );
  }
}

String readRepositories = """
    {
    markers {
      _id
      latitude
      longitude
      imageFilename
      polish {
        name
        description
      }
      english {
        name
        description
      }
    }
  }
""";

class Markers extends StatelessWidget {
  final _biggerFont = TextStyle(fontSize: 18.0);

  Widget _buildRow(dynamic marker) {
    return ListTile(
      title: Text(
        marker['english']['name'],
        style: _biggerFont,
      ),
    );
  }

  Widget _buildList() {
    return Query(
      options: QueryOptions(
        documentNode: gql(readRepositories),
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }

        List markers = result.data['markers'];

        return ListView.builder(
            itemCount: markers.length,
            itemBuilder: (context, index) {
              final marker = markers[index];
              return _buildRow(marker);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cracker app markers2')),
      body: _buildList(),
    );
  }
}
