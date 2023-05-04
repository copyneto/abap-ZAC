CLASS lcl_projetos DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validachave FOR VALIDATE ON SAVE
      IMPORTING keys FOR projetos~validachave.

    METHODS get_authorizations FOR AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR projetos RESULT result.

ENDCLASS.

CLASS lcl_projetos IMPLEMENTATION.

  METHOD validachave.

    READ ENTITIES OF zi_ca_projetos IN LOCAL MODE
      ENTITY projetos
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_projetos)
      FAILED DATA(ls_failed).

    IF ls_failed-projetos IS NOT INITIAL.
      RETURN.
    ENDIF.

    SELECT cliente,
           projeto
      FROM ztca_projetos
      INTO TABLE @DATA(lt_projetos_db)
      FOR ALL ENTRIES IN @lt_projetos
      WHERE cliente EQ @lt_projetos-cliente
        AND projeto EQ @lt_projetos-projeto.
    SORT lt_projetos_db BY cliente projeto.

    LOOP AT lt_projetos ASSIGNING FIELD-SYMBOL(<fs_projetos>).
      APPEND VALUE #(  %tky = <fs_projetos>-%tky %state_area = 'CRIACAO_PROJETO' ) TO reported-projetos.

      READ TABLE lt_projetos_db TRANSPORTING NO FIELDS
        WITH KEY cliente = <fs_projetos>-cliente
                 projeto = <fs_projetos>-projeto BINARY SEARCH.
      IF sy-subrc EQ 0.
        APPEND VALUE #( %tky = <fs_projetos>-%tky ) TO failed-projetos.

        APPEND VALUE #(
          %tky        = <fs_projetos>-%tky
          %state_area = 'CRIACAO_PROJETO'
          %msg        =  new_message(
            id       = 'ZCA_CONTROLE_RICEFW'
            number   = '001'
            severity = if_abap_behv_message=>severity-error
            v1       = |{ <fs_projetos>-projeto }|
            v2       = |{ <fs_projetos>-cliente }|
          )
          %element-cliente   = if_abap_behv=>mk-on
          %element-projeto = if_abap_behv=>mk-on
        ) TO reported-projetos.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_authorizations.

    READ ENTITIES OF zi_ca_projetos IN LOCAL MODE
      ENTITY projetos
        FIELDS ( projeto ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_projetos)
      FAILED failed.

    LOOP AT lt_projetos ASSIGNING FIELD-SYMBOL(<fs_projetos>).
      APPEND VALUE #( %tky            = <fs_projetos>-%tky
                      %update         = if_abap_behv=>auth-allowed
                      %delete         = if_abap_behv=>auth-allowed
                      %assoc-_ricefws = if_abap_behv=>auth-allowed
                    ) TO result.
    ENDLOOP.

*  if_abap_behv=>auth-allowed
*  if_abap_behv=>auth-unauthorized

  ENDMETHOD.

ENDCLASS.
