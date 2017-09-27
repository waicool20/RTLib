#include "config/config.h"

#if defined(LIB_USE_LED) && (EMPTY_MACRO(LIB_USE_LED) != 1)

#include "lib/led.h"

#include <cassert>

namespace {
inline Pinout GetConfigPinout(const uint8_t id) {
  assert(id < LIB_USE_LED);
  switch (id) {
    default:
      // not handled, since assert will catch this error
      assert(false);
      break;
#if LIB_USE_LED > 0
    case 0:
      return LIB_LED1_PINOUT;
#endif
  }
}
}  // namespace

Led::Led(const Config& config) :
    gpio_(GetConfigPinout(config.id), GPIO_CNF_OUTPUT_PUSHPULL, GPIO_MODE_OUTPUT_50_MHZ),
    polarity_(config.polarity) {
  SetEnable(false);
}

void Led::SetEnable(const bool flag) {
  gpio_.Set(polarity_ ^ flag);
}

void Led::Switch() {
  gpio_.Toggle();
}

#else
#error "LIB_USE_LED macro not found. (Did you define it in your board configuration?)"
#endif  // defined(LIB_USE_LED)
