import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web_view/data_log.dart';
import 'package:web_view/main.dart';

class TankGridView extends State<MyHomePage> {
  String inkwell = '';
  bool isHovering = false;
  Offset translate = const Offset(0, 0);

  final log = DataLog('time', 1, 'currentTemperatureString', 'thermalTarget',
      'currentPhString', 'pHTarget', 2, 'kp', 'ki', 'kd');

  Map<String, dynamic> map = {
    //   'time' : log.time,
    //   'tankId' : log.tankId,
  };

  // Function to be called on click
  void _onTileClicked(int index) {
    debugPrint("You clicked on tank $index");
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Text('Tank $index Page')),
              body: SingleChildScrollView(
                child: Container(
                  // Use background color to emphasize that it's a new route.
                  //color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
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
                        child: Table(
                          border: TableBorder.all(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                          children: [
                            TableRow(children: [
                              const Text('Time'),
                              Text('time of tank $index'),
                            ]),
                            TableRow(children: [
                              const Text('Tank ID'),
                              Text('tankID of tank $index'),
                            ]),
                            TableRow(children: [
                              const Text('Current Temperature'),
                              Text('currentTemperatureString of $index'),
                            ]),
                            TableRow(children: [
                              const Text('Thermal Target'),
                              Text('Thermal Target of $index'),
                            ]),
                            TableRow(children: [
                              const Text('Current pH'),
                              Text('currentPhString of $index'),
                            ]),
                            TableRow(children: [
                              const Text('pH Target'),
                              Text('pHTarget of $index'),
                            ]),
                            TableRow(children: [
                              const Text('On Time'),
                              Text('onTime (millis() / 1000) of $index'),
                            ]),
                            TableRow(children: [
                              const Text('KP (Proportional gain)'),
                              Text('kp of $index'),
                            ]),
                            TableRow(children: [
                              const Text('KI (Integral gain)'),
                              Text('ki of $index'),
                            ]),
                            TableRow(children: [
                              const Text('KD (Derivative gain)'),
                              Text('kd of $index'),
                            ])
                          ],
                        ),
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
                        "Variable Graph of tank $index",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20.0,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.width * 0.95 * 0.65,
                        //margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          //color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: LineChart(
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
                                    colors: <Color>[
                                      Colors.cyan,
                                      Colors.green.withOpacity(0.4)
                                    ],
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
                        ),
                      ),
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
              ));
        },
      ),
    );
  }

  void _onHover(int index) {
    debugPrint("You hovered over tank $index");
    //_dialogBuilder(context);
  }

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
        child: GridView.builder(
          gridDelegate: myGridDelegate(),
          // padding: const EdgeInsets.all(0.0), // padding around the grid
          itemCount: 24, //tanks.length, // total number of items
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _onTileClicked(index);
                setState(() {
                  inkwell = 'Inkwell Tapped';
                  Text(
                    inkwell,
                  );
                });
              },
              onHover: (hovering) {
                _onHover(index);
                setState(() => isHovering = hovering);
                if (hovering) {
                  setState(() {
                    // translate = Offset(10, 10);
                  });
                } else {
                  setState(() {
                    // translate = Offset(0, 0);
                  });
                }
              },
              highlightColor: Colors.blue.withOpacity(0.4),
              splashColor: const Color.fromARGB(255, 58, 104, 183),
              // child: Hero(
              //   tag: 'selection',
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                decoration: const BoxDecoration(
                  color:
                      Color.fromARGB(138, 113, 210, 128), // color of grid items
                  //  image: DecorationImage(
                  //   image: AssetImage('assets/TankIcon.png'),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                // child: Transform.translate(
                //   offset: translate,
                child: Center(
                  child: Text(
                    'Tank $index + $inkwell',
                    //items[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                // ),
              ),
            );
            // )
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
