FROM ubuntu:16.04
RUN apt-get update -qq
RUN apt-get build-dep llvm -y
RUN apt-get install gcc git cmake python-pip -y
WORKDIR /
RUN git clone http://llvm.org/git/llvm.git --branch release_38 --depth 1
RUN cd /llvm/tools/ && git clone http://llvm.org/git/clang.git --branch release_38 --depth 1
RUN pip install --user lit
WORKDIR /llvm/_build
RUN mkdir /tools
RUN cmake .. 	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DLLVM_INSTALL_UTILS=ON \
		-DLLVM_TARGETS_TO_BUILD=X86 \
		-DCMAKE_INSTALL_PREFIX=/tools
RUN make -j4
RUN make install
