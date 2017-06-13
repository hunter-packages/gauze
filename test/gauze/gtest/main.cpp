#include <gtest/gtest.h> // TEST

int gauze_main(int argc, char** argv) {
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
