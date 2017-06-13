With resources
--------------

If we need some resource file while testing it can be uploaded by adding
``$<GAUZE_RESOURCE_FILE:...>`` directive:

.. literalinclude:: /../test/gauze/resource/CMakeLists.txt
  :language: cmake
  :emphasize-lines: 12

Files specified with ``GAUZE_RESOURCE_FILE`` will be uploaded to device
and path will be substituted with real path **on device**.
Note that similar string without ``GAUZE_RESOURCE_FILE`` will be used as is:

.. literalinclude:: /../test/gauze/resource/CMakeLists.txt
  :language: cmake
  :emphasize-lines: 13

Read resource file:

.. literalinclude:: /../test/gauze/resource/main.cpp
  :language: cpp
  :emphasize-lines: 17, 23

Running this test on Android device:

.. code-block:: none
  :emphasize-lines: 1, 9, 10

  > ctest -VV -R gauze_resource
  3: Command output (with exit code):
  3: *** BEGIN ***
  3: argc = 6
  3: argv[0] = /data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/bin/gauze_resource
  3: argv[1] = arg1
  3: argv[2] = arg2
  3: argv[3] = arg3
  3: argv[4] = /data/local/tmp/gauze/android-ndk-r10e-api-19-armeabi-v7a-neon/data/input.txt
  3: argv[5] = /.../gauze/test/gauze/resource/data/just_a_string.txt
  3: Content: 'Gauze resource file'
  3: 0
  3: *** END ***
  3: Done
  1/1 Test #3: gauze_resource ...................   Passed    1.15 sec
