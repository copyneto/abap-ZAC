*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZVCA_STATUS.....................................*
FORM GET_DATA_ZVCA_STATUS.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM ZTCA_STATUS WHERE
(VIM_WHERETAB) .
    CLEAR ZVCA_STATUS .
ZVCA_STATUS-CLIENT =
ZTCA_STATUS-CLIENT .
ZVCA_STATUS-IDSTATUS =
ZTCA_STATUS-IDSTATUS .
ZVCA_STATUS-STATUS =
ZTCA_STATUS-STATUS .
ZVCA_STATUS-CRITICIDADE =
ZTCA_STATUS-CRITICIDADE .
<VIM_TOTAL_STRUC> = ZVCA_STATUS.
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
FORM DB_UPD_ZVCA_STATUS .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVCA_STATUS.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVCA_STATUS-ST_DELETE EQ GELOESCHT.
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
  SELECT SINGLE FOR UPDATE * FROM ZTCA_STATUS WHERE
  IDSTATUS = ZVCA_STATUS-IDSTATUS .
    IF SY-SUBRC = 0.
    DELETE ZTCA_STATUS .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM ZTCA_STATUS WHERE
  IDSTATUS = ZVCA_STATUS-IDSTATUS .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR ZTCA_STATUS.
    ENDIF.
ZTCA_STATUS-CLIENT =
ZVCA_STATUS-CLIENT .
ZTCA_STATUS-IDSTATUS =
ZVCA_STATUS-IDSTATUS .
ZTCA_STATUS-STATUS =
ZVCA_STATUS-STATUS .
ZTCA_STATUS-CRITICIDADE =
ZVCA_STATUS-CRITICIDADE .
    IF SY-SUBRC = 0.
    UPDATE ZTCA_STATUS ##WARN_OK.
    ELSE.
    INSERT ZTCA_STATUS .
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
CLEAR: STATUS_ZVCA_STATUS-UPD_FLAG,
STATUS_ZVCA_STATUS-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ZVCA_STATUS.
  SELECT SINGLE * FROM ZTCA_STATUS WHERE
IDSTATUS = ZVCA_STATUS-IDSTATUS .
ZVCA_STATUS-CLIENT =
ZTCA_STATUS-CLIENT .
ZVCA_STATUS-IDSTATUS =
ZTCA_STATUS-IDSTATUS .
ZVCA_STATUS-STATUS =
ZTCA_STATUS-STATUS .
ZVCA_STATUS-CRITICIDADE =
ZTCA_STATUS-CRITICIDADE .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVCA_STATUS USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVCA_STATUS-IDSTATUS TO
ZTCA_STATUS-IDSTATUS .
MOVE ZVCA_STATUS-CLIENT TO
ZTCA_STATUS-CLIENT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'ZTCA_STATUS'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN ZTCA_STATUS TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'ZTCA_STATUS'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
