import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  bool _isRunning = false;
  String _formattedTime = "00:00:00";

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 100), _updateTime);
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _formattedTime = _formatDuration(_stopwatch.elapsed);
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _stopwatch.start();
    });
  }

  void _pauseStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.stop();
    });
  }

  void _resetStopwatch() {
    setState(() {
      _isRunning = false;
      _stopwatch.reset();
      _formattedTime = "00:00:00";
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 22, 34, 171), // Light yellow background color
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Time display
              Text(
                _formattedTime,
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Start/Pause button
                  ElevatedButton(
                    onPressed: _isRunning ? _pauseStopwatch : _startStopwatch,
                    child: Text(
                      _isRunning ? 'Pause' : 'Start',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Red color for the button
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0), // Increased button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Reset button
                  ElevatedButton(
                    onPressed: _resetStopwatch,
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 20), // Increased font size
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Red color for the button
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0), // Increased button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
