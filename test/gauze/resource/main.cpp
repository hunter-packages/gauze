#include <cstdlib> // EXIT_SUCCESS
#include <fstream> // std::ifstream
#include <iostream> // std::cout
#include <string> // std::getline

int gauze_main(int argc, char** argv) {
  std::cout << "argc = " << argc << std::endl;
  for (int i=0; i<argc; ++i) {
    std::cout << "argv[" << i << "] = " << argv[i] << std::endl;
  }

  if(argc < 7) {
    std::cerr << "Unexpected number of arguments: " << argc << std::endl;
    return EXIT_FAILURE;
  }

  const char* filename = argv[4];

  std::ifstream file(filename);
  std::string content;
  std::getline(file, content);

  std::cout << "Content: '" << content << "'" << std::endl;

  return EXIT_SUCCESS;
}
