With GTest
----------

Working with GTest:

.. literalinclude:: /../test/gauze/gtest/CMakeLists.txt
  :language: cmake
  :emphasize-lines: 1,2,8

.. literalinclude:: /../test/gauze/gtest/main.cpp
  :language: cpp
  :emphasize-lines: 1, 17-18, 21, 25, 37

Run test:

.. code-block:: none
  :emphasize-lines: 1

  > ctest -VV -R gauze_gtest
  7: [==========] Running 3 tests from 1 test case.
  7: [----------] Global test environment set-up.
  7: [----------] 3 tests from gauze_gtest
  7: [ RUN      ] gauze_gtest.arith
  7: [       OK ] gauze_gtest.arith (0 ms)
  7: [ RUN      ] gauze_gtest.boolean
  7: [       OK ] gauze_gtest.boolean (0 ms)
  7: [ RUN      ] gauze_gtest.cli
  7: [       OK ] gauze_gtest.cli (8 ms)
  7: [----------] 3 tests from gauze_gtest (8 ms total)
  7:
  7: [----------] Global test environment tear-down
  7: [==========] 3 tests from 1 test case ran. (8 ms total)
  7: [  PASSED  ] 3 tests.
  1/1 Test #7: gauze_gtest ......................   Passed    0.03 sec
