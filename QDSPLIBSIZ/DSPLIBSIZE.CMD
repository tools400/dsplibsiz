000100000000/* =================================================================== */
000200000000/*                                                                     */
000300000000/*  Kurzdokumentation :                                                */
000400000000/*                                                                     */
000500000000/*  Bereich . . . : DSPLIBSIZ                                          */
000600000000/*  Objekt  . . . : DSPLIBSIZ                                          */
000700000000/*  Beschreibung  : Tool: DSPLIBSIZ  (Display Library Size) Eng        */
000800000000/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
000900000000/*  Datum . . . . : xx.xx.xxxx                                         */
001000000000/*                                                                     */
001100000000/* =================================================================== */
001200000000/*                                                                     */
001300000000/*  This software is free software, you can redistribute it and/or     */
001400000000/*  modify it under the terms of the GNU General Public License (GPL)  */
001500000000/*  as published by the Free Software Foundation.                      */
001600000000/*                                                                     */
001700000000/*  See GNU General Public License for details.                        */
001800000000/*          http://www.opensource.org                                  */
001900000000/*          http://www.opensource.org/licenses/gpl-license.html        */
002000000000/*                                                                     */
002100000000/* =================================================================== */
002200000000/*  History:                                                           */
002300000000/*                                                                     */
002400000000/*  Datum       Name          Änderung                                 */
002500000000/*  ----------  ------------  ---------------------------------------  */
002600000000/*                                                                     */
002700000000/* =================================================================== */
002800000000/* >>PRE-COMPILER<<                                                    */
002900000000/*                                                                     */
003000000000/*   >>CRTCMD<< CRTCMD       CMD(&LI/&OB) +                            */
003100000000/*                           SRCFILE(&SL/&SF) +                        */
003200000000/*                           SRCMBR(&SM);                              */
003300000000/*                                                                     */
003400000000/*   >>COMPILE<<                                                       */
003500000000/*     >>PARM<< PGM(*LIBL/DSPLIBSIZR);                                 */
003600000000/*     >>PARM<< HLPPNLGRP(*LIBL/DSPLIBSIZQ);                           */
003700000000/*     >>PARM<< HLPID(DSPLIBSIZ);                                      */
003800000000/*     >>PARM<< PRDLIB(&LI);                                           */
003900000000/*   >>END-COMPILE<<                                                   */
004000000000/*                                                                     */
004100000000/*   >>EXECUTE<<                                                       */
004200000000/*                                                                     */
004300000000/* >>END-PRE-COMPILER<<                                                */
004400000000/* =================================================================== */
004500000000
004600000000             CMD        PROMPT('Display Library Size')
004700000000
004800000000             PARM       KWD(LIB)               +
004900000000                        TYPE(*NAME)            +
005000000000                        MIN(1)                 +
005100000000                        PROMPT('Library')
005200000000
005300000000             PARM       KWD(LANGUAGE  ) TYPE(*CHAR)        +
005400000000                          LEN( 3)                          +
005500000000                          CONSTANT(ENG      )
005600000000
