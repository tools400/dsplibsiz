# DSPLIBSIZ - A Tools/400 Utility

DSPLIBSIZ is a simple wrapper around the Retrieve Library Description
(QLIRLIBD) API. The utility retrieves the size of a given library
and displays it in the status line.

## Dependencies

Dependencies:

None.

## Installation

Compile members with the following PDM option:

   STRPREPRC USESRCFILE(&L/&F) USESRCMBR(&N) OPTION(*EVENTF) CHGOBJD(*NO)
     LIB(&O) OBJ(&N) SRCLIB(&L) SRCFILE(&F) SRCMBR(&N) USER0(&X)
     USER1(*LIST) USER2(*FULL)

Members of type MAKPGM or BND are used for linking programs (MAKPGM)
and service programs (BND).

The [STRPREPRC](https://github.com/tools400/strpreprc) utility is used for compiling the members. The utility retrieves object creation parameters from the source member that is compiled and building and executing the final object creation command.

---

2019, Thomas Raddatz
