CLASS lcl_zeica_atc_variante_z3cor DEFINITION DEFERRED.
CLASS cl_satc_ac_transport_check DEFINITION LOCAL FRIENDS lcl_zeica_atc_variante_z3cor.
CLASS lcl_zeica_atc_variante_z3cor DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA obj TYPE REF TO lcl_zeica_atc_variante_z3cor. "#EC NEEDED
    DATA core_object TYPE REF TO cl_satc_ac_transport_check . "#EC NEEDED
 INTERFACES  IOW_ZEICA_ATC_VARIANTE_Z3COR.
    METHODS:
      constructor IMPORTING core_object
                              TYPE REF TO cl_satc_ac_transport_check OPTIONAL.
ENDCLASS.
CLASS lcl_zeica_atc_variante_z3cor IMPLEMENTATION.
  METHOD constructor.
    me->core_object = core_object.
  ENDMETHOD.

  METHOD iow_zeica_atc_variante_z3cor~_create_atc_project.
*"------------------------------------------------------------------------*
*" Declaration of Overwrite-method, do not insert any comments here please!
*"
*"methods _CREATE_ATC_PROJECT
*"  importing
*"    !I_TRANSPORT_ID type TRKORR
*"    !I_WORKLIST_ID type SATC_D_ID optional
*"    !I_R3TR_KEYS type SATC_T_R3TR_KEYS
*"  exporting
*"    !E_PROJECT_HANDLE type ref to IF_SATC_MD_PROJECT
*"  exceptions
*"    CHECK_ERROR .
*"------------------------------------------------------------------------*

    CLEAR e_project_handle.

    DATA(key_iterator) = NEW cl_satc_ac_iterate_fixed_keys( ).
    key_iterator->set_object_keys( i_r3tr_keys ).

    " Get checks
    IF cl_satc_ac_fixed_config=>use_code_inspector_as_flavor( ) = abap_true.
      DATA(check_profile) = core_object->_get_ci_check_variant( ).
    ELSE.
      core_object->_get_check_ids( IMPORTING  e_check_ids     = DATA(check_ids)
                                              e_check_profile = DATA(checkman_profile)
                                   EXCEPTIONS check_error     = 1 ).
      IF sy-subrc <> 0.
        RAISE check_error.
      ENDIF.

      check_profile = checkman_profile.
    ENDIF.

    DATA: called_from_location TYPE i.
    IF i_worklist_id IS INITIAL.
      called_from_location = if_satc_badi_trnsprt_chk_ctrl=>c_badi_called_from_location-sap_gui.
    ELSE.
      called_from_location = if_satc_badi_trnsprt_chk_ctrl=>c_badi_called_from_location-adt_release.
    ENDIF.

    TRY.
        " call the control BAdI for adjustment of project parameters defaults
        DATA(ls_adjustable_proj_params) = VALUE if_satc_badi_trnsprt_chk_ctrl=>s_atc_project_parameters(
                                                       check_run_title                = core_object->_generate_project_title( i_transport_id )
                                                       check_profile                  = check_profile
                                                       consider_baseline              = cl_satc_ac_fixed_config=>is_baseline_supported( )
                                                       analyse_generated_code         = abap_false
                                                       findings_exempted_in_code_mode = cl_satc_ac_project_parameters=>c_mode_fndng_xmptd_in_code-suppress ).
        DATA(original_check_variant) = ls_adjustable_proj_params-check_profile.
        control_badi=>get_instance( )->if_satc_badi_trnsprt_chk_ctrl~adjust_check_parameters( EXPORTING i_transport_id            = i_transport_id
                                                                                                        it_object_keys            = i_r3tr_keys
                                                                                                        i_called_from_location    = called_from_location
                                                                                              CHANGING  cs_atc_project_parameters = ls_adjustable_proj_params ).
        DATA(project_parameters) = NEW cl_satc_ac_project_parameters( ).

        DATA(access) = cl_satc_fiori_access=>get_instance( ).          " Begin of ADTGANY-691
        IF access->atc_configuration_enabled( ) = abap_true.
          DATA(config) = access->get_default_configuration( ).
          DATA(config_name) = COND #( WHEN config IS INITIAL THEN VALUE satc_ci_conf_name( )   " There is no default ATC coniguration
                                      ELSE config->get_name( ) ).
          project_parameters->set_atc_configuration( config_name ).    " End of ADTGANY-691
        ENDIF.

        project_parameters->set_project_title( ls_adjustable_proj_params-check_run_title ).
        project_parameters->set_is_transient( abap_false ).
        project_parameters->set_evaluate_exemptions( abap_true ).
        project_parameters->set_object_key_iterator( key_iterator ).
        project_parameters->set_evaluate_runtime_error( abap_true ).
        project_parameters->set_report_failures_as_fndngs( abap_true ).
        project_parameters->set_check_profile_name( ls_adjustable_proj_params-check_profile ).
        project_parameters->set_check_ids( check_ids ).
        project_parameters->set_consider_baseline( ls_adjustable_proj_params-consider_baseline ).
        project_parameters->set_generate_quickfixes( cl_satc_ac_project_parameters=>c_quickfix_generation_settings-no_quickfix_evaluation ).
        project_parameters->set_analyse_generated_code( ls_adjustable_proj_params-analyse_generated_code ).
        project_parameters->set_mode_fndng_xmptd_in_code( ls_adjustable_proj_params-findings_exempted_in_code_mode ).
        project_parameters->set_post_processing_agents( ls_adjustable_proj_params-add_postprocessing_agents ).

        IF check_profile EQ 'Z3COR'.
          project_parameters->set_analyse_generated_code( abap_true ).
        ENDIF.

        IF i_worklist_id IS INITIAL.
          e_project_handle = cl_satc_ac_project_builder=>create_builder( )->create_project( project_parameters ).
        ELSE.
          IF i_transport_id IS INITIAL.
            RETURN.
          ENDIF.
          DATA(set) = cl_satc_adt_object_set=>create_for_transport( i_transport_id ). "TODO
          DATA(list) = cl_satc_adt_object_list=>create_list( ).
          list->add_object_set( i_object_set = set ).
          e_project_handle = cl_satc_ac_project_builder=>create_builder( )->create_project_for_worklist( i_project_parameters = project_parameters
                                                                                                         i_worklist_id        = i_worklist_id
                                                                                                         i_object_list        = list ).
        ENDIF.
      CATCH cx_root INTO DATA(xpt_root) ##catch_All.
        DATA(msg_text) = 'ATC: Configuration missing; execution aborted'(nop) && space && xpt_root->get_text( ).
        MESSAGE msg_text TYPE 'I' RAISING check_error.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
