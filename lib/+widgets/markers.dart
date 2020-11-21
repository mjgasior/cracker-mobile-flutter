import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String readMarkers = """
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

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(readMarkers),
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
        return Expanded(
            child: ListView.builder(
                itemCount: markers.length,
                itemBuilder: (context, index) {
                  final marker = markers[index];
                  return _buildRow(marker);
                }));
      },
    );
  }
}
