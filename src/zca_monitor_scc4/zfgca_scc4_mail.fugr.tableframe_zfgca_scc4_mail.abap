*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZFGCA_SCC4_MAIL
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZFGCA_SCC4_MAIL    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
