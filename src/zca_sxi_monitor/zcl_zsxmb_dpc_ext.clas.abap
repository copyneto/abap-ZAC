CLASS zcl_zsxmb_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zsxmb_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /iwbep/if_mgw_appl_srv_runtime~execute_action
        REDEFINITION .
  PROTECTED SECTION.

    METHODS messageset_get_entity
        REDEFINITION .
    METHODS messageset_get_entityset
        REDEFINITION .
    METHODS statusset_get_entityset
        REDEFINITION .
    METHODS statustypeset_get_entityset
        REDEFINITION .
  PRIVATE SECTION.

    METHODS set_status_message
      IMPORTING
        !in_it_msgs         TYPE sxmsadminmsgt
        !in_action          TYPE char1
      RETURNING
        VALUE(re_it_return) TYPE sxmsadminresulttab .
    METHODS get_message
      IMPORTING
        VALUE(im_msgguid) TYPE sxmsmguid
      RETURNING
        VALUE(re_message) TYPE sxmsmsglst .
    METHODS get_payload_string
      IMPORTING
        VALUE(im_messagekey) TYPE sxmskey_s
      RETURNING
        VALUE(re_payload)    TYPE string .
    CLASS-METHODS get_statuscrit
      IMPORTING
        !im_statustype        TYPE sxmspmstat_type
      RETURNING
        VALUE(re_criticality) TYPE int1 .
    CLASS-METHODS get_statustype
      IMPORTING
        !im_sxmspmstat       TYPE sxmspmstat
      RETURNING
        VALUE(re_statustype) TYPE sxmspmstat_type .
ENDCLASS.



CLASS ZCL_ZSXMB_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.

    DATA: lv_msgguid TYPE sxmsmguid,
          lv_message TYPE sxmsmsglst,
          it_msgs    TYPE sxmsadminmsgt,
          it_return  TYPE sxmsadminresulttab.
    DATA lv_msg TYPE bapi_msg.

    IF iv_action_name = 'Reprocessar'. " Check what action is being requested

      TRY.
          lv_msgguid = it_parameter[  name = 'MessageID' ]-value.
          lv_message = me->get_message( lv_msgguid ).

          APPEND INITIAL LINE TO it_msgs ASSIGNING FIELD-SYMBOL(<fs_msgs>).
          <fs_msgs> = VALUE #( msgguid = lv_message-msgguid
                               pid     = lv_message-pid
                               version = lv_message-vers
                             ).

          it_return = set_status_message( in_it_msgs = it_msgs
                                          in_action  = 'R' ).

* Call method copy_data_to_ref and export entity set data
          copy_data_to_ref( EXPORTING is_data = it_return[ 1 ]
                  CHANGING cr_data = er_data ).
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.

      lv_msg = it_return[ 1 ]-text.

      DATA(lo_msg_container) = mo_context->get_message_container( ).
      lo_msg_container->add_message_text_only(
         EXPORTING
           iv_msg_type               =  /iwbep/cl_cos_logger=>info  " Message Type - defined by GCS_MESSAGE_TYPE
           iv_msg_text               =  lv_msg                      " Message Text
           iv_entity_type            = 'MSGGUID'                    " Entity type/name
           iv_message_target         =  '/#TRANSIENT#'              " Target (reference) (e.g. Property ID) of a message
           iv_add_to_response_header = abap_true
       ).

*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              message_container = lo_msg_container.

    ELSEIF iv_action_name = 'Cancelar'. " Check what action is being requested

      TRY.
          lv_msgguid = it_parameter[  name = 'MessageID' ]-value.
          lv_message = me->get_message( lv_msgguid ).

          APPEND INITIAL LINE TO it_msgs ASSIGNING FIELD-SYMBOL(<fs_msgs2>).
          <fs_msgs2> = VALUE #( msgguid = lv_message-msgguid
                               pid     = lv_message-pid
                               version = lv_message-vers
                             ).

          it_return = set_status_message( in_it_msgs = it_msgs
                                          in_action  = 'C' ).

          lv_msg = it_return[ 1 ]-text.

          lo_msg_container = mo_context->get_message_container( ).
          lo_msg_container->add_message_text_only(
             EXPORTING
               iv_msg_type               =  /iwbep/cl_cos_logger=>info  " Message Type - defined by GCS_MESSAGE_TYPE
               iv_msg_text               =  lv_msg                      " Message Text
               iv_entity_type            = 'MSGGUID'                    " Entity type/name
               iv_message_target         =  '/#TRANSIENT#'              " Target (reference) (e.g. Property ID) of a message
               iv_add_to_response_header = abap_true
           ).

*          RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
*            EXPORTING
*              message_container = lo_msg_container.

* Call method copy_data_to_ref and export entity set data
          copy_data_to_ref( EXPORTING is_data = it_return[ 1 ]
                  CHANGING cr_data = er_data ).
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.


    ENDIF.

  ENDMETHOD.


  METHOD get_message.

    DATA wa_filter TYPE sxi_msg_select.
    DATA: it_msgtab TYPE sxmsmsgtab.

    wa_filter-msgguid_tab[] = VALUE #( ( im_msgguid ) ).
    wa_filter-client = sy-mandt.


    CALL FUNCTION 'SXMB_SELECT_MESSAGES_NEW'
      EXPORTING
        im_filter           = wa_filter
        im_number           = 1
*       IM_ADAPTER_OR       = '0'
*       IM_PROCESS_MODE     = '0'
      IMPORTING
        ex_msgtab           = it_msgtab
*       EX_RESULT           =
*       EX_FIRST_TS         =
      EXCEPTIONS
        persist_error       = 1
        missing_parameter   = 2
        negative_time_range = 3
        too_many_parameters = 4
        no_timezone         = 5
        OTHERS              = 6.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    TRY.
        re_message = it_msgtab[ 1 ].
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.

  ENDMETHOD.


  METHOD get_payload_string.

    DATA: lr_root         TYPE REF TO  cx_root,
          lr_message      TYPE REF TO  if_xms_message,
          lr_resource     TYPE REF TO  if_xms_resource,
          lv_data_payload TYPE         xstring,
          lr_xms_persist  TYPE REF TO  cl_xms_persist.

    CREATE OBJECT lr_xms_persist.

    TRY.
        lr_xms_persist->read_msg_all(
          EXPORTING
            im_msgguid = im_messagekey-msgguid
            im_pid     = im_messagekey-pid
            im_version = im_messagekey-version
          IMPORTING
            ex_message = lr_message ).
      CATCH cx_xms_syserr_persist INTO lr_root.
        EXIT.
    ENDTRY.

    IF ( lr_message->numberofattachments( ) ) IS NOT INITIAL.
      lr_resource = lr_message->getattachmentatindex( index = 1 ).

      TRY.
          lv_data_payload = lr_resource->getbinarydata( ).
        CATCH: cx_xms_exception INTO lr_root,           "#EC NO_HANDLER
          cx_xms_system_error INTO lr_root.             "#EC NO_HANDLER
      ENDTRY.

      cl_bcs_convert=>xstring_to_string(
        EXPORTING
          iv_xstr   = lv_data_payload
          iv_cp     =  1100                " SAP character set identification
        RECEIVING
          rv_string = re_payload
      ).

    ENDIF.

  ENDMETHOD.


  method GET_STATUSCRIT.

**   0 - Neutral / 1 - Negative (red) / 2 - Critical (orange) / 3 - Positive (green)
    CASE im_statustype.
      WHEN  cl_xms_persist_adm=>co_mstat_type_executed.
        re_criticality = 3.
      WHEN cl_xms_persist_adm=>co_mstat_type_recorded.
        re_criticality = 2.
      WHEN cl_xms_persist_adm=>co_mstat_type_error_appl
        OR cl_xms_persist_adm=>co_mstat_type_error_sys.
*        OR cl_xms_persist_adm=>co_mstat_type_error
        re_criticality = 1.
      WHEN OTHERS.
        re_criticality = 0.
    ENDCASE.

  endmethod.


  method GET_STATUSTYPE.

    TYPES: ty_state TYPE STANDARD TABLE OF i WITH EMPTY KEY .

** Status List
    DATA(it_state1) = VALUE ty_state( ( 003 ) ( 010 ) ( 011 ) ( 020 ) ( 022 ) ( 031 ) ( 036 ) ( 103 ) ( 110 ) ).
    DATA(it_state3) = VALUE ty_state( ( 001 ) ( 009 ) ( 012 ) ( 016 ) ( 029 ) ( 038 ) ( 102 ) ( 112 ) ).
    DATA(it_state5) = VALUE ty_state( ( 017 ) ( 025 ) ( 035 ) ( 117 ) ( 118 ) ( 024 ) ).
    DATA(it_state6) = VALUE ty_state( ( 014 ) ( 018 ) ( 037 ) ( 111 ) ( 114 ) ( 023 ) ).
    DATA(it_state4) = VALUE ty_state( ( 014 ) ( 017 ) ( 018 ) ( 021 ) ( 023 ) ( 024 ) ( 025 ) ( 035 ) ( 037 ) ( 111 ) ( 114 ) ( 117 ) ( 118 ) ( 121 ) ( 019 ) ).

*** StatusType
    re_statustype = COND #(
       WHEN line_exists( it_state1[ table_line = im_sxmspmstat ] ) THEN '1'
       WHEN line_exists( it_state3[ table_line = im_sxmspmstat ] ) THEN '3'
       WHEN line_exists( it_state5[ table_line = im_sxmspmstat ] ) THEN '5'
       WHEN line_exists( it_state6[ table_line = im_sxmspmstat ] ) THEN '6'
       WHEN line_exists( it_state4[ table_line = im_sxmspmstat ] ) THEN '4'
       ELSE '4'
    ).

*    TYPES: BEGIN OF ty_statustype,
*             status_type TYPE sxmspmstat_type,
*             msgstate    TYPE sxmspmstat,
*           END OF ty_statustype.
*
*    STATICS: it_sxmsmstat TYPE TABLE OF ty_statustype.
**    STATICS: it_sxmsmstat TYPE TABLE OF sxmsmstat.
*
*    IF it_sxmsmstat IS INITIAL.
*      DATA: it_sxmspmstat TYPE sxmspmstat_tab,
*            it_statret    TYPE TABLE OF ty_statustype.
*
*      CALL FUNCTION 'SXMB_GET_STATUS_LIST'
*        EXPORTING
*          im_stat_type = '1'
*        IMPORTING
*          ex_mstat_tab = it_sxmspmstat.
*      it_statret = VALUE #( FOR wa IN it_sxmspmstat ( status_type = '1' msgstate = wa   )  ).
*      APPEND LINES OF it_statret TO it_sxmsmstat.
*
*      CALL FUNCTION 'SXMB_GET_STATUS_LIST'
*        EXPORTING
*          im_stat_type = '3'
*        IMPORTING
*          ex_mstat_tab = it_sxmspmstat.
*      it_statret = VALUE #( FOR wa IN it_sxmspmstat ( status_type = '3' msgstate = wa   )  ).
*      APPEND LINES OF it_statret TO it_sxmsmstat.
*
*      CALL FUNCTION 'SXMB_GET_STATUS_LIST'
*        EXPORTING
*          im_stat_type = '5'
*        IMPORTING
*          ex_mstat_tab = it_sxmspmstat.
*      it_statret = VALUE #( FOR wa IN it_sxmspmstat ( status_type = '5' msgstate = wa   )  ).
*      APPEND LINES OF it_statret TO it_sxmsmstat.
*
*      CALL FUNCTION 'SXMB_GET_STATUS_LIST'
*        EXPORTING
*          im_stat_type = '6'
*        IMPORTING
*          ex_mstat_tab = it_sxmspmstat.
*      it_statret = VALUE #( FOR wa IN it_sxmspmstat ( status_type = '6' msgstate = wa   )  ).
*      APPEND LINES OF it_statret TO it_sxmsmstat.
*
*      CALL FUNCTION 'SXMB_GET_STATUS_LIST'
*        EXPORTING
*          im_stat_type = '4'
*        IMPORTING
*          ex_mstat_tab = it_sxmspmstat.
*      it_statret = VALUE #( FOR wa IN it_sxmspmstat ( status_type = '4' msgstate = wa   )  ).
*      APPEND LINES OF it_statret TO it_sxmsmstat.
*
*    ENDIF.
*
*** StatusType
*    re_statustype = it_sxmsmstat[ msgstate = im_sxmspmstat ]-status_type.

  endmethod.


  METHOD messageset_get_entity.

    TRY.
        DATA lv_msgguid TYPE sxmsmguid.
        DATA lv_message TYPE sxmsmsglst.

        lv_msgguid =  VALUE #( it_key_tab[ 1 ]-value ).
        lv_message = me->get_message( lv_msgguid ).
        er_entity = CORRESPONDING  #( lv_message ).

      CATCH cx_sy_itab_line_not_found.
        RETURN.
    ENDTRY.

** StatusType
    er_entity-statustype = me->get_statustype( lv_message-msgstate ).

** Status Criticality- UI5 property to Status field
    er_entity-statuscriticality = me->get_statuscrit( er_entity-statustype ).

** Payload - Version 000 da mensagem
    er_entity-payload = me->get_payload_string( VALUE #( msgguid = lv_message-msgguid
                                                         pid     = lv_message-pid
                                                         version = '000' ) ).

** Error
    er_entity-error = me->get_payload_string( VALUE #( msgguid = lv_message-msgguid
                                                       pid     = lv_message-pid
                                                       version = lv_message-vers ) ).

  ENDMETHOD.


  METHOD messageset_get_entityset.

*** Filters
** Get filter or select option information
    DATA(lo_filter) = io_tech_request_context->get_filter( ).
    DATA(lt_filter_select_options) = lo_filter->get_filter_select_options( ).
    DATA: it_seloption TYPE /iwbep/t_cod_select_options.
    DATA wa_filter TYPE sxi_msg_select.
** ExecutionDate
    TRY.
        DATA(wa_filter_exedate) = lt_filter_select_options[  property = 'EXETIMEST' ]-select_options.
        DATA: tstamp    TYPE timestamp.
        tstamp = wa_filter_exedate[ 1 ]-low.
        CONVERT TIME STAMP tstamp TIME ZONE sy-zonlo INTO DATE wa_filter-exedate TIME wa_filter-exetime.
        IF  wa_filter_exedate[ 1 ]-option = 'BT'.
          tstamp = wa_filter_exedate[ 1 ]-high.
          CONVERT TIME STAMP tstamp TIME ZONE sy-zonlo  INTO DATE wa_filter-exe2date TIME wa_filter-exe2time.
          IF wa_filter-exe2time IS INITIAL.
            wa_filter-exe2time = '235959'.
          ENDIF.
        ELSE.
          wa_filter-exe2date = wa_filter-exedate.
          wa_filter-exe2time = '235959'.
        ENDIF.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Outbound System
    TRY.
        it_seloption = lt_filter_select_options[  property = 'OB_SYSTEM' ]-select_options.
        wa_filter-sender_receiver-ob_system = it_seloption[ 1 ]-low.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Outbound Namespace
    TRY.
        it_seloption = lt_filter_select_options[  property = 'OB_NS' ]-select_options.
        wa_filter-sender_receiver-ob_ns = it_seloption[ 1 ]-low.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Outbound Interface
    TRY.
        it_seloption = lt_filter_select_options[  property = 'OB_NAME' ]-select_options.
        wa_filter-sender_receiver-ob_name = it_seloption[ 1 ]-low.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Inbound System
    TRY.
        it_seloption = lt_filter_select_options[  property = 'IB_SYSTEM' ]-select_options.
        wa_filter-sender_receiver-ib_system = it_seloption[ 1 ]-low.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Inboun Namespace
    TRY.
        it_seloption = lt_filter_select_options[  property = 'IB_NS' ]-select_options.
        wa_filter-sender_receiver-ib_ns = it_seloption[ 1 ]-low.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Inboun Interface
    TRY.
        it_seloption = lt_filter_select_options[  property = 'IB_NAME' ]-select_options.
        wa_filter-sender_receiver-ib_name = it_seloption[ 1 ]-low.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Status
    TRY.
        it_seloption = lt_filter_select_options[  property = 'MSGSTATE' ]-select_options.
        wa_filter-msgstate_tab = VALUE #( FOR wa_state IN it_seloption ( CONV #( wa_state-low ) ) ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** MessageID
    TRY.
        it_seloption = lt_filter_select_options[  property = 'MSGGUID' ]-select_options.
        wa_filter-msgguid_tab = VALUE #( FOR wa_msgid IN it_seloption ( CONV #( wa_msgid-low ) ) ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Status Type
    TRY.
        it_seloption = lt_filter_select_options[  property = 'STATUSTYPE' ]-select_options.
        DATA: it_stat TYPE sxmspmstat_tab.

        LOOP AT it_seloption INTO DATA(wa_statustype).
          CALL FUNCTION 'SXMB_GET_STATUS_LIST'
            EXPORTING
              im_stat_type = CONV sxmspmstat_type( wa_statustype-low )
*             IM_MDT_STATUS       =
            IMPORTING
              ex_mstat_tab = it_stat.
          APPEND LINES OF it_stat TO wa_filter-msgstate_tab.
        ENDLOOP.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
** Cliente
    wa_filter-client = sy-mandt.


*** Seleção das informações
    DATA: lv_top       TYPE i,
          lv_skip      TYPE i,
          lv_max_index TYPE i.
** get number of records requested
    lv_top = io_tech_request_context->get_top( ).
** get number of lines that should be skipped
    lv_skip = io_tech_request_context->get_skip( ).

    DATA: it_msgtab TYPE sxmsmsgtab.

** Se precisa determinar o inlinecount a seleção tem que ser mais ampla (number com número alto)
    IF io_tech_request_context->has_inlinecount( ) = abap_true.
      lv_max_index = 99999.
    ELSE.
** Caso contrário apenas a quantidade máxima necessária para gerar o retorno
      lv_max_index = lv_top + lv_skip.
    ENDIF.

    CALL FUNCTION 'SXMB_SELECT_MESSAGES_NEW'
      EXPORTING
        im_filter = wa_filter
        im_number = lv_max_index
*       IM_ADAPTER_OR             = '0'
*       IM_PROCESS_MODE           = '0'
      IMPORTING
        ex_msgtab = it_msgtab
*       EX_RESULT =
*       EX_FIRST_TS               =
      EXCEPTIONS
*       PERSIST_ERROR             = 1
*       MISSING_PARAMETER         = 2
*       NEGATIVE_TIME_RANGE       = 3
*       TOO_MANY_PARAMETERS       = 4
*       NO_TIMEZONE               = 5
        OTHERS    = 6.

**  Inlinecount - get the total numbers of entries that fit to the where clause
    IF io_tech_request_context->has_inlinecount( ) = abap_true.
      es_response_context-inlinecount = lines( it_msgtab ).
    ELSE.
      CLEAR es_response_context-inlinecount.
    ENDIF.

    et_entityset = VALUE #( FOR wa IN it_msgtab ( CORRESPONDING #( wa ) ) ) .

*** Informações adicionais da Entidade
** StatusType and Criticality
    LOOP AT et_entityset ASSIGNING FIELD-SYMBOL(<fs_entity>).
** StatusType
      <fs_entity>-statustype = me->get_statustype( <fs_entity>-msgstate ).

** Status Criticality- UI5 property to Status field
      <fs_entity>-statuscriticality = me->get_statuscrit( <fs_entity>-statustype ).

    ENDLOOP.

*** Controle de Paginação (skip/top)
** skipping entries specified by $skip
    IF lv_skip IS NOT INITIAL.
      DELETE et_entityset TO lv_skip.
    ENDIF.

** skipping entries specified by $skip
    IF lv_top IS NOT INITIAL.
      DELETE et_entityset FROM lv_top + 1.
    ENDIF.

  ENDMETHOD.


  METHOD set_status_message.

    CHECK in_it_msgs[] IS NOT INITIAL.

    CALL FUNCTION 'SXMB_INVOKE_ADMIN_ACTION_INT'
      EXPORTING
        im_msgs            = in_it_msgs
        im_action          = in_action
        im_skip_validation = if_xms_main=>co_false "Não ignorar etapa de validação
        im_restart_trace   = space "Manter nível de rastreamento
      IMPORTING
        ex_admin_result    = re_it_return.

    LOOP AT re_it_return  ASSIGNING FIELD-SYMBOL(<wa>) .
      <wa>-was_successful = COND #( WHEN <wa>-was_successful = '1' THEN abap_true ELSE abap_false ).
    ENDLOOP.

  ENDMETHOD.


  METHOD statusset_get_entityset.
    DATA: it_status TYPE  sxmsmstat_attr_t.

    CALL FUNCTION 'SXMB_GET_STATUS_ATTRIBUTES'
      EXPORTING
        im_langu           = sy-langu
*       IM_MSGSTATE        = ' '
        im_icon_convert    = ' '
      IMPORTING
        ex_msgstate_attr   = it_status
      EXCEPTIONS
        msgstate_not_found = 1
        OTHERS             = 2.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    et_entityset = it_status.
    SORT et_entityset BY msgstate.
  ENDMETHOD.


  METHOD statustypeset_get_entityset.

    DATA: idd07v TYPE TABLE OF  dd07v .

    CALL FUNCTION 'DD_DOMVALUES_GET'
      EXPORTING
        domname        = 'SXMSPMSTAT_TYPE'
        text           = 'X'
        langu          = sy-langu
      TABLES
        dd07v_tab      = idd07v
      EXCEPTIONS
        wrong_textflag = 1
        OTHERS         = 2.

    et_entityset = VALUE #( FOR wa IN idd07v ( sxmspmstat_type = wa-domvalue_l  description = wa-ddtext )  ).
    SORT et_entityset BY sxmspmstat_type.

  ENDMETHOD.
ENDCLASS.
