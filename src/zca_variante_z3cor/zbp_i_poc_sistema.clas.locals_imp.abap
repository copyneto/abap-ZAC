class lhc_sistema definition inheriting from cl_abap_behavior_handler. "#autoformat

  private section.

    methods validatedescricao for validate on save
      importing keys for sistema~validatedescricao.

endclass.

class lhc_sistema implementation.

  method validatedescricao.

    read entities of yi_poc_sistema in local mode
        entity sistema
            fields ( descricao ) with corresponding #( keys )
        result data(descricoes).

    loop at descricoes into data(descricao).

      append value #( %tky        = descricao-%tky
                      %state_area = 'VALIDATE_DESCRICAO' ) to reported-sistema.

      data(lv_len) = strlen( descricao-descricao ).

      if lv_len lt 5.

        append value #( %tky = descricao-%tky ) to failed-sistema.

        append value #( %tky        = descricao-%tky
                        %state_area = 'VALIDATE_DESCRICAO'
                        %msg        = new ycm_rest_m(        severity = if_abap_behv_message=>severity-error
                                                             textid   = ycm_rest_m=>c_data_check )

                        %element-descricao = if_abap_behv=>mk-on ) to reported-sistema.

      endif.

    endloop.

  endmethod.

endclass.
