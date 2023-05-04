class ZCLCA_MESSAGES definition
  public
  final
  create public .

public section.

  methods MESSAGES_SHOW_AS_POPUP
    importing
      !IV_MSGID type SY-MSGID optional
      !IV_MSGTY type SY-MSGTY optional
      !IV_MSGNO type SY-MSGNO optional
      !IV_MSGV1 type SYST_MSGV optional
      !IV_MSGV2 type SYST_MSGV optional
      !IV_MSGV3 type SYST_MSGV optional
      !IV_MSGV4 type SYST_MSGV optional
      !IV_LINENO type I optional
      !IV_USE_GRID type C default ' '
      !IT_MESSAGE_TAB type ESP1_MESSAGE_TAB_TYPE optional .
protected section.
private section.
ENDCLASS.



CLASS ZCLCA_MESSAGES IMPLEMENTATION.


  METHOD messages_show_as_popup.
* Local data -------------------------------------------------------
    DATA: lv_message_to_display TYPE boolean.

    DATA: lv_msgv1  TYPE sy-msgv1,
          lv_msgv2  TYPE sy-msgv2,
          lv_msgv3  TYPE sy-msgv3,
          lv_msgv4  TYPE sy-msgv4,
          lv_lineno TYPE mesg-zeile.

* Function body ----------------------------------------------------
    CALL FUNCTION 'MESSAGES_INITIALIZE'.

    lv_message_to_display = abap_false.

    IF iv_msgid IS NOT INITIAL.
      lv_msgv1  = iv_msgv1.
      lv_msgv2  = iv_msgv2.
      lv_msgv3  = iv_msgv3.
      lv_msgv4  = iv_msgv4.
      lv_lineno = iv_lineno.

      CALL FUNCTION 'MESSAGE_STORE'
        EXPORTING
          arbgb = iv_msgid
          msgty = iv_msgty
          msgv1 = lv_msgv1
          msgv2 = lv_msgv2
          msgv3 = lv_msgv3
          msgv4 = lv_msgv4
          txtnr = iv_msgno
          zeile = lv_lineno.

      lv_message_to_display = abap_true.

    ENDIF.

    LOOP AT it_message_tab ASSIGNING FIELD-SYMBOL(<fs_message_tab>).
      CALL FUNCTION 'MESSAGE_STORE'
        EXPORTING
          arbgb = <fs_message_tab>-msgid
          msgty = <fs_message_tab>-msgty
          msgv1 = <fs_message_tab>-msgv1
          msgv2 = <fs_message_tab>-msgv2
          msgv3 = <fs_message_tab>-msgv3
          msgv4 = <fs_message_tab>-msgv4
          txtnr = <fs_message_tab>-msgno
          zeile = <fs_message_tab>-lineno.
    ENDLOOP.

    IF sy-subrc = 0.
      lv_message_to_display = abap_true.
    ENDIF.

    CALL FUNCTION 'MESSAGES_STOP'
      EXCEPTIONS
        a_message = 1
        e_message = 2
        i_message = 3
        w_message = 4.

    IF sy-subrc <> 0.
      lv_message_to_display = abap_true.
    ENDIF.

    IF lv_message_to_display = abap_true.
      CALL FUNCTION 'MESSAGES_SHOW'
        EXPORTING
          i_use_grid  = iv_use_grid
        EXCEPTIONS
          no_messages = 1.
      IF sy-subrc <> 0.
        RETURN.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
