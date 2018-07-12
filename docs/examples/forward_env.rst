Environment variables
---------------------

``FORWARD_ENV`` option can be used to forward environment variable from host
to target. Feature is useful while running tests on iOS and Android devices
since environment for such tests created from scratch and is not the same as
local user environment. For other platforms there are no extra functionality
introduced.

As an example let assume test is reading environment variables
``MY_GAUZE_VARIABLE_1`` and ``MY_GAUZE_VARIABLE_2``:

.. literalinclude:: /../test/gauze/forward_env/main.cpp
  :language: cpp
  :emphasize-lines: 12-13, 29-30

Environment variable ``MY_GAUZE_VARIABLE_1`` will be set by CTest:

.. literalinclude:: /../test/gauze/forward_env/CMakeLists.txt
  :language: cmake
  :emphasize-lines: 6, 13

Run test (Android build):

.. code-block:: none
  :emphasize-lines: 1, 3-4, 7-8

  > ctest -VV -R gauze_forward_env
  ...
  5: Forwarding user's variable 'MY_GAUZE_VARIABLE_1' with value '42'
  5: Forwarding user's variable 'MY_GAUZE_VARIABLE_2' with value ''
  5: Command output (with exit code):
  5: *** BEGIN ***
  5: Variable MY_GAUZE_VARIABLE_1 found!
  5: MY_GAUZE_VARIABLE_2 value:
  5: 0
  5: *** END ***
  5: Done
  1/1 Test #5: gauze_forward_env ................   Passed    0.53 sec

If environment variable ``MY_GAUZE_VARIABLE_2`` will be set on host then
Gauze will forward it to the Android test environment:

.. code-block:: none
  :emphasize-lines: 1, 4-5, 9

  > export MY_GAUZE_VARIABLE_2=hello
  > ctest -VV -R gauze_forward_env
  ...
  5: Forwarding user's variable 'MY_GAUZE_VARIABLE_1' with value '42'
  5: Forwarding user's variable 'MY_GAUZE_VARIABLE_2' with value 'hello'
  5: Command output (with exit code):
  5: *** BEGIN ***
  5: Variable MY_GAUZE_VARIABLE_1 found!
  5: MY_GAUZE_VARIABLE_2 value: hello
  5: 0
  5: *** END ***
  5: Done
  1/1 Test #5: gauze_forward_env ................   Passed    0.48 sec

There is no need to rebuild test or reconfigure CMake project.
