#ifndef CCA_BENCHMARK_H_ARM_BENCH
#define CCA_BENCHMARK_H_ARM_BENCH

/*
 * Issue:
 * Since compilation process is two folded:
 * 1: cu -> cpp with gcc 4
 * 2. cpp -> obj with {modern gcc|cross comipler}
 * preprocessor macros such as #if defined(__x86_64__) || defined(_M_X64)
 * do not work because in stage 1 we always use x86 compiler
 * This file contains all arm header files required in stage 1
 */

union arm_sigval
{
    int sival_int;
    void *sival_ptr;
};

typedef union arm_sigval arm___sigval_t;
typedef struct {
    int si_signo;
    int si_errno;
    int si_code;
    int __pad0;
    union {
        int _pad[((128 / sizeof(int)) - 4)];
        struct {
            __pid_t si_pid;
            __uid_t si_uid;
        } _kill;

        struct {
            int si_tid;
            int si_overrun;
            arm___sigval_t si_sigval;
        } _timer;

        struct {
            __pid_t si_pid;
            __uid_t si_uid;
            arm___sigval_t si_sigval;
        } _rt;

        struct {
            __pid_t si_pid;
            __uid_t si_uid;
            int si_status;
            __clock_t si_utime;
            __clock_t si_stime;
        } _sigchld;

        struct {
            void *si_addr;

            short int si_addr_lsb;
            union {

                struct {
                    void *_lower;
                    void *_upper;
                } _addr_bnd;

                __uint32_t _pkey;
            } _bounds;
        } _sigfault;

        struct {
            long int si_band;
            int si_fd;
        } _sigpoll;

        struct {
            void *_call_addr;
            int _syscall;
            unsigned int _arch;
        } _sigsys;

    } _sifields;
} w;

typedef void (*__arm_sighandler_t)(int);

typedef struct {
    unsigned long int __val[(1024 / (8 * sizeof(unsigned long int)))];
} __arm_sigset_t;

typedef __arm_sigset_t arm_sigset_t;

struct arm_sigaction {
    union {
        __arm_sighandler_t sa_handler;
        // void (*sa_arm_sigaction)(int, __arm_siginfo_t *, void *);
        void (*sa_arm_sigaction)(int, void *, void *);
    } __arm_sigaction_handler;
    __arm_sigset_t sa_mask;
    int sa_flags;
    void (*sa_restorer)(void);
};

typedef struct {
    void *ss_sp;
    int ss_flags;
    size_t ss_size;
} arm_stack_t;

typedef struct {
    unsigned long long int fault_address;
    unsigned long long int regs[31];
    unsigned long long int sp;
    unsigned long long int pc;
    unsigned long long int pstate;
    unsigned char __reserved[4096] __attribute__ ((__aligned__ (16)));
} arm_mcontext_t;

typedef struct arm_ucontext_t {
    unsigned long uc_flags;
    struct arm_ucontext_t *uc_link;
    arm_stack_t uc_stack;
    arm_sigset_t uc_sigmask;
    arm_mcontext_t uc_mcontext;
} arm_ucontext_t;


// SA_ONSTACK | SA_RESTART | SA_SIGINFO;
#define SA_FLAGS (0x08000000 | 0x10000000 | 4);

#define ARM_SIGILL   4

#endif