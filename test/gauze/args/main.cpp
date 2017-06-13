#include <iostream> // std::cout
#include <cstdlib> // EXIT_SUCCESS

int gauze_main(int argc, char** argv) {
  std::cout << "argc = " << argc << std::endl;
  for (int i=0; i<argc; ++i) {
    std::cout << "argv[" << i << "] = " << argv[i] << std::endl;
  }

  return EXIT_SUCCESS;
}
