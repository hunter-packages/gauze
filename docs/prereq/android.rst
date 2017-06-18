Android
-------

By default Gauze will run tests on real device connected to host. To check
that device is connected successfully run ``adb devices``:

.. code-block:: none

  > adb devices
  List of devices attached
  <device-name> device

To use emulator add ``GAUZE_ANDROID_USE_EMULATOR=ON``. In this case AVD
will be created automatically and emulator will be launched:

.. code-block:: none

  Creating AVD with name 'gauze_android-19_armeabi-v7a'
  Starting emulator
  Waiting for emulator
  Emulator is ready!

Created AVD can be found in list of available AVDs:

.. code-block:: none

  > /.../android-sdk/tools/android list avd
      Name: gauze_android-19_armeabi-v7a
      Path: /.../.android/avd/gauze_android-19_armeabi-v7a.avd
    Target: Android 4.4.2 (API level 19)
   Tag/ABI: default/armeabi-v7a
      Skin: WVGA800

Emulator is visible by the same ``adb device`` command:

.. code-block:: none
  :emphasize-lines: 3

  > /.../android-sdk/platform-tools/adb devices
  List of devices attached
  emulator-5678   device
  <device-name>   device

Deleting AVD:

.. code-block:: none

  > /.../android-sdk/tools/android delete avd --name gauze_android-19_armeabi-v7a
  Deleting file /.../.android/avd/gauze_android-19_armeabi-v7a.ini
  Deleting folder /.../.android/avd/gauze_android-19_armeabi-v7a.avd

  AVD 'gauze_android-19_armeabi-v7a' deleted.

Emulator can be stopped by ``kill -9`` command:

.. code-block:: none

  > ps aux | grep gauze_android
  <username> 9160 ... /.../android-sdk/tools/emulator64-arm -avd gauze_android-19_armeabi-v7a -no-window -port 5678 -gpu host
  > kill -9 9160

.. warning::

  Android emulator is not working on Travis CI Linux machines. OSX machines
  can be used instead.
