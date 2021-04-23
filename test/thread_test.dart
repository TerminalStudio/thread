import 'package:thread/thread.dart';
import 'package:test/test.dart';

void main() {
  test('Can create and destroy', () {
    final mutex = Mutex.create();
    mutex.destroy();
  });

  test('Can lock and unlock', () {
    final mutex = Mutex.create();
    mutex.lock();
    mutex.unlock();
  });

  test('Can trylock', () {
    final mutex = Mutex.create();

    mutex.lock();
    expect(mutex.trylock(), equals(false));

    mutex.unlock();
    expect(mutex.trylock(), equals(true));

    mutex.unlock();
  });
}
