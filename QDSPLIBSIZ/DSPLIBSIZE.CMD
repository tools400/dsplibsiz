/* =================================================================== */
/*                                                                     */
/*  Kurzdokumentation :                                                */
/*                                                                     */
/*  Bereich . . . : DSPLIBSIZ                                          */
/*  Objekt  . . . : DSPLIBSIZ                                          */
/*  Beschreibung  : Tool: DSPLIBSIZ  (Display Library Size) Eng        */
/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
/*  Datum . . . . : xx.xx.xxxx                                         */
/*                                                                     */
/* =================================================================== */
/*                                                                     */
/*  This software is free software, you can redistribute it and/or     */
/*  modify it under the terms of the GNU General Public License (GPL)  */
/*  as published by the Free Software Foundation.                      */
/*                                                                     */
/*  See GNU General Public License for details.                        */
/*          http://www.opensource.org                                  */
/*          http://www.opensource.org/licenses/gpl-license.html        */
/*                                                                     */
/* =================================================================== */
/*  History:                                                           */
/*                                                                     */
/*  Datum       Name          Änderung                                 */
/*  ----------  ------------  ---------------------------------------  */
/*                                                                     */
/* =================================================================== */
/* >>PRE-COMPILER<<                                                    */
/*                                                                     */
/*   >>CRTCMD<< CRTCMD       CMD(&LI/&OB) +                            */
/*                           SRCFILE(&SL/&SF) +                        */
/*                           SRCMBR(&SM);                              */
/*                                                                     */
/*   >>COMPILE<<                                                       */
/*     >>PARM<< PGM(*LIBL/DSPLIBSIZR);                                 */
/*     >>PARM<< HLPPNLGRP(*LIBL/DSPLIBSIZQ);                           */
/*     >>PARM<< HLPID(DSPLIBSIZ);                                      */
/*     >>PARM<< PRDLIB(&LI);                                           */
/*   >>END-COMPILE<<                                                   */
/*                                                                     */
/*   >>EXECUTE<<                                                       */
/*                                                                     */
/* >>END-PRE-COMPILER<<                                                */
/* =================================================================== */

             CMD        PROMPT('Display Library Size')

             PARM       KWD(LIB)               +
                        TYPE(*NAME)            +
                        MIN(1)                 +
                        PROMPT('Library')

             PARM       KWD(LANGUAGE  ) TYPE(*CHAR)        +
                          LEN( 3)                          +
                          CONSTANT(ENG      )

