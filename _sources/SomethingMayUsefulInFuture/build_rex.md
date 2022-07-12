# Building REX

## 1. Prerequisite

### 1.1 OS:
Ubuntu 20.04 LTS with GNU 9.x and 7.x, Ubuntu 18.04 LTS with GNU 7.x, and Ubuntu 16.04.6 LTS with GNU 5.x were all tested 

### 1.2 Software:
```bash
sudo apt update && \
sudo apt install -y openjdk-8-jdk && \
sudo apt install -y \
        autoconf \
        automake \
        autotools-dev \
        bc \
        binutils \
        bison \
        build-essential \
        cmake \
        cpufrequtils \
        curl \
        device-tree-compiler \
        dkms \
        doxygen \
        flex \
        gawk \
        gcc-multilib \
        gdb \
        gfortran \
        ghostscript \
        git \
        gperf \
        graphviz \
        libboost-all-dev \
        libgmp-dev \
        libhpdf-dev \
        libmpc-dev \
        libmpfr-dev \
        libomp-dev \
        libtool \
        libxml2-dev \
        patchutils \
        perl-doc \
        python3-dev \
        sqlite \
        texinfo \
        unzip \
        vim \
        wget \
        zip \
        zlib1g \
        zlib1g-dev
```

### 1.3 Environment

The compilation requires that `CC` and `CXX` point to the same compiler version. For example, it won't work if `CC=gcc-5` and `CXX=g++-7`. On each of our systems, we used the shipped compiler.

```bash
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
```

However, if you wish to use another version, or find it necessary to do so, you can repeat the steps above:

```bash
export CC=/usr/bin/gcc-7
export CXX=/usr/bin/g++-7
```

So far OpenJDK 8 is tested. Even we remove the limit to JDK, other versions may not work as expected.

```bash
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server:$LD_LIBRARY_PATH
```

Assume we prepare a folder `$HOME/Projects/rexcompiler` for the compilation and installation. You could use other proper folder as well.
```bash
REX_ROOT=$HOME/Projects/rexcompiler
```

### 1.4 EDG and ompparser
EDG and ompparser are part of REX compiler as git submodules. Thus no separate installation are needed. 

## 2. REX Compiler

```bash
cd $REX_ROOT
git clone git@github.com:passlab/rexompiler.git rex_src
mkdir rex_build
cd rex_src
git submodule update --init
./build
cd ../rex_build
../rex_src/configure --prefix=$REX_ROOT/rex_install --with-boost=/usr --with-boost-libdir=/usr/lib/x86_64-linux-gnu/ --enable-languages=c,c++,fortran --disable-tests-directory --disable-tutorial-directory
make core -j6
make install-core
```

Now the compilation is completed and `REXCompiler` is installed in `$REX_ROOT/rex_install`.
```bash
export LD_LIBRARY_PATH=$REX_ROOT/rex_install/lib:$LD_LIBRARY_PATH
export PATH=$REX_ROOT/rex_install/bin:$PATH
```

## 3. Tests

There are at least three locations we need to test, which are `/tests/nonsmoke/functional/CompileTests/OpenMP_tests`, `/tests/nonsmoke/functional/roseTests/astInterfaceTests`, and `/tests/nonsmoke/functional/roseTests/ompLoweringTests`. However, at this moment we only enable the tests in the first two locations because the last one hasn't been modified for `REXCompiler` yet.

**The following tests should be passed locally before committing.**

```bash
cd $REX_ROOT/rex_build/tests/nonsmoke/functional/CompileTests/OpenMP_tests
make check
cd $REX_ROOT/rex_build/tests/nonsmoke/functional/roseTests/astInterfaceTests
make check
```

## 4. Miscellaneous

Please notice that GitHub supports two ways to access the code using `https/password` and `git/SSH key`. In this tutorial, the `git/SSH key` is used. To use the other method, all the `git` link should be replaced with the `https` link. Check [here](https://help.github.com/en/github/using-git/which-remote-url-should-i-use) for more details.



