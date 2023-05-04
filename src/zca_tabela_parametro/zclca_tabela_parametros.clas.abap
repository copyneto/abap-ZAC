"!<p>Essa classe é utilizada para obter os valores dos parâmetros cadastrados na <strong>Tabela de Parâmetros</strong>
"!<p><strong>Autor:</strong> Alexsander Haas - Meta</p>
"!<p><strong>Data:</strong> 20/07/2021</p>
class ZCLCA_TABELA_PARAMETROS definition
  public
  final
  create public .

public section.

      "! Obtém os valores dos parâmetros da Tabela de Parâmetros e os retorna em RANGE
      "! @parameter iv_modulo | Módulo cadastrado
      "! @parameter iv_chave1 | Chave1 cadastrado
      "! @parameter iv_chave2 | Chave2 cadastrado
      "! @parameter iv_chave3 | Chave3 cadastrado
      "! @parameter et_range  | Valores dos parâmetros
  methods M_GET_RANGE
    importing
      !IV_MODULO type ZTCA_PARAM_PAR-MODULO
      !IV_CHAVE1 type ZTCA_PARAM_PAR-CHAVE1
      !IV_CHAVE2 type ZTCA_PARAM_PAR-CHAVE2 optional
      !IV_CHAVE3 type ZTCA_PARAM_PAR-CHAVE3 optional
    exporting
      !ET_RANGE type TABLE
    raising
      ZCXCA_TABELA_PARAMETROS .
  methods M_GET_SINGLE
    importing
      !IV_MODULO type ZTCA_PARAM_PAR-MODULO
      !IV_CHAVE1 type ZTCA_PARAM_PAR-CHAVE1
      !IV_CHAVE2 type ZTCA_PARAM_PAR-CHAVE2 optional
      !IV_CHAVE3 type ZTCA_PARAM_PAR-CHAVE3 optional
    exporting
      !EV_PARAM type ANY
    raising
      ZCXCA_TABELA_PARAMETROS .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLCA_TABELA_PARAMETROS IMPLEMENTATION.


  METHOD m_get_range.

    CONSTANTS: lc_sign   TYPE char4 VALUE 'SIGN',
               lc_option TYPE char6 VALUE 'OPTION',
               lc_low    TYPE char3 VALUE 'LOW',
               lc_high   TYPE char4 VALUE 'HIGH'.

    DATA lv_ref TYPE REF TO data.

    FIELD-SYMBOLS <fs_field> TYPE any.

    CREATE DATA lv_ref LIKE LINE OF et_range.

    ASSIGN lv_ref->* TO FIELD-SYMBOL(<fs_range>).

    SELECT sign,
           opt,
           low,
           high
      FROM ztca_param_val
     WHERE modulo EQ @iv_modulo
       AND chave1 EQ @iv_chave1
       AND chave2 EQ @iv_chave2
       AND chave3 EQ @iv_chave3
      INTO TABLE @DATA(lt_param_val).

    IF sy-subrc IS NOT INITIAL.
      RAISE EXCEPTION NEW zcxca_tabela_parametros( iv_textid = zcxca_tabela_parametros=>gc_parameter_not_found
                                                   iv_param  = iv_chave1 ).
    ENDIF.

    REFRESH et_range.

    LOOP AT lt_param_val ASSIGNING FIELD-SYMBOL(<fs_param_val>).

      ASSIGN COMPONENT lc_sign OF STRUCTURE <fs_range> TO <fs_field>.

      IF <fs_field> IS ASSIGNED.
        <fs_field> = <fs_param_val>-sign.
      ENDIF.

      ASSIGN COMPONENT lc_option OF STRUCTURE <fs_range> TO <fs_field>.
      IF <fs_field> IS ASSIGNED.
        <fs_field> = <fs_param_val>-opt.
      ENDIF.

      ASSIGN COMPONENT lc_low OF STRUCTURE <fs_range> TO <fs_field>.
      IF <fs_field> IS ASSIGNED.
        <fs_field> = <fs_param_val>-low.
      ENDIF.

      ASSIGN COMPONENT lc_high OF STRUCTURE <fs_range> TO <fs_field>.
      IF <fs_field> IS ASSIGNED.
        <fs_field> = <fs_param_val>-high.
      ENDIF.

      APPEND <fs_range> TO et_range.

      CLEAR <fs_range>.

    ENDLOOP.

  ENDMETHOD.


  METHOD m_get_single.

    SELECT SINGLE low
      FROM ztca_param_val
      INTO @DATA(lv_low)
     WHERE modulo EQ @iv_modulo
       AND chave1 EQ @iv_chave1
       AND chave2 EQ @iv_chave2
       AND chave3 EQ @iv_chave3.

    IF sy-subrc IS NOT INITIAL.

      RAISE EXCEPTION NEW zcxca_tabela_parametros(
        iv_textid = zcxca_tabela_parametros=>gc_parameter_not_found
        iv_param  = iv_chave1
      ).

    ENDIF.

    CLEAR: ev_param.

    ev_param = lv_low.

  ENDMETHOD.
ENDCLASS.
