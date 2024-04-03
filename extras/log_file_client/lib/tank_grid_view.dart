// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:csv/csv.dart';
import 'package:log_file_client/data_log.dart';
import 'package:log_file_client/main.dart';
// import 'package:log_file_client/sample_data.dart';

class TankGridView extends State<MyHomePage> {
  String inkwell = '';
  bool isHovering = false;
  Offset translate = const Offset(0, 0);
  //List<List<String>> _data = [];

  // get https data from choice of log and convert into tsv list
  Future<List<String>> _getData(String path) async {
    var url = Uri.https('oap.cs.wallawalla.edu', path);
    http.Response response = await http.get(url);
    debugPrint('Response status: ${response.statusCode}');
    // debugPrint('Response body: ${response.body}');
    return response.body.split('\n');
    // List<List<String>> listData = const CsvToListConverter().convert(sampleData,
    //     fieldDelimiter: '\t',
    //     shouldParseNumbers: false); //textDelimiter: ' ''' '
    //debugPrint(listData as String?);
    // return listData; // _data = listData;
    // return sampleData;
  }

  // get index html will log list
  Future<List<String>> _getIndex() async {
    var url = Uri.https('oap.cs.wallawalla.edu', '/logs/index.html');
    http.Response response = await http.get(url);
    debugPrint('Response status: ${response.statusCode}');
    if (response.statusCode != 200) {
      throw response.statusCode;
    }
    final htmlString = response.body;
    final document = parse(htmlString);
    final listItems = document
        .getElementsByTagName("li")
        .map((e) => e.children[0].innerHtml)
        .toList();
    //debugPrint(listItems.toList().toString());
    return listItems;
  }

  // Grid selection function making navigation for more on that log
  void _onTileClicked(String path) {
    debugPrint("You clicked on log at $path");
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Text('Tank $path Page')),
              body: _logBodyDisplay(context, path));
        },
      ),
    );
  }

  // Body of selected tile
  FutureBuilder<dynamic> _logBodyDisplay(BuildContext context, String path) {
    return FutureBuilder<dynamic>(
      future: _getData(path),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          final items = snapshot.data;
          return SingleChildScrollView(
            child: Column(children: [
              Container(
                // Use background color to emphasize that it's a new route.
                //color: Colors.lightBlueAccent,
                height: 450,
                padding: const EdgeInsets.all(8),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        prototypeItem: ListTile(
                          title: Text(items.first),
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(items[index]),
                          );
                        },
                      ),
                    ),
                    // Text(snapshot.data.toString()),
                    // Text(_data).toString;
                    // DataTable(
                    //   columns: snapshot.data![0]
                    //       .map(
                    //         (item) => DataColumn(
                    //           label: Text(
                    //             item.toString(),
                    //           ),
                    //         ),
                    //       )
                    //       .toList(),
                    //   rows: snapshot.data!
                    //       .map(
                    //         (csvrow) => DataRow(
                    //           cells: csvrow
                    //               .map(
                    //                 (csvItem) => DataCell(
                    //                   Text(
                    //                     csvItem.toString(),
                    //                   ),
                    //                 ),
                    //               )
                    //               .toList(),
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                  ],
                  // child: const Hero(
                  //   tag: 'selection',
                  //   child: SizedBox(
                  //     width: 100,
                  //     // child: Image.asset(
                  //     //   'lib/assets/tank-icon.png',
                  //     // ),
                  //   ),
                  // ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                //height: MediaQuery.of(context).size.width * 0.95 * 0.65,
                //margin: const EdgeInsets.all(25.0),
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _myTable(context, path),
              ),
              ListTile(
                title: const Text(
                  '1625 Main Street',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: const Text('My City, CA 99984'),
                leading: Icon(
                  Icons.restaurant_menu,
                  color: Colors.blue[500],
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  '(408) 555-1212',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.blue[500],
                ),
              ),
              ListTile(
                title: const Text('costa@example.com'),
                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.blue[500],
                ),
              ),
              Text(
                "Variable Graph of tank $path",
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20.0,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.width * 0.95 * 0.45,
                //margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  //color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _myChart(),
              ),
            ]),
          );
        }
        debugPrint(snapshot.connectionState.toString());
        return const Text('no data yet');
      },
    );
  }

  // Main display as table for tsv
  Table _myTable(BuildContext context, String path) {
    return Table(
      border:
          TableBorder.all(color: Theme.of(context).colorScheme.inversePrimary),
      children: [
        TableRow(children: [
          const Text('Time'),
          Text('time of tank $path'),
        ]),
        TableRow(children: [
          const Text('Tank ID'),
          Text('tankID of tank $path'),
        ]),
        TableRow(children: [
          const Text('Current Temperature'),
          Text('currentTemperatureString of $path'),
        ]),
        TableRow(children: [
          const Text('Thermal Target'),
          Text('Thermal Target of $path'),
        ]),
        TableRow(children: [
          const Text('Current pH'),
          Text('currentPhString of $path'),
        ]),
        TableRow(children: [
          const Text('pH Target'),
          Text('pHTarget of $path'),
        ]),
        TableRow(children: [
          const Text('On Time'),
          Text('onTime (millis() / 1000) of $path'),
        ]),
        TableRow(children: [
          const Text('KP (Proportional gain)'),
          Text('kp of $path'),
        ]),
        TableRow(children: [
          const Text('KI (Integral gain)'),
          Text('ki of $path'),
        ]),
        TableRow(children: [
          const Text('KD (Derivative gain)'),
          Text('kd of $path'),
        ])
      ],
    );
  }

  // Important data fields as chart visualizer
  LineChart _myChart() {
    return LineChart(
      LineChartData(
        //lineTouchData:LineTouchData(touchTooltipData: LineTouchTooltipData(getTooltipItems:))
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 4),
              FlSpot(1, 7),
              FlSpot(2, 2),
              FlSpot(3, 9),
              FlSpot(4, 5),
              FlSpot(5, 10),
              FlSpot(6, 1),
              FlSpot(7, 4),
              FlSpot(8, 9),
              FlSpot(9, 8),
              FlSpot(10, 3),
            ],
            isCurved: true,
            dotData: const FlDotData(show: true),
            color: Colors.blue,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.cyan, Colors.green.withOpacity(0.4)],
              ),
            ),
          ),
        ],
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 10,
        backgroundColor: Colors.white,
      ),
    );
  }

  // Function monitoring hovering over a grid tile
  void _onHover(int index) {
    // debugPrint("You hovered over tank $index");
    //_dialogBuilder(context);
  }

  // Dialog pop up use to be determined
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tank Monitor'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _getIndex(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasError) {
              Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final paths = snapshot.data;
              return GridView.builder(
                gridDelegate: myGridDelegate(),
                padding: const EdgeInsets.all(8.0), // padding around the grid
                itemCount: paths?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _onTileClicked(paths[index]);
                      // setState(() {
                      //   inkwell = 'Inkwell Tapped';
                      //   Text(
                      //     paths[index],
                      //   );
                      // });
                    },
                    // onHover: (hovering) {
                    //   _onHover(index);
                    //   setState(() => isHovering = hovering);
                    //   if (hovering) {
                    //     setState(() {
                    //       // translate = Offset(10, 10);
                    //     });
                    //   } else {
                    //     setState(() {
                    //       // translate = Offset(0, 0);
                    //     });
                    //   }
                    // },
                    highlightColor: Colors.blue.withOpacity(0.4),
                    splashColor: const Color.fromARGB(255, 58, 104, 183),
                    borderRadius: BorderRadius.circular(12),
                    // child: Hero(
                    //   tag: 'selection',
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            138, 113, 210, 128), // color of grid items
                        image: const DecorationImage(
                            image: AssetImage('assets/tank-icon.png'),
                            fit: BoxFit.none,
                            scale: 5,
                            alignment: Alignment(0, -0.75),
                            opacity: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // child: Transform.translate(
                      //   offset: translate,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: const Alignment(0, 0.75),
                        child: Text(
                          paths![index].substring(6),
                          // 'Tank $index + $inkwell',
                          //items[index],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      // ),
                    ),
                  );
                  // )
                },
              );
            }
            debugPrint(snapshot.connectionState.toString());
            return const Text('no data yet');
          },
        ),
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount myGridDelegate() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4, // number of items in each row
      mainAxisSpacing: 8.0, // spacing between rows
      crossAxisSpacing: 8.0, // spacing between columns
    );
  }
}
