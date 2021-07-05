all:
	@echo "help: \n\
		matlab_run - Run Optimal-REQUEST algorithm in Matlab \n \
		matlab_test - Run Optima-REQUEST tests in GNU Octave \n \
		install_gnu_octave - Installs GNU Octave with apt-get. You might want to run make with sudo \n \
	"

.PHONY: matlab_run
matlab_run:
	octave matlab/main.m 

.PHONY: matlab_test
matlab_test:
	./scripts/test_matlab.sh

.PHONY: install_gnu_octave
install_gnu_octave:
	./scripts/install_gnu_octave.sh
