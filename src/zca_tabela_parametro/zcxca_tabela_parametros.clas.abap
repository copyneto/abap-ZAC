CLASS zcxca_tabela_parametros DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    DATA:
      "! Parâmetro a exibir na mensagem da exceção
      gv_param    TYPE ztca_param_val-chave1.

    CONSTANTS:
      "! Mensagem: Parâmetro & não foi cadastrado no Aplicativo Tabela de Parâmetros.
      BEGIN OF gc_parameter_not_found,
        msgid TYPE symsgid VALUE 'ZCA_TAB_PARAM',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'GV_PARAM',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_parameter_not_found.

    METHODS constructor
      IMPORTING
        iv_textid   LIKE if_t100_message=>t100key OPTIONAL
        iv_previous LIKE previous OPTIONAL
        iv_param    TYPE ztca_param_val-chave1 OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCXCA_TABELA_PARAMETROS IMPLEMENTATION.


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

    me->gv_param = iv_param.

  ENDMETHOD.
ENDCLASS.
