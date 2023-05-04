CLASS zclca_controle_ricef_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zclca_controle_ricef_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS
      /iwbep/if_mgw_appl_srv_runtime~create_stream
        REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclca_controle_ricef_dpc_ext IMPLEMENTATION.

  METHOD /iwbep/if_mgw_appl_srv_runtime~create_stream.

    DATA: lo_message   TYPE REF TO /iwbep/if_message_container,
          lo_exception TYPE REF TO /iwbep/cx_mgw_busi_exception.

    DATA(lo_excel_import) = NEW zclca_import_excel_ricefw( ).

    DATA(lt_return) = lo_excel_import->execute(
      is_media_resource = is_media_resource
      iv_slug           = iv_slug ).

    lo_message = mo_context->get_message_container( ).
    lo_message->add_messages_from_bapi( it_bapi_messages = lt_return ).
    CREATE OBJECT lo_exception EXPORTING message_container = lo_message.
    RAISE EXCEPTION lo_exception.


  ENDMETHOD.

ENDCLASS.
