vic20_simtty
============
Simulate a TTY on the Vic-20, by taking over the _CHROUT_ (`$FFD2`) routine.

Requirements
------------
*  xa65 (To assemble)
*  Vice or C1541 (To create the disk image)

Usage
-----
To assemble the source to `simtty.prg` and put it on a disk image called `simtty.d64`:

    $ make

From your Vic-20 load `simtty.prg` and start the code:

    LOAD "SIMTTY",8
    RUN


History
-------
This was created after writing the article: [Creating a TTY Simulator in Assembly Language on the Vic-20](http://techtinkering.com/2013/05/04/creating-a-tty-simulator-in-assembly-language-on-the-vic-20) and creating its associated [video](http://www.youtube.com/watch?v=kmvF85euefs).  Both of these works used Vicmon to enter the code, but I thought it would be instructive to have it in a form that could be cross-assembled as well.  This has also allowed the program to be extended.

Licence
-------
Copyright (C) 2013, Lawrence Woodman <http://techtinkering.com>

This software is licensed under an MIT Licence.  Please see the file, LICENCE.md, for details.
