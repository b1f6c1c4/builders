FROM gcc:7

# [#40](https://github.com/docker-library/gcc/issues/40)
RUN update-alternatives --install /usr/bin/gfortran gfortran /usr/local/bin/gfortran 999

RUN \
      apt-get update \
      && apt-get install -y \
      cmake \
      python python-dev python-pip \
      python-numpy python-scipy \
      doxygen \
      gfortran libblas-dev liblapack-dev \
      && rm -rf /var/lib/apt/lists/*

RUN \
      curl -fsSL "https://downloads.sourceforge.net/project/boost/boost/1.66.0/boost_1_66_0.tar.bz2?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F1.66.0%2F&ts=1515136452&use_mirror=phoenixnap" \
      -o boost_1_66_0.tar.bz2 \
      && tar --bzip2 -xf boost_1_66_0.tar.bz2 \
      && rm -f boost_1_66_0.tar.bz2 \
      && cd boost_1_66_0 \
      && ./bootstrap.sh --prefix=/usr/local

ENV LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/local/lib"

RUN \
      cd boost_1_66_0 \
      && ./b2 -q -a -sHAVE_ICU=1 -j 10 \
      --with-python \
      --with-chrono \
      --with-system \
      --with-program_options \
      && ./b2 -d0 -j 10 \
      --with-python \
      --with-chrono \
      --with-system \
      --with-program_options \
      install \
      && cd .. \
      && rm -rf boost_1_66_0

RUN \
      curl -SL "https://raw.githubusercontent.com/nlohmann/json/master/single_include/nlohmann/json.hpp" \
      -o json.hpp \
      && mv json.hpp /usr/local/include

RUN \
      git clone --depth=1 "https://github.com/gabime/spdlog" \
      && cp -r spdlog/include/spdlog /usr/local/include \
      && rm -rf spdlog

RUN \
      git clone --depth=1 "https://github.com/Yelp/MOE" \
      && cd MOE \
      && pip install -r requirements.txt

RUN \
      cd MOE \
      && sed -i~ '/#include <algorithm>/a #include <numeric>' moe/optimal_learning/cpp/gpp_optimization_test.cpp \
      && MOE_CMAKE_OPTS='-D MOE_PYTHON_LIBRARY="/usr/lib/x86_64-linux-gnu/libpython2.7.so.1.0"' python setup.py install
