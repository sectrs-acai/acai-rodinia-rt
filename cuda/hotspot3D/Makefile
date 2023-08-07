include ../../common/cuda.config

SRC = 3D.cu

EXE = 3D

release: 3D.cu.cpp
	$(CXX) $(CXX_FLAGS) $? -o 3D $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)

3D.cu.cpp: 3D.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c $< -o $@  $(CUDA_FLAG)

clean:
	rm -f 3D 3D.cu.cpp
