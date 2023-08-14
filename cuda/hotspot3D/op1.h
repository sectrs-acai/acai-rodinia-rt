#define BLOCK_SIZE 16
#define STR_SIZE 256

#define block_x_ 128
#define block_y_ 2
#define block_z_ 1
#define MAX_PD	(3.0e6)
/* required precision in degrees	*/
#define PRECISION	0.001
#define SPEC_HEAT_SI 1.75e6
#define K_SI 100
/* capacitance fitting factor	*/
#define FACTOR_CHIP	0.5

void hotspot_opt1(float *p, float *tIn, float *tOut,
                  int nx, int ny, int nz,
                  float Cap,
                  float Rx, float Ry, float Rz,
                  float dt, int numiter);
