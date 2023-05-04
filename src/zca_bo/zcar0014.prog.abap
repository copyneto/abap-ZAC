*- SAP/ECC----------------------------------------------------SAP/ECC -*
*-                     *** CASA DOS VENTOS ***                       *-*
*- SAP/ECC----------------------------------------------------SAP/ECC -*
************************************************************************
* Projeto: Cocatrel
* Modulo / Componente: modulo de aplicação
*
* Descrição: Dados Interfaces BOPF
*
* Modo Execução: [] Background * [X] Online
*
************************************************************************
* Autor: Guido Olivan                                   Data: 13/07/2020
************************************************************************
* Modificações:
* DD / MM / AAAA Autor - empresa (no caso de consultoria)
*                 Descrição da modificação
************************************************************************

REPORT zcar0014 MESSAGE-ID zca0001.

TABLES:
  zsca_dados_integracao.

TYPES:
  BEGIN OF ty_data.
    INCLUDE STRUCTURE zsca_info_integracao.
    INCLUDE STRUCTURE /bobf/s_frw_key_incl.
    INCLUDE STRUCTURE zsca_dados_integracao.
TYPES:
  END OF ty_data,

  ty_t_data TYPE STANDARD TABLE OF ty_data.

* Declarações genéricas da interface
DATA: gt_int_root   TYPE zcac0001_k,
      gt_int_mess   TYPE zcac0004_k,
      gt_int_data   TYPE zcac0003_k,
      gt_int_key    TYPE /bobf/t_frw_key,
      gt_parameters TYPE /bobf/t_frw_query_selparam,
      gs_parameter  TYPE /bobf/s_frw_query_selparam.

CONSTANTS:
  c_msg_e     TYPE char1              VALUE 'E',
  c_msg_s     TYPE char1              VALUE 'S',
  c_sign_i    TYPE char1              VALUE 'I',
  c_option_eq TYPE char2              VALUE 'EQ'.

FIELD-SYMBOLS:
  <table> TYPE STANDARD TABLE.

*&---------------------------------------------------------------------*
*&  Selection Screen
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK sel WITH FRAME TITLE TEXT-000.

  PARAMETERS:
    p_proce       TYPE zsca_dados_integracao-procint OBLIGATORY.
  SELECT-OPTIONS:
    s_idnum       FOR zsca_dados_integracao-id_number,
    s_stat        FOR zsca_dados_integracao-status,
    s_direc       FOR zsca_dados_integracao-direct,
    s_dtcri       FOR zsca_dados_integracao-erdat,
    s_hrcri       FOR zsca_dados_integracao-erzet.

SELECTION-SCREEN END OF BLOCK sel.

*=================*
AT SELECTION-SCREEN OUTPUT.
*=================*

*=================*
START-OF-SELECTION.
*=================*
  PERFORM f_build_sel_para.
  PERFORM f_get_data.
  PERFORM f_build_out.
  PERFORM f_display_alv USING abap_false CHANGING <table>.

*===============*
END-OF-SELECTION.
*===============*

*&---------------------------------------------------------------------*
*& Form f_get_data
*&---------------------------------------------------------------------*
FORM f_get_data.

  DATA(lo_int_mgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zbcii_int_log=>sc_bo_key ).

  lo_int_mgr->query(
    EXPORTING
      iv_query_key            = zbcii_int_log=>sc_query-root-select_by_elements
      it_selection_parameters = gt_parameters
    IMPORTING
      et_key                  = gt_int_key ).

  zcacl_process_interface=>get_int_data(
  EXPORTING
      it_key         = gt_int_key
  IMPORTING
       et_root       = gt_int_root
       et_messages   = gt_int_mess
       et_data       = gt_int_data ).

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_build_out
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
FORM f_build_out .

  DATA: lo_struct   TYPE REF TO cl_abap_structdescr,
        lo_descr    TYPE REF TO cl_abap_elemdescr,
        lt_cols     TYPE cl_abap_structdescr=>component_table,
        lv_leng_ant TYPE dfies-leng.

  DATA:
    table_ref TYPE REF TO data,
    line_ref  TYPE REF TO data.

  FIELD-SYMBOLS:
    <line>   TYPE any,
    <line1>  TYPE any,
    <line2>  TYPE ty_data,
    <table1> TYPE STANDARD TABLE,
    <table2> TYPE ty_t_data.

  DATA: dyn_table TYPE REF TO data.

* Objetos locais
  DATA:
    lo_salv_table        TYPE REF TO cl_salv_table,
    lo_salv_columns      TYPE REF TO cl_salv_columns_table,
    lo_salv_aggregations TYPE REF TO cl_salv_aggregations,
    lo_cx_root           TYPE REF TO cx_root,

    lt_fcat              TYPE lvc_t_fcat.

  IF gt_int_data IS INITIAL.
    MESSAGE s007 DISPLAY LIKE c_msg_e.
    STOP.
  ENDIF.

  DATA(lv_struc) = gt_int_data[ 1 ]-struc.

* Exibir apenas uma estrutura caso a interface tenha mais de uma.
  DELETE gt_int_data WHERE struc <> lv_struc.

  LOOP AT gt_int_data ASSIGNING FIELD-SYMBOL(<data>).

    AT FIRST.

      CREATE DATA table_ref TYPE TABLE OF ty_data.
      ASSIGN table_ref->* TO <table2>.

      CREATE DATA line_ref TYPE ty_data.
      ASSIGN line_ref->* TO <line2>.

      TRY .
*     Gerando ALV
          CALL METHOD cl_salv_table=>factory
            EXPORTING
              list_display = if_salv_c_bool_sap=>false
            IMPORTING
              r_salv_table = lo_salv_table
            CHANGING
              t_table      = <table2>.


*     Buscar as informações das colunas da ALV
          lo_salv_columns      = lo_salv_table->get_columns( ).
          lo_salv_aggregations = lo_salv_table->get_aggregations( ).
          DATA(lt_fcat_aux)              = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
                                                     r_columns             = lo_salv_columns
                                                     r_aggregations        = lo_salv_aggregations ).


        CATCH cx_root INTO lo_cx_root.                   "#EC CATCH_ALL
          DATA(lv_text) = lo_cx_root->get_text( ).
          MESSAGE lv_text TYPE 'S' DISPLAY LIKE 'E'.
          STOP.
      ENDTRY.

      APPEND LINES OF lt_fcat_aux TO lt_fcat.

      CREATE DATA line_ref TYPE (<data>-struc).
      CREATE DATA table_ref TYPE TABLE OF (<data>-struc).
      ASSIGN table_ref->* TO <table1>.
      ASSIGN line_ref->* TO <line1>.

      DESCRIBE TABLE lt_fcat LINES DATA(line).


      TRY .
*     Gerando ALV
          CALL METHOD cl_salv_table=>factory
            EXPORTING
              list_display = if_salv_c_bool_sap=>false
            IMPORTING
              r_salv_table = lo_salv_table
            CHANGING
              t_table      = <table1>.

*     Buscar as informações das colunas da ALV
          lo_salv_columns      = lo_salv_table->get_columns( ).
          lo_salv_aggregations = lo_salv_table->get_aggregations( ).
          lt_fcat_aux              = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
                                                     r_columns             = lo_salv_columns
                                                     r_aggregations        = lo_salv_aggregations ).


        CATCH cx_root INTO lo_cx_root.                   "#EC CATCH_ALL
          lv_text = lo_cx_root->get_text( ).
          MESSAGE lv_text TYPE 'S' DISPLAY LIKE 'E'.
          STOP.
      ENDTRY.

      LOOP AT lt_fcat_aux ASSIGNING FIELD-SYMBOL(<fcat>).
        line = line + 1.
        <fcat>-col_pos = line.
      ENDLOOP.

      APPEND LINES OF lt_fcat_aux TO lt_fcat.

      SORT lt_fcat BY fieldname.
      DELETE ADJACENT DUPLICATES FROM lt_fcat COMPARING fieldname.

      SORT lt_fcat BY col_pos.

      CALL METHOD cl_alv_table_create=>create_dynamic_table
        EXPORTING
          it_fieldcatalog = lt_fcat
        IMPORTING
          ep_table        = dyn_table.

      ASSIGN dyn_table->* TO <table>.

      CREATE DATA line_ref LIKE LINE OF <table>.
      ASSIGN line_ref->* TO <line>.

    ENDAT.

    lo_struct ?= cl_abap_typedescr=>describe_by_data( <line1> ).
    lt_cols = lo_struct->get_components( ).

    CLEAR lv_leng_ant.
    LOOP AT lt_cols INTO DATA(col).

      ASSIGN COMPONENT col-name OF STRUCTURE <line> TO FIELD-SYMBOL(<field>).

      CHECK sy-subrc = 0.

      TRY.
          lo_descr ?= cl_abap_elemdescr=>describe_by_data( <field> ).
          DATA(ls_dfies) = lo_descr->get_ddic_field( ).
        CATCH cx_root INTO DATA(xroot).
          CONTINUE.
      ENDTRY.

      IF ls_dfies-datatype = 'STRG'.
        ls_dfies-leng = strlen( <field> ).
      ELSE.
      ENDIF.

      IF ls_dfies-leng IS NOT INITIAL.
        <field> = <data>-sdata+lv_leng_ant(ls_dfies-leng).
      ENDIF.

      lv_leng_ant = lv_leng_ant + ls_dfies-leng.

    ENDLOOP.

    READ TABLE gt_int_root ASSIGNING FIELD-SYMBOL(<root>) WITH KEY key = <data>-root_key.

    lo_struct ?= cl_abap_typedescr=>describe_by_data( <line2> ).
    lt_cols = lo_struct->get_components( ).

    LOOP AT lt_cols INTO col.

      lo_struct ?= col-type.

      DATA(lt_cols2) = lo_struct->get_components( ).

      LOOP AT lt_cols2 INTO DATA(col2).

        ASSIGN COMPONENT col2-name OF STRUCTURE <line> TO <field>.
        CHECK sy-subrc = 0.

        ASSIGN COMPONENT col2-name OF STRUCTURE <root> TO FIELD-SYMBOL(<field_src>).
        CHECK sy-subrc = 0.

        <field> = <field_src>.

      ENDLOOP.
    ENDLOOP.

    ASSIGN COMPONENT 'KEY' OF STRUCTURE <line> TO <field>.

    IF sy-subrc = 0.
      <field> = <root>-key.
    ENDIF.

    APPEND <line> TO <table>.

  ENDLOOP.

  LOOP AT <table> ASSIGNING <line>.

    ASSIGN COMPONENT 'STATUS' OF STRUCTURE <line> TO <field>.

    IF sy-subrc = 0.
      DATA(stainfo) = zcacl_process_interface=>get_status_info( <field> ).
      MOVE-CORRESPONDING stainfo TO <line>.
    ENDIF.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_build_sel_para
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
FORM f_build_sel_para.

  CLEAR gt_parameters.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-id_number.
  LOOP AT s_idnum INTO DATA(idnum).
    gs_parameter-sign   = idnum-sign.
    gs_parameter-option = idnum-option.
    gs_parameter-low    = idnum-low.
    gs_parameter-high   = idnum-high.
    APPEND gs_parameter TO gt_parameters.
  ENDLOOP.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-status.
  LOOP AT s_stat INTO DATA(stat).
    gs_parameter-sign   = stat-sign.
    gs_parameter-option = stat-option.
    gs_parameter-low    = stat-low.
    gs_parameter-high   = stat-high.
    APPEND gs_parameter TO gt_parameters.
  ENDLOOP.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-erdat.
  LOOP AT s_dtcri INTO DATA(dtcri).
    gs_parameter-sign   = dtcri-sign.
    gs_parameter-option = dtcri-option.
    gs_parameter-low    = dtcri-low.
    gs_parameter-high   = dtcri-high.
    APPEND gs_parameter TO gt_parameters.
  ENDLOOP.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-erzet.
  LOOP AT s_hrcri INTO DATA(hrcri).
    gs_parameter-sign   = hrcri-sign.
    gs_parameter-option = hrcri-option.
    gs_parameter-low    = hrcri-low.
    gs_parameter-high   = hrcri-high.
    APPEND gs_parameter TO gt_parameters.
  ENDLOOP.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-direct.
  LOOP AT s_direc INTO DATA(direc).
    gs_parameter-sign   = direc-sign.
    gs_parameter-option = direc-option.
    gs_parameter-low    = direc-low.
    gs_parameter-high   = direc-high.
    APPEND gs_parameter TO gt_parameters.
  ENDLOOP.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-procint.
  gs_parameter-sign   = c_sign_i.
  gs_parameter-option = c_option_eq.
  gs_parameter-low    = p_proce.
  APPEND gs_parameter TO gt_parameters.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_display_alv
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
FORM f_display_alv     USING p_mark
                    CHANGING ct_output TYPE ANY TABLE.

* Tabelas internas locais
  DATA:
    lt_fcat   TYPE lvc_t_fcat,
    ls_layout TYPE lvc_s_layo,
    lv_title  TYPE lvc_title.

  FIELD-SYMBOLS:
    <table>   TYPE STANDARD TABLE.

  CHECK ct_output IS NOT INITIAL.

* Monta o catalogo de campos
  PERFORM f_build_fieldcat CHANGING lt_fcat
                                    ct_output.

* Configura layout
  ls_layout-cwidth_opt  = abap_true.
*  ls_layout-sel_mode    = 'A'.
  IF p_mark IS NOT INITIAL.
    ls_layout-box_fname   = 'MARK'.
  ENDIF.

  SELECT SINGLE proctxt INTO lv_title
    FROM zcat0005
    WHERE process = p_proce.

  ASSIGN ct_output TO <table>.

* Mostra ALV
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SET_STATUS'
      i_callback_user_command  = 'USER_COMMAND'
      is_layout_lvc            = ls_layout
      it_fieldcat_lvc          = lt_fcat
      i_save                   = 'A'
      i_grid_title             = lv_title
*     is_variant               = gs_variant
    TABLES
      t_outtab                 = <table>
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid
          TYPE 'S'
        NUMBER sy-msgno
          WITH sy-msgv1
               sy-msgv2
               sy-msgv3
               sy-msgv4
         DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_build_fieldcat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
FORM f_build_fieldcat CHANGING ct_fcat   TYPE lvc_t_fcat
                             ct_outtab TYPE ANY TABLE.

* Objetos locais
  DATA:
    lo_salv_table        TYPE REF TO cl_salv_table,
    lo_salv_columns      TYPE REF TO cl_salv_columns_table,
    lo_salv_aggregations TYPE REF TO cl_salv_aggregations,
    lo_cx_root           TYPE REF TO cx_root.

* Variáveis
  DATA:
    lv_text                 TYPE string.

* Field-symbols
  FIELD-SYMBOLS:
    <fl_fcat>   TYPE lvc_s_fcat.

  TRY .
*     Gerando ALV OM
      CALL METHOD cl_salv_table=>factory
        EXPORTING
          list_display = if_salv_c_bool_sap=>false
        IMPORTING
          r_salv_table = lo_salv_table
        CHANGING
          t_table      = ct_outtab.

*     Buscar as informações das colunas da ALV
      lo_salv_columns      = lo_salv_table->get_columns( ).
      lo_salv_aggregations = lo_salv_table->get_aggregations( ).
      ct_fcat              = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
                                                 r_columns             = lo_salv_columns
                                                 r_aggregations        = lo_salv_aggregations ).

    CATCH cx_root INTO lo_cx_root.                       "#EC CATCH_ALL
      lv_text = lo_cx_root->get_text( ).
      MESSAGE lv_text TYPE 'S' DISPLAY LIKE 'E'.
      STOP.
  ENDTRY.

* Tratamento para campos específicos
  LOOP AT ct_fcat ASSIGNING <fl_fcat>.
    CASE <fl_fcat>-fieldname.
      WHEN 'ICON'.
        <fl_fcat>-key = abap_true.
      WHEN 'ID_NUMBER'.
        <fl_fcat>-key = abap_true.
      WHEN 'STATXT'.
        <fl_fcat>-key = abap_true.
      WHEN 'STATUS'.
        <fl_fcat>-key = abap_true.
      WHEN 'MANDT'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MODDATE'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MODTIME'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MODIFIER'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ID_MACRO'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'PROCINT'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MARK'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ZZZZZ'.
        <fl_fcat>-outputlen = 15.
        <fl_fcat>-key = abap_true.
        <fl_fcat>-scrtext_l = 'XXX'.
        <fl_fcat>-scrtext_m = 'XX'.
        <fl_fcat>-scrtext_s = 'X'.
      WHEN 'KEY'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'PARENT_KEY'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ROOT_KEY'.
        <fl_fcat>-no_out = abap_true.
      WHEN OTHERS.
    ENDCASE.

  ENDLOOP.

ENDFORM.
FORM set_status USING pt_extab TYPE kkblo_t_extab.

  APPEND 'REFRESH' TO pt_extab.
  SET PF-STATUS 'STATUS_001' EXCLUDING pt_extab.

ENDFORM.
FORM user_command USING ucomm    TYPE sy-ucomm
                        selfield TYPE slis_selfield.

  DATA lo_ref1 TYPE REF TO cl_gui_alv_grid.

  CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
    IMPORTING
      e_grid = lo_ref1.

  CALL METHOD lo_ref1->check_changed_data.

  CASE ucomm.
    WHEN 'REFRESH'.

      PERFORM f_get_data.
      PERFORM f_build_out.
      selfield-refresh = abap_true.

    WHEN 'MESS'.
      READ TABLE <table> ASSIGNING FIELD-SYMBOL(<line>) INDEX selfield-tabindex.

      ASSIGN COMPONENT 'KEY' OF STRUCTURE <line> TO FIELD-SYMBOL(<key>).

      CHECK sy-subrc = 0.

      DATA(lt_messages) = zcacl_process_interface=>get_messages( <key> ).

      DATA(lt_return) = zcacl_process_interface=>conv_messages( lt_messages ).

      IF lt_return IS NOT INITIAL.
        CALL FUNCTION 'UDM_MESSAGE_SHOW'
          EXPORTING
            et_message = lt_return.
      ENDIF.

  ENDCASE.

ENDFORM.
FORM f_display_alv_hier     USING p_mark
                    CHANGING ct_output_h TYPE ANY TABLE
                             ct_output_i TYPE ANY TABLE.

* Tabelas internas locais
  DATA:
    lt_fcat    TYPE lvc_t_fcat,
    ls_layout  TYPE lvc_s_layo,
    lv_title   TYPE lvc_title,
    ls_keyinfo TYPE slis_keyinfo_alv.

  FIELD-SYMBOLS:
    <table_out_h> TYPE STANDARD TABLE,
    <table_out_i> TYPE STANDARD TABLE.

  CHECK ct_output_h IS NOT INITIAL.

* Monta o catalogo de campos
  PERFORM f_build_fieldcat CHANGING lt_fcat
                                    ct_output_h.

* Configura layout
  ls_layout-cwidth_opt  = abap_true.
*  ls_layout-sel_mode    = 'A'.
  IF p_mark IS NOT INITIAL.
    ls_layout-box_fname   = 'MARK'.
  ENDIF.

  SELECT SINGLE proctxt INTO lv_title
    FROM zcat0005
    WHERE process = p_proce.

  ASSIGN ct_output_h TO <table_out_h>.
  ASSIGN ct_output_i TO <table_out_i>.

* Mostra ALV

  ls_keyinfo-header01 = 'KEY'.
  ls_keyinfo-item01 = 'ROOT_KEY'.

  CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK        = ' '
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SET_STATUS'
      i_callback_user_command  = 'USER_COMMAND'
      is_layout_lvc            = ls_layout
*     IT_FIELDCAT              =
*     I_SAVE                   = ' '
*     IS_VARIANT               =
      i_tabname_header         = 'CT_OUTPUT_H'
      i_tabname_item           = 'CT_OUTPUT_I'
*     I_STRUCTURE_NAME_HEADER  =
*     I_STRUCTURE_NAME_ITEM    =
      is_keyinfo               = ls_keyinfo
    TABLES
      t_outtab_header          = <table_out_h>
      t_outtab_item            = <table_out_i>.
ENDFORM.
