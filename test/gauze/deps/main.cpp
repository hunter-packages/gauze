#include <cstdlib> // EXIT_SUCCESS
#include <iostream> // std::cout
#include <gauze/deplib/Deplib.hpp>

int gauze_main(int argc, char** argv) {
  gauze::deplib::Deplib deplib;
  std::cout << "Result: " << deplib.result() << std::endl;
  return EXIT_SUCCESS;
}
