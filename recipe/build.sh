#!/bin/bash
echo "Building ${PKG_NAME}."


# Isolate the build.
mkdir -p Build-${PKG_NAME}
cd Build-${PKG_NAME} || exit 1


# Regarding -DDMLC_MODERN_THREAD_LOCAL=0, see https://github.com/dmlc/dmlc-core/issues/571#issuecomment-543467484

# Generate the build files.
echo "Generating the build files..."
cmake .. ${CMAKE_ARGS} \
      -GNinja \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_BUILD_TYPE=Release \
      \
      -DUSE_CXX14_IF_AVAILABLE=ON \
      -DGOOGLE_TEST=OFF \
      -DUSE_OPENMP=ON \
      -DINSTALL_DOCUMENTATION=OFF \
      -DUSE_HDFS=OFF \
      \
      -DDMLC_MODERN_THREAD_LOCAL=0

# Build.
echo "Building..."
ninja || exit 1


# Perform tests.
#  echo "Testing..."
#  ninja test || exit 1
#  path_to/test || exit 1
#  ctest -VV --output-on-failure || exit 1


# Installing
echo "Installing..."
ninja install || exit 1


# Error free exit!
echo "Error free exit!"
exit 0




#!/bin/bash

set -x
set -e

mkdir -p build

pushd build

cmake ${CMAKE_ARGS} .. \
      -DCMAKE_INSTALL_PREFIX="$PREFIX" \
      -DCMAKE_INSTALL_LIBDIR="lib" \

ninja install
