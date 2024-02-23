import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tank Monitor',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 215, 215, 215),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 21, 98, 231)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tank Monitor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => TankGridView();
}

class DataLog {
  String time;
  int tankId; // uint16_t
  String currentTemperatureString; // char[10]
  String thermalTarget; // char[10]
  String currentPhString; // char[10]
  String pHTarget; // char[10]
  int onTime; // unsigned long
  String kp; // char[12]
  String ki; // char[12]
  String kd; // char[12]

  DataLog(
      this.time,
      this.tankId,
      this.currentTemperatureString,
      this.thermalTarget,
      this.currentPhString,
      this.pHTarget,
      this.onTime,
      this.kp,
      this.ki,
      this.kd);
}

class Word {
  int id;
  String word;
  int frequency;

  Word();

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    word = map[columnWord];
    frequency = map[columnFrequency];
  }
}

class TankGridView extends State<MyHomePage> {
  int _counter = 0;

  String inkwell = '';

  bool isHovering = false;

  Offset translate = Offset(0, 0);

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
    // This method is rerun every time setState is called to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // number of items in each row
            mainAxisSpacing: 8.0, // spacing between rows
            crossAxisSpacing: 8.0, // spacing between columns
          ),
          padding: const EdgeInsets.all(0.0), // padding around the grid
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
                    'Tank $index + $_counter + $inkwell',
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
