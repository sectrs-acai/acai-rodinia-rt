#makefile

include ../../common/cuda.config

#CC := $(CUDA_DIR)/bin/nvcc

#INCLUDE := $(CUDA_DIR)/include

all: particlefilter_naive particlefilter_float


# $(CC) -I$(INCLUDE) -L$(CUDA_LIB_DIR) -lcuda -g -lm -O3 -use_fast_math -arch sm_13 ex_particle_CUDA_naive_seq.cu -o particlefilter_naive
naive.cu.cpp: ex_particle_CUDA_naive_seq.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

# $(CC) -I$(INCLUDE) -L$(CUDA_LIB_DIR) -lcuda -g -lm -O3 -use_fast_math -arch sm_13 ex_particle_CUDA_float_seq.cu -o particlefilter_float
float.cu.cpp: ex_particle_CUDA_float_seq.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS)  -c $< -o $@  $(CUDA_FLAG)

particlefilter_naive: naive.cu.cpp
	$(CXX) $(CXX_FLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

particlefilter_float: float.cu.cpp
	$(CXX) $(CXX_FLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

#naive: ex_particle_CUDA_naive_seq.cu
#	$(CC) -I$(INCLUDE) -L$(CUDA_LIB_DIR) -lcuda -g -lm -O3 -use_fast_math -arch sm_13 ex_particle_CUDA_naive_seq.cu -o particlefilter_naive

#float: ex_particle_CUDA_float_seq.cu
#	$(CC) -I$(INCLUDE) -L$(CUDA_LIB_DIR) -lcuda -g -lm -O3 -use_fast_math -arch sm_13 ex_particle_CUDA_float_seq.cu -o particlefilter_float


clean:
	rm particlefilter_naive particlefilter_float *.cu.cpp
