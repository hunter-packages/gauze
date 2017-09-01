Gauze
-----

Unified CTest-friendly testing framework for Windows, Linux, OSX, iOS, Android.

|build_travis| |build_appveyor| |build_docs| |license|

.. |build_docs| image:: https://readthedocs.org/projects/gauze/badge/?version=latest
  :target: https://gauze.readthedocs.io/en/latest/?badge=latest
  :alt: Documentation

.. |license| image:: https://img.shields.io/github/license/hunter-packages/gauze.svg
  :target: https://github.com/hunter-packages/gauze/blob/master/LICENSE
  :alt: LICENSE

.. |build_travis| image:: https://travis-ci.org/hunter-packages/gauze.svg?branch=master
  :target: https://travis-ci.org/hunter-packages/gauze/builds
  :alt: Travis

.. |build_appveyor| image:: https://ci.appveyor.com/api/projects/status/1fw2kvxx5wa90gci/branch/master?svg=true
  :target: https://ci.appveyor.com/project/ruslo/gauze/history
  :alt: AppVeyor

.. code-block:: cmake

  gauze_add_test(
      NAME
      foo
      COMMAND
      foo
      --param1 1
      --param2 2
      --resource $<GAUZE_RESOURCE_FILE:${CMAKE_CURRENT_LIST_DIR}/data/input.txt>
      --just-string ${CMAKE_CURRENT_LIST_DIR}/data/just-string.txt
 )


* Sources: `<https://github.com/hunter-packages/gauze>`_
* Documentation: `<https://gauze.readthedocs.io>`_
* Hunter package: https://docs.hunter.sh/en/latest/packages/pkg/gauze.html
* Reporting broken links, issues, general discussion: `<https://github.com/hunter-packages/gauze/issues/new>`_
* Contacts: Ruslan Baratov <ruslan_baratov@yahoo.com> David Hirvonen <dhirvonen@elucideye.com>
