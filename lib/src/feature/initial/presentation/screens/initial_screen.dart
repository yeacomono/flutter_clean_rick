import 'package:clean_arch_rick_and_morty/src/feature/initial/presentation/widgets/pulse_animation_buttom.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  static const String name = "InitialScreen";
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo.jpg',
                scale: 1.2,
              ),
            ),
            const PulsatingButton()
          ],
        ),
      ),
    );
  }
}
