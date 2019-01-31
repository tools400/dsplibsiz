000100190131      *=====================================================================*
000200190131      *                                                                     *
000300190131      *  Kurzdokumentation :                                                *
000400190131      *                                                                     *
000500190131      *  Bereich . . . : DSPLIBSIZ                                          *
000600190131      *  Objekt  . . . : DSPLIBSIZR                                         *
000700190131      *  Beschreibung  : Tool: DSPLIBSIZ  (Display Library Size)            *
000800190131      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
000900190131      *  Datum . . . . : xx.xx.xxxx                                         *
001000190131      *                                                                     *
001100190131      *=====================================================================*
001200190131      *                                                                     *
001300190131      *  This software is free software, you can redistribute it and/or     *
001400190131      *  modify it under the terms of the GNU General Public License (GPL)  *
001500190131      *  as published by the Free Software Foundation.                      *
001600190131      *                                                                     *
001700190131      *  See GNU General Public License for details.                        *
001800190131      *          http://www.opensource.org                                  *
001900190131      *          http://www.opensource.org/licenses/gpl-license.html        *
002000190131      *                                                                     *
002100190131      *=====================================================================*
002200190131      *  History:                                                           *
002300190131      *                                                                     *
002400190131      *  Datum       Name          Änderung                                 *
002500190131      *  ----------  ------------  ---------------------------------------  *
002600190131      *                                                                     *
002700190131      *=====================================================================*
002800190131      * >>PRE-COMPILER<<                                                    *
002900190131      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
003100190131      *                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
003200190131      *   >>IMPORTANT<<                                                     *
003500190131      *     >>PARM<< TRUNCNBR(*NO);                                         *
003600190131      *     >>PARM<< DBGVIEW(*LIST);                                        *
003700190131      *   >>END-IMPORTANT<<                                                 *
004300190131      *   >>EXECUTE<<                                                       *
004500190131      *   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                            *
004501190131      *                           MODULE(&LI/&OB) +                         *
004502190131      *                           ACTGRP(*NEW) +                            *
004503190131      *                           DETAIL(*BASIC);                           *
004504190131      * >>END-PRE-COMPILER<<                                                *
004700190131      *=====================================================================*
004800190131     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
004801190131      /COPY QDSPLIBSIZ,COPYRIGHT
005000190131      *=====================================================================*
005100000000      *
005200000000      * ----------------------------------------------------------------------
005300000000      *  Definitionen für QLIRLIBD API
005400000000      * ----------------------------------------------------------------------
005500000000      *  ... Receiver Variable
005600190131     D rcvVar          DS           512    qualified
005700190131     D  bytRet                 1      4I 0 inz
005800190131     D  bytAvl                 5      8I 0 inz
005900190131     D  numRet                 9     12I 0 inz
006000190131     D  numAvl                13     16I 0 inz
006100190131      *
006200190131      *  ... Attributes to retreive
006300000000      *      ... Type of library
006400190131     D cTYPE           C                   1
006500000000      *      ... ASP
006600190131     D cASP            C                   2
006700000000      *      ... Create authority
006800190131     D cCRTAUTH        C                   3
006900000000      *      ... Create object auditing
007000190131     D cCRTAUD         C                   4
007100000000      *      ... Text description
007200190131     D cTEXT           C                   5
007300000000      *      ... Library size information
007400190131     D cSIZE           C                   6
007500000000      *      ... Number of objects in library
007600190131     D cNUMOBJ         C                   7
007700190131      *
007800190131      *  ... Attributes to retrieve (return value)
007900190131     D attrToRtv       DS                  qualified
008000190131     D  numAttr                1      4I 0 inz
008100190131     D  attr1                  5      8I 0 inz
008300190131     D  attr2                  9     12I 0 inz
008500190131     D  attr3                 13     16I 0 inz
008700190131     D  attr4                 17     20I 0 inz
008900190131     D  attr5                 21     24I 0 inz
009100190131     D  attr6                 25     28I 0 inz
009300190131     D  attr7                 29     32I 0 inz
009500190131      *
009700000000      *  ... Data returned
009800190131     D varLenRcd       DS                  qualified based(pVarLenRcd)
009900190131     D  dtaLen                 1      4I 0
010000190131     D  keyID                  5      8I 0
010200190131     D  fldSize                9     12I 0
010400190131      *
010600000000      *  ... Library Size Information Format
010700190131     D libSize         DS                  qualified based(pLibSize)
010800190131     D  size                   1      4I 0
010900190131     D  mult                   5      8I 0
011100190131     D  infStat                9      9A
011300190131     D  res01                 10     12A
011500190131      *
011700000000      *  ... Library Text Information Format
011800190131     D libDesc         DS                  qualified based(pLibDesc)
011900190131     D  text                   1     50A
012000190131     D
012100190131      *
012200190131      * ----------------------------------------------------------------------
012300190131      *  Referenzfelder
012400190131      * ----------------------------------------------------------------------
012500190131     D bool_t          S               N   based(pDummy)
012501190131      *
012502190131      /COPY QDSPLIBSIZ,FDERRCODE
012600190131      /COPY QDSPLIBSIZ,FDQOBJ
012601190131      *
012900190131      * ----------------------------------------------------------------------
013000190131      *  Konstanten
013100190131      * ----------------------------------------------------------------------
013200190131     D cTRUE           C                   *on
013300190131     D cFALSE          C                   *off
013400190131      *
013500190131      * ----------------------------------------------------------------------
013600190131      *  Prototypen
013700190131      * ----------------------------------------------------------------------
013701190131      *
013702190131      * Retrieve Library Description (QLIRLIBD) API
013800190131     D QLIRLIBD        PR                  extpgm('QLIRLIBD')
013900190131     D  o_rcvVar                  32767A          options(*varsize)
014000190131     D  i_rcvVarLen                  10I 0 const
014100190131     D  i_lib                        10A   const
014200190131     D  i_attrToRtv               32767A   const  options(*varsize)
014300190131     D  io_errCode                32767A          options(*varsize)
014400190131      *
014500190131     D f_newApiErrCode...
014600190131     D                 PR                         likeds(errCode_t)
014700190131     D  i_monMsg                       N   value
014800190131      *
014900190131     D f_isApiErr...
015000190131     D                 PR              N
015100190131     D  i_errCode                          value  likeds(errCode_t)
015200000000      *
015300000000      * ----------------------------------------------------------------------
015400000000      *  Definitionen für QMHSNDPM API
015500000000      * ----------------------------------------------------------------------
015600190131     D QMHSNDPM        PR                  extpgm('QMHSNDPM')
015700190131     D  i_msgID                       7A   const
015800190131     D  i_qMsgF                      20A   const
015900190131     D  i_msgData                 32767A   const  options(*varsize)
016000190131     D  i_lenMsgData                 10I 0 const
016100190131     D  i_msgType                    10A   const
016200190131     D  i_callStkE                   10A   const
016300190131     D  i_callStkC                   10I 0 const
016400190131     D  o_msgKey                      4A
016500190131     D  io_errCode                32767A          options(*varsize)
016600190131      *  optional parameter group 1
016700190131     D  i_lenCallStkE                10I 0 const  options(*nopass )
016800190131     D  i_callStkEQ                  20A   const  options(*nopass )
016900190131     D  i_dspMsgWait                 10I 0 const  options(*nopass )
017000190131      *  optional parameter group 2
017100190131     D  i_callStkEDT                 10A   const  options(*nopass )
017200190131     D  i_ccsid                      10I 0 const  options(*nopass )
017300190131      *
017400190131     D msgKey          S              4A   inz
017500190131      *
017600190131     D qMsgF           DS                  likeds(qObj_t) inz
017700190131      *
017900000000      * ----------------------------------------------------------------------
018000000000      *  Definitionen für alle API
018100000000      * ----------------------------------------------------------------------
018200000000      *  ... Error Code
018300190131     D errCode         DS                  likeds(errCode_t) inz
018400190131      *
018600000000      * ----------------------------------------------------------------------
018700190131      *  Nachrichten
018800000000      * ----------------------------------------------------------------------
018900190131     D totLibSize      S             20S 0 inz
019000190131     D msgData         S             80A   inz
019100190131      *
019200190131      * ----------------------------------------------------------------------
019300190131      *  *ENTYR Felder
019400190131      * ----------------------------------------------------------------------
019500190131     D DSPLIBSIZR...
019600190131     D                 PR                         extpgm('DSPLIBSIZR')
019700190131     D  i_lib                        10A   const
019800190131     D  i_language                    3A   const
019900000000      *
020000190131      * ======================================================================
020100000000      *  *ENTRY - Liste
020200190131      * ======================================================================
020300000000      *
020400190131     D DSPLIBSIZR...
020401190131     D                 PI
020600190131     D  i_lib                        10A   const
020700190131     D  i_language                    3A   const
020800190131      *-------------------------------------------------------------------
020900190131      *
021000190131      *  Ermitteln der Bibliotheksattribute
021100190131     C                   Exsr      getLibAttr
021200000000      *
021300000000      *  Verarbeiten der Informationen
021400000000      *  ... setzen Offset für "Variable length records returned"
021500190131     C                   Eval      pVarLenRcd = %addr(rcvVar) + 16              Startposition
021600000000      *
021700000000      *  ... durchlesen aller "Variable length records returned"
021800190131     C     1             Do        rcvVar.numRet
021900000000      *
022000000000      *  ... starten Verarbeitung pro Satz
022100190131     C                   Select
022200000000      *      ... Bibliotheksgröße
022300190131     C                   When      (varLenRcd.keyID = cSIZE)
022400190131     C                   Exsr      getLibSize
022500000000      *      ... Bibliotheksbeschreibung (Text)
022600190131     C                   When      (varLenRcd.keyID = cTEXT)
022700190131     C                   Exsr      getLibText
022800190131     C                   Other
022900190131     C                   Exsr      *PSSR
023000190131     C                   Endsl
023100000000      *
023200000000      *  ... berechnen neuen Offset
023300190131     C                   Eval      pVarLenRcd = pVarLenRcd + varLenRcd.dtaLen
023400190131     C                   Enddo
023500000000      *
023600000000      *  Beenden Programm
023700190131     C                   Eval      *INLR = *ON
023800000000      *
023900000000      * ----------------------------------------------------------------------
024000000000      *  Ermitteln der Bibliotheksattribute
024100000000      * ----------------------------------------------------------------------
024200000000      *
024300190131     C     getLibAttr    Begsr
024400000000      *
024500190131     C                   Clear                   rcvVar
024600190131     C                   Clear                   attrToRtv                      | Attr. to rec
024700190131     C                   Eval      attrToRtv.numAttr = 2
024800190131     C                   Eval      attrToRtv.attr1 = cSIZE
024900190131     C                   Eval      attrToRtv.attr2 = cTEXT
025000190131     C                   Eval      errCode = f_newApiErrCode(cFALSE)
025100190131     C                   Callp     QLIRLIBD(rcvVar        :
025200190131     C                                      %size(rcvVar) :
025300190131     C                                      i_lib         :
025400190131     C                                      attrToRtv     :
025500190131     C                                      errCode       )
025600000000      *
025700190131     C                   Endsr
025800000000      *
025900000000      * ----------------------------------------------------------------------
026000000000      *  Anzeigen der Bibliotheksgröße
026100000000      * ----------------------------------------------------------------------
026200000000      *
026300190131     C     getLibSize    Begsr
026400000000      *
026500000000      *  Ermitteln der Größe (Objekte in Bibliothek)
026600190131     C                   Eval      pLibSize = pVarLenRcd + %size(varLenRcd)
026700000000      *
026800000000      *  Aufbereiten der Nachricht (Nicht alle Objekte berücksichtigt)
026900190131     C                   If        (libSize.infStat = '0')
027000190131      *
027100190131     C                   Select
027200190131     C                   When      (i_language = 'GER')
027300190131     C                   Eval      msgData = 'Nicht alle Objekte von +
027400190131     C                                        Bibliothek ' +
027500190131     C                                          %trim(i_lib) +
027600190131     C                                       ' berücksichtigt.'
027700190131     C                   When      (i_language = 'ENG')
027800190131     C                   Eval      msgData = 'Not all objects of +
027900190131     C                                        library ' +
028000190131     C                                          %trim(i_lib) +
028100190131     C                                       ' included in total library size.'
028200190131     C                   Other
028300190131     C                   Eval      msgData = 'Unknown language identifier!'
028400190131     C                   Endsl
028500190131      *
028600190131     C                   Eval      qMsgF.name = 'QCPFMSG'
028700190131     C                   Eval      qMsgF.lib  = '*LIBL'
028800190131      *
028900190131     C                   Callp     QMHSNDPM('CPF9897'      :
029000190131     C                                      qMsgF          :
029100190131     C                                      msgData        :
029200190131     C                                      %size(msgData) :
029300190131     C                                      '*INFO'        :
029400190131     C                                      '*CTLBDY'      :
029500190131     C                                      1              :
029600190131     C                                      msgKey         :
029700190131     C                                      errCode        )
029800000000      *
029900190131     C                   Endif
030000000000      *
030100000000      *  Aufbereiten der Nachricht (Größe)
030200190131     C                   Eval      totLibSize = libSize.size * libSize.mult
030300190131      *
030400190131     C                   Select
030500190131     C                   When      (i_language = 'GER')
030600190131     C                   Eval      msgData = 'Bibliothek: ' +
030700190131     C                                          %trim(i_lib) +
030800190131     C                                       ' - Größe: ' +
030900190131     C                                          %trim(%editc(totLibSize: 'K')) +
031000190131     C                                       ' Byte.'
031100190131     C                   When      (i_language = 'ENG')
031200190131     C                   Eval      msgData = 'Library: ' +
031300190131     C                                          %trim(i_lib) +
031400190131     C                                       ' - Size: ' +
031500190131     C                                          %trim(%editc(totLibSize: 'K')) +
031600190131     C                                       ' byte.'
031700190131     C                   Other
031800190131     C                   Eval      msgData = 'Unknown language identifier!'
031900190131     C                   Endsl
032000190131      *
032100190131     C                   Eval      qMsgF.name = 'QCPFMSG'
032200190131     C                   Eval      qMsgF.lib = '*LIBL'
032300000000      *
032400190131     C                   Callp     QMHSNDPM('CPF9897'      :
032500190131     C                                      qMsgF          :
032600190131     C                                      msgData        :
032700190131     C                                      %size(msgData) :
032800190131     C                                      '*INFO'        :
032900190131     C                                      '*CTLBDY'      :
033000190131     C                                      1              :
033100190131     C                                      msgKey         :
033200190131     C                                      errCode        )
033300000000      *
033400190131     C                   Endsr
033500000000      *
033600000000      * ----------------------------------------------------------------------
033700000000      *  Anzeigen der Bibliotheksbeschreibung (Text)
033800000000      * ----------------------------------------------------------------------
033900000000      *
034000190131     C     getLibText    Begsr
034100000000      *
034200000000      *  Ermitteln der Größe
034300190131     C                   Eval      pLibDesc = pVarLenRcd + %size(varLenRcd)
034400000000      *
034500000000      *  Aufbereiten der Nachricht (Beschreibung)
034600190131     C                   Eval      msgData = libDesc.text
034700190131      *
034800190131     C                   Eval      qMsgF.name = 'QCPFMSG'
034900190131     C                   Eval      qMsgF.lib  = '*LIBL'
035000000000      *
035100190131     C                   Callp     QMHSNDPM('CPF9897'      :
035200190131     C                                      qMsgF          :
035300190131     C                                      msgData        :
035400190131     C                                      %size(msgData) :
035500190131     C                                      '*INFO'        :
035600190131     C                                      '*CTLBDY'      :
035700190131     C                                      1              :
035800190131     C                                      msgKey         :
035900190131     C                                      errCode        )
036000000000      *
036100190131     C                   Endsr
036200000000      *
036300000000      * ----------------------------------------------------------------------
036400000000      *  Fehlerbehandlung
036500000000      * ----------------------------------------------------------------------
036600000000      *
036700190131     C     *PSSR         Begsr
036800000000      *
036900000000      *
037000190131     C                   Endsr     '*CANCL'
037100190131      *
037200190131      *==================================================================*
037300190131      *  Create new API error code
037400190131      *==================================================================*
037500190131      *
037600190131     P f_newApiErrCode...
037700190131     P                 B
037800190131     D                 PI                         likeds(errCode_t)
038100190131     D  i_monMsg                           value  like(bool_t)
038200190131      *
038300190131      *  Deklarieren Funktionswert
038400190131     D errCode         DS                  likeds(errCode_t) inz
038500190131      *-------------------------------------------------------------------
038700190131      *
038800190131     C                   Clear                   errCode
038900190131      *
039000190131     C                   If        (i_monMsg)
039100190131     C                   Eval      errCode.bytPrv = %size(errCode)
039200190131     C                   Else
039300190131     C                   Eval      errCode.bytPrv = 0
039400190131     C                   Endif
039500190131      *
039600190131     C                   Return    errCode
039700190131      *
039800190131     P                 E
040000190131      *
040100190131      *==================================================================*
040200190131      *  Is API Error?
040300190131      *==================================================================*
040400190131      *
040500190131     P f_isApiErr...
040600190131     P                 B
040700190131     D                 PI                         like(bool_t)
041000190131     D  i_errCode                          value  likeds(errCode_t)
041100190131      *
041200190131      *  Deklarieren Funktionswert
041300190131     D o_isError       S                   like(bool_t) inz(cFALSE)
041400190131      *-------------------------------------------------------------------
041900190131      *
042200190131     C                   If        (i_errCode.bytAvl = 0)
042300190131     C                   Eval      o_isError = cFALSE
042400190131     C                   Else
042500190131     C                   Eval      o_isError = cTRUE
042600190131     C                   Endif
042700190131      *
042800190131     C                   Return    o_isError
042900190131      *
043000190131     P                 E
043200000000      *
