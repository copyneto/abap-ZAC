CLASS zclca_exit_conv DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.

    DATA gv_convexit TYPE convexit .

    METHODS set_convexit
      IMPORTING
        !iv_convexit TYPE convexit .
  PRIVATE SECTION.

    METHODS get_convexit
      EXPORTING
        !ev_convexit TYPE convexit .
    METHODS conversion_exit_output
      IMPORTING
        !iv_convexit TYPE convexit
        !iv_input    TYPE any
      EXPORTING
        !ev_output   TYPE any .
    METHODS conversion_exit_input
      IMPORTING
        !iv_convexit TYPE convexit
        !iv_input    TYPE any
      EXPORTING
        !ev_output   TYPE any .
ENDCLASS.



CLASS ZCLCA_EXIT_CONV IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

    DATA:
      lo_table    TYPE REF TO data,
      lo_tabdescr TYPE REF TO cl_abap_structdescr.

* --------------------------------------------------------------------
* Cria tabela dinâmicamente usando o nome da entidade
* --------------------------------------------------------------------
    CREATE DATA lo_table TYPE (iv_entity).
    ASSIGN lo_table TO FIELD-SYMBOL(<fs_table>).

* --------------------------------------------------------------------
* Recupera campos da entidade
* --------------------------------------------------------------------
    lo_tabdescr   ?= cl_abap_structdescr=>describe_by_data_ref( lo_table ).
    DATA(lt_dfies) = cl_salv_data_descr=>read_structdescr( lo_tabdescr ).

* --------------------------------------------------------------------
* Adiciona todos os campos na busca, menos o campo com exit de conversão
* --------------------------------------------------------------------
    LOOP AT lt_dfies INTO DATA(ls_dfies).
      CHECK NOT line_exists( it_requested_calc_elements[ table_line = ls_dfies-fieldname ] ).
      INSERT CONV string( ls_dfies-fieldname ) INTO TABLE et_Requested_orig_elements[].
    ENDLOOP.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA:
      lo_table    TYPE REF TO data.

    FIELD-SYMBOLS:
      <fs_t_table>  TYPE STANDARD TABLE,
      <fs_s_table>  TYPE any,
      <fs_v_input>  TYPE any,
      <fs_v_output> TYPE any.

* --------------------------------------------------------------------
* Cria tabela dinâmicamente
* --------------------------------------------------------------------
    CREATE DATA lo_table LIKE it_original_data.
    ASSIGN lo_table->* TO <fs_t_table>.
    <fs_t_table> = CORRESPONDING #( it_original_data ).

* --------------------------------------------------------------------
* Recupera exit de conversão
* --------------------------------------------------------------------
    me->get_convexit( IMPORTING ev_convexit = DATA(lv_convexit) ).

* --------------------------------------------------------------------
* Aplica conversão dos campos
* --------------------------------------------------------------------
    LOOP AT <fs_t_table> ASSIGNING <fs_s_table>.

      LOOP AT it_requested_calc_elements INTO DATA(lv_element). "#EC CI_LOOP_INTO_WA #EC CI_NESTED

        " Recupera campo de saída
        ASSIGN COMPONENT lv_element OF STRUCTURE <fs_s_table> TO <fs_v_output>.
        CHECK sy-subrc EQ 0.

        "Recupera campo com o valor original (Terminado com CV)
        DATA(lv_element_cv) = lv_element && 'CV'.

        " Recupera campo de entrada (com valor original)
        ASSIGN COMPONENT lv_element_cv OF STRUCTURE <fs_s_table> TO <fs_v_input>.
        CHECK sy-subrc EQ 0.

        " Aplica conversão
        me->conversion_exit_output( EXPORTING iv_convexit = lv_convexit
                                              iv_input    = <fs_v_input>
                                    IMPORTING ev_output   = <fs_v_output> ).
      ENDLOOP.

    ENDLOOP.

* --------------------------------------------------------------------
* Transfere dados convertidos
* --------------------------------------------------------------------
    ct_calculated_data = CORRESPONDING #( <fs_t_table> ).

  ENDMETHOD.


  METHOD conversion_exit_input.

    FREE: ev_output.

* --------------------------------------------------------------------
* Prepara nome da função e aplica conversão
* --------------------------------------------------------------------
    DATA(lv_funcname) = |CONVERSION_EXIT_{ iv_convexit }_INPUT|.

    TRY.
        CALL FUNCTION lv_funcname
          EXPORTING
            input  = iv_input
          IMPORTING
            output = ev_output.

      CATCH cx_root INTO DATA(lo_root).
    ENDTRY.

  ENDMETHOD.


  METHOD conversion_exit_output.

    FREE: ev_output.

* --------------------------------------------------------------------
* Prepara nome da função e aplica conversão
* --------------------------------------------------------------------
    DATA(lv_funcname) = |CONVERSION_EXIT_{ iv_convexit }_OUTPUT|.

    TRY.
        CALL FUNCTION lv_funcname
          EXPORTING
            input  = iv_input
          IMPORTING
            output = ev_output.

      CATCH cx_root INTO DATA(lo_root).
        DATA(lv_message) = CONV bapi_msg( lo_root->get_longtext( ) ).
    ENDTRY.

  ENDMETHOD.


  METHOD get_convexit.
* --------------------------------------------------------------------
* Recupera exit de conversão
* --------------------------------------------------------------------
    ev_convexit = gv_convexit.

  ENDMETHOD.


  METHOD set_convexit.
* --------------------------------------------------------------------
* Armazena exit de conversão
* --------------------------------------------------------------------
    gv_convexit = iv_convexit.

  ENDMETHOD.
ENDCLASS.
