.PHONY: all build test run clang_format_check clang_format codecov \
	cppcheck matlab_codegen matlab_run octave_run matlab_test \
	help clean clean_matlab lib_size cross_build cross_size

all: build

build: builddir
	@ninja -C builddir

builddir:
	@meson builddir -Db_coverage=true

test: build
	@cd matlab/tests && \
		octave --no-gui --no-window-system test_OR_rms_error.m && \
		octave --no-gui --no-window-system gen_meas_for_c.m
	@meson test -C builddir
	@./scripts/clear_meas_data_c.sh

run: build
	@cd matlab/tests && octave --no-gui --no-window-system gen_meas_for_c.m
	@./builddir/src/demo
	@./scripts/clear_meas_data_c.sh

clang_format_check:
	@cd scripts && python3 run-clang-format.py -r ../src

clang_format:
	@./scripts/clang_format.sh .

codecov: build
	@ninja -C builddir coverage-html

cppcheck:
	@mkdir -p logs
	@cppcheck --std=c99 --template=gcc --output-file=logs/cppcheck.log --quiet --enable=all --project=./builddir/compile_commands.json

matlab_codegen:
	@rm -rf matlab/codegen
	@matlab -sd matlab -noFigureWindows -batch "codegen_script_c"
	@mv src/opt_req/meson.build scripts
	@rm -rf src/opt_req
	@cp -R matlab/codegen/lib/get_quat_from_K src/opt_req
	@mv scripts/meson.build src/opt_req/meson.build
	@make clang_format

matlab_run:
	@matlab -sd matlab/tests -noFigureWindows -batch "run_OR"

octave_run:
	@cd matlab/tests && octave --no-gui --no-window-system test_OR_rms_error.m

matlab_test:
	@cd matlab/tests && octave --no-gui --no-window-system run_tests.m

lib_size:
	@size builddir/src/opt_req/libopt_req.a --format=SysVD

cross_build: cross_builddir
	@ninja -C cross_builddir
	@make cross_size

cross_builddir:
	@meson cross_builddir --cross-file cross_file.cfg -Dbuildtype=minsize

cross_size:
	@arm-none-eabi-size cross_builddir/src/opt_req/libopt_req_cross.a --totals --format=gnu

help:
	@echo "make build - Build project"
	@echo "make test - Run unit tests"
	@echo "make run - Run demo example"
	@echo "make clang_format_check - Check if the code is formatted."
	@echo "make clang_format - Run Clang-format."
	@echo "make codecov - Run code coverage."
	@echo "make cppcheck - Run Cppcheck."
	@echo "make build - Build project."
	@echo "make test - Run unit tests."
	@echo "make matlab_codegen - Generate C code from MATLAB code with the MATLAB Code generator"
	@echo "make matlab_run - Run Optimal-REQUEST algorithm in Matlab"
	@echo "make octave_run - Run Optimal-REQUEST algorithm in GNU Octave"
	@echo "make matlab_test - Run Optima-REQUEST tests in GNU Octave"
	@echo "make clean - Clean build artifacts."
	@echo "make clean_matlab - Clean code from Matlab Code generator."
	@echo "make lib_size - Show Optimal-REQUEST library size."

clean:
	@rm -rf builddir cross_builddir

clean_matlab:
	@rm -rf matlab/codegen matlab/get_quat_from_K_mex.mexa64
