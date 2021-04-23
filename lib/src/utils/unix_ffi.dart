import 'dart:ffi';

Unix? _unix;
Unix get unix {
  _unix ??= Unix(DynamicLibrary.process());
  return _unix!;
}

typedef _c_pthread_mutex_init = Int32 Function(
    Pointer<Uint8> mutex_t, Int32 attr);
typedef _dart_pthread_mutex_init = int Function(
    Pointer<Uint8> mutex_t, int attr);

typedef _c_pthread_mutex_lock = Int32 Function(Pointer<Uint8> mutex_t);
typedef _dart_pthread_mutex_lock = int Function(Pointer<Uint8> mutex_t);

class Unix {
  Unix(DynamicLibrary lib) {
    pthreadMutexInit =
        lib.lookupFunction<_c_pthread_mutex_init, _dart_pthread_mutex_init>(
            'pthread_mutex_init');

    pthreadMutexLock =
        lib.lookupFunction<_c_pthread_mutex_lock, _dart_pthread_mutex_lock>(
            'pthread_mutex_lock');

    pthreadMutexUnlock =
        lib.lookupFunction<_c_pthread_mutex_lock, _dart_pthread_mutex_lock>(
            'pthread_mutex_unlock');

    pthreadMutexTrylock =
        lib.lookupFunction<_c_pthread_mutex_lock, _dart_pthread_mutex_lock>(
            'pthread_mutex_trylock');

    pthreadMutexDestroy =
        lib.lookupFunction<_c_pthread_mutex_lock, _dart_pthread_mutex_lock>(
            'pthread_mutex_destroy');
  }

  late final Pointer<Int32> errno;

  late final _dart_pthread_mutex_init pthreadMutexInit;
  late final _dart_pthread_mutex_lock pthreadMutexLock;
  late final _dart_pthread_mutex_lock pthreadMutexUnlock;
  late final _dart_pthread_mutex_lock pthreadMutexTrylock;
  late final _dart_pthread_mutex_lock pthreadMutexDestroy;
}
