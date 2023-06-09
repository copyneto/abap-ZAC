*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZVCA_CENARIO....................................*
FORM GET_DATA_ZVCA_CENARIO.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTCA_CENARIO WHERE
(VIM_WHERETAB) .
    CLEAR ZVCA_CENARIO .
ZVCA_CENARIO-CLIENT =
ZTCA_CENARIO-CLIENT .
ZVCA_CENARIO-ID_CENARIO =
ZTCA_CENARIO-ID_CENARIO .
    SELECT SINGLE * FROM ZTCA_CENARIOT WHERE
ID_CENARIO = ZTCA_CENARIO-ID_CENARIO AND
LANGU = SY-LANGU .
    IF SY-SUBRC EQ 0.
ZVCA_CENARIO-DESC_CENARIO =
ZTCA_CENARIOT-DESC_CENARIO .
    ENDIF.
<VIM_TOTAL_STRUC> = ZVCA_CENARIO.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZVCA_CENARIO .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVCA_CENARIO.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVCA_CENARIO-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM ZTCA_CENARIO WHERE
  ID_CENARIO = ZVCA_CENARIO-ID_CENARIO .
    IF SY-SUBRC = 0.
    DELETE ZTCA_CENARIO .
    ENDIF.
    DELETE FROM ZTCA_CENARIOT WHERE
    ID_CENARIO = ZTCA_CENARIO-ID_CENARIO .
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZTCA_CENARIO WHERE
  ID_CENARIO = ZVCA_CENARIO-ID_CENARIO .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTCA_CENARIO.
    ENDIF.
ZTCA_CENARIO-CLIENT =
ZVCA_CENARIO-CLIENT .
ZTCA_CENARIO-ID_CENARIO =
ZVCA_CENARIO-ID_CENARIO .
    IF SY-SUBRC = 0.
    UPDATE ZTCA_CENARIO ##WARN_OK.
    ELSE.
    INSERT ZTCA_CENARIO .
    ENDIF.
    SELECT SINGLE FOR UPDATE * FROM ZTCA_CENARIOT WHERE
    ID_CENARIO = ZTCA_CENARIO-ID_CENARIO AND
    LANGU = SY-LANGU .
      IF SY-SUBRC <> 0.   "insert preprocessing: init WA
        CLEAR ZTCA_CENARIOT.
ZTCA_CENARIOT-ID_CENARIO =
ZTCA_CENARIO-ID_CENARIO .
ZTCA_CENARIOT-LANGU =
SY-LANGU .
      ENDIF.
ZTCA_CENARIOT-DESC_CENARIO =
ZVCA_CENARIO-DESC_CENARIO .
    IF SY-SUBRC = 0.
    UPDATE ZTCA_CENARIOT ##WARN_OK.
    ELSE.
    INSERT ZTCA_CENARIOT .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZVCA_CENARIO-UPD_FLAG,
STATUS_ZVCA_CENARIO-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ZVCA_CENARIO.
  SELECT SINGLE * FROM ZTCA_CENARIO WHERE
ID_CENARIO = ZVCA_CENARIO-ID_CENARIO .
ZVCA_CENARIO-CLIENT =
ZTCA_CENARIO-CLIENT .
ZVCA_CENARIO-ID_CENARIO =
ZTCA_CENARIO-ID_CENARIO .
    SELECT SINGLE * FROM ZTCA_CENARIOT WHERE
ID_CENARIO = ZTCA_CENARIO-ID_CENARIO AND
LANGU = SY-LANGU .
    IF SY-SUBRC EQ 0.
ZVCA_CENARIO-DESC_CENARIO =
ZTCA_CENARIOT-DESC_CENARIO .
    ELSE.
      CLEAR SY-SUBRC.
      CLEAR ZVCA_CENARIO-DESC_CENARIO .
    ENDIF.
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVCA_CENARIO USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVCA_CENARIO-ID_CENARIO TO
ZTCA_CENARIO-ID_CENARIO .
MOVE ZVCA_CENARIO-CLIENT TO
ZTCA_CENARIO-CLIENT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTCA_CENARIO'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTCA_CENARIO TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTCA_CENARIO'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

MOVE ZTCA_CENARIO-ID_CENARIO TO
ZTCA_CENARIOT-ID_CENARIO .
MOVE SY-LANGU TO
ZTCA_CENARIOT-LANGU .
MOVE ZVCA_CENARIO-CLIENT TO
ZTCA_CENARIOT-CLIENT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTCA_CENARIOT'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTCA_CENARIOT TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTCA_CENARIOT'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
