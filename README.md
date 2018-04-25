# builder:moed

[![Build Status](https://travis-ci.org/b1f6c1c4/builders.svg?branch=moed)](https://travis-ci.org/b1f6c1c4/builders)

Docker image for building C++ programs.

- gcc 7
- (apt-get)
    - cmake
    - python python-dev python-pip
    - python-numpy python-scipy
    - doxygen
    - gfortran libblas-dev liblapack-dev
- boost 1.66.0
    - boost.python
    - boost.chrono
    - boost.system
    - boost.program\_options
- [alanxz/rabbitmq-c](https://github.com/alanxz/rabbitmq-c)
- [alanxz/SimpleAmqpClient](https://github.com/alanxz/SimpleAmqpClient)
- [nlohmann/json](https://raw.githubusercontent.com/nlohmann/json/master/single_include/nlohmann/json.hpp)
- [gabime/spdlog](https://github.com/gabime/spdlog)
- [Yelp/MOE](https://github.com/Yelp/MOE)
