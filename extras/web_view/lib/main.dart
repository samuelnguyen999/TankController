import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 104, 183)),
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

class TankGridView extends State<MyHomePage> {
  int _counter = 0;

  String inkwell = '';

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
    debugPrint("You tapped on item $index");
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
              child: Container(
                decoration: const BoxDecoration(
                  color:
                      Color.fromARGB(138, 113, 210, 128), // color of grid items
                  // image: DecorationImage(
                  //   image: AssetImage('assets/TankIcon.png'),
                  //   fit: BoxFit.cover,
                  // ),
                ),
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
              ),
            );
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
