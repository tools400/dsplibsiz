000100190131       //=====================================================================*
000200190131       //                                                                     *
000300190131       //  Kurzdokumentation :                                                *
000400190131       //                                                                     *
000500190131       //  Bereich . . . : DSPLIBSIZ                                          *
000600190131       //  Objekt  . . . : DSPLIBSIZR                                         *
000700190131       //  Beschreibung  : Tool: DSPLIBSIZ  (Display Library Size)            *
000800190131       //  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
000900190131       //  Datum . . . . : xx.xx.xxxx                                         *
001000190131       //                                                                     *
001100190131       //=====================================================================*
001200190131       //                                                                     *
001300190131       //  This software is free software, you can redistribute it and/or     *
001400190131       //  modify it under the terms of the GNU General Public License (GPL)  *
001500190131       //  as published by the Free Software Foundation.                      *
001600190131       //                                                                     *
001700190131       //  See GNU General Public License for details.                        *
001800190131       //          http://www.opensource.org                                  *
001900190131       //          http://www.opensource.org/licenses/gpl-license.html        *
002000190131       //                                                                     *
002100190131       //=====================================================================*
002200190131       //  History:                                                           *
002300190131       //                                                                     *
002400190131       //  Datum       Name          Änderung                                 *
002500190131       //  ----------  ------------  ---------------------------------------  *
002600190131       //                                                                     *
002700190131       //=====================================================================*
002800190131       // >>PRE-COMPILER<<                                                    *
002900190131       //   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
003000190131       //                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
003100190131       //   >>IMPORTANT<<                                                     *
003200190131       //     >>PARM<< TRUNCNBR(*NO);                                         *
003300190131       //     >>PARM<< DBGVIEW(*LIST);                                        *
003400190131       //   >>END-IMPORTANT<<                                                 *
003500190131       //   >>EXECUTE<<                                                       *
003600190131       //   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                            *
003700190131       //                           MODULE(&LI/&OB) +                         *
003800190131       //                           ACTGRP(*NEW) +                            *
003900190131       //                           DETAIL(*BASIC);                           *
004000190131       // >>END-PRE-COMPILER<<                                                *
004100190131       //=====================================================================*
004200190131     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
004300190131      /COPY QDSPLIBSIZ,COPYRIGHT
004400190131       //=====================================================================*
004500190131
004600000000       // ----------------------------------------------------------------------
004700000000       //  Definitionen für QLIRLIBD API
004800000000       // ----------------------------------------------------------------------
004900000000       //  ... Receiver Variable
005000190131     D rcvVar          DS           512    qualified
005100190131     D bytRet                        10I 0 inz
005200190131     D bytAvl                        10I 0 inz
005300190131     D numRet                        10I 0 inz
005400190131     D numAvl                        10I 0 inz
005500190131
005600190131       //  ... Attributes to retreive
005700000000       //      ... Type of library
005800190131     D cTYPE           C                   1
005900000000       //      ... ASP
006000190131     D cASP            C                   2
006100000000       //      ... Create authority
006200190131     D cCRTAUTH        C                   3
006300000000       //      ... Create object auditing
006400190131     D cCRTAUD         C                   4
006500000000       //      ... Text description
006600190131     D cTEXT           C                   5
006700000000       //      ... Library size information
006800190131     D cSIZE           C                   6
006900000000       //      ... Number of objects in library
007000190131     D cNUMOBJ         C                   7
007100190131
007200190131       //  ... Attributes to retrieve (return value)
007300190131     D attrToRtv       DS                  qualified
007400190131     D numAttr                       10I 0 inz
007500190131     D attr1                         10I 0 inz
007600190131     D attr2                         10I 0 inz
007700190131     D attr3                         10I 0 inz
007800190131     D attr4                         10I 0 inz
007900190131     D attr5                         10I 0 inz
008000190131     D attr6                         10I 0 inz
008100190131     D attr7                         10I 0 inz
008200190131
008300000000       //  ... Data returned
008400190131     D varLenRcd       DS                  qualified based(pVarLenRcd)
008500190131     D dtaLen                        10I 0
008600190131     D keyID                         10I 0
008700190131     D fldSize                       10I 0
008800190131
008900000000       //  ... Library Size Information Format
009000190131     D libSize         DS                  qualified based(pLibSize)
009100190131     D size                          10I 0
009200190131     D mult                          10I 0
009300190131     D infStat                        1A
009400190131     D res01                          3A
009500190131
009600000000       //  ... Library Text Information Format
009700190131     D libDesc         DS                  qualified based(pLibDesc)
009800190131     D text                          50A
009900190131     D
010000190131
010100190131       // ----------------------------------------------------------------------
010200190131       //  Referenzfelder
010300190131       // ----------------------------------------------------------------------
010400190131     D bool_t          S               N   based(pDummy)
010500190131
010600190131      /COPY QDSPLIBSIZ,FDERRCODE
010700190131      /COPY QDSPLIBSIZ,FDQOBJ
010800190131
010900190131       // ----------------------------------------------------------------------
011000190131       //  Konstanten
011100190131       // ----------------------------------------------------------------------
011200190131     D cTRUE           C                   *on
011300190131     D cFALSE          C                   *off
011400190131
011500190131       // ----------------------------------------------------------------------
011600190131       //  Prototypen
011700190131       // ----------------------------------------------------------------------
011800190131
011900190131       // Retrieve Library Description (QLIRLIBD) API
012000190131     D QLIRLIBD        PR                  extpgm('QLIRLIBD')
012100190131     D  o_rcvVar                  32767A          options(*varsize)
012200190131     D  i_rcvVarLen                  10I 0 const
012300190131     D  i_lib                        10A   const
012400190131     D  i_attrToRtv               32767A   const  options(*varsize)
012500190131     D  io_errCode                32767A          options(*varsize)
012600190131
012700190131     D f_newApiErrCode...
012800190131     D                 PR                         likeds(errCode_t)
012900190131     D  i_monMsg                       N   value
013000190131
013100190131     D f_isApiErr...
013200190131     D                 PR              N
013300190131     D  i_errCode                          value  likeds(errCode_t)
013400190131
013500000000       // ----------------------------------------------------------------------
013600000000       //  Definitionen für QMHSNDPM API
013700000000       // ----------------------------------------------------------------------
013800190131     D QMHSNDPM        PR                  extpgm('QMHSNDPM')
013900190131     D  i_msgID                       7A   const
014000190131     D  i_qMsgF                      20A   const
014100190131     D  i_msgData                 32767A   const  options(*varsize)
014200190131     D  i_lenMsgData                 10I 0 const
014300190131     D  i_msgType                    10A   const
014400190131     D  i_callStkE                   10A   const
014500190131     D  i_callStkC                   10I 0 const
014600190131     D  o_msgKey                      4A
014700190131     D  io_errCode                32767A          options(*varsize)
014800190131       //  optional parameter group 1
014900190131     D  i_lenCallStkE                10I 0 const  options(*nopass )
015000190131     D  i_callStkEQ                  20A   const  options(*nopass )
015100190131     D  i_dspMsgWait                 10I 0 const  options(*nopass )
015200190131       //  optional parameter group 2
015300190131     D  i_callStkEDT                 10A   const  options(*nopass )
015400190131     D  i_ccsid                      10I 0 const  options(*nopass )
015500190131
015600190131     D msgKey          S              4A   inz
015700190131     D totLibSize      S             20S 0 inz
017000190131     D msgData         S             80A   inz
017100190131     D qMsgF           DS                  likeds(qObj_t) inz
017101190131     D errCode         DS                  likeds(errCode_t) inz
017102190131
017200190131       // ----------------------------------------------------------------------
017300190131       //  *ENTYR Felder
017400190131       // ----------------------------------------------------------------------
017500190131     D DSPLIBSIZR...
017600190131     D                 PR                         extpgm('DSPLIBSIZR')
017700190131     D  i_lib                        10A   const
017800190131     D  i_language                    3A   const
017900190131
018000190131       // ======================================================================
018100190131       //  Program entry point
018200190131       // ======================================================================
018300190131
018400190131     D DSPLIBSIZR...
018500190131     D                 PI
018600190131     D  i_lib                        10A   const
018700190131     D  i_language                    3A   const
018701190131     D
018800190131     D i               S             10i 0
019200190131       //-------------------------------------------------------------------
019600190131      /free
019900190131
019901190131       Exsr getLibAttr;
020000190131
020100190131       pVarLenRcd = %addr(rcvVar) + 16;
020400190131
020500190131       FOR i = 1 TO rcvVar.numRet;
020700190131
020800190131          Select;
021000190131             //  ... Bibliotheksgröße
021100190131          When (varLenRcd.keyID = cSIZE);
021200190131             Exsr getLibSize;
021300190131             //  ... Bibliotheksbeschreibung (Text)
021400190131          When (varLenRcd.keyID = cTEXT);
021500190131             Exsr getLibText;
021600190131          Other;
021700190131             Exsr *PSSR;
021800190131          Endsl;
021900190131
022000190131          pVarLenRcd = pVarLenRcd + varLenRcd.dtaLen;
022200190131       ENDFOR;
022300190131
022400190131       *INLR = *ON;
022600190131
022700000000       // ----------------------------------------------------------------------
022800000000       //  Ermitteln der Bibliotheksattribute
022900000000       // ----------------------------------------------------------------------
023000190131       Begsr getLibAttr;
023200190131
023300190131          Clear rcvVar;
023400190131          Clear attrToRtv;
023500190131          attrToRtv.numAttr = 2;
023600190131          attrToRtv.attr1 = cSIZE;
023700190131          attrToRtv.attr2 = cTEXT;
023800190131          errCode = f_newApiErrCode(cFALSE);
023900190131          QLIRLIBD(rcvVar: %size(rcvVar): i_lib: attrToRtv: errCode);
024400190131
024500190131       Endsr;
024600190131
024700000000       // ----------------------------------------------------------------------
024800000000       //  Anzeigen der Bibliotheksgröße
024900000000       // ----------------------------------------------------------------------
025000190131       Begsr getLibSize;
025200190131
025300000000          //  Ermitteln der Größe (Objekte in Bibliothek)
025400190131          pLibSize = pVarLenRcd + %size(varLenRcd);
025500190131
025600000000          //  Aufbereiten der Nachricht (Nicht alle Objekte berücksichtigt)
025700190131          If (libSize.infStat = '0');
025800190131
025900190131             Select;
026000190131             When (i_language = 'GER');
026100190131                msgData = 'Nicht alle Objekte von +
026200190131                          Bibliothek ' +
026300190131                            %trim(i_lib) +
026400190131                         ' berücksichtigt.';
026500190131             When (i_language = 'ENG');
026600190131                msgData = 'Not all objects of +
026700190131                          library ' +
026800190131                            %trim(i_lib) +
026900190131                         ' included in total library size.';
027000190131             Other;
027100190131                msgData = 'Unknown language identifier!';
027200190131             Endsl;
027300190131
027400190131             qMsgF.name = 'QCPFMSG';
027500190131             qMsgF.lib = '*LIBL';
027600190131
027700190131             QMHSNDPM('CPF9897': qMsgF: msgData: %size(msgData)
028100190131                      : '*INFO': '*CTLBDY': 1: msgKey: errCode);
028600190131
028700190131          Endif;
028800190131
028900000000          //  Aufbereiten der Nachricht (Größe)
029000190131          totLibSize = libSize.size * libSize.mult;
029100190131
029200190131          Select;
029300190131          When (i_language = 'GER');
029400190131             msgData = 'Bibliothek: ' +
029500190131                         %trim(i_lib) +
029600190131                      ' - Größe: ' +
029700190131                         %trim(%editc(totLibSize: 'K')) +
029800190131                      ' Byte.';
029900190131          When (i_language = 'ENG');
030000190131             msgData = 'Library: ' +
030100190131                         %trim(i_lib) +
030200190131                      ' - Size: ' +
030300190131                         %trim(%editc(totLibSize: 'K')) +
030400190131                      ' byte.';
030500190131          Other;
030600190131             msgData = 'Unknown language identifier!';
030700190131          Endsl;
030800190131
030900190131          qMsgF.name = 'QCPFMSG';
031000190131          qMsgF.lib = '*LIBL';
031100190131
031200190131          QMHSNDPM('CPF9897': qMsgF: msgData: %size(msgData)
031500190131                   : '*INFO': '*CTLBDY': 1: msgKey: errCode);
032100190131
032200190131       Endsr;
032300190131
032400000000       // ----------------------------------------------------------------------
032500000000       //  Anzeigen der Bibliotheksbeschreibung (Text)
032600000000       // ----------------------------------------------------------------------
032700190131       Begsr getLibText;
032900190131
033000190131          //  Aufbereiten der Nachricht (Beschreibung)
033001190131          pLibDesc = pVarLenRcd + %size(varLenRcd);
033200190131          msgData = libDesc.text;
033500190131
033600190131          qMsgF.name = 'QCPFMSG';
033700190131          qMsgF.lib = '*LIBL';
033800190131
033900190131          QMHSNDPM('CPF9897': qMsgF: msgData: %size(msgData)
034300190131                   : '*INFO': '*CTLBDY': 1: msgKey: errCode);
034800190131
034900190131       Endsr;
035000190131
035100000000       // ----------------------------------------------------------------------
035200000000       //  Fehlerbehandlung
035300000000       // ----------------------------------------------------------------------
035400190131       Begsr *PSSR;
035600190131       Endsr '*CANCL';
035900190131
035901190131      /end-free
035902190131
036000190131       //==================================================================*
036100190131       //  Create new API error code
036200190131       //==================================================================*
036300190131     P f_newApiErrCode...
036600190131     P                 B
036700190131     D                 PI                         likeds(errCode_t)
036800190131     D  i_monMsg                           value  like(bool_t)
036900190131
037000190131     D errCode         DS                  likeds(errCode_t) inz
037200190131       //-------------------------------------------------------------------
037300190131      /free
037301190131
037500190131       Clear errCode;
037600190131
037700190131       If (i_monMsg);
037800190131          errCode.bytPrv = %size(errCode);
037900190131       Else;
038000190131          errCode.bytPrv = 0;
038100190131       Endif;
038200190131
038300190131       Return errCode;
038400190131
038500190131      /end-free
038600190131     P                 E
038700190131
038800190131       //==================================================================*
038900190131       //  Is API Error?
039000190131       //==================================================================*
039100190131     P f_isApiErr...
039300190131     P                 B
039400190131     D                 PI                         like(bool_t)
039500190131     D  i_errCode                          value  likeds(errCode_t)
039600190131
039700190131     D o_isError       S                   like(bool_t) inz(cFALSE)
039900190131       //-------------------------------------------------------------------
040000190131      /free
040001190131
040200190131       If (i_errCode.bytAvl = 0);
040300190131          o_isError = cFALSE;
040400190131       Else;
040500190131          o_isError = cTRUE;
040600190131       Endif;
040700190131
040800190131       Return o_isError;
040900190131
041000190131      /end-free
041100190131     P                 E
