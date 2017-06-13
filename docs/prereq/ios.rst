iOS
---

``ios-deploy`` tool will be used for uploading and running executables.

Building from source:

.. code-block:: none
  :emphasize-lines: 1, 7-8

  > git clone https://github.com/phonegap/ios-deploy
  > cd ios-deploy
  [ios-deploy]> xcodebuild
  [ios-deploy]> ls build/Release/ios-deploy
  build/Release/ios-deploy
  [ios-deploy]> export PATH=`pwd`/build/Release/ios-deploy:$PATH
  [ios-deploy]> which ios-deploy
  /.../ios-deploy/build/Release/ios-deploy


.. note::

  * https://github.com/phonegap/ios-deploy

.. warning::

  Currently only testing on device is supported (no simulator testing)

.. https://github.com/phonegap/ios-deploy/pull/264 iOS 10+ ?
