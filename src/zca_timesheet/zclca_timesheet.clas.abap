class ZCLCA_TIMESHEET definition
  public
  final
  create public .

public section.

  methods UPLOAD_FILE
    importing
      !IV_FILE type XSTRING
      !IV_FILENAME type STRING
    exporting
      !ET_RETURN type BAPIRET2_T .
protected section.
private section.
ENDCLASS.



CLASS ZCLCA_TIMESHEET IMPLEMENTATION.


  METHOD upload_file.

    DATA: lt_file       TYPE TABLE OF ztca_timesheet.
    DATA: lt_timesheet  TYPE TABLE OF ztca_timesheet.
    DATA: ls_timesheet  TYPE ztca_timesheet.
* ---------------------------------------------------------------------------
* Converte arquivo excel para tabela
* ---------------------------------------------------------------------------
    DATA(lo_excel) = NEW zclca_excel( iv_filename = iv_filename
                                      iv_file     = iv_file ).
    lo_excel->gv_quant = abap_true.
    lo_excel->get_sheet( IMPORTING et_return = DATA(lt_return)              " Ignorar validação durante carga
                         CHANGING  ct_table  = lt_file[] ).

    IF line_exists( lt_return[ number = '008' ] ) OR line_exists( lt_return[ number = '009' ] ).
      et_return = lt_return.
      RETURN.
    ENDIF.

* ---------------------------------------------------------------------------
* Prepara dados para salvar
* ---------------------------------------------------------------------------
    GET TIME STAMP FIELD DATA(lv_timestamp).

    LOOP AT lt_file ASSIGNING FIELD-SYMBOL(<fs_file>).
      CLEAR: ls_timesheet.
      MOVE-CORRESPONDING <fs_file> TO ls_timesheet.

      TRY.
          ls_timesheet-guid = cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error.
      ENDTRY.

      ls_timesheet-created_by = sy-uname.
      APPEND ls_timesheet TO lt_timesheet.

    ENDLOOP.

    IF lt_timesheet IS NOT INITIAL.
      MODIFY ztca_timesheet FROM TABLE lt_timesheet.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
