Dependent libraries
-------------------

Dependent shared libraries on Android will be uploaded automatically and
``LD_LIBRARY_PATH`` will be updated before running executable:

.. literalinclude:: /../test/gauze/deps/CMakeLists.txt
  :language: cmake
  :emphasize-lines: 3

Calling C++ function from library:

.. literalinclude:: /../test/gauze/deps/main.cpp
  :language: cpp
  :emphasize-lines: 7

Run test (you should build with ``BUILD_SHARED_LIBS=ON``):

.. code-block:: none
  :emphasize-lines: 2-5

  4: Creating directory on Android device: '/data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/lib'
  4: Uploading dependent libraries to Android device
  4:   '/.../test/gauze/deplib/libgauze_deplib.so'
  4:   -> '/data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/lib/libgauze_deplib.so'
  4: Set LD_LIBRARY_PATH to '/data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/lib'
  4: Run command on Android device:
  4: [/data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon]> "/data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/bin/gauze_deps" 
  4: Command output (with exit code):
  4: *** BEGIN ***
  4: Result: 42
  4: 0
  4: *** END ***
  4: Done
  1/1 Test #4: gauze_deps .......................   Passed    2.13 sec
