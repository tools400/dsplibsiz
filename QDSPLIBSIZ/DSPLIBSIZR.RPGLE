       //=====================================================================*
       //                                                                     *
       //  Kurzdokumentation :                                                *
       //                                                                     *
       //  Bereich . . . : DSPLIBSIZ                                          *
       //  Objekt  . . . : DSPLIBSIZR                                         *
       //  Beschreibung  : Tool: DSPLIBSIZ  (Display Library Size)            *
       //  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
       //  Datum . . . . : xx.xx.xxxx                                         *
       //                                                                     *
       //=====================================================================*
       //                                                                     *
       //  This software is free software, you can redistribute it and/or     *
       //  modify it under the terms of the GNU General Public License (GPL)  *
       //  as published by the Free Software Foundation.                      *
       //                                                                     *
       //  See GNU General Public License for details.                        *
       //          http://www.opensource.org                                  *
       //          http://www.opensource.org/licenses/gpl-license.html        *
       //                                                                     *
       //=====================================================================*
       //  History:                                                           *
       //                                                                     *
       //  Datum       Name          Änderung                                 *
       //  ----------  ------------  ---------------------------------------  *
       //                                                                     *
       //=====================================================================*
       // >>PRE-COMPILER<<                                                    *
       //   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
       //                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
       //   >>IMPORTANT<<                                                     *
       //     >>PARM<< TRUNCNBR(*NO);                                         *
       //     >>PARM<< DBGVIEW(*LIST);                                        *
       //   >>END-IMPORTANT<<                                                 *
       //   >>EXECUTE<<                                                       *
       //   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                            *
       //                           MODULE(&LI/&OB) +                         *
       //                           ACTGRP(*NEW) +                            *
       //                           DETAIL(*BASIC);                           *
       // >>END-PRE-COMPILER<<                                                *
       //=====================================================================*
     H DEBUG DECEDIT('0,') DATEDIT(*DMY.)
      /COPY QDSPLIBSIZ,COPYRIGHT
       //=====================================================================*

       // ----------------------------------------------------------------------
       //  Definitionen für QLIRLIBD API
       // ----------------------------------------------------------------------
       //  ... Receiver Variable
     D rcvVar          DS           512    qualified
     D bytRet                        10I 0 inz
     D bytAvl                        10I 0 inz
     D numRet                        10I 0 inz
     D numAvl                        10I 0 inz

       //  ... Attributes to retreive
       //      ... Type of library
     D cTYPE           C                   1
       //      ... ASP
     D cASP            C                   2
       //      ... Create authority
     D cCRTAUTH        C                   3
       //      ... Create object auditing
     D cCRTAUD         C                   4
       //      ... Text description
     D cTEXT           C                   5
       //      ... Library size information
     D cSIZE           C                   6
       //      ... Number of objects in library
     D cNUMOBJ         C                   7

       //  ... Attributes to retrieve (return value)
     D attrToRtv       DS                  qualified
     D numAttr                       10I 0 inz
     D attr1                         10I 0 inz
     D attr2                         10I 0 inz
     D attr3                         10I 0 inz
     D attr4                         10I 0 inz
     D attr5                         10I 0 inz
     D attr6                         10I 0 inz
     D attr7                         10I 0 inz

       //  ... Data returned
     D varLenRcd       DS                  qualified based(pVarLenRcd)
     D dtaLen                        10I 0
     D keyID                         10I 0
     D fldSize                       10I 0

       //  ... Library Size Information Format
     D libSize         DS                  qualified based(pLibSize)
     D size                          10I 0
     D mult                          10I 0
     D infStat                        1A
     D res01                          3A

       //  ... Library Text Information Format
     D libDesc         DS                  qualified based(pLibDesc)
     D text                          50A
     D

       // ----------------------------------------------------------------------
       //  Referenzfelder
       // ----------------------------------------------------------------------
     D bool_t          S               N   based(pDummy)

      /COPY QDSPLIBSIZ,FDERRCODE
      /COPY QDSPLIBSIZ,FDQOBJ

       // ----------------------------------------------------------------------
       //  Konstanten
       // ----------------------------------------------------------------------
     D cTRUE           C                   *on
     D cFALSE          C                   *off

       // ----------------------------------------------------------------------
       //  Prototypen
       // ----------------------------------------------------------------------

       // Retrieve Library Description (QLIRLIBD) API
     D QLIRLIBD        PR                  extpgm('QLIRLIBD')
     D  o_rcvVar                  32767A          options(*varsize)
     D  i_rcvVarLen                  10I 0 const
     D  i_lib                        10A   const
     D  i_attrToRtv               32767A   const  options(*varsize)
     D  io_errCode                32767A          options(*varsize)

     D f_newApiErrCode...
     D                 PR                         likeds(errCode_t)
     D  i_monMsg                       N   value

     D f_isApiErr...
     D                 PR              N
     D  i_errCode                          value  likeds(errCode_t)

       // ----------------------------------------------------------------------
       //  Definitionen für QMHSNDPM API
       // ----------------------------------------------------------------------
     D QMHSNDPM        PR                  extpgm('QMHSNDPM')
     D  i_msgID                       7A   const
     D  i_qMsgF                      20A   const
     D  i_msgData                 32767A   const  options(*varsize)
     D  i_lenMsgData                 10I 0 const
     D  i_msgType                    10A   const
     D  i_callStkE                   10A   const
     D  i_callStkC                   10I 0 const
     D  o_msgKey                      4A
     D  io_errCode                32767A          options(*varsize)
       //  optional parameter group 1
     D  i_lenCallStkE                10I 0 const  options(*nopass )
     D  i_callStkEQ                  20A   const  options(*nopass )
     D  i_dspMsgWait                 10I 0 const  options(*nopass )
       //  optional parameter group 2
     D  i_callStkEDT                 10A   const  options(*nopass )
     D  i_ccsid                      10I 0 const  options(*nopass )

     D msgKey          S              4A   inz
     D totLibSize      S             20S 0 inz
     D msgData         S             80A   inz
     D qMsgF           DS                  likeds(qObj_t) inz
     D errCode         DS                  likeds(errCode_t) inz

       // ----------------------------------------------------------------------
       //  *ENTYR Felder
       // ----------------------------------------------------------------------
     D DSPLIBSIZR...
     D                 PR                         extpgm('DSPLIBSIZR')
     D  i_lib                        10A   const
     D  i_language                    3A   const

       // ======================================================================
       //  Program entry point
       // ======================================================================

     D DSPLIBSIZR...
     D                 PI
     D  i_lib                        10A   const
     D  i_language                    3A   const
     D
     D i               S             10i 0
       //-------------------------------------------------------------------
      /free

       Exsr getLibAttr;

       pVarLenRcd = %addr(rcvVar) + 16;

       FOR i = 1 TO rcvVar.numRet;

          Select;
             //  ... Bibliotheksgröße
          When (varLenRcd.keyID = cSIZE);
             Exsr getLibSize;
             //  ... Bibliotheksbeschreibung (Text)
          When (varLenRcd.keyID = cTEXT);
             Exsr getLibText;
          Other;
             Exsr *PSSR;
          Endsl;

          pVarLenRcd = pVarLenRcd + varLenRcd.dtaLen;
       ENDFOR;

       *INLR = *ON;

       // ----------------------------------------------------------------------
       //  Ermitteln der Bibliotheksattribute
       // ----------------------------------------------------------------------
       Begsr getLibAttr;

          Clear rcvVar;
          Clear attrToRtv;
          attrToRtv.numAttr = 2;
          attrToRtv.attr1 = cSIZE;
          attrToRtv.attr2 = cTEXT;
          errCode = f_newApiErrCode(cFALSE);
          QLIRLIBD(rcvVar: %size(rcvVar): i_lib: attrToRtv: errCode);

       Endsr;

       // ----------------------------------------------------------------------
       //  Anzeigen der Bibliotheksgröße
       // ----------------------------------------------------------------------
       Begsr getLibSize;

          //  Ermitteln der Größe (Objekte in Bibliothek)
          pLibSize = pVarLenRcd + %size(varLenRcd);

          //  Aufbereiten der Nachricht (Nicht alle Objekte berücksichtigt)
          If (libSize.infStat = '0');

             Select;
             When (i_language = 'GER');
                msgData = 'Nicht alle Objekte von +
                          Bibliothek ' +
                            %trim(i_lib) +
                         ' berücksichtigt.';
             When (i_language = 'ENG');
                msgData = 'Not all objects of +
                          library ' +
                            %trim(i_lib) +
                         ' included in total library size.';
             Other;
                msgData = 'Unknown language identifier!';
             Endsl;

             qMsgF.name = 'QCPFMSG';
             qMsgF.lib = '*LIBL';

             QMHSNDPM('CPF9897': qMsgF: msgData: %size(msgData)
                      : '*INFO': '*CTLBDY': 1: msgKey: errCode);

          Endif;

          //  Aufbereiten der Nachricht (Größe)
          totLibSize = libSize.size * libSize.mult;

          Select;
          When (i_language = 'GER');
             msgData = 'Bibliothek: ' +
                         %trim(i_lib) +
                      ' - Größe: ' +
                         %trim(%editc(totLibSize: 'K')) +
                      ' Byte.';
          When (i_language = 'ENG');
             msgData = 'Library: ' +
                         %trim(i_lib) +
                      ' - Size: ' +
                         %trim(%editc(totLibSize: 'K')) +
                      ' byte.';
          Other;
             msgData = 'Unknown language identifier!';
          Endsl;

          qMsgF.name = 'QCPFMSG';
          qMsgF.lib = '*LIBL';

          QMHSNDPM('CPF9897': qMsgF: msgData: %size(msgData)
                   : '*INFO': '*CTLBDY': 1: msgKey: errCode);

       Endsr;

       // ----------------------------------------------------------------------
       //  Anzeigen der Bibliotheksbeschreibung (Text)
       // ----------------------------------------------------------------------
       Begsr getLibText;

          //  Aufbereiten der Nachricht (Beschreibung)
          pLibDesc = pVarLenRcd + %size(varLenRcd);
          msgData = libDesc.text;

          qMsgF.name = 'QCPFMSG';
          qMsgF.lib = '*LIBL';

          QMHSNDPM('CPF9897': qMsgF: msgData: %size(msgData)
                   : '*INFO': '*CTLBDY': 1: msgKey: errCode);

       Endsr;

       // ----------------------------------------------------------------------
       //  Fehlerbehandlung
       // ----------------------------------------------------------------------
       Begsr *PSSR;
       Endsr '*CANCL';

      /end-free

       //==================================================================*
       //  Create new API error code
       //==================================================================*
     P f_newApiErrCode...
     P                 B
     D                 PI                         likeds(errCode_t)
     D  i_monMsg                           value  like(bool_t)

     D errCode         DS                  likeds(errCode_t) inz
       //-------------------------------------------------------------------
      /free

       Clear errCode;

       If (i_monMsg);
          errCode.bytPrv = %size(errCode);
       Else;
          errCode.bytPrv = 0;
       Endif;

       Return errCode;

      /end-free
     P                 E

       //==================================================================*
       //  Is API Error?
       //==================================================================*
     P f_isApiErr...
     P                 B
     D                 PI                         like(bool_t)
     D  i_errCode                          value  likeds(errCode_t)

     D o_isError       S                   like(bool_t) inz(cFALSE)
       //-------------------------------------------------------------------
      /free

       If (i_errCode.bytAvl = 0);
          o_isError = cFALSE;
       Else;
          o_isError = cTRUE;
       Endif;

       Return o_isError;

      /end-free
     P                 E
