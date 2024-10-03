import 'dart:async';
import 'package:flutter/material.dart';

class LoaderComponent extends StatefulWidget {
  const LoaderComponent({super.key});

  @override
  State<LoaderComponent> createState() => _LoaderComponentState();
}

class _LoaderComponentState extends State<LoaderComponent> {
  final List<String> icons = [
    "assets/Icons/car.png",
    "assets/Icons/clothes.png",
    "assets/Icons/home-agreement.png",
    "assets/Icons/pets.png",
    "assets/Icons/responsive.png"
  ];

  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startIconLoop();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }

  void _startIconLoop() {
    _timer = Timer.periodic(Duration(milliseconds: 600), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % icons.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: Image.asset(
          icons[_currentIndex],color: Colors.white,
          key: ValueKey<int>(_currentIndex),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
