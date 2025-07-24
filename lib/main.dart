import 'package:flutter/material.dart';
import 'Gallary.dart';
import 'assets/gallery_data.dart';
import 'profile.dart';
import 'dart:async';
import 'dart:math';

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

  Widget _buildHomePage() {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            itemCount: galleryData.length,
            controller: PageController(viewportFraction: 0.85),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    galleryData[index].imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const Text('<<- SLIDE ->>', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 24),
        const _RandomImageBox(),
        const SizedBox(height: 24),
      ],
    );
  }

  final List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages.addAll([
      _buildHomePage(),
      Gallary(),
      Center(child: Text('Notifications', style: TextStyle(fontSize: 24))),
      const ProfilePage(),
    ]);
  }

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
          NavigationDestination(icon: Icon(Icons.notifications), label: 'Notifications', selectedIcon: Icon(Icons.notifications),),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile', selectedIcon: Icon(Icons.person),),
        ],
      ),
    );
  }
}

class _RandomImageBox extends StatefulWidget {
  const _RandomImageBox();

  @override
  State<_RandomImageBox> createState() => _RandomImageBoxState();
}

class _RandomImageBoxState extends State<_RandomImageBox> {
  int _currentIndex = 0;
  late Timer _timer;
  final Random _random = Random();
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        _visible = false;
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        setState(() {
          _currentIndex = _random.nextInt(galleryData.length);
          _visible = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              galleryData[_currentIndex].imagePath,
              fit: BoxFit.cover,
              width: 400,
              height: 320,
            ),
          ),
        ),
      ),
    );
  }
}
