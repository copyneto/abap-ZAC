class ZCLCA_CDS_CFOP definition
  public
  final
  create public .

public section.

  interfaces IF_SADL_EXIT .
  interfaces IF_SADL_EXIT_CALC_ELEMENT_READ .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLCA_CDS_CFOP IMPLEMENTATION.


  METHOD IF_SADL_EXIT_CALC_ELEMENT_READ~GET_CALCULATION_INFO.

    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_element>).
          APPEND 'CFOP1' TO et_requested_orig_elements.
          APPEND 'TEXT' TO et_requested_orig_elements.
    ENDLOOP..

  ENDMETHOD.


  method IF_SADL_EXIT_CALC_ELEMENT_READ~CALCULATE.

    DATA: lt_original_data TYPE STANDARD TABLE OF ZI_SD_CFOP_ENTITY WITH DEFAULT KEY.

          lt_original_data = CORRESPONDING #( it_original_data ).


    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_data>).

     CALL FUNCTION 'CONVERSION_EXIT_CFOBR_OUTPUT'
        EXPORTING INPUT = <fs_data>-cfop1
        IMPORTING output =  <fs_data>-Cfop.

    endloop.

    ct_calculated_data = CORRESPONDING #(  lt_original_data ).

  endmethod.
ENDCLASS.
