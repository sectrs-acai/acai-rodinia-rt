include ../../common/cuda.config

myocyte:		main.cu.cpp
	$(CC) $(CCFLAGS) $? -o $@  $(CC_LIB_DIRS) $(CC_LIBS)

main.cu.cpp : define.c \
              				main.cu \
              				work.cu \
              				solver.cu \
              				embedded_fehlberg_7_8.cu \
              				master.cu \
              				kernel.cu \
              				kernel_ecc.cu \
              				kernel_cam.cu \
              				kernel_fin.cu \
              				work_2.cu \
              				solver_2.cu \
              				embedded_fehlberg_7_8_2.cu \
              				kernel_2.cu \
              				kernel_ecc_2.cu \
              				kernel_cam_2.cu \
              				kernel_fin_2.cu \
              				file.c \
              				timer.c
	$(NVCC) $(OUTPUT) $(NVCC_FLAGS) -c main.cu -o main.cu.cpp  $(CUDA_FLAG)

clean:
	rm -f *.o *.out output.txt *.cu.cpp myocyte
