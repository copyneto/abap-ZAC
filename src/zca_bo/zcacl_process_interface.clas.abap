class ZCACL_PROCESS_INTERFACE definition
  public
  final
  create public .

public section.

  constants C_STAT_INICIAL type ZE_STATUS_INT value 000 ##NO_TEXT.
  constants C_STAT_INTEGRADO type ZE_STATUS_INT value 001 ##NO_TEXT.
  constants C_STAT_ERRO_INT type ZE_STATUS_INT value 003 ##NO_TEXT.
  constants C_STAT_ELIMINADO type ZE_STATUS_INT value 099 ##NO_TEXT.

  class-methods ASSIGN_DATA
    importing
      !IS_LINE type ANY
    returning
      value(RS_DATA) type ZCAS0003_K .
  class-methods ASSIGN_DATA_PROCESS
    importing
      !IT_TABLE type ref to DATA
    changing
      value(CT_DATA) type ref to DATA .
  class-methods MESSAGES_EXEC
    importing
      !IV_ID_NUMBER type ZE_ID_NUMBER_INT
      !IV_KEY type /BOBF/CONF_KEY
      !IT_RETURN type BAPIRET2_T optional
    changing
      value(CV_ERRO) type CHAR1 optional .
  class-methods ADD_BO_DEPENDENT
    importing
      !IV_NODE type /BOBF/OBM_NODE_KEY
      !IV_ASSOCIATION type /BOBF/OBM_ASSOC_KEY
      !IT_KEY type /BOBF/T_FRW_KEY_INCL
    changing
      !CT_KEY type /BOBF/T_FRW_KEY_INCL
      !CT_MOD type /BOBF/T_FRW_MODIFICATION .
  class-methods ADD_DATA
    importing
      !IS_DATA type ref to DATA
      !IT_KEY type /BOBF/T_FRW_KEY_INCL
    changing
      !CT_MOD type /BOBF/T_FRW_MODIFICATION
      !CS_DATA type ref to DATA optional .
  class-methods ADD_MESSAGES
    importing
      !IS_DATA type ref to DATA
      !IT_KEY type /BOBF/T_FRW_KEY_INCL
    changing
      !CT_MOD type /BOBF/T_FRW_MODIFICATION .
  class-methods CONV_MESSAGES
    importing
      !IT_MESSAGES type ZCAC0004_K
    returning
      value(RT_RETURN) type BAPIRET2_T .
  class-methods CHECK_INSERT_KEY
    importing
      !IV_KEY type /BOBF/CONF_KEY optional
      !IS_KEY type /BOBF/S_FRW_KEY optional
    changing
      value(CT_KEY) type /BOBF/T_FRW_KEY .
  class-methods NEXT_NUMBER
    importing
      !IV_OBJECT type NROBJ
    returning
      value(E_ID_NUMBER) type EDI_DOCNUM .
  class-methods CREATE_REF_TO_DATA
    importing
      !IS_DATA type ANY
    changing
      !CS_MOD type /BOBF/S_FRW_MODIFICATION .
  class-methods CREATE_REGISTER_MULT
    importing
      !IV_NODE type /BOBF/OBM_NODE_KEY
      !IT_DATA type INDEX TABLE
      !IV_DO_SORTING type ABAP_BOOL optional
      !IV_ASSOCIATION type /BOBF/OBM_ASSOC_KEY optional
      !IV_SOURCE_NODE type /BOBF/CONF_KEY optional
    changing
      !CT_MOD type /BOBF/T_FRW_MODIFICATION .
  methods CONSTRUCTOR .
  class-methods CREATE_REGISTER
    importing
      !IS_DATA type ANY
      !IV_KEY type /BOBF/CONF_KEY optional
      !IV_PARENT_KEY type /BOBF/CONF_KEY optional
      !IV_ROOT_KEY type /BOBF/CONF_KEY optional
      !IV_NODE type /BOBF/OBM_NODE_KEY
      !IV_SOURCE_NODE type /BOBF/OBM_NODE_KEY optional
      !IV_ASSOCIATION type /BOBF/OBM_ASSOC_KEY optional
    exporting
      !ES_MOD type /BOBF/S_FRW_MODIFICATION
    changing
      !CT_MOD type /BOBF/T_FRW_MODIFICATION optional .
  class-methods GET_MESSAGES
    importing
      !IV_KEY type /BOBF/CONF_KEY optional
    returning
      value(CT_MESSAGES) type ZCAC0004_K .
  class-methods GET_INT_DATA
    importing
      !IT_KEY type /BOBF/T_FRW_KEY optional
    exporting
      value(ET_MESSAGES) type ZCAC0004_K
      !ET_DATA type ZCAC0003_K
      !ET_ROOT type ZCAC0001_K .
  class-methods GET_MESSAGES_MULT
    importing
      !IT_KEY type /BOBF/T_FRW_KEY optional
    returning
      value(RT_MESSAGES) type ZCAC0004_K .
  class-methods CREATE_REF_DATA
    importing
      !I_BO_KEY type /BOBF/OBM_BO_KEY
      !I_NODE_KEY type /BOBF/OBM_NODE_KEY
    exporting
      !CH_TABLE type ref to DATA
      !CH_LINE type ref to DATA .
  class-methods CREATE_REF_DATA_K
    importing
      !I_BO_KEY type /BOBF/OBM_BO_KEY
      !I_NODE_KEY type /BOBF/OBM_NODE_KEY
    exporting
      !CH_TABLE type ref to DATA
      !CH_LINE type ref to DATA .
  class-methods ADD_DATA_BO_DEPENDENT
    importing
      !IT_DATA type ref to DATA
      !I_BO_KEY type /BOBF/OBM_BO_KEY
      !I_NODE_KEY type /BOBF/OBM_NODE_KEY
      !I_ROOT_KEY type /BOBF/CONF_KEY
      !I_PARENT_KEY type /BOBF/CONF_KEY
      !I_DO_NODE_KEY type /BOBF/OBM_NODE_KEY
      !I_DO_ASSOC_KEY type /BOBF/OBM_ASSOC_KEY
      !I_SOURCE_NODE_KEY type /BOBF/OBM_NODE_KEY
    exporting
      !EV_ROOT_KEY type /BOBF/CONF_KEY
      !EV_PARENT_KEY type /BOBF/CONF_KEY
    changing
      !CT_MOD type /BOBF/T_FRW_MODIFICATION .
  class-methods GET_STATUS_INFO
    importing
      !IV_STATUS type ZE_STATUS_INT
    returning
      value(RS_STAINFO) type ZCAT0002 .
  class-methods SET_MESSAGES
    importing
      !IV_KEY type /BOBF/CONF_KEY
      !IT_MESSAGES type BAPIRET2_T .
  class-methods SET_STATUS
    importing
      !IV_STATUS type ZE_STATUS_INT
      !IV_KEY type /BOBF/CONF_KEY .
  class-methods CREATE_INTEGRATION
    importing
      !IV_ID_MACRO type EDI_DOCNUM optional
      !IV_PROCESS type ZE_PROCESS_INTEGRATION
      !IV_DIRECT type ZE_INT_DIRECT
      !IV_SYSTEM type TEXT50 optional
      !IT_RETURN type BAPIRET2_T optional
      !IV_ERROR type CHAR1 optional
    exporting
      !EV_ID_NUMBER type ZE_ID_NUMBER_INT
    changing
      value(CT_KEY) type /BOBF/T_FRW_KEY_INCL
      !CT_MOD type /BOBF/T_FRW_MODIFICATION .
  class-methods MODIFY
    importing
      !IT_MOD type /BOBF/T_FRW_MODIFICATION .
  class-methods SAVE .
protected section.
private section.
ENDCLASS.



CLASS ZCACL_PROCESS_INTERFACE IMPLEMENTATION.


  METHOD add_bo_dependent.

    DATA:
      ls_node_dep   TYPE zcas0006_k,
      ls_mod        LIKE LINE OF ct_mod.

*   Guarda chave Root do objeto principal
    DATA(lv_root_key)    = it_key[ 1 ]-root_key.
    DATA(lv_parent_key)  = it_key[ 1 ]-parent_key..

* Cria registro do objeto dependente (interface associada a BO principal ZBCBO_INT_LOG)
    ls_node_dep-root_key      = lv_root_key.
    ls_node_dep-parent_key    = lv_parent_key.
    ls_node_dep-host_node_key = zbcii_int_log=>sc_node-root.
    ls_node_dep-host_key      = lv_root_key.
    ls_node_dep-host_bo_key   = zbcii_int_log=>sc_bo_key.
    ls_node_dep-host_node_key = zbcii_int_log=>sc_node-root.

    zcacl_process_interface=>create_register(
      EXPORTING
        is_data        = ls_node_dep
        iv_node        = iv_node
        iv_source_node = zbcii_int_log=>sc_node-root
        iv_association = iv_association
      IMPORTING
        es_mod         = ls_mod ).

    APPEND ls_mod TO ct_mod.

    APPEND VALUE /bobf/s_frw_key_incl( root_key   = ls_mod-key
                                       parent_key = ls_mod-key ) TO ct_key.

  ENDMETHOD.


  METHOD add_data.

    DATA:
*      lt_data TYPE zcac0003_k,
      ls_data TYPE zcas0003_k.

*    DATA: lo_struct   TYPE REF TO cl_abap_structdescr,
*          lo_descr    TYPE REF TO cl_abap_elemdescr,
*          lt_cols     TYPE cl_abap_structdescr=>component_table,
*          lv_leng_ant TYPE dfies-leng.

    FIELD-SYMBOLS:<line> TYPE any,
                  <data> TYPE ANY TABLE.

*   Guarda chave Root do objeto principal
    DATA(lv_root_key)    = it_key[ 1 ]-root_key.
    DATA(lv_parent_key)  = it_key[ 1 ]-parent_key..

    ASSIGN is_data->* TO <data>.

    LOOP AT <data> ASSIGNING <line>.

      ls_data = zcacl_process_interface=>assign_data( <line> ).

*      lo_struct ?= cl_abap_typedescr=>describe_by_data( <line> ).
*
*      lt_cols = lo_struct->get_components( ).
*
*      CLEAR lv_leng_ant.
*      LOOP AT lt_cols INTO DATA(col).
*
*        ASSIGN COMPONENT col-name OF STRUCTURE <line> TO FIELD-SYMBOL(<field>).
*
*        TRY.
*            lo_descr ?= cl_abap_elemdescr=>describe_by_data( <field> ).
*            DATA(ls_dfies) = lo_descr->get_ddic_field( ).
*          CATCH cx_root INTO DATA(xroot).
**          IF i_message = abap_true.
**            MESSAGE xroot TYPE 'I'.
**          ENDIF.
*            CONTINUE.
*        ENDTRY.
*
*        IF ls_dfies-datatype = 'STRG'.
*          ls_dfies-leng = strlen( <field> ).
*        ELSE.
*        ENDIF.
*
*        IF ls_dfies-leng IS NOT INITIAL.
*          MOVE <field> TO ls_data-sdata+lv_leng_ant(ls_dfies-leng).
*        ENDIF.
*
*        lv_leng_ant = lv_leng_ant + ls_dfies-leng.
*
*      ENDLOOP.

*    ls_data-struc = lo_struct->get_relative_name( ).

      ls_data-root_key   = lv_root_key.
      ls_data-parent_key = lv_parent_key.
*      ls_data-dleng = strlen( ls_data-sdata ).
*      APPEND ls_data TO lt_data.

**   Cria registros dados de negócio da interface
      CALL METHOD zcacl_process_interface=>create_register
        EXPORTING
          is_data        = ls_data
          iv_node        = zbcii_int_log=>sc_node-data
          iv_source_node = zbcii_int_log=>sc_node-root
          iv_association = zbcii_int_log=>sc_association-root-data
        IMPORTING
          es_mod         = DATA(ls_mod)
        CHANGING
          ct_mod         = ct_mod.

      ASSIGN COMPONENT 'KEY' OF STRUCTURE <line> TO FIELD-SYMBOL(<field>).
      IF sy-subrc IS INITIAL.
        <field> = ls_mod-key.
      ENDIF.

      CLEAR ls_data.

    ENDLOOP.

**   Cria registros dados de negócio da interface
*    CALL METHOD zcacl_process_interface=>create_register_mult
*      EXPORTING
*        it_data        = lt_data
*        iv_node        = zbcii_int_log=>sc_node-data
*        iv_source_node = zbcii_int_log=>sc_node-root
*        iv_association = zbcii_int_log=>sc_association-root-data
*      CHANGING
*        ct_mod         = ct_mod.

  ENDMETHOD.


  METHOD add_data_bo_dependent.

    DATA:
      line_ref  TYPE REF TO data.

    DATA: ls_mod  LIKE LINE OF ct_mod.

    FIELD-SYMBOLS: <line>   TYPE any,
                   <table>  TYPE ANY TABLE,
                   <line_k> TYPE any.

    zcacl_process_interface=>create_ref_data_k(
      EXPORTING
        i_bo_key    = i_bo_key
        i_node_key  = i_node_key
      IMPORTING
        ch_line       = line_ref ).

    ASSIGN line_ref->* TO <line_k>.

    ASSIGN it_data->* TO <table>.

    LOOP AT <table> ASSIGNING <line>.

      MOVE-CORRESPONDING <line> TO <line_k>.

      ASSIGN COMPONENT 'ROOT_KEY' OF STRUCTURE <line_k> TO FIELD-SYMBOL(<key>).
      <key>   = i_root_key.
      ASSIGN COMPONENT 'PARENT_KEY' OF STRUCTURE <line_k> TO <key>.
      <key>   = i_parent_key.

*   Cria registros dados de itens da BO dependente (negócio)
      CALL METHOD zcacl_process_interface=>create_register
        EXPORTING
          is_data        = <line_k>
          iv_node        = i_do_node_key
          iv_source_node = i_source_node_key
          iv_association = i_do_assoc_key
        IMPORTING
          es_mod         = ls_mod.

      APPEND ls_mod TO ct_mod.

      AT FIRST.
        ev_root_key = ls_mod-key.
        ev_root_key = ls_mod-key.
      ENDAT.

    ENDLOOP.

  ENDMETHOD.


  METHOD add_messages.

    DATA:
      lt_messages TYPE zcac0004_k,
      ls_message  LIKE LINE OF lt_messages.

    FIELD-SYMBOLS:<line> TYPE any,
                  <data> TYPE ANY TABLE.

    CHECK is_data IS NOT INITIAL.

    DATA:
      table_ref TYPE REF TO data,
      line_ref  TYPE REF TO data.

    DATA: go_struct TYPE REF TO cl_abap_structdescr,
          gt_comp   TYPE abap_component_tab,
          gs_comp   TYPE abap_componentdescr.

    FIELD-SYMBOLS:
      <lv_root_key>   TYPE /bobf/conf_key,
      <lv_parent_key> TYPE /bobf/conf_key.

* Guarda chave Root doobjeto principal
    DATA(lv_root_key)    = it_key[ 1 ]-root_key.
    DATA(lv_parent_key)  = it_key[ 1 ]-parent_key..

    ASSIGN is_data->* TO <data>.

    LOOP AT <data> ASSIGNING <line>.

      MOVE-CORRESPONDING <line> TO ls_message.

      ASSIGN COMPONENT 'NUMBER' OF STRUCTURE <line> TO FIELD-SYMBOL(<value>).
      IF sy-subrc = 0.
        ls_message-zznumber = <value>.
      ENDIF.
      ASSIGN COMPONENT 'PARAMETER' OF STRUCTURE <line> TO <value>.
      IF sy-subrc = 0.
        ls_message-zzparameter = <value>.
      ENDIF.
      ASSIGN COMPONENT 'SYSTEM' OF STRUCTURE <line> TO <value>.
      IF sy-subrc = 0.
        ls_message-zzsystem = <value>.
      ENDIF.
      ASSIGN COMPONENT 'ROW' OF STRUCTURE <line> TO <value>.
      IF sy-subrc = 0.
        ls_message-zzrow = <value>.
      ENDIF.

      IF ls_message-message IS INITIAL.

        MESSAGE ID ls_message-id
              TYPE ls_message-type
            NUMBER ls_message-zznumber
              WITH ls_message-message_v1
                   ls_message-message_v2
                   ls_message-message_v3
                   ls_message-message_v4
              INTO ls_message-message.

      ENDIF.

      ls_message-root_key = lv_root_key.
      ls_message-parent_key = lv_parent_key.

      ls_message-datcre = sy-datum.
      GET TIME FIELD ls_message-timcre.
      ls_message-usrcre = sy-uname.

      APPEND ls_message TO lt_messages.
      CLEAR ls_message.

    ENDLOOP.

* Cria registros mensagens de negócio da interface
    CALL METHOD zcacl_process_interface=>create_register_mult
      EXPORTING
        it_data        = lt_messages
        iv_node        = zbcii_int_log=>sc_node-messages
        iv_source_node = zbcii_int_log=>sc_node-root
        iv_association = zbcii_int_log=>sc_association-root-messages
      CHANGING
        ct_mod         = ct_mod.

  ENDMETHOD.


  METHOD assign_data.

    DATA:
      lo_struct   TYPE REF TO cl_abap_structdescr,
      lv_leng_ant TYPE dfies-leng,
      lo_descr    TYPE REF TO cl_abap_elemdescr.

    lo_struct ?= cl_abap_typedescr=>describe_by_data( is_line ).

    DATA(cols) = lo_struct->get_components( ).

    CLEAR lv_leng_ant.
    LOOP AT cols INTO DATA(col).

      ASSIGN COMPONENT col-name OF STRUCTURE is_line TO FIELD-SYMBOL(<field>).

      TRY.
          lo_descr ?= cl_abap_elemdescr=>describe_by_data( <field> ).
          DATA(ls_dfies) = lo_descr->get_ddic_field( ).
        CATCH cx_root INTO DATA(xroot).
          CONTINUE.
      ENDTRY.

*      MOVE <field> TO rs_data-sdata+lv_leng_ant(ls_dfies-leng).

      IF ls_dfies-datatype = 'STRG'.
        ls_dfies-leng = strlen( <field> ).
      ELSE.
      ENDIF.

      IF ls_dfies-leng IS NOT INITIAL.
        MOVE <field> TO rs_data-sdata+lv_leng_ant(ls_dfies-leng).
      ENDIF.

      lv_leng_ant = lv_leng_ant + ls_dfies-leng.

    ENDLOOP.

    rs_data-struc = lo_struct->get_relative_name( ).
    rs_data-dleng = strlen( rs_data-sdata ).

  ENDMETHOD.


  METHOD assign_data_process.

    DATA:
      lo_struct    TYPE REF TO cl_abap_structdescr,
      lo_descr     TYPE REF TO cl_abap_elemdescr,
      lv_leng_ant  TYPE dfies-leng,
      ls_fieldinfo TYPE rsanu_s_fieldinfo,
      lr_line      TYPE REF TO data,
      lr_table     TYPE REF TO data,

      lv_value     TYPE string.

    FIELD-SYMBOLS: <line_src>  TYPE any,
                   <line_dst>  TYPE any,
                   <table_src> TYPE ANY TABLE,
                   <table_dst> TYPE STANDARD TABLE.




    ASSIGN it_table->* TO <table_src>.
    ASSIGN ct_data->* TO <table_dst>.

*    CREATE DATA lr_table LIKE <table_dst>.
*    ASSIGN ct_data->* TO <table_dst>.

    CREATE DATA lr_line LIKE LINE OF <table_dst>.
    ASSIGN lr_line->* TO <line_dst>.

    LOOP AT <table_src> ASSIGNING <line_src>.

      lo_struct ?= cl_abap_typedescr=>describe_by_data( <line_src> ).

      DATA(lt_cols) = lo_struct->get_components( ).

      CLEAR lv_leng_ant.
      LOOP AT lt_cols INTO DATA(col).

        ASSIGN COMPONENT col-name OF STRUCTURE <line_src> TO FIELD-SYMBOL(<field_src>).
        CHECK sy-subrc = 0.

        ASSIGN COMPONENT col-name OF STRUCTURE <line_dst> TO FIELD-SYMBOL(<field_dst>).
        CHECK sy-subrc = 0.

        TRY.
            lo_descr ?= cl_abap_elemdescr=>describe_by_data( <field_dst> ).
            DATA(ls_dfies) = lo_descr->get_ddic_field( ).
          CATCH cx_root INTO DATA(xroot).
            CONTINUE.
        ENDTRY.

        lv_value = <field_src>.

        IF ls_dfies-inttype = 'P' OR
           ls_dfies-inttype = 'F'.
          TRANSLATE lv_value USING '. ,.'.
          CONDENSE lv_value NO-GAPS.
        ENDIF.

        <field_dst> = lv_value.

        "If the data has no DDIC structure, exit
        IF lo_descr->is_ddic_type( ) <> abap_true.
          CONTINUE.
        ENDIF.

        "If DDIC structure has no conversion exit, exit.
        IF ls_dfies-convexit IS INITIAL.
          CONTINUE.
        ENDIF.

        "If alpha just convert right away and return
        IF ls_dfies-convexit = 'ALPHA'.
          <field_dst> = |{ <field_dst> ALPHA = IN }|.
          CONTINUE.
        ENDIF.

        MOVE-CORRESPONDING ls_dfies TO ls_fieldinfo.

        IF ls_dfies-inttype <> 'P' AND
           ls_dfies-inttype <> 'F'.

          TRY.
              cl_rsan_ut_conversion_exit=>try_conv_int_ext_int(
                EXPORTING
                  i_fieldinfo              = ls_fieldinfo
                  i_value                  = <field_dst>
                  i_conversion_errors_type = '*'
                IMPORTING
                  e_value                  = <field_dst> ).
            CATCH cx_root INTO DATA(lv_exc).
              CONTINUE.
          ENDTRY.
        ENDIF.
      ENDLOOP.

      APPEND <line_dst> TO <table_dst>.

    ENDLOOP.

  ENDMETHOD.


  METHOD check_insert_key.

    DATA ls_key TYPE /bobf/s_frw_key.

    IF is_key-key IS NOT INITIAL.
      READ TABLE ct_key TRANSPORTING NO FIELDS
        WITH KEY key_sort COMPONENTS key = is_key-key.
      IF sy-subrc NE 0.
        INSERT is_key INTO TABLE ct_key.
      ENDIF.
    ELSEIF iv_key IS NOT INITIAL.
      READ TABLE ct_key TRANSPORTING NO FIELDS
        WITH KEY key_sort COMPONENTS key = iv_key.
      IF sy-subrc NE 0.
        ls_key-key = iv_key.
        INSERT ls_key INTO TABLE ct_key.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  method CONSTRUCTOR.
  endmethod.


  METHOD conv_messages.

    LOOP AT it_messages INTO DATA(ls_log_msg).

      APPEND VALUE bapiret2(             type       = ls_log_msg-type
                                         number     = ls_log_msg-zznumber
                                         id         = ls_log_msg-id
                                         message_v1 = ls_log_msg-message_v1
                                         message_v2 = ls_log_msg-message_v2
                                         message_v3 = ls_log_msg-message_v3
                                         message_v4 = ls_log_msg-message_v4
                                         message    = ls_log_msg-message
                                       ) TO rt_return.

    ENDLOOP.

  ENDMETHOD.


  METHOD create_integration.

    DATA:
      lt_root     TYPE zcac0001_k,
      ls_root     LIKE LINE OF lt_root,
      lt_messages TYPE zcac0004_k,
      ls_mod      TYPE /bobf/s_frw_modification,
      lt_return   TYPE bapiret2_t,
      lr_data     TYPE REF TO data.

*   Gera numeração para documento a ser integrado
*   Por exemplo somente 1 cabeçalho de doc contabil e suas linhas de contabilização)
    ev_id_number = ls_root-id_number = zcacl_process_interface=>next_number( 'ZCAIN00001').

    ls_root-procint   = iv_process.

    IF it_return IS INITIAL AND
       iv_error  IS INITIAL.
      ls_root-status    = zcacl_process_interface=>c_stat_inicial.

    ELSEIF iv_error IS NOT INITIAL.

      ls_root-status    = zcacl_process_interface=>c_stat_erro_int.

    ELSEIF it_return IS NOT INITIAL.
      READ TABLE it_return WITH KEY type = 'E' TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
        ls_root-status    = zcacl_process_interface=>c_stat_erro_int.
      ELSE.
        ls_root-status    = zcacl_process_interface=>c_stat_integrado.
      ENDIF.
    ENDIF.

    ls_root-id_macro  = iv_id_macro.
    ls_root-direct    = iv_direct.

    ls_root-ernam = sy-uname.
    ls_root-erdat = sy-datum.
    GET TIME FIELD ls_root-erzet.

*   Cria registro ROOT do objeto principal ZBCBO_INT_LOG
    zcacl_process_interface=>create_register(
      EXPORTING
        is_data = ls_root
        iv_node = zbcii_int_log=>sc_node-root
      IMPORTING
        es_mod  = ls_mod ).

    APPEND ls_mod TO ct_mod.

    APPEND VALUE /bobf/s_frw_key_incl( root_key   = ls_mod-key
                                       parent_key = ls_mod-key ) TO ct_key.

    IF it_return IS INITIAL AND
       iv_error  IS INITIAL.

    ELSEIF it_return IS NOT INITIAL.

      APPEND LINES OF it_return TO lt_return.

    ELSEIF iv_error IS NOT INITIAL.

      APPEND VALUE bapiret2( id         = 'ZCA0001'
                             number     = '001' "Erro na integração de dados com o sistema &
                             type       = 'E'
                             message_v1 = iv_system
                             message_v2 = |{ ls_root-id_number ALPHA = OUT }| ) TO lt_return.

    ELSE.

      APPEND VALUE bapiret2( id         = 'ZCA0001'
                             number     = '005' "Dados enviados com sucesso para sistema &.
                             type       = 'S'
                             message_v1 = iv_system
                             message_v2 = |{ ls_root-id_number ALPHA = OUT }| ) TO lt_return.

    ENDIF.

    GET REFERENCE OF lt_return INTO lr_data.

    zcacl_process_interface=>add_messages( EXPORTING is_data = lr_data
                                                     it_key  = ct_key
                                            CHANGING ct_mod  = ct_mod ).

  ENDMETHOD.


  METHOD create_ref_data.

*    DATA: go_struct TYPE REF TO cl_abap_structdescr.
*
*    go_struct ?= cl_abap_typedescr=>describe_by_data( i_data_struct ).
*
*
*    DATA(struc_name) = go_struct->get_relative_name( ).


    DATA:
      lo_conf   TYPE REF TO /bobf/if_frw_configuration.

    DATA:
      ls_node_conf       TYPE /bobf/s_confro_node.


    DATA:
      table_ref TYPE REF TO data,
      line_ref  TYPE REF TO data.
    TRY .
        lo_conf = /bobf/cl_frw_factory=>get_configuration( iv_bo_key = i_bo_key ).
      CATCH cx_root.

    ENDTRY.


    lo_conf->get_node(
      EXPORTING
        iv_node_key = i_node_key
      IMPORTING
        es_node = ls_node_conf ).

    IF ls_node_conf-data_data_type IS NOT INITIAL.
      CREATE DATA line_ref    TYPE (ls_node_conf-data_data_type).
      CREATE DATA table_ref    TYPE STANDARD TABLE OF (ls_node_conf-data_data_type) WITH DEFAULT KEY.
    ELSE.
    ENDIF.

    ch_table  = table_ref.
    ch_line   = line_ref.

  ENDMETHOD.


  METHOD create_ref_data_k.

    DATA:
      lo_conf   TYPE REF TO /bobf/if_frw_configuration.

    DATA:
      ls_node_conf       TYPE /bobf/s_confro_node.


    DATA:
      table_ref TYPE REF TO data,
      line_ref  TYPE REF TO data.
    TRY .
        lo_conf = /bobf/cl_frw_factory=>get_configuration( iv_bo_key = i_bo_key ).
      CATCH cx_root.

    ENDTRY.

    lo_conf->get_node(
      EXPORTING
        iv_node_key = i_node_key
      IMPORTING
        es_node = ls_node_conf ).

    IF ls_node_conf-data_type IS NOT INITIAL.
      CREATE DATA line_ref    TYPE (ls_node_conf-data_type).
      CREATE DATA table_ref    TYPE STANDARD TABLE OF (ls_node_conf-data_type) WITH DEFAULT KEY.
    ELSE.
    ENDIF.

    ch_table  = table_ref.
    ch_line   = line_ref.

  ENDMETHOD.


  METHOD create_ref_to_data.

    FIELD-SYMBOLS: <fs_data>        TYPE any.

    CREATE DATA cs_mod-data LIKE is_data.
    ASSIGN cs_mod-data->* TO <fs_data>.

    ASSERT <fs_data> IS ASSIGNED.

    <fs_data> = is_data.

  ENDMETHOD.


  METHOD create_register.

    FIELD-SYMBOLS: <fv_key>         TYPE /bobf/conf_key.

* Preparation
    CLEAR es_mod.


* set the change mode to create
    IF iv_key IS INITIAL.
      es_mod-change_mode = /bobf/if_frw_c=>sc_modify_create.
    ELSE.
      es_mod-change_mode = /bobf/if_frw_c=>sc_modify_update.
    ENDIF.


* try to get the key if not provided by the caller
    IF iv_key IS NOT SUPPLIED OR iv_key IS INITIAL.
*   if not provided by the caller, try to get the information from the passed structure
      ASSIGN COMPONENT 'KEY' OF STRUCTURE is_data TO <fv_key>.
      IF <fv_key> IS NOT ASSIGNED OR <fv_key> IS INITIAL.
*     create a new key
        es_mod-key = /bobf/cl_frw_factory=>get_new_key( ).
      ELSE.
*     set the key to the extracted one
        es_mod-key = <fv_key>.
      ENDIF.
    ELSE.
*   use the key passed by the caller
      es_mod-key = iv_key.
    ENDIF.

* TODO: Maybe some fields are allowed to be missing?!?!!?

* try to get the root_key if not provided by the caller
    IF iv_root_key IS NOT SUPPLIED OR iv_root_key IS INITIAL.
      UNASSIGN <fv_key>.
      ASSIGN COMPONENT 'ROOT_KEY' OF STRUCTURE is_data TO <fv_key>.
      ASSERT <fv_key> IS ASSIGNED.
      es_mod-root_key = <fv_key>.
    ELSE.
      es_mod-root_key = iv_root_key.
    ENDIF.

* set the node_key
    es_mod-node = iv_node.

* set the source_node_key
    IF iv_source_node IS NOT INITIAL.
      es_mod-source_node = iv_source_node.
*   try to get the parent_key if not provided by the caller
      IF iv_parent_key IS NOT SUPPLIED OR iv_parent_key IS INITIAL.
        UNASSIGN <fv_key>.
        ASSIGN COMPONENT 'PARENT_KEY' OF STRUCTURE is_data TO <fv_key>.
        ASSERT <fv_key> IS ASSIGNED.
        IF <fv_key> IS NOT INITIAL.
          es_mod-source_key  = <fv_key>.
        ELSE.
          UNASSIGN <fv_key>.
          ASSIGN COMPONENT 'ROOT_KEY' OF STRUCTURE is_data TO <fv_key>.
          ASSERT <fv_key> IS ASSIGNED.
          IF <fv_key> IS NOT INITIAL.
            es_mod-source_key  = <fv_key>.
          ENDIF.
        ENDIF.
      ELSE.
        es_mod-source_key = iv_parent_key.
      ENDIF.
    ENDIF.


* set the association
    es_mod-association = iv_association.


* set the change mode to create
*   es_mod-change_mode = /bobf/if_frw_c=>sc_modify_create.


* set the reference to the data
    CALL METHOD create_ref_to_data(
      EXPORTING
        is_data = is_data
      CHANGING
        cs_mod  = es_mod
    ).

    IF ct_mod IS SUPPLIED.
      INSERT es_mod INTO TABLE ct_mod.
    ENDIF.


  ENDMETHOD.


  METHOD create_register_mult.

    DATA: ls_mod        TYPE /bobf/s_frw_modification.

    FIELD-SYMBOLS: <fs_data>      TYPE any.

    IF it_data IS INITIAL.
      RETURN.
    ENDIF.

    LOOP AT it_data ASSIGNING <fs_data>.
      CALL METHOD zcacl_process_interface=>create_register(
        EXPORTING
          is_data        = <fs_data>
          iv_node        = iv_node
          iv_source_node = iv_source_node
          iv_association = iv_association
        IMPORTING
          es_mod         = ls_mod
      ).
      INSERT ls_mod INTO TABLE ct_mod.
    ENDLOOP.

*    IF iv_do_sorting = abap_true.
*      sort_modifications( CHANGING ct_mod = ct_mod ).
*    ENDIF.

  ENDMETHOD.


  METHOD get_int_data.

    DATA(lo_int_mgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zbcii_int_log=>sc_bo_key ).


    IF et_root IS SUPPLIED.

      lo_int_mgr->retrieve(
      EXPORTING
          it_key        = it_key
          iv_node_key   = zbcii_int_log=>sc_node-root
      IMPORTING
          et_data       = et_root
      ).

    ENDIF.

    IF et_messages IS SUPPLIED.

      et_messages = zcacl_process_interface=>get_messages_mult( it_key ).

*      lo_int_mgr->retrieve_by_association(
*      EXPORTING
*          it_key         = it_key
*          iv_node_key    = zbcii_int_log=>sc_node-root
*          iv_association = zbcii_int_log=>sc_association-root-messages
*          iv_fill_data   = abap_true
*      IMPORTING
*           et_data       = et_messages ).

    ENDIF.

    IF et_data IS SUPPLIED.

      lo_int_mgr->retrieve_by_association(
      EXPORTING
          it_key         = it_key
          iv_node_key    = zbcii_int_log=>sc_node-root
          iv_association = zbcii_int_log=>sc_association-root-data
          iv_fill_data   = abap_true
      IMPORTING
           et_data       = et_data ).

    ENDIF.

  ENDMETHOD.


  METHOD get_messages.

    DATA: lt_key  TYPE /bobf/t_frw_key.

    DATA(lo_int_mgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zbcii_int_log=>sc_bo_key ).


    zcacl_process_interface=>check_insert_key( EXPORTING iv_key = iv_key
                                                CHANGING ct_key = lt_key ).


    lo_int_mgr->retrieve_by_association(
    EXPORTING
        it_key         = lt_key
        iv_node_key    = zbcii_int_log=>sc_node-root
        iv_association = zbcii_int_log=>sc_association-root-messages
        iv_fill_data   = abap_true
    IMPORTING
         et_data       = ct_messages ).


    LOOP AT ct_messages ASSIGNING FIELD-SYMBOL(<message>).

      IF <message>-message IS INITIAL.

        MESSAGE ID <message>-id
              TYPE <message>-type
            NUMBER <message>-zznumber
              WITH <message>-message_v1
                   <message>-message_v2
                   <message>-message_v3
                   <message>-message_v4
              INTO <message>-message.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_messages_mult.

    DATA(lo_int_mgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zbcii_int_log=>sc_bo_key ).

    lo_int_mgr->retrieve_by_association(
    EXPORTING
        it_key         = it_key
        iv_node_key    = zbcii_int_log=>sc_node-root
        iv_association = zbcii_int_log=>sc_association-root-messages
        iv_fill_data   = abap_true
    IMPORTING
         et_data       = rt_messages ).

    LOOP AT rt_messages ASSIGNING FIELD-SYMBOL(<message>).

      IF <message>-message IS INITIAL.

        MESSAGE ID <message>-id
              TYPE <message>-type
            NUMBER <message>-zznumber
              WITH <message>-message_v1
                   <message>-message_v2
                   <message>-message_v3
                   <message>-message_v4
              INTO <message>-message.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD GET_STATUS_INFO.

    SELECT SINGLE * INTO rs_stainfo FROM zcat0002 WHERE status = iv_status.

  ENDMETHOD.


  METHOD messages_exec.

    DATA(lt_return) = it_return.

*   Grava retorno do processamento e atualiza status
    IF NOT line_exists( lt_return[ type = 'E' ] ).

      zcacl_process_interface=>set_status(
        EXPORTING
          iv_status = zcacl_process_interface=>c_stat_integrado
          iv_key    = iv_key ).

      CLEAR lt_return.

      APPEND VALUE bapiret2( id         = 'ZCA0001'
                             number     = 000 "Dados integrados com sucesso
                             type       = 'S'
                             message_v1 = |{ iv_id_number ALPHA = OUT }| )
      TO lt_return.

    ELSE.

      cv_erro = abap_true.

      zcacl_process_interface=>set_status(
        EXPORTING
          iv_status = zcacl_process_interface=>c_stat_erro_int
          iv_key    = iv_key ).

    ENDIF.

    zcacl_process_interface=>set_messages(
      EXPORTING
        iv_key      = iv_key
        it_messages = lt_return ).

  ENDMETHOD.


  METHOD modify.

    DATA(lr_srvmgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( iv_bo_key = zbcii_int_log=>sc_bo_key ).

*   Guarda informações
    CALL METHOD lr_srvmgr->modify
      EXPORTING
        it_modification = it_mod
      IMPORTING
        eo_message      = DATA(lo_message).

  ENDMETHOD.


  METHOD next_number.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = iv_object
*       QUANTITY                = '1'
*       SUBOBJECT               = ' '
*       TOYEAR                  = '0000'
*       IGNORE_BUFFER           = ' '
      IMPORTING
        number                  = e_id_number
*       QUANTITY                =
*       RETURNCODE              =
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

  ENDMETHOD.


  METHOD save.

*    DATA(lr_srvmgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( iv_bo_key = zbcii_int_log=>sc_bo_key ).
*
** Guarda informações
*    CALL METHOD lr_srvmgr->modify
*      EXPORTING
*        it_modification = it_mod
*      IMPORTING
*        eo_message      = DATA(lo_message).

    DATA(lo_txn_mgr) = /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( ).

    DATA(lv_tra_patt) = /bobf/if_tra_c=>gc_tp_save_and_continue.
*    DATA(lv_tra_patt) = /bobf/if_tra_c=>gc_tp_async_save_and_continue.
*    DATA(lv_tra_patt) = /bobf/if_tra_c=>gc_tp_save_and_exit.

* Salva informações
    lo_txn_mgr->save( EXPORTING iv_transaction_pattern = lv_tra_patt
                      IMPORTING ev_rejected            = DATA(lv_rejected)
                                eo_change              = DATA(lo_change)
                                eo_message             = DATA(lo_message)
                                et_rejecting_bo_key    = DATA(ls_rejecting_bo_key) ).

  ENDMETHOD.


  METHOD set_messages.

    DATA:
      lt_param TYPE bapiret2_t,
      lr_param TYPE REF TO data,
      lt_key   TYPE /bobf/t_frw_key.

    CHECK it_messages IS NOT INITIAL.

    DATA(lo_int_mgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zbcii_int_log=>sc_bo_key ).
    DATA(lo_txn_mgr) = /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( ).

    lt_param = it_messages.

    GET REFERENCE OF lt_param INTO lr_param.

    CLEAR lt_key.
    APPEND VALUE #( key = iv_key ) TO lt_key.

    lo_int_mgr->do_action( EXPORTING iv_act_key = zbcii_int_log=>sc_action-root-set_messages
                                     it_key                = lt_key
                                     is_parameters         = lr_param
                           IMPORTING eo_change             = DATA(lo_change_action)
                                     eo_message            = DATA(lo_message_action) ).

*    lo_txn_mgr->save(
*          IMPORTING
*            ev_rejected = DATA(lv_rejected)
*            eo_message  = DATA(lo_message) ).

  ENDMETHOD.


    METHOD set_status.

      DATA:
        lv_param_stat TYPE ze_status_int,
        lr_param      TYPE REF TO data,
        lt_key        TYPE /bobf/t_frw_key.

      DATA(lo_int_mgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zbcii_int_log=>sc_bo_key ).
      DATA(lo_txn_mgr) = /bobf/cl_tra_trans_mgr_factory=>get_transaction_manager( ).

      lv_param_stat = iv_status.

      GET REFERENCE OF lv_param_stat INTO lr_param.

      CLEAR lt_key.
      APPEND VALUE #( key = iv_key ) TO lt_key.

      lo_int_mgr->do_action( EXPORTING iv_act_key = zbcii_int_log=>sc_action-root-set_status
                                       it_key                = lt_key
                                       is_parameters         = lr_param
                             IMPORTING eo_change             = DATA(lo_change_action)
                                       eo_message            = DATA(lo_message_action) ).

*    lo_txn_mgr->save(
*          IMPORTING
*            ev_rejected = DATA(lv_rejected)
*            eo_message  = DATA(lo_message) ).

    ENDMETHOD.
ENDCLASS.
