CLASS zclca_pdf_url DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! Construtor: Inicializa dados
    "! @parameter iv_pdf_file | Arquivo PDF
    METHODS constructor IMPORTING iv_pdf_file  TYPE xstring.

    "! Gera URL para visualização do arquivo PDF em Browser
    "! @parameter iv_cache_expires | Duração da validade do cache (em segundos)
    "! @parameter rv_url           | URL completa
    METHODS gerar_url IMPORTING iv_cache_expires TYPE i DEFAULT 60
                      RETURNING VALUE(rv_url)    TYPE string.


PROTECTED SECTION.
private section.

  data GV_PDF_FILE type XSTRING .
  constants GC_FI type ZTCA_PARAM_VAL-MODULO value 'FI' ##NO_TEXT.
  constants GC_WF type ZTCA_PARAM_VAL-CHAVE1 value 'WF' ##NO_TEXT.
  constants GC_URL type ZTCA_PARAM_VAL-CHAVE2 value 'URL' ##NO_TEXT.
ENDCLASS.



CLASS ZCLCA_PDF_URL IMPLEMENTATION.


  METHOD constructor.

    me->gv_pdf_file = iv_pdf_file.

  ENDMETHOD.


  METHOD gerar_url.

    CONSTANTS: lc_app_type         TYPE string VALUE '.PDF',
               lc_code_response_ok TYPE i      VALUE '200',
               lc_code_reason_ok   TYPE string VALUE 'OK',
               lc_prefix_url_1     TYPE string VALUE '/sap/public/',
               lc_url_extension    TYPE string VALUE '.pdf'.

    DATA lo_cached_response    TYPE REF TO if_http_response.

    DATA lt_host               TYPE STANDARD TABLE OF /sdf/icm_data_struc.

    DATA lv_url TYPE string.

* ----------------------------------------------------------------------
* Prepara criação de HTTP Response
* ----------------------------------------------------------------------
    CREATE OBJECT lo_cached_response
      TYPE
      cl_http_response
      EXPORTING
        add_c_msg = 1.

* ----------------------------------------------------------------------
* Determina dados e cabeçalho
* ----------------------------------------------------------------------
    lo_cached_response->set_data( me->gv_pdf_file ).

*    DATA(lv_app_type) = CONV string( '.PDF' ).
    DATA(lv_app_type) = lc_app_type.

    lo_cached_response->set_header_field( name  = if_http_header_fields=>content_type
                                          value = lv_app_type ).

* ----------------------------------------------------------------------
* Determina o Status Response
* ----------------------------------------------------------------------
    lo_cached_response->set_status( code = lc_code_response_ok reason = lc_code_reason_ok ).

* ----------------------------------------------------------------------
* Determina o Cache Timeout - 60 segundos - o tempo deve ser o
* suficiente para montar a página
* ----------------------------------------------------------------------
*    lo_cached_response->server_cache_expire_rel( expires_rel = 60 ).
    lo_cached_response->server_cache_expire_rel( expires_rel = iv_cache_expires ).

* ----------------------------------------------------------------------
* Cria uma URL única para o objeto e exporta a URL
* ----------------------------------------------------------------------
    TRY.
        DATA(lv_guid) = cl_system_uuid=>create_uuid_c32_static( ).
      CATCH cx_uuid_error.
    ENDTRY.


*    CONCATENATE  '/sap/public' '/' lv_guid '.' 'pdf' INTO lv_url.
    CONCATENATE  lc_prefix_url_1 lv_guid lc_url_extension INTO lv_url.

* ----------------------------------------------------------------------
* Guarda a URL no Cache
* ----------------------------------------------------------------------
    cl_http_server=>server_cache_upload( url      = lv_url
                                         response = lo_cached_response ).


* ----------------------------------------------------------------------
* Solução para utilizar com o link externo
* ----------------------------------------------------------------------
    SELECT SINGLE low
       FROM ztca_param_val
       INTO @DATA(lv_low_url)
      WHERE modulo EQ @gc_fi
        AND chave1 EQ @gc_wf
        AND chave2 EQ @gc_url.

    IF sy-subrc EQ 0.

      rv_url = |http://{ lv_low_url }{ lv_url }|.

    ELSE.

* ----------------------------------------------------------------------
* Recupera hostname e port
* ----------------------------------------------------------------------
      CALL FUNCTION '/SDF/GET_ICM_VIRT_HOST_DATA'
        TABLES
          icm_data       = lt_host[]
        EXCEPTIONS
          not_authorized = 1
          OTHERS         = 2.

      IF sy-subrc <> 0.
        FREE lt_host.
      ENDIF.

* ----------------------------------------------------------------------
* Retorna a URL completa
* ----------------------------------------------------------------------
      TRY.
          rv_url = |http://{ lt_host[ 1 ]-fqhostname }:{ lt_host[ 1 ]-port }{ lv_url }|.
        CATCH cx_root.
          RETURN.
      ENDTRY.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
