import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void onTileClicked(BuildContext context, String path) {
  debugPrint('You clicked on log at $path');
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('$path Data'),
          ),
          body: logBodyDisplay(context, path),
        );
      },
    ),
  );
}

Future<List<String>> getData(String path) async {
  final url = Uri.https('oap.cs.wallawalla.edu', path);
  final http.Response response = await http.get(url);
  debugPrint('Response status: ${response.statusCode}');
  return response.body.split('\n');
  // List<List<String>> listData = const CsvToListConverter().convert(sampleData,
  //     fieldDelimiter: '\t',
  //     shouldParseNumbers: false); //textDelimiter: ' ''' '
  //debugPrint(listData as String?);
  // return listData; // _data = listData;
  // return sampleData;
}

FutureBuilder<dynamic> logBodyDisplay(BuildContext context, String path) {
  return FutureBuilder<dynamic>(
    future: getData(path),
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(snapshot.data[index]),
            );
          },
        );
      }
    },
  );
}
