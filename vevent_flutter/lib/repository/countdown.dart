import 'dart:async';

class Countdown {
  late Timer timer;
  late bool isPaused = false;
  static const oneSecond = Duration(seconds: 1);
  late int totalMinutes;
  late int totalSecond = 0;

  Countdown({required this.totalMinutes});

  void startCountdown() {
    timer = Timer.periodic(oneSecond, (timer) {
      if (countdownMinutes == 0 && totalSecond == 0) {
        timer.cancel();
      } else if (totalSecond == 0) {
        totalMinutes--;
        totalSecond = 59;
      } else {
        totalSecond--;
      }
    });
  }

   int get countdownMinutes{
    return totalMinutes;
  }

  // void pauseResumeTimer() {
  //   if (isPaused) {
  //     startTimer();
  //   } else {
  //     timer.cancel();
  //   }
  //   setState(() {
  //     isPaused = !isPaused;
  //   });
  // }
}
