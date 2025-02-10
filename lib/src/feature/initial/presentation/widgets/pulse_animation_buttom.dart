import 'package:clean_arch_rick_and_morty/src/feature/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PulsatingButton extends StatefulWidget {
  const PulsatingButton({super.key});

  @override
  State<PulsatingButton> createState() => _PulsatingButtonState();
}

class _PulsatingButtonState extends State<PulsatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Siempre se debe liberar el controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _animation,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey.withOpacity(0.25),
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {
            GoRouter.of(context).pushReplacementNamed(HomeScreen.name);
          },
          child: const Text(
            'Get Started',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
