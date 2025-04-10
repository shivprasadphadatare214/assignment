import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoveSquare(),
    );
  }
}

class MoveSquare extends StatefulWidget {
  const MoveSquare({super.key});
  @override
  MoveSquareState createState() => MoveSquareState();
}

class MoveSquareState extends State<MoveSquare> {
  double _alignmentX = 0;
  bool _isAnimating = false;

  final double _step = 0.2;

  void move(double direction) async {
    setState(() {
      _isAnimating = true;
      _alignmentX += direction;
      _alignmentX = _alignmentX.clamp(-1.0, 1.0);
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isAnimating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAtLeft = _alignmentX <= -1.0;
    final isAtRight = _alignmentX >= 1.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Square Move',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedAlign(
              alignment: Alignment(_alignmentX, 0),
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Container(width: 80, height: 80, color: Colors.blue),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed:
                    (_isAnimating || isAtLeft) ? null : () => move(-_step),
                child: const Text(
                  'To Left',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed:
                    (_isAnimating || isAtRight) ? null : () => move(_step),
                child: const Text(
                  'To Right',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
