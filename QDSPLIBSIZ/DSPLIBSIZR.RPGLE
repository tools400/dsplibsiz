**free
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
ctl-opt debug decedit('0,') datedit(*DMY.);
/copy QDSPLIBSIZ,COPYRIGHT
//=====================================================================*

// ----------------------------------------------------------------------
//  Definitionen für QLIRLIBD API
// ----------------------------------------------------------------------
//  ... Receiver Variable
dcl-ds rcvVar len(512) qualified;
  bytRet int(10) inz;
  bytAvl int(10) inz;
  numRet int(10) inz;
  numAvl int(10) inz;
end-ds;

//  ... Attributes to retreive
//      ... Type of library
dcl-c cTYPE 1;
//      ... ASP
dcl-c cASP 2;
//      ... Create authority
dcl-c cCRTAUTH 3;
//      ... Create object auditing
dcl-c cCRTAUD 4;
//      ... Text description
dcl-c cTEXT 5;
//      ... Library size information
dcl-c cSIZE 6;
//      ... Number of objects in library
dcl-c cNUMOBJ 7;

//  ... Attributes to retrieve (return value)
dcl-ds attrToRtv qualified;
  numAttr int(10) inz;
  attr1   int(10) inz;
  attr2   int(10) inz;
  attr3   int(10) inz;
  attr4   int(10) inz;
  attr5   int(10) inz;
  attr6   int(10) inz;
  attr7   int(10) inz;
end-ds;

//  ... Data returned
dcl-ds varLenRcd qualified based(pVarLenRcd);
  dtaLen  int(10);
  keyID   int(10);
  fldSize int(10);
end-ds;

//  ... Library Size Information Format
dcl-ds libSize qualified based(pLibSize);
  size    int(10);
  mult    int(10);
  infStat char(1);
  res01   char(3);
end-ds;

//  ... Library Text Information Format
dcl-ds libDesc qualified based(pLibDesc);
  text char(50);
end-ds;


// ----------------------------------------------------------------------
//  Referenzfelder
// ----------------------------------------------------------------------
dcl-s bool_t ind based(pDummy);

/copy QDSPLIBSIZ,FDERRCODE
/copy QDSPLIBSIZ,FDQOBJ

// ----------------------------------------------------------------------
//  Konstanten
// ----------------------------------------------------------------------
dcl-c cTRUE *on;
dcl-c cFALSE *off;

// ----------------------------------------------------------------------
//  Prototypen
// ----------------------------------------------------------------------

// Retrieve Library Description (QLIRLIBD) API
dcl-pr QLIRLIBD extpgm('QLIRLIBD');
  o_rcvVar    char(32767) options(*varsize);
  i_rcvVarLen int(10) const;
  i_lib       char(10) const;
  i_attrToRtv char(32767) options(*varsize) const;
  io_errCode  char(32767) options(*varsize);
end-pr;

dcl-pr f_newApiErrCode likeds(errCode_t);
  i_monMsg ind value;
end-pr;

dcl-pr f_isApiErr ind;
  i_errCode likeds(errCode_t) value;
end-pr;

// ----------------------------------------------------------------------
//  Definitionen für QMHSNDPM API
// ----------------------------------------------------------------------
dcl-pr QMHSNDPM extpgm('QMHSNDPM');
  i_msgID       char(7) const;
  i_qMsgF       char(20) const;
  i_msgData     char(32767) options(*varsize) const;
  i_lenMsgData  int(10) const;
  i_msgType     char(10) const;
  i_callStkE    char(10) const;
  i_callStkC    int(10) const;
  o_msgKey      char(4);
  io_errCode    char(32767) options(*varsize);
  //  optional parameter group 1
  i_lenCallStkE int(10) options(*nopass) const;
  i_callStkEQ   char(20) options(*nopass) const;
  i_dspMsgWait  int(10) options(*nopass) const;
  //  optional parameter group 2
  i_callStkEDT  char(10) options(*nopass) const;
  i_ccsid       int(10) options(*nopass) const;
end-pr;

dcl-s msgKey char(4) inz;
dcl-s totLibSize zoned(20) inz;
dcl-s msgData char(80) inz;
dcl-ds qMsgF likeds(qObj_t) inz;
dcl-ds errCode likeds(errCode_t) inz;

// --------------------------------------------------------------------
//  *ENTYR Felder
// --------------------------------------------------------------------
dcl-pr DSPLIBSIZR extpgm('DSPLIBSIZR');
  i_lib      char(10) const;
  i_language char(3) const;
end-pr;

// ======================================================================
//  Program entry point
// ======================================================================
dcl-pi DSPLIBSIZR;
  i_lib      char(10) const;
  i_language char(3) const;
end-pi;

dcl-s i int(10);
//-------------------------------------------------------------------

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


//==================================================================*
//  Create new API error code
//==================================================================*
dcl-proc f_newApiErrCode;
  dcl-pi *n likeds(errCode_t);
    i_monMsg like(bool_t) value;
  end-pi;

  dcl-ds errCode likeds(errCode_t) inz;
  //-------------------------------------------------------------------

  Clear errCode;

  If (i_monMsg);
    errCode.bytPrv = %size(errCode);
  Else;
    errCode.bytPrv = 0;
  Endif;

  Return errCode;

end-proc;

//==================================================================*
//  Is API Error?
//==================================================================*
dcl-proc f_isApiErr;
  dcl-pi *n like(bool_t);
    i_errCode likeds(errCode_t) value;
  end-pi;

  dcl-s o_isError like(bool_t) inz(cFALSE);
  //-------------------------------------------------------------------

  If (i_errCode.bytAvl = 0);
    o_isError = cFALSE;
  Else;
    o_isError = cTRUE;
  Endif;

  Return o_isError;

end-proc;
