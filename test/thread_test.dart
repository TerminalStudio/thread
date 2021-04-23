import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
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

  test('it works', () async {
    final struct = calloc<TestStruct>();
    final mutex = Mutex.create();

    final iso1 = Isolate.spawn(testIsolate, [struct.address, mutex]);
    final iso2 = Isolate.spawn(testIsolate, [struct.address, mutex]);

    await iso1;
    await iso2;

    await Future.delayed(Duration(seconds: 5));
    expect(struct.ref.value, equals(20000));
  });

  // test('Can trylock', () {
  //   final mutex = Mutex.create();

  //   mutex.lock();
  //   expect(mutex.trylock(), equals(false));

  //   mutex.unlock();
  //   expect(mutex.trylock(), equals(true));

  //   mutex.unlock();
  // });
}

class TestStruct extends Struct {
  @Uint32()
  external int value;
}

void testIsolate(List args) {
  final structAddress = args[0] as int;
  final mutex = args[1] as Mutex;

  final intPointer = Pointer<TestStruct>.fromAddress(structAddress);
  for (var i = 0; i < 10000; i++) {
    mutex.lock();
    intPointer.ref.value++;
    mutex.unlock();
  }
}
