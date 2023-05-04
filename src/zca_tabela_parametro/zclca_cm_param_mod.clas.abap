CLASS zclca_cm_param_mod DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS: BEGIN OF gc_data_check,
                 msgid TYPE symsgid VALUE 'ZCA_TAB_PARAM',
                 msgno TYPE symsgno VALUE '001',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF gc_data_check.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    METHODS constructor
      IMPORTING
        iv_severity TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        iv_textid   LIKE if_t100_message=>t100key OPTIONAL
        iv_previous TYPE REF TO cx_root OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLCA_CM_PARAM_MOD IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = iv_previous.
    CLEAR me->textid.

    IF iv_textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = iv_textid.
    ENDIF.

    me->if_abap_behv_message~m_severity = iv_severity.

  ENDMETHOD.
ENDCLASS.
