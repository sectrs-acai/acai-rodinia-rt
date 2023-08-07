include ../../common/cuda.config

# C compiler
# CC = gcc
# CC_FLAGS += -fopenmp

# CUDA compiler
#NVCC = $(CUDA_DIR)/bin/nvcc
#NVCC_FLAGS = -I$(CUDA_DIR)/include

# 'make dbg=1' enables NVCC debugging
#ifeq ($(dbg),1)
#	NVCC_FLAGS += -g -O0
#else
#	NVCC_FLAGS += -O2
#endif
#
## 'make emu=1' compiles the CUDA kernels for emulation
#ifeq ($(emu),1)
#	NVCC_FLAGS += -deviceemu
#endif


# kmeans: cluster.o getopt.o kmeans.o kmeans_clustering.o kmeans_cuda.cu.cpp rmse.o
kmeans: cluster.o getopt.o kmeans.o kmeans_clustering.o kmeans_cuda.cu.cpp rmse.o
	$(CXX) $(CXX_FLAGS) $? -o $@ $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)
	# $(CC) $(CC_FLAGS) cluster.o getopt.o kmeans.o kmeans_clustering.o kmeans_cuda.o rmse.o -o kmeans -L$(CUDA_LIB_DIR) -lcuda -lcudart -lm

kmeans.o: kmeans.c
	$(CC) $(CC_FLAGS) $< -c

%.o: %.[ch]
	#$(CX) $(CXX_FLAGS) $? -o 3D $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)
	$(CC) $(CC_FLAGS) $< -c

kmeans_cuda.cu.cpp: kmeans_cuda.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

kmeans_cuda_kernel.cu.cpp: kmeans_cuda_kernel.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

#kmeans_cuda.o: kmeans_cuda.cu
#	$(NVCC) $(NVCC_FLAGS) -c kmeans_cuda.cu

clean:
	rm -f *.o *~ kmeans kmeans_cuda.linkinfo *.cu.cpp
