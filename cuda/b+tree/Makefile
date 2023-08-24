include ../../common/cuda.config
C_C = $(CC)
CUD_C = $(NVCC)

b+tree.out:	./main.o \
		./kernel/kernel_gpu_cuda_wrapper.cu.cpp \
		./util/timer/timer.o \
		./util/num/num.o
	$(CC)	$(CCFLAGS) $? $(CC_LIB_DIRS) $(CC_LIBS) -o b+tree.out

main.o:	./common.h \
		./main.h \
		./main.c
	$(CC)	$(CCFLAGS) $(KERNEL_DIM) -O3 ./main.c \
			-c \
			-o ./main.o $(CC_LIBS)

./kernel/kernel_gpu_cuda_wrapper.cu.cpp:	./common.h \
									./kernel/kernel_gpu_cuda_wrapper.h \
									./kernel/kernel_gpu_cuda_wrapper.cu
	$(NVCC) $(KERNEL_DIM) $(NVCC_FLAGS) ./kernel/kernel_gpu_cuda_wrapper.cu \
				-c \
				-o $@ \
				$(CUDA_FLAG) $(CC_LIBS)

./util/timer/timer.o:	./common.h \
						./util/timer/timer.h \
						./util/timer/timer.c
	$(CC) $(CCFLAGS)	./util/timer/timer.c \
			-c \
			-o ./util/timer/timer.o \
			-O3 $(CC_LIBS)

./util/num/num.o:	./common.h \
					./util/num/num.h \
					./util/num/num.c
	$(CC) $(CCFLAGS)	./util/num/num.c \
			-c \
			-o ./util/num/num.o \
			-O3 $(CC_LIBS)

clean_cu_cpp:
	rm	*.cu.cpp ./kernel/*.cu.cpp ./util/cuda/*.cu.cpp

clean:
	rm	-f *.o *.out \
		./kernel/*.o \
		./util/timer/*.o \
		./util/num/*.o \
		./util/cuda/*.o \
                output.txt ./util/cuda/*.cu.cpp  ./util/num/*.cu.cpp ./util/timer/*.cu.cpp ./kernel/*.cu.cpp
