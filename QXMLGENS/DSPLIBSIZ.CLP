/* -------------------------------------------------------------------------- */
/* DSPLIBSIZ  - SCRIPT MEMBER                                                 */
/* Use commands  xmlgenINC (generate text for install pgm)                    */
/*               xmlgenMBR (to define source members                          */
/*               xmlgenCMD (execute qcmdexc at run time                       */
/* Put &TOLIB where you want user selected lib at run time.                   */
   DCL &TOLIB *CHAR 10
/* -------------------------------------------------------------------------- */
             XMLGENINC  XINCLUDE(*YES)

             XMLGENVRS XSRCFILE(QDSPLIBSIZ) XSRCLIB(TOOLS400) XSRCMBR(COPYRIGHT)

             XMLGENCND  XMSG('Select language (GER, ENG)') +
                          XVALUES(GER ENG) XVAR(&LANG)

             XMLGENSET  XVAR(&SRCFILE) XVALUE(QDSPLIBSIZ)

/* ---------------------------------- */
/*  Deploy source member              */
/* ---------------------------------- */
             XMLGENMBR  XMBR(A_INSTALL ) XMBRATR(CLLE ) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*PGM   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(A_README  ) XMBRATR(TXT) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*PGM) XGENCRT(*NO ) +
                          XPARAM(*BLANK)

             XMLGENMBR  XMBR(COPYRIGHT ) XMBRATR(RPGLE ) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*MODULE) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPLIBSIPE) XMBRATR(PNLGRP) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*PNLGRP ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPLIBSIPG) XMBRATR(PNLGRP) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*PNLGRP ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPLIBSIZE) XMBRATR(CMD   ) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPLIBSIZG) XMBRATR(CMD   ) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*CMD    ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(DSPLIBSIZR) XMBRATR(RPGLE) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*MODULE ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(FDERRCODE ) XMBRATR(RPGLE   ) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*FILE   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

             XMLGENMBR  XMBR(FDQOBJ    ) XMBRATR(RPGLE   ) XFROMSRCF(QDSPLIBSIZ) +
                          XFROMSRCL(TOOLS400) XTOSRCF(QDSPLIBSIZ) XOBJTYPE(*FILE   ) +
                          XGENCRT(*NO ) XPARAM(*BLANK)

/* ---------------------------------- */
/*  Create objects                    */
/* ---------------------------------- */
             XMLGENCMD  XCMD(CRTBNDCL PGM(&TOLIB/A_INSTALL) +
                          SRCFILE(&TOLIB/QDSPLIBSIZ) SRCMBR(*PGM) +
                          DFTACTGRP(*NO) ACTGRP(*NEW) +
                          DBGVIEW(*LIST)) XDLTSPLF(A_INSTALL)

             XMLGENCMD  XCMD(CALL PGM(&TOLIB/A_INSTALL) +
                             PARM('&TGTRLS' '&SRCFILE' '&TOLIB' '&LANG'))
             XMLGENCMD  XCMD(DLTPGM PGM(&TOLIB/A_INSTALL))

