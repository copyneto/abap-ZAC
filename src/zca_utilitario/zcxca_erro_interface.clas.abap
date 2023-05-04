"!<p>Classe de exceção para a interface com o sistema MES</p>
"!<p><strong>Autor:</strong> Heitor Alves</p>
"!<p><strong>Data:</strong> 23 de dez de 2021</p>
CLASS zcxca_erro_interface DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    "! @parameter textid |Erro apontado pela exceção
    "! @parameter previous |Erro anterior (utilizado para a propagação de erros)
    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCXCA_ERRO_INTERFACE IMPLEMENTATION.


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
  ENDMETHOD.
ENDCLASS.
