import 'dart:io';

import 'package:thread/src/impl/mutex_unix.dart';
import 'package:thread/src/impl/mutex_windows.dart';

class MutexError {}

/// A mutex backed by real os level mutex. Use this with care. A instance of
/// [Mutex] must be freed by calling [destroy].
abstract class Mutex {
  factory Mutex.create() {
    if (Platform.isWindows) {
      return WindowsMutex.create();
    }

    return UnixMutex.create();
  }

  void lock();

  void unlock();

  // bool trylock();

  void destroy();
}
