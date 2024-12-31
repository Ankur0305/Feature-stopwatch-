import 'dart:io';
import 'dart:async';

void main() {
  Stopwatch stopwatch = Stopwatch();
  bool isRunning = false;
  Timer? timer;

  print("Stopwatch Console App");
  print("Commands: start, pause, reset, quit");

  // Function to update and print the time
  void updateTime() {
    stdout.write('\rElapsed time: ${stopwatch.elapsedMilliseconds ~/ 1000}s       ');
  }

  // Command loop
  while (true) {
    String command = stdin.readLineSync() ?? '';

    if (command == 'start' && !isRunning) {
      stopwatch.start();
      isRunning = true;
      timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        updateTime();
      });
      print("Stopwatch started...");
    } else if (command == 'pause' && isRunning) {
      stopwatch.stop();
      isRunning = false;
      timer?.cancel();
      print("Stopwatch paused.");
    } else if (command == 'reset') {
      stopwatch.reset();
      if (isRunning) {
        stopwatch.stop();
        isRunning = false;
        timer?.cancel();
      }
      print("Stopwatch reset.");
      updateTime();
    } else if (command == 'quit') {
      stopwatch.stop();
      timer?.cancel();
      break;
    } else {
      print("Invalid command. Try 'start', 'pause', 'reset', or 'quit'.");
    }
  }

  print("\nGoodbye!");
}
