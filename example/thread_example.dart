import 'package:thread/thread.dart';

void main() {
  final mutex = Mutex.create();
  mutex.lock();
  mutex.unlock();
  mutex.trylock();
}
