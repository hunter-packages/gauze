#include <cstdlib> // std::getenv

#include <iostream> // std::cerr

#include <boost/predef.h> // BOOST_OS_IOS

// clang-format off
#if (BOOST_OS_IOS)
#  include <regex>    // std::regex
#  include <unistd.h> // chdir
#endif
// clang-format on

// Should be defined by user
int gauze_main(int argc, char** argv);

int main(int argc, char** argv)
{
    try
    {
#if (BOOST_OS_IOS)
        const char* home = std::getenv("HOME");
        if (home == nullptr)
        {
            std::cerr << "HOME not found" << std::endl;
            return EXIT_FAILURE;
        }

        std::string working_dir(home);
        working_dir += "/tmp";

        if (chdir(working_dir.c_str()) != 0)
        {
            std::cerr << "Can't change working directory" << std::endl;
            return EXIT_FAILURE;
        }

        std::vector<char*> new_argv;

        // NOTE: GAUZE_RESOURCE_DIR converted to GAUZE_RESOURCE_FILE
        // to simplify logic (see iOSTest.cmake.in)
        const std::regex resource_regex("\\$<GAUZE_RESOURCE_FILE:(.*)>$");
        const std::regex environment_regex
        (
            "^\\$<GAUZE_ENVIRONMENT_VARIABLE:(.*)=(.*)>$"
        );

        std::string fmt(home);
        fmt += "/\\1";

        std::vector<std::string> extra_args;

        for (int i = 0; i < argc; ++i)
        {
            const std::string original(argv[i]);

            std::smatch environment_matches;

            if
            (
                std::regex_match
                (
                    original,
                    environment_matches,
                    environment_regex,
                    std::regex_constants::format_sed
                )
            )
            {
                if (environment_matches.size() != 3)
                {
                    std::cerr << "Expected 3 matches" << std::endl;
                    return EXIT_FAILURE;
                }

                if (environment_matches[0].str() != original)
                {
                    std::cerr << "Match 0 is not equal to orignal" << std::endl;
                    return EXIT_FAILURE;
                }

                const std::string name = environment_matches[1].str();
                const std::string value = environment_matches[2].str();

                const int overwrite = 1; // do overwrite existing variables
                const int result = setenv(name.c_str(), value.c_str(), overwrite);
                if (result != 0)
                {
                    std::cerr << "Setenv failed" << std::endl;
                    return EXIT_FAILURE;
                }

                continue;
            }

            const std::string resource_string = std::regex_replace
            (
                original,
                resource_regex,
                fmt,
                std::regex_constants::format_sed
            );

            if (original == resource_string)
            {
                new_argv.push_back(argv[i]);
            }
            else
            {
                extra_args.push_back(resource_string);
                new_argv.push_back(const_cast<char*>(extra_args.back().c_str()));
            }
        }

        return gauze_main(new_argv.size(), new_argv.data());
#else
        // If platform is not iOS - leave as is
        return gauze_main(argc, argv);
#endif
    }
    catch (std::exception& exc)
    {
        std::cerr << "Exception caught: " << exc.what() << std::endl;
        return EXIT_FAILURE;
    }
    catch (...)
    {
        std::cerr << "Unknown exception caught" << std::endl;
        return EXIT_FAILURE;
    }
}
