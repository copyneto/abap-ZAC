CLASS zclca_import_excel_ricefw DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: tt_return TYPE SORTED TABLE OF ztca_ricefws WITH UNIQUE KEY uuid_ricefw.

    METHODS:
      execute
        IMPORTING
                  is_media_resource TYPE /iwbep/if_mgw_appl_srv_runtime=>ty_s_media_resource
                  iv_slug           TYPE string
        RETURNING VALUE(rt_return)  TYPE bapiret2_t.


  PROTECTED SECTION.

  PRIVATE SECTION.

    TYPES:
        tt_ricefws TYPE TABLE OF ztca_ricefws.

    CONSTANTS:
        gc_msgid TYPE sy-msgid VALUE 'ZCA_RICEFWS'.

    METHODS:
      get_file_table
        IMPORTING
                  is_media_resource TYPE /iwbep/if_mgw_appl_srv_runtime=>ty_s_media_resource
                  iv_slug           TYPE string
        RETURNING VALUE(ro_data)    TYPE REF TO data,

      set_existing_uuid
        CHANGING
          ct_ricefws TYPE tt_ricefws,

      get_complexidade
        IMPORTING
                  iv_field               TYPE string
        RETURNING VALUE(rv_complexidade) TYPE ze_complexidade,

      save_data
        IMPORTING
                  it_ricefws       TYPE tt_ricefws
        RETURNING VALUE(lt_return) TYPE bapiret2_t.

ENDCLASS.


CLASS zclca_import_excel_ricefw IMPLEMENTATION.

  METHOD execute.

    DATA: lv_filename TYPE string,
          lv_projeto  TYPE string,
          ls_ricefws  TYPE ztca_ricefws,
          lt_ricefws  TYPE TABLE OF ztca_ricefws.

    FIELD-SYMBOLS <fs_data_table> TYPE STANDARD TABLE.

    DATA(lo_data_ref) = get_file_table(
      is_media_resource = is_media_resource
      iv_slug           = iv_slug ).

    IF lo_data_ref IS BOUND.

      ASSIGN lo_data_ref->* TO <fs_data_table>.

    ENDIF.

    LOOP AT <fs_data_table> ASSIGNING FIELD-SYMBOL(<fs_data>) FROM 3.

      IF <fs_data> IS INITIAL.
        EXIT.
      ENDIF.

      CLEAR ls_ricefws.

      WHILE sy-subrc IS INITIAL.

        ASSIGN COMPONENT sy-index OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_field>).
        IF <fs_field> IS NOT ASSIGNED.
          EXIT.
        ENDIF.

        CASE sy-index.
          WHEN 1.
*            Projeto

          WHEN 2. "Id Ricefw
            ls_ricefws-id_ricefw     = <fs_field>.

          WHEN 3.
            ls_ricefws-id_gap        = <fs_field>.

          WHEN 4.
            ls_ricefws-contador      = <fs_field>.

          WHEN 5.
            ls_ricefws-id_modulo     = <fs_field>.

          WHEN 6.
            ls_ricefws-id_cenario    = <fs_field>.

          WHEN 7.
            ls_ricefws-desc_ricefw   = <fs_field>.

          WHEN 8.
            ls_ricefws-sist_legado   = <fs_field>.

          WHEN 9.
            ls_ricefws-tipo_ini      = <fs_field>(1).

          WHEN 10.
            ls_ricefws-complex_abap_ini = get_complexidade( iv_field = <fs_field> ).

          WHEN 11.
*            ls_ricefws-abap_estim_ini = <fs_field>. Estimativa

          WHEN 12.
            ls_ricefws-complex_po_ini = get_complexidade( iv_field = <fs_field> ).

          WHEN 13.
            ls_ricefws-po_estim_ini = <fs_field>.

          WHEN 14.
*            ls_ricefws- = <fs_field>. Total DEV

          WHEN 15.
*            ls_ricefws- = <fs_field>. Metrica Funcional

          WHEN 16.
*            ls_ricefws- = <fs_field>. Total

          WHEN 17.
*            ls_ricefws- = <fs_field>. Status EF

          WHEN 18.
*            ls_ricefws-observacoes = <fs_field>. Observações EF

          WHEN 19.
            ls_ricefws-tipo_real = <fs_field>(1).

          WHEN 20.
            ls_ricefws-complex_abap_real = get_complexidade( iv_field = <fs_field> ).

          WHEN 21.
            ls_ricefws-abap_estim = <fs_field>.

          WHEN 22.
            ls_ricefws-complex_po_real = get_complexidade( iv_field = <fs_field> ).

          WHEN 23.
            ls_ricefws-po_estim = <fs_field>.

          WHEN 24.
*            ls_ricefws- = <fs_field>. Total Dev

          WHEN 25.
*            ls_ricefws- = <fs_field>. Métrica Funcional

          WHEN 26.
*            ls_ricefws- = <fs_field>. Total

          WHEN 27.
*            ls_ricefws- = <fs_field>. Divergência Estimativa

          WHEN 28.
*            ls_ricefws- = <fs_field>. Data Início

          WHEN 29.
*            ls_ricefws- = <fs_field>. Data Prevista

          WHEN 30.
*            ls_ricefws- = <fs_field>. Data Status

          WHEN 31.
*            ls_ricefws- = <fs_field>. TraceGP

          WHEN 32.
            ls_ricefws-sprint = <fs_field>.

          WHEN 33.
            ls_ricefws-status = <fs_field>.

          WHEN 34.
            ls_ricefws-abap_estim_ini = <fs_field>.

          WHEN 35.
            ls_ricefws-abap_estim = <fs_field>.

          WHEN 36.
            ls_ricefws-abap_desenv = <fs_field>.

          WHEN 37.
            ls_ricefws-po_desenv = <fs_field>.

          WHEN 38.
*            ls_ricefws- = <fs_field>. Revisão Ana

          WHEN 39.
            ls_ricefws-observacoes = <fs_field>.

          WHEN OTHERS.
            EXIT.

        ENDCASE.

      ENDWHILE.

      APPEND ls_ricefws TO lt_ricefws.

    ENDLOOP.

    set_existing_uuid(
      CHANGING
        ct_ricefws = lt_ricefws ).

    rt_return = save_data( it_ricefws = lt_ricefws ).


  ENDMETHOD.

  METHOD get_file_table.

    DATA: lv_filename TYPE string,
          lv_projeto  TYPE string.


    SPLIT iv_slug AT ';' INTO  lv_filename lv_projeto.

    TRY .
        DATA(lo_excel_ref) = NEW cl_fdt_xl_spreadsheet(
          document_name = lv_filename
          xdocument     = is_media_resource-value ).
      CATCH cx_fdt_excel_core INTO DATA(lo_excel_error).
        "Implement suitable error handling here
    ENDTRY .

    lo_excel_ref->if_fdt_doc_spreadsheet~get_worksheet_names(
      IMPORTING
        worksheet_names = DATA(lt_worksheets) ).

    IF NOT lt_worksheets IS INITIAL.

      READ TABLE lt_worksheets INTO DATA(lv_woksheetname) INDEX 1.
      IF sy-subrc IS INITIAL.

        ro_data = lo_excel_ref->if_fdt_doc_spreadsheet~get_itab_from_worksheet(
                                                 lv_woksheetname ).

      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD set_existing_uuid.

    SELECT uuid_ricefw,
           id_ricefw,
           id_gap,
           contador
        FROM ztca_ricefws
        INTO TABLE @DATA(lt_database_ricefws)
        FOR ALL ENTRIES IN @ct_ricefws
        WHERE id_ricefw EQ @ct_ricefws-id_ricefw
        AND   id_gap    EQ @ct_ricefws-id_gap
        AND   contador  EQ @ct_ricefws-contador.

    SORT lt_database_ricefws BY id_ricefw
                                id_gap
                                contador.

    LOOP AT ct_ricefws ASSIGNING FIELD-SYMBOL(<fs_ricefws>).

      READ TABLE lt_database_ricefws ASSIGNING FIELD-SYMBOL(<fs_database_ricefws>) WITH KEY id_ricefw = <fs_ricefws>-id_ricefw
                                                                                            id_gap    = <fs_ricefws>-id_gap
                                                                                            contador  = <fs_ricefws>-contador BINARY SEARCH.

      CONVERT DATE sy-datum
          TIME sy-uzeit
          INTO TIME STAMP <fs_ricefws>-last_changed_at
          TIME ZONE sy-zonlo.

      <fs_ricefws>-local_last_changed_at = <fs_ricefws>-last_changed_at.
      <fs_ricefws>-last_changed_by = sy-uname.

      IF sy-subrc IS INITIAL.

        <fs_ricefws>-uuid_ricefw = <fs_database_ricefws>-uuid_ricefw.

      ELSE.

        TRY.
            <fs_ricefws>-uuid_ricefw = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_x16_by_version( version = 4 ).
          CATCH cx_uuid_error.
            "handle exception
        ENDTRY.

        <fs_ricefws>-created_at = <fs_ricefws>-last_changed_at.
        <fs_ricefws>-created_by = <fs_ricefws>-last_changed_by.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD get_complexidade.

    CASE iv_field.

      WHEN 'Muito Baixa'.
        rv_complexidade = 1.

      WHEN 'Baixa'.
        rv_complexidade = 2.

      WHEN 'Média'.
        rv_complexidade = 3.

      WHEN 'Alta'.
        rv_complexidade = 4.

      WHEN 'Muito Alta'.
        rv_complexidade = 5.

      WHEN OTHERS.
        rv_complexidade = 0.

    ENDCASE.

  ENDMETHOD.

  METHOD save_data.

    MODIFY ztca_ricefws FROM TABLE it_ricefws.
    IF sy-subrc IS INITIAL.

      COMMIT WORK.
      lt_return = VALUE #( ( id     = gc_msgid
                             number = '001'
                             type   = if_abap_behv_message=>severity-success ) ).

    ELSE.

      ROLLBACK WORK.
      lt_return = VALUE #( ( id     = gc_msgid
                             number = '002'
                             type   = if_abap_behv_message=>severity-error ) ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
