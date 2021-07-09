all:
	@echo "help: \n\
		make matlab_codegen_c - Generate C code from MATLAB code with the MATLAB Code generator \n \
		make matlab_codegen_mex - Generate MATLAB MEX function with the MATLAB Code generator \n \
		make matlab_run - Run Optimal-REQUEST algorithm in Matlab \n \
		make octave_run - Run Optimal-REQUEST algorithm in GNU Octave \n \
		make matlab_test - Run Optima-REQUEST tests in GNU Octave \n \
		make install_gnu_octave - Installs GNU Octave with apt-get. You might want to run make with sudo \n \
		make clean - Clean the generated code \n \
	"


.PHONY: matlab_codegen_c
matlab_codegen_c:
	./scripts/matlab_codegen_c.sh

.PHONY: matlab_codegen_mex
matlab_codegen_mex:
	./scripts/matlab_codegen_mex.sh

.PHONY: matlab_run
matlab_run:
	./scripts/matlab_run.sh

.PHONY: octave_run
octave_run:
	./scripts/octave_run.sh

.PHONY: matlab_test
matlab_test:
	./scripts/test_matlab.sh

.PHONY: install_gnu_octave
install_gnu_octave:
	./scripts/install_gnu_octave.sh

.PHONY: clean
clean:
	rm -rf matlab/codegen matlab/get_quat_from_K_mex.mexa64
