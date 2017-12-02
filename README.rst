*************************************************
Conreality Software Development Kit (SDK) for C++
*************************************************

.. image:: https://img.shields.io/badge/license-Public%20Domain-blue.svg
   :alt: Project license
   :target: https://unlicense.org/

.. image:: https://img.shields.io/travis/conreality/conreality-sdk/master.svg
   :alt: Travis CI build status
   :target: https://travis-ci.org/conreality/conreality-sdk

|

https://sdk.conreality.org/cxx/

Prerequisites
=============

Build Prerequisites
-------------------

* Clang_ (>= 3.4) or GCC_ (>= 5.0)
* `GNU Autoconf`_ (>= 2.69)
* `GNU Automake`_ (>= 1.15)
* `GNU Make`_ (>= 3.81)
* pkg-config_ (>= 0.29)

.. _Clang:        https://clang.llvm.org/
.. _GCC:          https://gcc.gnu.org/
.. _GNU Autoconf: https://www.gnu.org/software/autoconf/
.. _GNU Automake: https://www.gnu.org/software/automake/
.. _GNU Make:     https://www.gnu.org/software/make/
.. _pkg-config:   https://www.freedesktop.org/wiki/Software/pkg-config/

Dependencies
============

Installation
============

Installation from Source Code
-----------------------------

Configuring, building, and installing the library (by default, into
``/usr/local``) are all performed with the standard incantations::

   $ ./autogen.sh   # only needed for the development version from Git

   $ ./configure

   $ make

   $ sudo make install

   $ sudo ldconfig  # only on Linux

Configuration
=============

Configuring a Custom Build
--------------------------

The library is thoroughly modular. Specific header files and their
underlying function implementations can be omitted using the familiar
``./configure --disable-FEATURE`` facility provided by Autoconf.

To review the list of features, see the output of ``./configure --help``.

See Also
========

* `Conreality Game Development Kit (GDK)
  <https://github.com/conreality/conreality-gdk>`__

* `Conreality Driver Development Kit (DDK) for C++
  <https://github.com/conreality/conreality-ddk>`__
