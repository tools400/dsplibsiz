000100181219DSPLIBSIZ - A Tools/400 Utility 
000200181219-------------------------------
000300181219
000400181219DSPLIBSIZ is a simple wrapper around the Retrieve Library Description 
000500181219(QLIRLIBD) API. The utility retrieves the size of a given library
000600181219and displays it in the status line.
000700181219
000800181219Dependencies: *NONE
000900181219
001000181219Compile members with the following PDM option:
001100181219
001200181219   STRPREPRC USESRCFILE(&L/&F) USESRCMBR(&N) OPTION(*EVENTF) CHGOBJD(*NO)
001300181219     LIB(&O) OBJ(&N) SRCLIB(&L) SRCFILE(&F) SRCMBR(&N) USER0(&X)
001400181219     USER1(*LIST) USER2(*FULL)
001500181219
001600181219Members of type MAKPGM or BND are used for linking programs (MAKPGM)
001700181219and service programs (BND).
001800181219
9999999999992019, Thomas Raddatz
