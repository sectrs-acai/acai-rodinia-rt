
include ../../common/cuda.config
all: particlefilter_naive particlefilter_float

naive.cu.cpp: ex_particle_CUDA_naive_seq.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)


float.cu.cpp: ex_particle_CUDA_float_seq.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS)  -c $< -o $@  $(CUDA_FLAG)

particlefilter_naive: naive.cu.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

particlefilter_float: float.cu.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

clean:
	rm -f particlefilter_naive particlefilter_float *.cu.cpp
