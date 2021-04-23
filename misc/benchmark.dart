import 'package:thread/thread.dart';

void main() {
  BenchmarkMutex().run();
}

abstract class Benchmark {
  String explain();

  void benchmark();

  void run() {
    print('benchmark: ${explain()}');
    print('preheating...');
    benchmark();
    final sw = Stopwatch()..start();
    print('running...');
    benchmark();
    sw.stop();
    print('result: ${sw.elapsedMilliseconds} ms');
  }
}

class BenchmarkMutex extends Benchmark {
  static const cycle = 1 << 20;

  @override
  String explain() {
    return 'lock and unlock a mutex for $cycle times';
  }

  @override
  void benchmark() {
    final mutex = Mutex.create();
    for (var i = 0; i < cycle; i++) {
      mutex.lock();
      mutex.unlock();
    }
  }
}
