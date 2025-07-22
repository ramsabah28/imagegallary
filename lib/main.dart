import 'package:flutter/material.dart';
import 'Gallary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndexPage = 0;

  final List<Widget> pages = [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Gallary(),
    Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Header Placeholder"),
      ),
      body: pages[currentIndexPage],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndexPage = index;
          });
        },
        indicatorColor: Colors.cyan,
        selectedIndex: currentIndexPage,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home', selectedIcon: Icon(Icons.home),),
          NavigationDestination(icon: Icon(Icons.image), label: 'Gallary', selectedIcon: Icon(Icons.image),),
          NavigationDestination(icon: Icon(Icons.notifications), label: 'Notifications', selectedIcon: Icon(Icons.notifications),)
        ],
      ),
    );
  }
}
