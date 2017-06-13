With GTest
----------

Working with GTest:

.. literalinclude:: /../test/gauze/gtest/CMakeLists.txt
  :language: cmake
  :emphasize-lines: 1,2,5

.. literalinclude:: /../test/gauze/gtest/main.cpp
  :language: cpp
  :emphasize-lines: 1, 4-5, 8, 12

Run test:

.. code-block:: none
  :emphasize-lines: 1

  > ctest -VV -R gauze_gtest
  5: Command output (with exit code):
  5: *** BEGIN ***
  5: [==========] Running 2 tests from 1 test case.
  5: [----------] Global test environment set-up.
  5: [----------] 2 tests from gauze_gtest
  5: [ RUN      ] gauze_gtest.arith
  5: [       OK ] gauze_gtest.arith (0 ms)
  5: [ RUN      ] gauze_gtest.boolean
  5: [       OK ] gauze_gtest.boolean (0 ms)
  5: [----------] 2 tests from gauze_gtest (1 ms total)
  5: 
  5: [----------] Global test environment tear-down
  5: [==========] 2 tests from 1 test case ran. (1 ms total)
  5: [  PASSED  ] 2 tests.
  5: 0
  5: *** END ***
  5: Done
  1/1 Test #5: gauze_gtest ......................   Passed    2.17 sec
