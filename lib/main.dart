import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' Timer app',
      theme: ThemeData.dark(),
      home: const TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _seconds = 0;
  late Timer _timer;
  bool _isRunning = false;

  // Start or stop the timer
  void _startPauseTimer() {
    if (_isRunning) {
      _timer.cancel();
    } else {
      _startTimer();
    }

    setState(() {
      _isRunning = !_isRunning;
    });
  }

  // Start the countdown
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  // Reset the timer
  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  // Format the time as MM:SS
  String _formatTime() {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Timer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer display in an oval shape
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _formatTime(),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Start/Pause button
            ElevatedButton(
              onPressed: _startPauseTimer,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: Colors.green,
                shape: const StadiumBorder(),
              ),
              child: Text(_isRunning ? 'Pause' : 'Start'),
            ),
            const SizedBox(height: 20),

            // Reset button
            ElevatedButton(
              onPressed: _resetTimer,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: Colors.red,
                shape: const StadiumBorder(),
              ),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
