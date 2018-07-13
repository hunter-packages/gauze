#include <iostream> // std::cout
#include <cstdlib> // EXIT_SUCCESS

int gauze_main(int argc, char** argv)
{
  if (argc != 1)
  {
    std::cerr << "No arguments expected" << std::endl;
    return EXIT_FAILURE;
  }

  const char* var_1_name = "MY_GAUZE_VARIABLE_1";
  const char* var_1 = std::getenv(var_1_name);

  if (var_1 == nullptr)
  {
    std::cerr << "Variable " << var_1_name << " not found" << std::endl;
    return EXIT_FAILURE;
  }

  if (std::string(var_1) != "42")
  {
    std::cerr << "Variable " << var_1_name << " unexpected value" << std::endl;
    return EXIT_FAILURE;
  }

  std::cout << "Variable " << var_1_name << " found!" << std::endl;

  const char* var_2_name = "MY_GAUZE_VARIABLE_2";
  const char* var_2 = std::getenv(var_2_name);

  if (var_2 != nullptr)
  {
    std::cout << var_2_name << " value: " << var_2 << std::endl;
  }

  return EXIT_SUCCESS;
}
