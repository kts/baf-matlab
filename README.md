
A Matlab/Octave library for reading and writing ``baf`` files.

http://trybaf.org

Usage
-----

    x = bafread('infile.baf');

    bafwrite('outfile.baf', x);


Testing
-------

I have tested with GNU Octave version 3.2.4 on Ubuntu.

    $ octave runtests.m


Problems
--------

Some things in the ``baf`` type system do not really 
match up with Matlab's.

* scalars.  In Matlab, ``x=5;`` has ``size(x)`` of ``[1,1]``. So
it looks like a 1x1 matrix.

* lists. Matlab cell-arrays

TODO: document how ``bafread`` and ``bafwrite`` match the types.

Todo
----

- Look at efficiency: reading array without reshape, or without changing order/type?
- Test different machine format and row/col major.
- More error checking
- Better organization

  - defining global variables in bafconstants
  - ugly way to map integer IDs to string names

- Is there a testing 'framework' to use?

