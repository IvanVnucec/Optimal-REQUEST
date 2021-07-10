all: build

.PHONY: build
build: builddir
	@meson compile -C builddir

builddir:
	@meson setup builddir

.PHONY: test
test: build
	@cd matlab/tests && octave test_OR_rms_error.m && octave gen_meas_for_c.m
	@meson test -C builddir

.PHONY: run
run: build
	./builddir/src/demo

#TODO: this needs some kind of exit status
.PHONY: clang_format_check
clang_format_check:
	@cd scripts && python3 run-clang-format.py -r ../src

.PHONY: clang_format
clang_format:
	./scripts/clang_format.sh .

.PHONY: codecov
	@ninja coverage -v -C builddir

.PHONY: cppcheck
cppcheck:
	@cppcheck --quiet --enable=all --project=./builddir/compile_commands.json

.PHONY: doxygen
doxygen:
	@mkdir -p docs
	@mkdir -p docs/Doxygen
	@doxygen Doxyfile
	@echo "Done Generate Doxygen documentation."


.PHONY: matlab_codegen_c
matlab_codegen_c:
	@rm -rf matlab/codegen
	@cd matlab && matlab -batch "codegen_script_c"
	@mv src/opt_req/meson.build scripts
	@rm -rf src/opt_req
	@cp -R matlab/codegen/lib/get_quat_from_K src/opt_req
	@mv scripts/meson.build src/opt_req/meson.build
	@make clang_format

.PHONY: matlab_codegen_mex
matlab_codegen_mex:
	@cd matlab && matlab -batch "codegen_script_mex"

.PHONY: matlab_run
matlab_run:
	cd matlab/tests && \
	matlab -batch "run_OR"

.PHONY: octave_run
octave_run:
	cd matlab/tests && \
	octave test_OR_rms_error.m

.PHONY: matlab_test
matlab_test:
	cd matlab/tests && \
	octave --no-gui run_tests.m

.PHONY: help
help:
	@echo "make build - Build project"
	@echo "make test - Run unit tests"
	@echo "make run - Run demo example"
	@echo "make clang_format_check - Check if the code is formatted."
	@echo "make clang_format - Run Clang-format."
	@echo "make codecov - Run code coverage."
	@echo "make cppcheck - Run Cppcheck."
	@echo "make doxygen - Generate Doxygen documentation."
	@echo "make build - Build project."
	@echo "make test - Run unit tests."
	@echo "make matlab_codegen_c - Generate C code from MATLAB code with the MATLAB Code generator"
	@echo "make matlab_codegen_mex - Generate MATLAB MEX function with the MATLAB Code generator"
	@echo "make matlab_run - Run Optimal-REQUEST algorithm in Matlab"
	@echo "make octave_run - Run Optimal-REQUEST algorithm in GNU Octave"
	@echo "make matlab_test - Run Optima-REQUEST tests in GNU Octave"
	@echo "make clean - Clean build artifacts."
	@echo "make clean_matlab - Clean code from Matlab Code generator."

.PHONY: clean
clean:
	@rm -rf builddir

.PHONY: clean_matlab
clean_matlab:
	@rm -rf matlab/codegen matlab/get_quat_from_K_mex.mexa64
