Gauze
=====

Gauze framework provides unified C++/CMake interface for testing on
iOS/Android/Linux/OSX/Windows platforms. CMake function ``gauze_add_tests``
wraps standard
`add_test <https://cmake.org/cmake/help/latest/command/add_test.html>`__
and in case of testing on host (Linux on Linux, OSX on OSX, etc.) just
forwards ``NAME`` and ``COMMAND`` arguments. Main functionality of the framework
is uploading/starting binaries for iOS/Android testing.  CMake style generator
expression ``$<GAUZE_RESOURCE_FILE:...>`` can be used for managing resources.

.. admonition:: Hunter

  * `gauze <https://docs.hunter.sh/en/latest/packages/pkg/gauze.html>`__

.. toctree::
  :maxdepth: 1
  :caption: Prerequirements

  /prereq/ios
  /prereq/android

.. toctree::
  :maxdepth: 1
  :caption: Examples

  /examples/simple
  /examples/args
  /examples/resource
  /examples/deps
  /examples/gtest
