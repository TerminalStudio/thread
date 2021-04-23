#include <synchapi.h>

void main() {
    LPCRITICAL_SECTION cr;
    InitializeCriticalSection(cr);
    EnterCriticalSection(cr);
    LeaveCriticalSection(cr);
    DeleteCriticalSection(cr);
}