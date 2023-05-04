CLASS zclca_create_salesorder DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS main
      IMPORTING
        !iv_dados  TYPE zsca_header_pedido_venda
      EXPORTING
        !et_return TYPE bapiret2_tab .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS: gc_e TYPE char1 VALUE 'E'.

    DATA gv_ordem TYPE bapivbeln-vbeln .
    DATA gs_order_header_in TYPE bapisdhd1 .
    DATA gs_order_header_inx TYPE bapisdhd1x .
    DATA gs_dados TYPE zsca_header_pedido_venda .
    DATA:
      gt_order_items TYPE TABLE OF bapisditm .
    DATA:
      gt_order_itemsx TYPE STANDARD TABLE OF  bapisditmx .
    DATA:
      gt_order_partners  TYPE STANDARD TABLE OF  bapiparnr .
    DATA:
      gt_order_schedules_in   TYPE STANDARD TABLE OF  bapischdl .
    DATA:
      gt_order_schedules_inx  TYPE STANDARD TABLE OF  bapischdlx .
    DATA:
      gt_order_conditions_in  TYPE STANDARD TABLE OF  bapicond .
    DATA:
      gt_order_conditions_inx TYPE STANDARD TABLE OF  bapicondx .
    DATA:
      gt_extensionin          TYPE STANDARD TABLE OF  bapiparex .
    DATA:
      gt_extensionex          TYPE STANDARD TABLE OF  bapiparex .
    DATA:
      gt_return TYPE STANDARD TABLE OF bapiret2 .

    METHODS fill_bapi .
    METHODS exec_bapi .
    METHODS set_dados_input
      IMPORTING
        !iv_dados TYPE zsca_header_pedido_venda .
    METHODS fill_header .
    METHODS fill_items .
    METHODS fill_partner .
    METHODS fill_conditions
      IMPORTING
        !iv_item       TYPE zsca_itens_pedido_venda
        !iv_itm_number TYPE posnr_va .
    METHODS fill_extensions
      IMPORTING
        iv_item TYPE zsca_itens_pedido_venda .
    METHODS fill_schedules
      IMPORTING
        iv_item TYPE zsca_itens_pedido_venda.
ENDCLASS.



CLASS ZCLCA_CREATE_SALESORDER IMPLEMENTATION.


  METHOD exec_bapi.

    CLEAR: gv_ordem,
           gt_return.

    CALL FUNCTION 'BAPI_SALESORDER_CREATEFROMDAT2'
      EXPORTING
        order_header_in      = gs_order_header_in
        order_header_inx     = gs_order_header_inx
      IMPORTING
        salesdocument        = gv_ordem
      TABLES
        return               = gt_return
        order_items_in       = gt_order_items
        order_items_inx      = gt_order_itemsx
        order_partners       = gt_order_partners
        order_schedules_in   = gt_order_schedules_in
        order_schedules_inx  = gt_order_schedules_inx
        order_conditions_in  = gt_order_conditions_in
        order_conditions_inx = gt_order_conditions_inx
        extensionin          = gt_extensionin
        extensionex          = gt_extensionex.

    SORT gt_return BY type.
    READ  TABLE gt_return TRANSPORTING NO FIELDS WITH KEY type = gc_e BINARY SEARCH.
    IF sy-subrc IS INITIAL.
      ROLLBACK WORK.
    ELSE.

      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
    ENDIF.


    FREE:  gt_order_conditions_in,
           gt_order_conditions_inx,
           gt_order_schedules_in,
           gt_order_schedules_inx,
           gt_extensionex.

  ENDMETHOD.


  METHOD fill_bapi.

    fill_header(  ).
    fill_items(  ).
    fill_partner(  ).

  ENDMETHOD.


  METHOD fill_conditions.

    FIELD-SYMBOLS: <fs_cond>  LIKE LINE OF gt_order_conditions_in,
                   <fs_condx> LIKE LINE OF gt_order_conditions_inx.

    IF iv_item-valor_item_desc IS NOT INITIAL.

      APPEND INITIAL LINE TO gt_order_conditions_in ASSIGNING <fs_cond>.
      <fs_cond>-itm_number  = iv_itm_number.
      <fs_cond>-cond_st_no  = iv_item-cond_st_no.
      <fs_cond>-cond_type   = iv_item-cond_type.
      <fs_cond>-cond_value  = iv_item-valor_item_desc / 10.
      <fs_cond>-condvalue   = iv_item-valor_item_desc / 10.

      APPEND INITIAL LINE TO gt_order_conditions_inx ASSIGNING <fs_condx>.
      <fs_condx>-itm_number = iv_itm_number.

      IF <fs_cond>-cond_st_no IS NOT INITIAL.
        <fs_condx>-cond_st_no   = abap_true.
      ENDIF.

      IF <fs_cond>-cond_type IS NOT INITIAL.
        <fs_condx>-cond_type   = abap_true.
      ENDIF.

      IF <fs_cond>-cond_value IS NOT INITIAL.
        <fs_condx>-cond_value   = abap_true.
      ENDIF.

      <fs_condx>-updateflag  = 'U'."iv_item-updateflag.

    ENDIF.

  ENDMETHOD.


  METHOD fill_extensions.

    FIELD-SYMBOLS: <fs_ext_in> LIKE LINE OF gt_extensionex.
    FIELD-SYMBOLS: <fs_ext> LIKE LINE OF gt_extensionex.

    DATA: ls_bapi_vbak  TYPE bape_vbak,
          ls_bapi_vbakx TYPE bape_vbakx,
          ls_bapi_vbap  TYPE bape_vbap,
          ls_bapi_vbapx TYPE bape_vbapx.


    LOOP AT iv_item-extension ASSIGNING FIELD-SYMBOL(<fs_extension>).

      ASSIGN COMPONENT <fs_extension>-fieldname OF STRUCTURE ls_bapi_vbak TO FIELD-SYMBOL(<fs_value>).

      IF  <fs_value> IS ASSIGNED.

        APPEND INITIAL LINE TO gt_extensionin ASSIGNING <fs_ext_in>.
        <fs_value> = <fs_extension>-value.
        <fs_ext_in>-structure = <fs_extension>-structure.
        <fs_ext_in>+30(960) = ls_bapi_vbak.

        ASSIGN COMPONENT <fs_extension>-fieldname OF STRUCTURE ls_bapi_vbakx TO FIELD-SYMBOL(<fs_valuex>).

        APPEND INITIAL LINE TO gt_extensionex ASSIGNING <fs_ext>.

        IF <fs_value> IS NOT INITIAL.
          <fs_valuex>   = abap_true.
        ENDIF.

        <fs_ext>-structure = <fs_extension>-structure.
        <fs_ext>+30(960) = ls_bapi_vbakx.

      ENDIF.

      ASSIGN COMPONENT <fs_extension>-fieldname OF STRUCTURE ls_bapi_vbap TO <fs_value>.

      IF  <fs_value> IS ASSIGNED.
        APPEND INITIAL LINE TO gt_extensionin ASSIGNING <fs_ext_in>.
        <fs_value> = <fs_extension>-value.
        <fs_ext_in>-structure = <fs_extension>-structure.
        <fs_ext_in>-valuepart1 = <fs_extension>-value.
*        <fs_ext>+30(960) = ls_bapi_vbap.
        <fs_ext_in>+16(10)  = ls_bapi_vbap.

        ASSIGN COMPONENT <fs_extension>-fieldname OF STRUCTURE ls_bapi_vbapx TO FIELD-SYMBOL(<fs_valuex_vbap>).

        APPEND INITIAL LINE TO gt_extensionex ASSIGNING <fs_ext>.

        IF <fs_value> IS NOT INITIAL.
          <fs_valuex_vbap>   = abap_true.
        ENDIF.

        <fs_ext>-structure = <fs_extension>-structure.
        <fs_ext>-valuepart1 = abap_true.
*        <fs_ext>+30(960) = ls_bapi_vbapx.
        <fs_ext>+23(1) = ls_bapi_vbapx.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD fill_header.

    CLEAR: gs_order_header_in,
               gs_order_header_inx.

    gs_order_header_in-doc_type    = gs_dados-doc_type.
    gs_order_header_in-sales_org   = gs_dados-sales_org.
    gs_order_header_in-distr_chan  = gs_dados-canal_vendas.
    gs_order_header_in-division    = gs_dados-setor_atividade.
    gs_order_header_in-sales_off   = gs_dados-escritorio_vendas.
    gs_order_header_in-sales_grp   = gs_dados-equipe_vendas.
    gs_order_header_in-purch_no_c  = gs_dados-purch_no_c.
    gs_order_header_in-incoterms1  = gs_dados-incoterms1.
    gs_order_header_in-incoterms2  = gs_dados-incoterms2.
    gs_order_header_in-pmnttrms    = gs_dados-pmnttrms.
    gs_order_header_in-po_method   = gs_dados-po_method.
    gs_order_header_in-ord_reason  = gs_dados-ord_reason.
*    gs_order_header_in-fix_val_dy  = gs_dados-data_efetiva.
*    gs_order_header_in-price_list  = gs_dados-lista_preco.

    gs_order_header_inx-updateflag = gs_dados-updateflag.

    IF gs_order_header_in-doc_type IS NOT INITIAL.
      gs_order_header_inx-doc_type    = abap_true.
    ENDIF.

    IF gs_order_header_in-sales_org IS NOT INITIAL.
      gs_order_header_inx-sales_org    = abap_true.
    ENDIF.

    IF gs_order_header_in-distr_chan IS NOT INITIAL.
      gs_order_header_inx-distr_chan    = abap_true.
    ENDIF.

    IF gs_order_header_in-division IS NOT INITIAL.
      gs_order_header_inx-division    = abap_true.
    ENDIF.

    IF gs_order_header_in-sales_off IS NOT INITIAL.
      gs_order_header_inx-sales_off    = abap_true.
    ENDIF.

    IF gs_order_header_in-sales_off IS NOT INITIAL.
      gs_order_header_inx-sales_off    = abap_true.
    ENDIF.

    IF gs_order_header_in-sales_grp IS NOT INITIAL.
      gs_order_header_inx-sales_grp    = abap_true.
    ENDIF.

    IF gs_order_header_in-purch_no_c IS NOT INITIAL.
      gs_order_header_inx-purch_no_c    = abap_true.
    ENDIF.

    IF gs_order_header_in-incoterms1 IS NOT INITIAL.
      gs_order_header_inx-incoterms1    = abap_true.
    ENDIF.

    IF gs_order_header_in-incoterms2 IS NOT INITIAL.
      gs_order_header_inx-incoterms2    = abap_true.
    ENDIF.

    IF gs_order_header_in-pmnttrms IS NOT INITIAL.
      gs_order_header_inx-pmnttrms    = abap_true.
    ENDIF.

    IF gs_order_header_in-po_method IS NOT INITIAL.
      gs_order_header_inx-po_method    = abap_true.
    ENDIF.

    IF gs_order_header_in-ord_reason IS NOT INITIAL.
      gs_order_header_inx-ord_reason    = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD fill_items.

    DATA: lv_item_number TYPE posnr_va.

    FREE: gt_order_items,
           gt_order_itemsx.

    LOOP AT gs_dados-itens ASSIGNING FIELD-SYMBOL(<fs_item>).

      lv_item_number = <fs_item>-item.

      APPEND INITIAL LINE TO gt_order_items ASSIGNING FIELD-SYMBOL(<fs_item_order>).
      <fs_item_order>-itm_number  = lv_item_number.
      <fs_item_order>-material    = <fs_item>-produto.
      <fs_item_order>-plant       = gs_dados-centro.
      <fs_item_order>-target_qty  = <fs_item>-quantidade.
      <fs_item_order>-store_loc   = <fs_item>-store_loc.
      <fs_item_order>-wbs_elem    = <fs_item>-wbs_elem.
      <fs_item_order>-target_qu   = <fs_item>-target_qu.
      <fs_item_order>-sales_unit  = <fs_item>-target_qu.




      APPEND INITIAL LINE TO gt_order_itemsx ASSIGNING FIELD-SYMBOL(<fs_item_orderx>).

      <fs_item_orderx>-itm_number = lv_item_number.
      <fs_item_orderx>-updateflag = <fs_item>-updateflag.

      IF <fs_item_order>-material IS NOT INITIAL.
        <fs_item_orderx>-material   = abap_true.
      ENDIF.

      IF <fs_item_order>-plant IS NOT INITIAL.
        <fs_item_orderx>-plant   = abap_true.
      ENDIF.

      IF <fs_item_order>-target_qty IS NOT INITIAL.
        <fs_item_orderx>-target_qty   = abap_true.
      ENDIF.

      IF <fs_item_order>-store_loc IS NOT INITIAL.
        <fs_item_orderx>-store_loc   = abap_true.
      ENDIF.

      IF <fs_item_order>-wbs_elem IS NOT INITIAL.
        <fs_item_orderx>-wbs_elem   = abap_true.
      ENDIF.

      IF <fs_item_order>-target_qu IS NOT INITIAL.
        <fs_item_orderx>-target_qu   = abap_true.
      ENDIF.

      IF <fs_item_order>-sales_unit IS NOT INITIAL.
        <fs_item_orderx>-sales_unit   = abap_true.
      ENDIF.

      fill_conditions( EXPORTING iv_item = <fs_item>
                                 iv_itm_number = lv_item_number ).

      fill_schedules( EXPORTING iv_item = <fs_item> ).

      fill_extensions( EXPORTING iv_item = <fs_item> ).

    ENDLOOP.

  ENDMETHOD.


  METHOD fill_partner.

    FREE: gt_order_partners.

    APPEND INITIAL LINE TO gt_order_partners ASSIGNING FIELD-SYMBOL(<fs_partner>).
    <fs_partner>-partn_role = gs_dados-partn_role.
    <fs_partner>-partn_numb = gs_dados-partn_numb.

  ENDMETHOD.


  METHOD main.

    set_dados_input( iv_dados ).

    fill_bapi(  ).

    exec_bapi(  ).

    et_return = gt_return.

  ENDMETHOD.


  METHOD set_dados_input.

    CLEAR: gs_dados.
    gs_dados = iv_dados.

  ENDMETHOD.


  METHOD fill_schedules.

    APPEND VALUE #( itm_number = iv_item-item
                    req_qty    = iv_item-quantidade ) TO gt_order_schedules_in.

    APPEND VALUE #( itm_number = iv_item-item
                    req_qty    = abap_true          ) TO gt_order_schedules_inx.

  ENDMETHOD.
ENDCLASS.
