# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Produce verbose output by default.
VERBOSE = 1

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /media/h3/Study/Git/Human-detection-by-HOG/c

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /media/h3/Study/Git/Human-detection-by-HOG/c/build

# Include any dependencies generated for this target.
include CMakeFiles/hog.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/hog.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/hog.dir/flags.make

CMakeFiles/hog.dir/lsi_2017.c.o: CMakeFiles/hog.dir/flags.make
CMakeFiles/hog.dir/lsi_2017.c.o: ../lsi_2017.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/hog.dir/lsi_2017.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hog.dir/lsi_2017.c.o   -c /media/h3/Study/Git/Human-detection-by-HOG/c/lsi_2017.c

CMakeFiles/hog.dir/lsi_2017.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hog.dir/lsi_2017.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /media/h3/Study/Git/Human-detection-by-HOG/c/lsi_2017.c > CMakeFiles/hog.dir/lsi_2017.c.i

CMakeFiles/hog.dir/lsi_2017.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hog.dir/lsi_2017.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /media/h3/Study/Git/Human-detection-by-HOG/c/lsi_2017.c -o CMakeFiles/hog.dir/lsi_2017.c.s

CMakeFiles/hog.dir/lsi_2017.c.o.requires:

.PHONY : CMakeFiles/hog.dir/lsi_2017.c.o.requires

CMakeFiles/hog.dir/lsi_2017.c.o.provides: CMakeFiles/hog.dir/lsi_2017.c.o.requires
	$(MAKE) -f CMakeFiles/hog.dir/build.make CMakeFiles/hog.dir/lsi_2017.c.o.provides.build
.PHONY : CMakeFiles/hog.dir/lsi_2017.c.o.provides

CMakeFiles/hog.dir/lsi_2017.c.o.provides.build: CMakeFiles/hog.dir/lsi_2017.c.o


CMakeFiles/hog.dir/png/Cal_HOG_block.c.o: CMakeFiles/hog.dir/flags.make
CMakeFiles/hog.dir/png/Cal_HOG_block.c.o: ../png/Cal_HOG_block.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/hog.dir/png/Cal_HOG_block.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hog.dir/png/Cal_HOG_block.c.o   -c /media/h3/Study/Git/Human-detection-by-HOG/c/png/Cal_HOG_block.c

CMakeFiles/hog.dir/png/Cal_HOG_block.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hog.dir/png/Cal_HOG_block.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /media/h3/Study/Git/Human-detection-by-HOG/c/png/Cal_HOG_block.c > CMakeFiles/hog.dir/png/Cal_HOG_block.c.i

CMakeFiles/hog.dir/png/Cal_HOG_block.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hog.dir/png/Cal_HOG_block.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /media/h3/Study/Git/Human-detection-by-HOG/c/png/Cal_HOG_block.c -o CMakeFiles/hog.dir/png/Cal_HOG_block.c.s

CMakeFiles/hog.dir/png/Cal_HOG_block.c.o.requires:

.PHONY : CMakeFiles/hog.dir/png/Cal_HOG_block.c.o.requires

CMakeFiles/hog.dir/png/Cal_HOG_block.c.o.provides: CMakeFiles/hog.dir/png/Cal_HOG_block.c.o.requires
	$(MAKE) -f CMakeFiles/hog.dir/build.make CMakeFiles/hog.dir/png/Cal_HOG_block.c.o.provides.build
.PHONY : CMakeFiles/hog.dir/png/Cal_HOG_block.c.o.provides

CMakeFiles/hog.dir/png/Cal_HOG_block.c.o.provides.build: CMakeFiles/hog.dir/png/Cal_HOG_block.c.o


CMakeFiles/hog.dir/png/helper.c.o: CMakeFiles/hog.dir/flags.make
CMakeFiles/hog.dir/png/helper.c.o: ../png/helper.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/hog.dir/png/helper.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hog.dir/png/helper.c.o   -c /media/h3/Study/Git/Human-detection-by-HOG/c/png/helper.c

CMakeFiles/hog.dir/png/helper.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hog.dir/png/helper.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /media/h3/Study/Git/Human-detection-by-HOG/c/png/helper.c > CMakeFiles/hog.dir/png/helper.c.i

CMakeFiles/hog.dir/png/helper.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hog.dir/png/helper.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /media/h3/Study/Git/Human-detection-by-HOG/c/png/helper.c -o CMakeFiles/hog.dir/png/helper.c.s

CMakeFiles/hog.dir/png/helper.c.o.requires:

.PHONY : CMakeFiles/hog.dir/png/helper.c.o.requires

CMakeFiles/hog.dir/png/helper.c.o.provides: CMakeFiles/hog.dir/png/helper.c.o.requires
	$(MAKE) -f CMakeFiles/hog.dir/build.make CMakeFiles/hog.dir/png/helper.c.o.provides.build
.PHONY : CMakeFiles/hog.dir/png/helper.c.o.provides

CMakeFiles/hog.dir/png/helper.c.o.provides.build: CMakeFiles/hog.dir/png/helper.c.o


CMakeFiles/hog.dir/png/human_detection.c.o: CMakeFiles/hog.dir/flags.make
CMakeFiles/hog.dir/png/human_detection.c.o: ../png/human_detection.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/hog.dir/png/human_detection.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hog.dir/png/human_detection.c.o   -c /media/h3/Study/Git/Human-detection-by-HOG/c/png/human_detection.c

CMakeFiles/hog.dir/png/human_detection.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hog.dir/png/human_detection.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /media/h3/Study/Git/Human-detection-by-HOG/c/png/human_detection.c > CMakeFiles/hog.dir/png/human_detection.c.i

CMakeFiles/hog.dir/png/human_detection.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hog.dir/png/human_detection.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /media/h3/Study/Git/Human-detection-by-HOG/c/png/human_detection.c -o CMakeFiles/hog.dir/png/human_detection.c.s

CMakeFiles/hog.dir/png/human_detection.c.o.requires:

.PHONY : CMakeFiles/hog.dir/png/human_detection.c.o.requires

CMakeFiles/hog.dir/png/human_detection.c.o.provides: CMakeFiles/hog.dir/png/human_detection.c.o.requires
	$(MAKE) -f CMakeFiles/hog.dir/build.make CMakeFiles/hog.dir/png/human_detection.c.o.provides.build
.PHONY : CMakeFiles/hog.dir/png/human_detection.c.o.provides

CMakeFiles/hog.dir/png/human_detection.c.o.provides.build: CMakeFiles/hog.dir/png/human_detection.c.o


CMakeFiles/hog.dir/png/lodepng.c.o: CMakeFiles/hog.dir/flags.make
CMakeFiles/hog.dir/png/lodepng.c.o: ../png/lodepng.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object CMakeFiles/hog.dir/png/lodepng.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hog.dir/png/lodepng.c.o   -c /media/h3/Study/Git/Human-detection-by-HOG/c/png/lodepng.c

CMakeFiles/hog.dir/png/lodepng.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hog.dir/png/lodepng.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /media/h3/Study/Git/Human-detection-by-HOG/c/png/lodepng.c > CMakeFiles/hog.dir/png/lodepng.c.i

CMakeFiles/hog.dir/png/lodepng.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hog.dir/png/lodepng.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /media/h3/Study/Git/Human-detection-by-HOG/c/png/lodepng.c -o CMakeFiles/hog.dir/png/lodepng.c.s

CMakeFiles/hog.dir/png/lodepng.c.o.requires:

.PHONY : CMakeFiles/hog.dir/png/lodepng.c.o.requires

CMakeFiles/hog.dir/png/lodepng.c.o.provides: CMakeFiles/hog.dir/png/lodepng.c.o.requires
	$(MAKE) -f CMakeFiles/hog.dir/build.make CMakeFiles/hog.dir/png/lodepng.c.o.provides.build
.PHONY : CMakeFiles/hog.dir/png/lodepng.c.o.provides

CMakeFiles/hog.dir/png/lodepng.c.o.provides.build: CMakeFiles/hog.dir/png/lodepng.c.o


CMakeFiles/hog.dir/png/rwpng.c.o: CMakeFiles/hog.dir/flags.make
CMakeFiles/hog.dir/png/rwpng.c.o: ../png/rwpng.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/hog.dir/png/rwpng.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hog.dir/png/rwpng.c.o   -c /media/h3/Study/Git/Human-detection-by-HOG/c/png/rwpng.c

CMakeFiles/hog.dir/png/rwpng.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hog.dir/png/rwpng.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /media/h3/Study/Git/Human-detection-by-HOG/c/png/rwpng.c > CMakeFiles/hog.dir/png/rwpng.c.i

CMakeFiles/hog.dir/png/rwpng.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hog.dir/png/rwpng.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /media/h3/Study/Git/Human-detection-by-HOG/c/png/rwpng.c -o CMakeFiles/hog.dir/png/rwpng.c.s

CMakeFiles/hog.dir/png/rwpng.c.o.requires:

.PHONY : CMakeFiles/hog.dir/png/rwpng.c.o.requires

CMakeFiles/hog.dir/png/rwpng.c.o.provides: CMakeFiles/hog.dir/png/rwpng.c.o.requires
	$(MAKE) -f CMakeFiles/hog.dir/build.make CMakeFiles/hog.dir/png/rwpng.c.o.provides.build
.PHONY : CMakeFiles/hog.dir/png/rwpng.c.o.provides

CMakeFiles/hog.dir/png/rwpng.c.o.provides.build: CMakeFiles/hog.dir/png/rwpng.c.o


CMakeFiles/hog.dir/png/SVMclassification.c.o: CMakeFiles/hog.dir/flags.make
CMakeFiles/hog.dir/png/SVMclassification.c.o: ../png/SVMclassification.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object CMakeFiles/hog.dir/png/SVMclassification.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hog.dir/png/SVMclassification.c.o   -c /media/h3/Study/Git/Human-detection-by-HOG/c/png/SVMclassification.c

CMakeFiles/hog.dir/png/SVMclassification.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hog.dir/png/SVMclassification.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /media/h3/Study/Git/Human-detection-by-HOG/c/png/SVMclassification.c > CMakeFiles/hog.dir/png/SVMclassification.c.i

CMakeFiles/hog.dir/png/SVMclassification.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hog.dir/png/SVMclassification.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /media/h3/Study/Git/Human-detection-by-HOG/c/png/SVMclassification.c -o CMakeFiles/hog.dir/png/SVMclassification.c.s

CMakeFiles/hog.dir/png/SVMclassification.c.o.requires:

.PHONY : CMakeFiles/hog.dir/png/SVMclassification.c.o.requires

CMakeFiles/hog.dir/png/SVMclassification.c.o.provides: CMakeFiles/hog.dir/png/SVMclassification.c.o.requires
	$(MAKE) -f CMakeFiles/hog.dir/build.make CMakeFiles/hog.dir/png/SVMclassification.c.o.provides.build
.PHONY : CMakeFiles/hog.dir/png/SVMclassification.c.o.provides

CMakeFiles/hog.dir/png/SVMclassification.c.o.provides.build: CMakeFiles/hog.dir/png/SVMclassification.c.o


# Object files for target hog
hog_OBJECTS = \
"CMakeFiles/hog.dir/lsi_2017.c.o" \
"CMakeFiles/hog.dir/png/Cal_HOG_block.c.o" \
"CMakeFiles/hog.dir/png/helper.c.o" \
"CMakeFiles/hog.dir/png/human_detection.c.o" \
"CMakeFiles/hog.dir/png/lodepng.c.o" \
"CMakeFiles/hog.dir/png/rwpng.c.o" \
"CMakeFiles/hog.dir/png/SVMclassification.c.o"

# External object files for target hog
hog_EXTERNAL_OBJECTS =

hog: CMakeFiles/hog.dir/lsi_2017.c.o
hog: CMakeFiles/hog.dir/png/Cal_HOG_block.c.o
hog: CMakeFiles/hog.dir/png/helper.c.o
hog: CMakeFiles/hog.dir/png/human_detection.c.o
hog: CMakeFiles/hog.dir/png/lodepng.c.o
hog: CMakeFiles/hog.dir/png/rwpng.c.o
hog: CMakeFiles/hog.dir/png/SVMclassification.c.o
hog: CMakeFiles/hog.dir/build.make
hog: CMakeFiles/hog.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Linking C executable hog"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/hog.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/hog.dir/build: hog

.PHONY : CMakeFiles/hog.dir/build

CMakeFiles/hog.dir/requires: CMakeFiles/hog.dir/lsi_2017.c.o.requires
CMakeFiles/hog.dir/requires: CMakeFiles/hog.dir/png/Cal_HOG_block.c.o.requires
CMakeFiles/hog.dir/requires: CMakeFiles/hog.dir/png/helper.c.o.requires
CMakeFiles/hog.dir/requires: CMakeFiles/hog.dir/png/human_detection.c.o.requires
CMakeFiles/hog.dir/requires: CMakeFiles/hog.dir/png/lodepng.c.o.requires
CMakeFiles/hog.dir/requires: CMakeFiles/hog.dir/png/rwpng.c.o.requires
CMakeFiles/hog.dir/requires: CMakeFiles/hog.dir/png/SVMclassification.c.o.requires

.PHONY : CMakeFiles/hog.dir/requires

CMakeFiles/hog.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/hog.dir/cmake_clean.cmake
.PHONY : CMakeFiles/hog.dir/clean

CMakeFiles/hog.dir/depend:
	cd /media/h3/Study/Git/Human-detection-by-HOG/c/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /media/h3/Study/Git/Human-detection-by-HOG/c /media/h3/Study/Git/Human-detection-by-HOG/c /media/h3/Study/Git/Human-detection-by-HOG/c/build /media/h3/Study/Git/Human-detection-by-HOG/c/build /media/h3/Study/Git/Human-detection-by-HOG/c/build/CMakeFiles/hog.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/hog.dir/depend

