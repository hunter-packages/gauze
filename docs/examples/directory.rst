Directory
---------

To copy directory with resources use ``$<GAUZE_RESOURCE_DIR:...>``:

.. literalinclude:: /../test/gauze/directory/CMakeLists.txt
  :language: cmake
  :emphasize-lines: 16

Read files in directory:

.. literalinclude:: /../test/gauze/directory/main.cpp
  :language: cpp
  :emphasize-lines: 28, 39

Running this test on Android device:

.. code-block:: none
  :emphasize-lines: 1, 9, 11-16

  > ctest -VV -R gauze_directory
  4: Command output (with exit code):
  4: *** BEGIN ***
  4: argc = 6
  4: argv[0] = /data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/bin/gauze_directory
  4: argv[1] = arg1
  4: argv[2] = arg2
  4: argv[3] = arg3
  4: argv[4] = /data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/data/resdir
  4: argv[5] = /.../gauze/test/gauze/directory/resdir/just_a_string.txt
  4: Processing file: "/data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/data/resdir/file.0"
  4: Content: 'Content 0'
  4: Processing file: "/data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/data/resdir/file.1"
  4: Content: 'Content 1'
  4: Processing file: "/data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/data/resdir/file.2"
  4: Content: 'Content 2'
  4: 0
  4: *** END ***
  4: Done
  1/1 Test #4: gauze_directory ..................   Passed    0.54 sec
