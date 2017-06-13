Simple
------

Simple example, without arguments on launch:

.. literalinclude:: /../test/gauze/simple/CMakeLists.txt
  :language: cmake
  :emphasize-lines: 3

User should define ``int gauze_main(int argc, char** argv)`` function instead
of ``main``:

.. literalinclude:: /../test/gauze/simple/main.cpp
  :language: cpp
  :emphasize-lines: 4

.. warning::

  While migrating to Gauze framework note that ``gauze_main`` unlike ``main``
  doesn't have default return value - you should return explicit ``int``
  from function.
