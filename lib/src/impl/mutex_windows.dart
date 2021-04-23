import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:thread/src/utils/windows_ffi.dart';
import 'package:thread/thread.dart';

class WindowsMutex implements Mutex {
  WindowsMutex.create() {
    final criticalSection = calloc<Uint8>(128);
    criticalSectionAddress = criticalSection.address;
    windows.InitializeCriticalSection(criticalSection);
  }

  late final int criticalSectionAddress;

  @override
  void lock() {
    final criticalSection = Pointer<Uint8>.fromAddress(criticalSectionAddress);
    windows.EnterCriticalSection(criticalSection);
  }

  @override
  void unlock() {
    final criticalSection = Pointer<Uint8>.fromAddress(criticalSectionAddress);
    windows.LeaveCriticalSection(criticalSection);
  }

  @override
  void destroy() {
    final criticalSection = Pointer<Uint8>.fromAddress(criticalSectionAddress);
    windows.DeleteCriticalSection(criticalSection);
    calloc.free(criticalSection);
  }
}
