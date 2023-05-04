CLASS lhc_Modulo DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS: BEGIN OF gc_actvt,
                 create TYPE numc2 VALUE '01',
                 update TYPE numc2 VALUE '02',
                 delete TYPE numc2 VALUE '06',
               END OF gc_actvt.

    METHODS get_authorizations FOR AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Modulo RESULT result.
    METHODS validatemodulo FOR VALIDATE ON SAVE
      IMPORTING keys FOR modulo~validatemodulo.

ENDCLASS.

CLASS lhc_Modulo IMPLEMENTATION.

  METHOD get_authorizations.

    DATA: lv_before_image     TYPE abap_bool,
          lv_update_requested TYPE abap_bool,
          lv_delete_requested TYPE abap_bool,
          lv_update_granted   TYPE abap_bool,
          lv_delete_granted   TYPE abap_bool.

    READ ENTITIES OF zi_ca_param_mod IN LOCAL MODE
      ENTITY Modulo
        FIELDS ( Modulo ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_modulos)
      FAILED failed.

    CHECK lt_modulos IS NOT INITIAL.

    SELECT FROM ztca_param_mod
      FIELDS modulo
      FOR ALL ENTRIES IN @lt_modulos
      WHERE modulo EQ @lt_modulos-Modulo
      ORDER BY PRIMARY KEY
      INTO TABLE @DATA(lt_modulos_before_image).

    lv_update_requested   = COND #( WHEN  requested_authorizations-%update            = if_abap_behv=>mk-on
                                      OR  requested_authorizations-%assoc-_Parametros = if_abap_behv=>mk-on
                                    THEN abap_true ELSE abap_false ).

*    lv_delete_requested   = COND #( WHEN requested_authorizations-%delete = if_abap_behv=>mk-on
*                                    THEN abap_true ELSE abap_false ).

    SORT lt_modulos_before_image BY modulo.

    LOOP AT lt_modulos ASSIGNING FIELD-SYMBOL(<fs_modulo>).

      lv_update_granted = lv_delete_granted = abap_false.

      READ TABLE lt_modulos_before_image TRANSPORTING NO FIELDS
           WITH KEY modulo = <fs_modulo>-Modulo BINARY SEARCH.

      lv_before_image = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).

      IF lv_update_requested = abap_true.

        IF lv_before_image = abap_true.

          AUTHORITY-CHECK OBJECT 'Z_PARAM'
           ID 'Z_MODULO' DUMMY
           ID 'ACTVT'  FIELD gc_actvt-update.

          IF sy-subrc IS NOT INITIAL.

            APPEND VALUE #( %tky = <fs_modulo>-%tky
                            %msg = NEW zclca_cm_param_mod( iv_severity = if_abap_behv_message=>severity-error
                                                           iv_textid   = zclca_cm_param_mod=>gc_data_check )
                          ) TO reported-modulo.

            lv_update_granted = abap_false.

          ELSE.

            lv_update_granted = abap_true.

          ENDIF.

        ELSE.

          AUTHORITY-CHECK OBJECT 'Z_PARAM'
           ID 'Z_MODULO' DUMMY
           ID 'ACTVT'  FIELD gc_actvt-create.

          IF sy-subrc IS NOT INITIAL.

            APPEND VALUE #(  %tky = <fs_modulo>-%tky
                             %msg = NEW zclca_cm_param_mod( iv_severity = if_abap_behv_message=>severity-error
                                                            iv_textid   = zclca_cm_param_mod=>gc_data_check )
                          ) TO reported-modulo.

            lv_update_granted = abap_false.

          ELSE.

            lv_update_granted = abap_true.

          ENDIF.

        ENDIF.

      ENDIF.

      IF lv_delete_requested = abap_true.

        AUTHORITY-CHECK OBJECT 'Z_PARAM'
           ID 'Z_MODULO' DUMMY
           ID 'ACTVT'  FIELD gc_actvt-delete.

        IF sy-subrc IS NOT INITIAL.
          APPEND VALUE #(  %tky        = <fs_modulo>-%tky
                           %msg        = NEW zclca_cm_param_mod( iv_severity = if_abap_behv_message=>severity-error
                                                                 iv_textid   = zclca_cm_param_mod=>gc_data_check )
                        ) TO reported-modulo.
          lv_update_granted = abap_false.
        ELSE.

          lv_delete_granted = abap_true.

        ENDIF.
      ENDIF.

      APPEND VALUE #( %tky = <fs_modulo>-%tky

                      %update              = COND #( WHEN lv_update_granted = abap_true
                                                        THEN if_abap_behv=>auth-allowed
                                                        ELSE if_abap_behv=>auth-unauthorized )

                      %assoc-_parametros   = COND #( WHEN lv_update_granted = abap_true
                                                        THEN if_abap_behv=>auth-allowed
                                                        ELSE if_abap_behv=>auth-unauthorized )

*                      %delete              = COND #( WHEN lv_delete_granted = abap_true
*                                                        THEN if_abap_behv=>auth-allowed
*                                                        ELSE if_abap_behv=>auth-unauthorized )
                    )
        TO result.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateModulo.

    CONSTANTS: lc_state_area TYPE string VALUE 'VALIDATE_MODULO'.

    READ ENTITIES OF zi_ca_param_mod IN LOCAL MODE
      ENTITY Modulo
        FIELDS ( Modulo ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_modulos).

    CHECK lt_modulos IS NOT INITIAL.

    LOOP AT lt_modulos ASSIGNING FIELD-SYMBOL(<fs_modulo>).

      APPEND VALUE #( %tky        = <fs_modulo>-%tky
                      %state_area = lc_state_area  ) TO reported-modulo.

      AUTHORITY-CHECK OBJECT 'Z_PARAM'
         ID 'Z_MODULO' DUMMY
         ID 'ACTVT'  FIELD gc_actvt-create.

      IF sy-subrc IS NOT INITIAL.

        APPEND VALUE #( %tky = <fs_modulo>-%tky ) TO failed-modulo.

        APPEND VALUE #( %tky        = <fs_modulo>-%tky
                        %state_area = lc_state_area
                        %msg        = NEW zclca_cm_param_mod( iv_severity = if_abap_behv_message=>severity-error
                                                              iv_textid   = zclca_cm_param_mod=>gc_data_check )

                        %element-Modulo = if_abap_behv=>mk-on ) TO reported-modulo.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
