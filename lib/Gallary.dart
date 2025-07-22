import 'package:flutter/material.dart';


class Gallary extends StatelessWidget {

  Gallary({super.key});

  final List<String> imagePaths = const [
    'lib/assets/basketball_1.jpeg',
    'lib/assets/basketball_2.jpeg',
    'lib/assets/bike.jpeg',
    'lib/assets/kaya.jpeg',
    'lib/assets/running.jpeg',
    'lib/assets/ski.jpeg',
    'lib/assets/soccer.jpeg',
    'lib/assets/tennis_1.jpeg',
    'lib/assets/tennis_2.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePaths[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }


}