*- SAP/ECC----------------------------------------------------SAP/ECC -*
*-                         *** COCATREL ***                          *-*
*- SAP/ECC----------------------------------------------------SAP/ECC -*
************************************************************************
* Projeto: Cocatrel
* Modulo / Componente: modulo de aplicação
*
* Descrição: Mensagens Interfaces BOPF
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

REPORT zcar0011.

TABLES:
  zsca_dados_integracao.

TYPES:
  BEGIN OF ty_data,
    key    TYPE /bobf/conf_key,
    icon   TYPE icon_d,
    statxt TYPE text50.
    INCLUDE STRUCTURE zsca_dados_integracao.
    INCLUDE STRUCTURE zsca_mensagens_integracao.
TYPES:
    mark   TYPE char1,
  END OF ty_data.

DATA: gv_return          TYPE boolean VALUE abap_false,
      lo_transaction_mgr TYPE REF TO /bobf/if_tra_transaction_mgr.

* Decalarações genéricas da interface
DATA: gv_lines      TYPE i,
      gt_int_root   TYPE zcac0001_k,
      gt_int_mess   TYPE zcac0004_k,
      gt_int_data   TYPE zcac0003_k,
      gt_int_key    TYPE /bobf/t_frw_key,
      gt_fol_key    TYPE /bobf/t_frw_key,
      gt_failed_key TYPE /bobf/t_frw_key,
      gt_parameters TYPE /bobf/t_frw_query_selparam,
      gs_parameter  TYPE /bobf/s_frw_query_selparam,
      gt_return     TYPE bapiret2_t,
      gt_data       TYPE TABLE OF ty_data.

CONSTANTS:
  c_msg_e     TYPE char1              VALUE 'E',
  c_msg_s     TYPE char1              VALUE 'S',
  c_sign_i    TYPE char1              VALUE 'I',
  c_option_eq TYPE char2              VALUE 'EQ'.

*&---------------------------------------------------------------------*
*&  Selection Screen
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK sel WITH FRAME TITLE TEXT-000.

  SELECT-OPTIONS:
    s_proce       FOR zsca_dados_integracao-procint,
    s_idnum       FOR zsca_dados_integracao-id_number,
    s_stat        FOR zsca_dados_integracao-status,
    s_dtcri       FOR zsca_dados_integracao-erdat,
    s_hrcri       FOR zsca_dados_integracao-erzet.

SELECTION-SCREEN END OF BLOCK sel.

AT SELECTION-SCREEN OUTPUT.


START-OF-SELECTION.

  PERFORM f_get_data.
  PERFORM f_display_alv.

END-OF-SELECTION.


FORM f_get_data.

  CLEAR:
    gt_int_root,
    gt_data.

  DATA(lo_int_mgr) = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( zbcii_int_log=>sc_bo_key ).

  PERFORM build_sel_para CHANGING gt_parameters.

  IF gv_return EQ abap_true.
    RETURN.
  ENDIF.

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

  DATA: ls_data       LIKE LINE OF gt_data.

  DELETE gt_int_root  WHERE erdat NOT IN s_dtcri.
  DELETE gt_int_root  WHERE erzet NOT IN s_hrcri.

  LOOP AT gt_int_mess ASSIGNING FIELD-SYMBOL(<file>).

    MOVE-CORRESPONDING <file> TO ls_data.

    READ TABLE gt_int_root INTO DATA(int_root) WITH KEY key = <file>-root_key.
    CHECK sy-subrc = 0.

    MOVE-CORRESPONDING int_root      TO ls_data.

    DATA(stainfo) = zcacl_process_interface=>get_status_info( ls_data-status ).

    MOVE-CORRESPONDING stainfo TO ls_data.

    ls_data-key     = int_root-key.

    APPEND ls_data TO gt_data.
    CLEAR ls_data.
  ENDLOOP.

  SORT gt_data BY id_number.

ENDFORM.

FORM build_sel_para   CHANGING ct_parameters TYPE /bobf/t_frw_query_selparam.

  CLEAR ct_parameters.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-id_number.
  LOOP AT s_idnum INTO DATA(idnum).
    gs_parameter-sign   = idnum-sign.
    gs_parameter-option = idnum-option.
    gs_parameter-low    = idnum-low.
    gs_parameter-high   = idnum-high.
    APPEND gs_parameter TO ct_parameters.
  ENDLOOP.


  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-status.
  LOOP AT s_stat INTO DATA(stat).
    gs_parameter-sign   = stat-sign.
    gs_parameter-option = stat-option.
    gs_parameter-low    = stat-low.
    gs_parameter-high   = stat-high.
    APPEND gs_parameter TO ct_parameters.
  ENDLOOP.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-erdat.
  LOOP AT s_dtcri INTO DATA(dtcri).
    gs_parameter-sign   = dtcri-sign.
    gs_parameter-option = dtcri-option.
    gs_parameter-low    = dtcri-low.
    gs_parameter-high   = dtcri-high.
    APPEND gs_parameter TO ct_parameters.
  ENDLOOP.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-erzet.
  LOOP AT s_hrcri INTO DATA(hrcri).
    gs_parameter-sign   = hrcri-sign.
    gs_parameter-option = hrcri-option.
    gs_parameter-low    = hrcri-low.
    gs_parameter-high   = hrcri-high.
    APPEND gs_parameter TO ct_parameters.
  ENDLOOP.

  CLEAR gs_parameter.
  gs_parameter-attribute_name = zbcii_int_log=>sc_node_attribute-root-procint.
  LOOP AT s_proce INTO DATA(proce).
    gs_parameter-sign   = proce-sign.
    gs_parameter-option = proce-option.
    gs_parameter-low    = proce-low.
    gs_parameter-high   = proce-high.
    APPEND gs_parameter TO ct_parameters.
  ENDLOOP.

ENDFORM.

FORM f_display_alv.

* Tabelas internas locais
  DATA:
    lt_fcat             TYPE lvc_t_fcat.

* Workareas
  DATA:
    ls_layout           TYPE lvc_s_layo.

* Monta o catalogo de campos
  PERFORM build_fieldcat CHANGING lt_fcat
                                  gt_data.

* Configura layout
  ls_layout-cwidth_opt  = abap_true.
*  ls_layout-sel_mode    = 'A'.
  ls_layout-box_fname   = 'MARK'.

* Mostra ALV
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SET_STATUS'
      i_callback_user_command  = 'USER_COMMAND'
      is_layout_lvc            = ls_layout
      it_fieldcat_lvc          = lt_fcat
      i_save                   = 'A'
*     is_variant               = gs_variant
    TABLES
      t_outtab                 = gt_data[]
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

FORM build_fieldcat CHANGING ct_fcat   TYPE lvc_t_fcat
                             ct_outtab LIKE gt_data.

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
    <lf_outtab> TYPE ANY TABLE,
    <fl_fcat>   TYPE lvc_s_fcat.

  ASSIGN ct_outtab[] TO <lf_outtab>.

  TRY .
*     Gerando ALV OM
      CALL METHOD cl_salv_table=>factory
        EXPORTING
          list_display = if_salv_c_bool_sap=>false
        IMPORTING
          r_salv_table = lo_salv_table
        CHANGING
          t_table      = <lf_outtab>.

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
      WHEN 'BUZEI'.
      WHEN 'ICON'.
        <fl_fcat>-icon = abap_true.
        <fl_fcat>-fix_column = abap_true.
        <fl_fcat>-scrtext_l = space.
        <fl_fcat>-scrtext_m = space.
        <fl_fcat>-scrtext_s = space.
        <fl_fcat>-coltext   = space.
      WHEN 'STATUS'.
        <fl_fcat>-col_pos = 3.
        <fl_fcat>-key = abap_true.
        <fl_fcat>-fix_column = abap_true.
      WHEN 'STATXT'.
        <fl_fcat>-col_pos = 4.
        <fl_fcat>-key = abap_true.
        <fl_fcat>-fix_column = abap_true.
      WHEN 'ERNAM'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'SGTXT'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'WAERS'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'BLDAT'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MODDATE'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MODTIME'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MODFIER'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ID_MACRO'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ID'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ZZNUMBER'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'TYPE'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ZZROW'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ZZSYSTEM'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'FIELD'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ZZPARAMETER'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'LOG_MSG_NO'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'LOG_NO'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MESSAGE_V1'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MESSAGE_V2'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MESSAGE_V3'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MESSAGE_V4'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'STATUS'.
      WHEN 'MANDT'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'MARK'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ICON_MSGTYPE'.
        <fl_fcat>-key = abap_true.
      WHEN 'KEY'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'INT_KEY'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'PARENT_KEY'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'ROOT_KEY'.
        <fl_fcat>-no_out = abap_true.
      WHEN 'CREATED_BY'.
      WHEN 'CREATED_ON'.
      WHEN 'CHANGED_BY'.
      WHEN 'CHANGED_ON'.
      WHEN OTHERS.

    ENDCASE.

  ENDLOOP.

ENDFORM.
FORM set_status USING pt_extab TYPE kkblo_t_extab.

  SET PF-STATUS 'STATUS_001' EXCLUDING pt_extab.

ENDFORM.
FORM user_command USING ucomm    TYPE sy-ucomm
                        selfield TYPE slis_selfield.

  DATA lo_ref1 TYPE REF TO cl_gui_alv_grid.

  CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
    IMPORTING
      e_grid = lo_ref1.

  CALL METHOD lo_ref1->check_changed_data.

  CLEAR gt_return.

  CASE ucomm.
    WHEN 'REFRESH'.

      PERFORM f_get_data.
      selfield-refresh = abap_true.

    WHEN 'LOG'.


  ENDCASE.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form F_FORMAT_DT_HR
*&---------------------------------------------------------------------*
FORM f_format_dt_hr  USING    p_value
                              p_type
                     CHANGING p_valformat.
  CASE p_type.
    WHEN 'D'.
      CONCATENATE p_value+6(4)
                  p_value+3(2)
                  p_value+0(2)
             INTO p_valformat.
    WHEN 'H'.
      CONCATENATE p_value+0(2)
                  p_value+3(2)
                  p_value+6(2)
             INTO p_valformat.
  ENDCASE.

ENDFORM.
