#ifndef __firstinclude_h
#define __firstinclude_h

/* THIS IS C FILE, NO C++ here */

/*
* This is the first file you should include from user space apps
*/

#ifndef _GNU_SOURCE
#define _GNU_SOURCE // needed for SCHED_IDLE, SCHED_BATCH
#endif // _GNU_SOURCE

#ifndef __USE_GNU
#define __USE_GNU // Needed to get REG_EIP from ucontext.h
#endif // __USE_GNU

#endif /* !__firstinclude_h */
