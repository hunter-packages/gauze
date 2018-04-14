#include <gtest/gtest.h> // TEST

#include <cxxopts.hpp>

#include <fstream>

int argc_;
char** argv_;

int gauze_main(int argc, char** argv) {
  std::cout << "argc = " << argc << std::endl;
  for (int i=0; i<argc; ++i) {
      std::cout << "argv[" << i << "] = " << argv[i] << std::endl;
  }
  argc_ = argc;
  argv_ = argv;
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}

TEST(gauze_gtest, arith) {
  ASSERT_EQ(2 + 2, 4);
}

TEST(gauze_gtest, boolean) {
  const bool a = true;
  ASSERT_TRUE(a);
}

static void check_file(const std::string &filename, const std::string &message) {
    std::ifstream ifs(filename);
    ASSERT_TRUE(ifs);
    std::string line((std::istreambuf_iterator<char>(ifs)), std::istreambuf_iterator<char>());
    ASSERT_EQ(line, message);
}

TEST(gauze_gtest, cli) {
    
    cxxopts::Options options("gauze-gtest", "Test command line parsing");

    bool a = false;
    int aint = 0;
    float afloat = 0.f;
    std::string astring;
    std::string afile;
    std::string adir;

    bool b = false;
    int bint = 0;
    float bfloat = 0.f;
    std::string bstring;
    std::string bfile;
    std::string bdir;

    // clang-format off
    options.add_options()
        ("a,aval", "equals boolean", cxxopts::value<bool>(a))
        ("aint", "equals integer", cxxopts::value<int>(aint))
        ("afloat", "equals float", cxxopts::value<float>(afloat))
        ("astring", "equals string", cxxopts::value<std::string>(astring))
        ("afile", "equals filename", cxxopts::value<std::string>(afile))
        ("adir", "equals directory", cxxopts::value<std::string>(adir))
    ;
    // clang-format on    
    
    options.parse(argc_, argv_);

    static const std::string message = "Gauze resource file\n";
    
    ASSERT_EQ(a, true);
    ASSERT_EQ(aint, 314159);
    ASSERT_EQ(afloat, 3.14159265359f);
    ASSERT_EQ(astring, "3.14159265359");
    check_file(afile, message);
    check_file(adir + "/input.txt", message);
}
