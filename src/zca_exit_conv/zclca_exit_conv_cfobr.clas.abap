class ZCLCA_EXIT_CONV_CFOBR definition
  public
  inheriting from ZCLCA_EXIT_CONV
  final
  create public .

public section.

  methods IF_SADL_EXIT_CALC_ELEMENT_READ~CALCULATE
    redefinition .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLCA_EXIT_CONV_CFOBR IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

* --------------------------------------------------------------------
* Indica nome da exit de conversão
* --------------------------------------------------------------------
    me->set_convexit( EXPORTING iv_convexit = 'CFOBR' ).

* --------------------------------------------------------------------
* Chama processo de conversão
* --------------------------------------------------------------------
    TRY.
        CALL METHOD super->if_sadl_exit_calc_element_read~calculate
          EXPORTING
            it_original_data           = it_original_data
            it_requested_calc_elements = it_requested_calc_elements
          CHANGING
            ct_calculated_data         = ct_calculated_data.

      CATCH cx_sadl_exit.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
