CLASS zclca_save_log DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA gv_object TYPE bal_s_log-object .
    DATA gv_log_handle TYPE balloghndl .

    METHODS constructor
      IMPORTING
        !iv_object TYPE c .
    METHODS log_generate
      IMPORTING
        !iv_subobject TYPE balsubobj
        !it_msg       TYPE bapiret2_tab .
    METHODS create_log
      IMPORTING
        !iv_subobject  TYPE balsubobj
        !iv_externalid TYPE balnrext OPTIONAL.
    METHODS add_msgs
      IMPORTING
        !it_msg TYPE bapiret2_tab .
    METHODS save .
  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.



CLASS zclca_save_log IMPLEMENTATION.


  METHOD add_msgs.

    DATA: ls_msg     TYPE bal_s_msg,
          ls_context TYPE zeca_job.

    LOOP AT it_msg ASSIGNING FIELD-SYMBOL(<fs_msg>).

      ls_msg = VALUE #(
        msgty = <fs_msg>-type
        msgid = <fs_msg>-id
        msgno = <fs_msg>-number
        msgv1 = <fs_msg>-message_v1
        msgv2 = <fs_msg>-message_v2
        msgv3 = <fs_msg>-message_v3
        msgv4 = <fs_msg>-message_v4
      ).

      CALL FUNCTION 'BAL_LOG_MSG_ADD'
        EXPORTING
          i_log_handle     = gv_log_handle
          i_s_msg          = ls_msg
        EXCEPTIONS
          log_not_found    = 1
          msg_inconsistent = 2
          log_is_full      = 3
          OTHERS           = 4.

      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD constructor.

    gv_object = iv_object.

  ENDMETHOD.


  METHOD create_log.

    DATA: ls_log TYPE bal_s_log.

    ls_log-aluser    = sy-uname.
    ls_log-alprog    = sy-repid.
    ls_log-object    = gv_object.
    ls_log-subobject = iv_subobject.
    ls_log-extnumber = iv_externalid.

    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log      = ls_log
      IMPORTING
        e_log_handle = gv_log_handle
      EXCEPTIONS
        OTHERS       = 1.

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

  ENDMETHOD.


  METHOD log_generate.

    create_log( iv_subobject ).

    add_msgs( it_msg ).

    save( ).

  ENDMETHOD.


  METHOD save.

    DATA: lt_log_handle TYPE bal_t_logh.

    APPEND gv_log_handle TO lt_log_handle.

    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_t_log_handle = lt_log_handle
      EXCEPTIONS
        OTHERS         = 4.

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
