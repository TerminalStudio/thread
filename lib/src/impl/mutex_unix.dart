import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:thread/src/utils/unix_ffi.dart';
import 'package:thread/thread.dart';

class UnixMutex implements Mutex {
  UnixMutex.create() {
    final mutex = calloc<Uint8>(100);
    mutexAddress = mutex.address;

    final result = unix.pthreadMutexInit(mutex, 0);

    if (result != 0) {
      calloc.free(mutex);
      throw MutexError();
    }
  }

  late final int mutexAddress;

  @override
  void lock() {
    final mutex = Pointer<Uint8>.fromAddress(mutexAddress);
    final result = unix.pthreadMutexLock(mutex);
    if (result != 0) {
      throw MutexError();
    }
  }

  @override
  void unlock() {
    final mutex = Pointer<Uint8>.fromAddress(mutexAddress);
    final result = unix.pthreadMutexUnlock(mutex);
    if (result != 0) {
      throw MutexError();
    }
  }

  @override
  bool trylock() {
    final mutex = Pointer<Uint8>.fromAddress(mutexAddress);
    return unix.pthreadMutexTrylock(mutex) == 0;
  }

  @override
  void destroy() {
    final mutex = Pointer<Uint8>.fromAddress(mutexAddress);

    final result = unix.pthreadMutexDestroy(mutex);
    if (result != 0) {
      throw MutexError();
    }

    calloc.free(mutex);
  }
}
