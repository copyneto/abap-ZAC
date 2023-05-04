class ZCLCA_TIMESHEET_MPC_EXT definition
  public
  inheriting from ZCLCA_TIMESHEET_MPC
  create public .

public section.

  methods DEFINE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCLCA_TIMESHEET_MPC_EXT IMPLEMENTATION.


  method DEFINE.
    super->define( ).

    DATA:
      lo_entity   TYPE REF TO /iwbep/if_mgw_odata_entity_typ,
      lo_property TYPE REF TO /iwbep/if_mgw_odata_property.

    lo_entity = model->get_entity_type( iv_entity_name = 'uploadFile' ).

    IF lo_entity IS BOUND.
      lo_property = lo_entity->get_property( iv_property_name = 'FileName' ).
      lo_property->set_as_content_type( ).
    ENDIF.
  endmethod.
ENDCLASS.
