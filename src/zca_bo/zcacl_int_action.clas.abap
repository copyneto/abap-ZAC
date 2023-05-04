class ZCACL_INT_ACTION definition
  public
  final
  create public .

public section.

  interfaces /BOBF/IF_FRW_ACTION .
protected section.
private section.
ENDCLASS.



CLASS ZCACL_INT_ACTION IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.

    DATA:
      lt_root           TYPE           zcac0001_k,
      ls_root           TYPE           zcas0001_k,
      lr_root           TYPE REF TO    zcas0001_k,
      lt_messages       TYPE           bapiret2_t,
      lt_msg_data       TYPE           zcac0004_k,
      ls_messages       TYPE           zcas0004_k,
      lr_messages       TYPE REF TO    zcas0004_k,
      lt_changed_fields TYPE           /bobf/t_frw_name,
      ls_key            TYPE           /bobf/s_frw_key.

    CLEAR:
      eo_message,
      et_failed_key.

    FIELD-SYMBOLS:
      <status>   TYPE any,
      <messages> TYPE ANY TABLE.

    CALL METHOD io_read->retrieve
      EXPORTING
        iv_node       = zbcii_int_log=>sc_node-root
        it_key        = it_key
        iv_fill_data  = abap_true
      IMPORTING
        et_data       = lt_root
        et_failed_key = et_failed_key.

    CASE is_ctx-act_key.
      WHEN zbcii_int_log=>sc_action-root-set_status.

        LOOP AT lt_root REFERENCE INTO lr_root.

          APPEND 'STATUS'   TO lt_changed_fields.
          APPEND 'MODDATE'  TO lt_changed_fields.
          APPEND 'MODTIME'  TO lt_changed_fields.
          APPEND 'MODIFIER' TO lt_changed_fields.

          ASSIGN is_parameters->* TO <status>.

          lr_root->status = <status>.
          GET TIME FIELD lr_root->modtime.
          lr_root->moddate  = sy-datum.
          lr_root->modifier = sy-uname.

          CALL METHOD io_modify->update
            EXPORTING
              iv_node           = zbcii_int_log=>sc_node-root
              iv_key            = lr_root->key
              is_data           = lr_root
              it_changed_fields = lt_changed_fields.

          io_modify->notify_change(
          EXPORTING
            iv_node_key    = zbcii_int_log=>sc_node-root
            iv_key         =  lr_root->key
            iv_change_mode = /bobf/if_frw_c=>sc_modify_update ).

        ENDLOOP.

      WHEN zbcii_int_log=>sc_action-root-set_messages.

        CALL METHOD io_read->retrieve
          EXPORTING
            iv_node       = zbcii_int_log=>sc_node-messages
            it_key        = it_key
            iv_fill_data  = abap_true
          IMPORTING
            et_data       = lt_msg_data
            et_failed_key = et_failed_key.

        ASSIGN is_parameters->* TO <messages>.

        LOOP AT <messages> ASSIGNING FIELD-SYMBOL(<message>).

          GET REFERENCE OF ls_messages INTO lr_messages.

          MOVE-CORRESPONDING <message> TO lr_messages->*.

          ASSIGN COMPONENT 'NUMBER' OF STRUCTURE <message> TO FIELD-SYMBOL(<value>).
          IF sy-subrc = 0.
            lr_messages->zznumber = <value>.
          ENDIF.
          ASSIGN COMPONENT 'PARAMETER' OF STRUCTURE <message> TO <value>.
          IF sy-subrc = 0.
            lr_messages->zzparameter = <value>.
          ENDIF.
          ASSIGN COMPONENT 'SYSTEM' OF STRUCTURE <message> TO <value>.
          IF sy-subrc = 0.
            lr_messages->zzsystem = <value>.
          ENDIF.
          ASSIGN COMPONENT 'ROW' OF STRUCTURE <message> TO <value>.
          IF sy-subrc = 0.
            lr_messages->zzrow = <value>.
          ENDIF.

          lr_messages->root_key = it_key[ 1 ]-key.
          GET TIME FIELD lr_messages->timcre.
          lr_messages->datcre = sy-datum.
          lr_messages->usrcre = sy-uname.

          CALL METHOD io_modify->create
            EXPORTING
              iv_node            = zbcii_int_log=>sc_node-messages
              iv_root_key        = lr_messages->root_key
              iv_source_node_key = zbcii_int_log=>sc_node-root
              iv_assoc_key       = zbcii_int_log=>sc_association-root-messages
              iv_source_key      = lr_messages->root_key
              is_data            = lr_messages
            IMPORTING
              ev_key             = DATA(key).

        ENDLOOP.

      WHEN OTHERS.
    ENDCASE.


  ENDMETHOD.


  METHOD /bobf/if_frw_action~prepare.

  ENDMETHOD.


  method /BOBF/IF_FRW_ACTION~RETRIEVE_DEFAULT_PARAM.
  endmethod.
ENDCLASS.
