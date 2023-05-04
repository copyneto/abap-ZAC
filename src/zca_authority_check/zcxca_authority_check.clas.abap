CLASS zcxca_authority_check DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_dyn_msg.
    INTERFACES if_t100_message.

    CONSTANTS:
      BEGIN OF gc_create,
        msgid TYPE symsgid VALUE 'ZCA_AUTHORITY_CHECK',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_create,

       BEGIN OF gc_update,
        msgid TYPE symsgid VALUE 'ZCA_AUTHORITY_CHECK',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_update,

      BEGIN OF gc_delete,
        msgid TYPE symsgid VALUE 'ZCA_AUTHORITY_CHECK',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_delete,

      BEGIN OF gc_range_empresa,
        msgid TYPE symsgid VALUE 'ZCA_AUTHORITY_CHECK',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_range_empresa.

    METHODS constructor
      IMPORTING
        severity  TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCXCA_AUTHORITY_CHECK IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    CLEAR me->textid.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

     me->if_abap_behv_message~m_severity = severity.

  ENDMETHOD.
ENDCLASS.
