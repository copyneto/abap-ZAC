CLASS zclca_exit_conv_cunit DEFINITION
  PUBLIC
  INHERITING FROM zclca_exit_conv
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS if_sadl_exit_calc_element_read~calculate
        REDEFINITION .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLCA_EXIT_CONV_CUNIT IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

* --------------------------------------------------------------------
* Indica nome da exit de conversão
* --------------------------------------------------------------------
    me->set_convexit( EXPORTING iv_convexit = 'CUNIT' ).

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
