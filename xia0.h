#define GCD_AFTER_MAIN(__dp_af) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(__dp_af * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
#define GCD_AFTER(__dp_af, __dp_q) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(__dp_af * NSEC_PER_SEC)), dispatch_queue_create(__dp_q, NULL), ^{
#define GCD_END });