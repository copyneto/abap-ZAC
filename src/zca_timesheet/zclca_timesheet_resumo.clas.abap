class ZCLCA_TIMESHEET_RESUMO definition
  public
  final
  create public .

public section.

  interfaces IF_RAP_QUERY_PROVIDER .
  interfaces IF_RAP_QUERY_FILTER .
protected section.
private section.

  types:
    BEGIN OF ty_filters, " Tipo para ranges
      contrato TYPE if_rap_query_filter=>tt_range_option,
      tarefa   TYPE if_rap_query_filter=>tt_range_option,
      usuario  TYPE if_rap_query_filter=>tt_range_option,
      ano      TYPE if_rap_query_filter=>tt_range_option,
      dtapro   TYPE if_rap_query_filter=>tt_range_option,
    END OF ty_filters .
  types:
    ty_relat TYPE STANDARD TABLE OF zc_ca_timesheet_res WITH EMPTY KEY .

  data GS_RANGE type TY_FILTERS .

  methods SET_FILTERS
    importing
      !IT_FILTERS type IF_RAP_QUERY_FILTER=>TT_NAME_RANGE_PAIRS .
  methods BUILD
    exporting
      !ET_RELAT type TY_RELAT .
ENDCLASS.



CLASS ZCLCA_TIMESHEET_RESUMO IMPLEMENTATION.


  METHOD build.

    DATA: lt_result TYPE STANDARD TABLE OF zc_ca_timesheet_res,
          "ls_data   TYPE zi_ca_timesheet,
          ls_result TYPE zc_ca_timesheet_res,
          lv_time   TYPE c LENGTH 20,
          lv_r_time TYPE sy-uzeit.

    CHECK gs_range IS NOT INITIAL.

    SELECT *
    FROM zi_ca_timesheet
    WHERE contrato IN @gs_range-contrato
    AND tarefa IN @gs_range-tarefa
    AND usuario IN @gs_range-usuario
    AND dtapropriacao IN @gs_range-dtapro
    INTO TABLE @DATA(lt_data).

    SORT lt_data BY dtapropriacao ASCENDING.

    LOOP AT lt_data INTO DATA(ls_data_ref) GROUP BY (
                                        contrato  = ls_data_ref-contrato
                                        tarefa    = ls_data_ref-tarefa
                                        usuario   = ls_data_ref-usuario
                                        size      = GROUP SIZE
                                        index     = GROUP INDEX )
    INTO DATA(lt_grp).
      CLEAR: ls_result.
      LOOP AT GROUP lt_grp INTO DATA(ls_grp).
        MOVE-CORRESPONDING ls_grp TO ls_result.

        ls_result-d25 = ls_result-d24 = ls_result-d23 =
        ls_result-d22 = ls_result-d21 = ls_result-d20 =
        ls_result-d19 = ls_result-d18 = ls_result-d17 =
        ls_result-d16 = ls_result-d15 = ls_result-d14 =
        ls_result-d13 = ls_result-d12 = ls_result-d11 =
        ls_result-d10 = ls_result-d09 = ls_result-d08 =
        ls_result-d07 = ls_result-d06 = ls_result-d05 =
        ls_result-d04 = ls_result-d03 = ls_result-d02 =
        ls_result-d01 = ls_result-d31 = ls_result-d30 =
        ls_result-d29 = ls_result-d28 = ls_result-d27 = ls_result-d26 = '00:00:00'.
        "APPEND ls_result TO lt_result.
        COLLECT ls_result INTO lt_result.
      ENDLOOP.

    ENDLOOP.

    LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>).

      LOOP AT lt_data INTO DATA(ls_data) WHERE  contrato EQ <fs_result>-contrato
                                          AND   tarefa EQ <fs_result>-tarefa
                                          AND   usuario EQ <fs_result>-usuario
                                          AND   dtapropriacao IS NOT INITIAL
                                         GROUP BY (
                                          dtapropriacao = ls_data-dtapropriacao
                                          size          = GROUP SIZE
                                          index         = GROUP INDEX )
                                         REFERENCE INTO DATA(lt_grp_dat).

        CLEAR: lv_time, lv_r_time.

        LOOP AT GROUP lt_grp_dat INTO DATA(ls_grp_dat).
          lv_time = lv_time + ls_grp_dat-hrinformada.
        ENDLOOP.

        lv_r_time+0(2) = floor( lv_time / 3600 ).
        lv_r_time+2(2) = floor( ( lv_time MOD 3600 ) / 60 ).
        lv_r_time+4(2) = ( lv_time MOD 3600 ) MOD 60.
        lv_time = |{ lv_r_time(2) }:{ lv_r_time+2(2) }:{ lv_r_time+4(2) }|.

        CASE lt_grp_dat->dtapropriacao+6(2).
          WHEN '26'. <fs_result>-d26 = lv_time.
          WHEN '27'. <fs_result>-d27 = lv_time.
          WHEN '28'. <fs_result>-d28 = lv_time.
          WHEN '29'. <fs_result>-d29 = lv_time.
          WHEN '30'. <fs_result>-d30 = lv_time.
          WHEN '31'. <fs_result>-d31 = lv_time.
          WHEN '01'. <fs_result>-d01 = lv_time.
          WHEN '02'. <fs_result>-d02 = lv_time.
          WHEN '03'. <fs_result>-d03 = lv_time.
          WHEN '04'. <fs_result>-d04 = lv_time.
          WHEN '05'. <fs_result>-d05 = lv_time.
          WHEN '06'. <fs_result>-d06 = lv_time.
          WHEN '07'. <fs_result>-d07 = lv_time.
          WHEN '08'. <fs_result>-d08 = lv_time.
          WHEN '09'. <fs_result>-d09 = lv_time.
          WHEN '10'. <fs_result>-d10 = lv_time.
          WHEN '11'. <fs_result>-d11 = lv_time.
          WHEN '12'. <fs_result>-d12 = lv_time.
          WHEN '13'. <fs_result>-d13 = lv_time.
          WHEN '14'. <fs_result>-d14 = lv_time.
          WHEN '15'. <fs_result>-d15 = lv_time.
          WHEN '16'. <fs_result>-d16 = lv_time.
          WHEN '17'. <fs_result>-d17 = lv_time.
          WHEN '18'. <fs_result>-d18 = lv_time.
          WHEN '19'. <fs_result>-d19 = lv_time.
          WHEN '20'. <fs_result>-d20 = lv_time.
          WHEN '21'. <fs_result>-d21 = lv_time.
          WHEN '22'. <fs_result>-d22 = lv_time.
          WHEN '23'. <fs_result>-d23 = lv_time.
          WHEN '24'. <fs_result>-d24 = lv_time.
          WHEN '25'. <fs_result>-d25 = lv_time.
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.

      ENDLOOP.

    ENDLOOP.

    et_relat = CORRESPONDING #( lt_result ).

  ENDMETHOD.


  method IF_RAP_QUERY_FILTER~GET_AS_RANGES.
    RETURN.
  endmethod.


  method IF_RAP_QUERY_FILTER~GET_AS_SQL_STRING.
    RETURN.
  endmethod.


  method IF_RAP_QUERY_PROVIDER~SELECT.
* ---------------------------------------------------------------------------
* Recupera informações de entidade, paginação, etc
* ---------------------------------------------------------------------------
    DATA(lv_top)      = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)     = io_request->get_paging( )->get_offset( ).
    DATA(lv_max_rows) = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited THEN 0 ELSE lv_top ).

* ---------------------------------------------------------------------------
* Recupera e seta filtros de seleção
* ---------------------------------------------------------------------------
    TRY.
        me->set_filters( EXPORTING it_filters = io_request->get_filter( )->get_as_ranges( ) ). "#EC CI_CONV_OK
      CATCH cx_rap_query_filter_no_range INTO DATA(lo_ex_filter).
        DATA(lv_exp_msg) = lo_ex_filter->get_longtext( ).
    ENDTRY.

* ---------------------------------------------------------------------------
* Monta relatório
* ---------------------------------------------------------------------------
    DATA lt_result TYPE STANDARD TABLE OF zc_ca_timesheet_res WITH EMPTY KEY.
    me->build( IMPORTING et_relat = lt_result ).

** ---------------------------------------------------------------------------
** Realiza as agregações de acordo com as annotatios na custom entity
** ---------------------------------------------------------------------------
    DATA(lt_req_elements) = io_request->get_requested_elements( ).

    DATA(lt_aggr_element) = io_request->get_aggregation( )->get_aggregated_elements( ).
    IF lt_aggr_element IS NOT INITIAL.
      LOOP AT lt_aggr_element ASSIGNING FIELD-SYMBOL(<fs_aggr_element>).
        DELETE lt_req_elements WHERE table_line = <fs_aggr_element>-result_element. "#EC CI_STDSEQ
        DATA(lv_aggregation) = |{ <fs_aggr_element>-aggregation_method }( { <fs_aggr_element>-input_element } ) as { <fs_aggr_element>-result_element }|.
        APPEND lv_aggregation TO lt_req_elements.
      ENDLOOP.
    ENDIF.

    DATA(lv_req_elements)  = concat_lines_of( table = lt_req_elements sep = ',' ).

    DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
    DATA(lv_grouping) = concat_lines_of(  table = lt_grouped_element sep = ',' ).

    DATA(lo_filter) = io_request->get_filter( ).
    DATA(lv_filtro) = lo_filter->get_as_sql_string( ).

    SELECT (lv_req_elements) FROM @lt_result AS dados
                             WHERE (lv_filtro)
                             GROUP BY (lv_grouping)
                             INTO CORRESPONDING FIELDS OF TABLE @lt_result.

* ---------------------------------------------------------------------------
* Realiza ordenação de acordo com parâmetros de entrada
* ---------------------------------------------------------------------------
    DATA(lt_requested_sort) = io_request->get_sort_elements( ).
    IF lines( lt_requested_sort ) > 0.
      DATA(lt_sort) = VALUE abap_sortorder_tab( FOR ls_sort IN lt_requested_sort ( name = ls_sort-element_name descending = ls_sort-descending ) ).
      SORT lt_result BY (lt_sort).
    ENDIF.

* ---------------------------------------------------------------------------
* Controla paginação (Adiciona registros de 20 em 20 )
* ---------------------------------------------------------------------------
    DATA(lt_result_page) = lt_result[].
    lt_result_page = VALUE #( FOR ls_result IN lt_result FROM ( lv_skip + 1 ) TO ( lv_skip + lv_max_rows ) ( ls_result ) ).

* ---------------------------------------------------------------------------
* Exibe registros
* ---------------------------------------------------------------------------
    IF io_request->is_total_numb_of_rec_requested(  ).
      io_response->set_total_number_of_records( CONV #( lines( lt_result[] ) ) ).
    ENDIF.

** ---------------------------------------------------------------------------
** Verifica se informação foi solicitada
** ---------------------------------------------------------------------------
    IF io_request->is_data_requested( ).
      io_response->set_data( lt_result_page[] ).
    ENDIF.
  endmethod.


  METHOD set_filters.
    CHECK it_filters[] IS NOT INITIAL.

    LOOP AT it_filters ASSIGNING FIELD-SYMBOL(<fs_filters>).

      CASE <fs_filters>-name.
        WHEN 'CONTRATO'.
          gs_range-contrato = VALUE #( BASE gs_range-contrato ( LINES OF <fs_filters>-range ) ).

        WHEN 'TAREFA'.
          gs_range-tarefa = VALUE #( BASE gs_range-tarefa ( LINES OF <fs_filters>-range ) ).

        WHEN 'USUARIO'.
          gs_range-usuario = VALUE #( BASE gs_range-usuario ( LINES OF <fs_filters>-range ) ).

        WHEN 'DTAPROPRIACAO'.
          gs_range-dtapro = VALUE #( BASE gs_range-dtapro ( LINES OF <fs_filters>-range ) ).

        WHEN OTHERS.
          CONTINUE.
      ENDCASE.

    ENDLOOP.

    "sempre fixo o filtro de data
    DATA(lv_anoatual) = sy-datum(4).
    DATA(lv_anoutilizar) = sy-datum(4).
    DATA(lv_mesatual) = sy-datum+4(2).
    DATA(lv_mesanterior) = sy-datum+4(2).
    lv_mesanterior = lv_mesanterior - 1.

    IF lv_anoatual EQ 1.
      lv_mesanterior = 12.
      lv_anoutilizar = lv_anoutilizar - 1.
    ENDIF.

    IF gs_range-dtapro IS INITIAL.
      gs_range-dtapro = VALUE #( BASE gs_range-dtapro ( sign = 'I' option = 'BT' low = |{ lv_anoutilizar }{ lv_mesanterior }26| high = |{ lv_anoatual }{ lv_mesatual }25| ) ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
