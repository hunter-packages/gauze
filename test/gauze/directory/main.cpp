#include <cstdlib> // EXIT_SUCCESS
#include <fstream> // std::ifstream
#include <iostream> // std::cout
#include <string> // std::getline
#include <boost/filesystem.hpp>
#include <sstream> // std::ostringstream

int gauze_main(int argc, char** argv) {
  std::cout << "argc = " << argc << std::endl;
  for (int i=0; i<argc; ++i) {
    std::cout << "argv[" << i << "] = " << argv[i] << std::endl;
  }

  if(argc < 7) {
    std::cerr << "Unexpected number of arguments: " << argc << std::endl;
    return EXIT_FAILURE;
  }

  boost::filesystem::path resdir(argv[4]);

  for (int i=0; i<3; ++i) {
    std::ostringstream file_name;
    file_name << "file." << i;

    boost::filesystem::path file_path(resdir);
    file_path /= file_name.str();

    std::cout << "Processing file: " << file_path << std::endl;
    std::ifstream file(file_path.string());

    std::string content;
    std::getline(file, content);

    if(!file) {
      std::cerr << "Can't read file: " << file_path << std::endl;
      return EXIT_FAILURE;
    }

    std::cout << "Content: '" << content << "'" << std::endl;
  }

  return EXIT_SUCCESS;
}
