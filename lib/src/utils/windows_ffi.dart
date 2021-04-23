import 'dart:ffi';

Windows? _windows;
Windows get windows {
  _windows ??= Windows(DynamicLibrary.open('kernel32.dll'));
  return _windows!;
}

typedef _c_InitializeCriticalSection = Int32 Function(
    Pointer<Uint8> LPCRITICAL_SECTION);
typedef _dart_InitializeCriticalSection = int Function(
    Pointer<Uint8> LPCRITICAL_SECTION);

typedef _c_EnterCriticalSection = Void Function(Pointer<Uint8> mutex_t);
typedef _dart_EnterCriticalSection = void Function(Pointer<Uint8> mutex_t);

typedef _c_LeaveCriticalSection = Void Function(Pointer<Uint8> mutex_t);
typedef _dart_LeaveCriticalSection = void Function(Pointer<Uint8> mutex_t);

typedef _c_DeleteCriticalSection = Void Function(Pointer<Uint8> mutex_t);
typedef _dart_DeleteCriticalSection = void Function(Pointer<Uint8> mutex_t);

class Windows {
  Windows(DynamicLibrary lib) {
    InitializeCriticalSection = lib.lookupFunction<_c_InitializeCriticalSection,
        _dart_InitializeCriticalSection>('InitializeCriticalSection');

    EnterCriticalSection =
        lib.lookupFunction<_c_EnterCriticalSection, _dart_EnterCriticalSection>(
            'EnterCriticalSection');

    LeaveCriticalSection =
        lib.lookupFunction<_c_LeaveCriticalSection, _dart_LeaveCriticalSection>(
            'LeaveCriticalSection');

    DeleteCriticalSection = lib.lookupFunction<_c_DeleteCriticalSection,
        _dart_DeleteCriticalSection>('DeleteCriticalSection');
  }

  late final Pointer<Int32> errno;

  late final _dart_InitializeCriticalSection InitializeCriticalSection;
  late final _dart_EnterCriticalSection EnterCriticalSection;
  late final _dart_LeaveCriticalSection LeaveCriticalSection;
  late final _dart_DeleteCriticalSection DeleteCriticalSection;
}
