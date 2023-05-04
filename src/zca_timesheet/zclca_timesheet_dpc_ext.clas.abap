class ZCLCA_TIMESHEET_DPC_EXT definition
  public
  inheriting from ZCLCA_TIMESHEET_DPC
  create public .

public section.

  methods /IWBEP/IF_MGW_APPL_SRV_RUNTIME~CREATE_STREAM
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCLCA_TIMESHEET_DPC_EXT IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_stream.

    TYPES: BEGIN OF ty_entity,
             filename TYPE string,
             message  TYPE string,
           END OF ty_entity.

    DATA: lo_message   TYPE REF TO /iwbep/if_message_container,
          lo_exception TYPE REF TO /iwbep/cx_mgw_busi_exception,
          ls_entity    TYPE ty_entity,
          lv_filename  TYPE string,
          lv_tablename TYPE tablename.

    DATA(lo_timesheet) = NEW zclca_timesheet( ).

    SPLIT iv_slug AT ';' INTO lv_filename lv_tablename.
* ----------------------------------------------------------------------
* Gerencia Botão do aplicativo
* ----------------------------------------------------------------------
    lo_timesheet->upload_file( EXPORTING iv_file         = is_media_resource-value
                                         iv_filename     = lv_filename
                               IMPORTING et_return    = DATA(lt_return) ).

    TRY.
        ls_entity-filename = lv_filename.
        ls_entity-message  = lt_return[ 1 ]-message.
      CATCH cx_root.
    ENDTRY.

* ----------------------------------------------------------------------
* Prepara informações de retorno
* ----------------------------------------------------------------------
    copy_data_to_ref( EXPORTING is_data = ls_entity
                      CHANGING  cr_data = er_entity ).

* ----------------------------------------------------------------------
* Ativa exceção em casos de erro
* ----------------------------------------------------------------------
    IF NOT line_exists( lt_return[ type = 'S' ] ).       "#EC CI_STDSEQ
      lo_message = mo_context->get_message_container( ).
      lo_message->add_messages_from_bapi( it_bapi_messages = lt_return ).
      CREATE OBJECT lo_exception EXPORTING message_container = lo_message.
      RAISE EXCEPTION lo_exception.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
