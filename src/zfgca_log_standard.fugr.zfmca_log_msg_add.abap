FUNCTION zfmca_log_msg_add.
*"----------------------------------------------------------------------
*"*"Interface local:
*"  IMPORTING
*"     VALUE(IS_LOG) TYPE  BAL_S_LOG
*"     VALUE(IS_MSG) TYPE  BAPIRET2 OPTIONAL
*"     VALUE(IT_MSGS) TYPE  BAPIRET2_TAB OPTIONAL
*"----------------------------------------------------------------------

  DATA: lv_log_handle TYPE balloghndl.

  CALL FUNCTION 'BAL_LOG_CREATE'
    EXPORTING
      i_s_log                 = is_log
    IMPORTING
      e_log_handle            = lv_log_handle
    EXCEPTIONS
      log_header_inconsistent = 1
      OTHERS                  = 2.
  CHECK sy-subrc EQ 0.

  IF is_msg IS NOT INITIAL.
    APPEND is_msg TO it_msgs.
  ENDIF.

  LOOP AT it_msgs ASSIGNING FIELD-SYMBOL(<fs_msg>).
    DATA(ls_bal_msg) = VALUE bal_s_msg( msgty = <fs_msg>-type
                                        msgid = <fs_msg>-id
                                        msgno = <fs_msg>-number
                                        msgv1 = <fs_msg>-message_v1
                                        msgv2 = <fs_msg>-message_v2
                                        msgv3 = <fs_msg>-message_v3
                                        msgv4 = <fs_msg>-message_v4 ).

    CALL FUNCTION 'BAL_LOG_MSG_ADD'
      EXPORTING
        i_log_handle     = lv_log_handle
        i_s_msg          = ls_bal_msg
      EXCEPTIONS
        log_not_found    = 1
        msg_inconsistent = 2
        log_is_full      = 3
        OTHERS           = 4.
    CHECK sy-subrc EQ 0.
  ENDLOOP.

  DATA(lt_log_handle) = VALUE bal_t_logh( ).
  APPEND lv_log_handle TO lt_log_handle.

  CALL FUNCTION 'BAL_DB_SAVE'
    EXPORTING
      i_t_log_handle = lt_log_handle
    EXCEPTIONS
      OTHERS         = 4.
  CHECK sy-subrc EQ 0.

ENDFUNCTION.
