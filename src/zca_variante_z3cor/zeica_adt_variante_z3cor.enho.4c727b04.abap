"Name: \PR:CL_SATC_ADT_RES_ATC_RUNS======CP\TY:ABSTRACT_HANDLER\ME:GET_DEFAULT_PROJECT_PARAMETERS\SE:END\EI
ENHANCEMENT 0 ZEICA_ADT_VARIANTE_Z3COR.
  IF result->get_check_profile_name( ) EQ 'Z3COR'.
    result->set_analyse_generated_code( abap_true ).
  ENDIF.
ENDENHANCEMENT.
