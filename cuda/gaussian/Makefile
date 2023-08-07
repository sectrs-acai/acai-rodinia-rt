include ../../common/cuda.config


SRC = gaussian.cu
EXE = gaussian



all:
	$(NVCC) $(NVCC_FLAGS) gaussian.cu -o gaussian.cu.cpp
	$(CC) $(KERNEL_DIM) gaussian.cu.cpp -o $(EXE) $(CC_LIBS) $(CC_LIB_DIRS)

clang: $(SRC)
	clang++ $(SRC) -o $(EXE) -I../util --cuda-gpu-arch=sm_20 \
		-L/usr/local/cuda/lib64 -lcudart_static -ldl -lrt -pthread -DTIMING

clean:
	rm gaussian
