#ifndef CCA_BENCHMARK_H_
#define CCA_BENCHMARK_H_

#ifndef EMIT_ARM_INSTR
#define EMIT_ARM_INSTR 1
#endif

#include <stdio.h>
#include "arm_bench.h"
#include <signal.h>

#ifdef __cplusplus
extern "C" {
#endif

#include <cuda.h>

#ifdef ENC_CUDA
CUresult cuda_enc_setup(char *key, char *iv);
CUresult cuda_enc_release();
#endif // ENC_CUDA

#ifdef __cplusplus
}
#endif // cplusplus

#if EMIT_ARM_INSTR == 0
#define CCA_MARKER(marker)
#define CCA_FLUSH
#define CCA_BENCHMARK_INIT _benchmark_init()
#define CCA_BENCHMARK_CLEANUP _benchmark_cleanup()
#define CCA_TRACE_START
#define CCA_TRACE_STOP


#else // EMIT_ARM_INSTR != 0

#define STR(s) #s
#define CCA_MARKER(marker) __asm__ volatile("MOV XZR, " STR(marker))

#define CCA_FLUSH __asm__ volatile("ISB");
#define CCA_TRACE_START __asm__ volatile("HLT 0x1337");
#define CCA_TRACE_STOP __asm__ volatile("HLT 0x1337");


static void __cca_sighandler(int signo, void *si, void *data)
{
    arm_ucontext_t *uc = (arm_ucontext_t *) data;
    uc->uc_mcontext.pc += 4;
}

#ifdef ENC_CUDA
#define IS_ENC_CUDA 1
#else // ENC_CUDA
#define IS_ENC_CUDA 0
#endif // ENC_CUDA

#define CCA_BENCHMARK_INIT                                                     \
  {                                                                          \
    printf("enc_cuda: %d\n", IS_ENC_CUDA);                                      \
    printf("cca is no bench: %d\n", IS_CCA_NO_BENCH);                        \
    struct arm_sigaction sa, osa;                                                   \
    sa.sa_flags = SA_FLAGS;                        \
    sa.__arm_sigaction_handler.sa_arm_sigaction = __cca_sighandler;            \
    sigaction(ARM_SIGILL, (struct sigaction *) &sa, (struct sigaction*) &osa);                                              \
                                                                               \
   _benchmark_init();                                                          \
  }

#define CCA_BENCHMARK_CLEANUP _benchmark_cleanup()

#endif // arm architecture


// -----------------------------------------------------------------------
/* for linux: */
#define CCA_INIT CCA_MARKER(0x1010)
#define CCA_INIT_STOP CCA_MARKER(0x1011)

#define CCA_MEMALLOC CCA_MARKER(0x1012)
#define CCA_MEMALLOC_STOP CCA_MARKER(0x1013)

#define CCA_EXEC CCA_MARKER(0x1014)
#define CCA_EXEC_STOP CCA_MARKER(0x1015)

#define CCA_CLOSE CCA_MARKER(0x1016)
#define CCA_CLOSE_STOP CCA_MARKER(0x1017)

#define CCA_H_TO_D CCA_MARKER(0x1018)
#define CCA_H_TO_D_STOP CCA_MARKER(0x1019)

#define CCA_D_TO_H CCA_MARKER(0x101A)
#define CCA_D_TO_H_STOP CCA_MARKER(0x101B)

#ifdef CCA_NO_BENCH

#define IS_CCA_NO_BENCH 1
#define CCA_BENCHMARK_START
#define CCA_BENCHMARK_STOP

#else // ^ CCA_NO_BENCH

#define IS_CCA_NO_BENCH 0
#define CCA_BENCHMARK_START                                             \
  CCA_TRACE_START;                                                             \
  CCA_FLUSH;                                                                             \
  CCA_MARKER(0x1)

#define CCA_BENCHMARK_STOP                                                     \
  CCA_MARKER(0x2);                                                             \
  CCA_FLUSH;                                                                             \
  CCA_TRACE_STOP

#endif // ^CCA_NO_BENCH

static inline int _benchmark_init(void)
{
    /* load encryption */
    #ifdef ENC_CUDA
    {
        printf("init: ENC_CUDA=1\n");
        char static_key[] = "0123456789abcdeF0123456789abcdeF";
        char static_iv[] = "12345678876543211234567887654321";

        CUresult ret = cuda_enc_setup(static_key, static_iv);
        if (ret != CUDA_SUCCESS) {
          fprintf(stderr, "cuda_enc_setup failed\n");
          return ret;
        }
  }
    #else
    printf("init: ENC_CUDA=0\n");
    #endif

    return CUDA_SUCCESS;
}

static inline int _benchmark_cleanup(void)
{
    /* unload encryption */
    #ifdef ENC_CUDA
    {
        printf("cleanup: ENC_CUDA=1\n");
        CUresult ret = cuda_enc_release();
        if (ret != CUDA_SUCCESS) {
          fprintf(stderr, "cuda_enc_release failed\n");
          return ret;
        }
  }
    #else
    printf("cleanup: ENC_CUDA=0\n");
    #endif
    return CUDA_SUCCESS;
}


#endif // CCA_BENCHMARK_H_

