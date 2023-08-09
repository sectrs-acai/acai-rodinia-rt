include ../../common/cuda.config

ifdef OUTPUT
override OUTPUT = -DOUTPUT
endif

# RD_WG_SIZE_0=10

# link objects(binaries) together
heartwall: main.cu.cpp ./AVI/avilib.o ./AVI/avimod.o
	$(CC) $(CCFLAGS)  $? -o heartwall $(LDFLAGS) $(CC_LIB_DIRS) $(CC_LIBS)

# compile main function file into object (binary)
./AVI/avilib.o ./AVI/avimod.o:
	cd AVI; make;

# delete all object files
clean:
	rm -f *.o AVI/*.o heartwall *.linkinfo

main.cu.cpp: main.cu
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -I./AVI -c $< -o $@  $(CUDA_FLAG)

#setdevice.cu.cpp: setdevice.cu
#	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -I./AVI -c $< -o $@  $(CUDA_FLAG)


include AVI/makefile

clean:
	rm -f *.cu.cpp AVI/*.o