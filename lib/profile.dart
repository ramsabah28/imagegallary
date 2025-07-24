import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<String> _loadProfileText() async {
    return await rootBundle.loadString('lib/assets/max_musterman.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/assets/images/avatar.jpg'),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Max Musterman',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<String>(
              future: _loadProfileText(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Fehler beim Laden des Profils.'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      snapshot.data!.replaceAll('"', '').replaceAll('\\n', '\n'),
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
} 