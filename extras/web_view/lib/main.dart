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
        scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 21, 98, 231)),
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

  bool isHovering = false;

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
    debugPrint("You tapped on tank $index");
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Text('Tank $index Page')),
              body: Container(
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
                      "Welcome to Tank $index!!!",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 25.0,
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
              },
              highlightColor: Colors.blue.withOpacity(0.4),
              splashColor: const Color.fromARGB(255, 58, 104, 183),
              // child: Hero(
              //   tag: 'selection',
              child: Container(
                decoration: const BoxDecoration(
                  color:
                      Color.fromARGB(138, 113, 210, 128), // color of grid items
                  // // image: DecorationImage(
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
