*&---------------------------------------------------------------------*
*& Report ZBO_INTERFACE_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbo_interface_test.

DATA: lt_header   TYPE yboc0001, "@@ Cat. tab. para os dados de cabeçalho
      lt_item     TYPE yboc0002, "@@ Cat. tab. para os dados de item
      lr_data     TYPE REF TO data,
      lr_header   TYPE REF TO data,
      lr_item     TYPE REF TO data,
      lt_root_key TYPE /bobf/t_frw_key,
      lt_key      TYPE /bobf/t_frw_key_incl,
      lt_mod      TYPE /bobf/t_frw_modification.

DATA gt_return TYPE bapiret2_t.

BREAK-POINT.

"@@ Dados de header e item, que serão armazenados.
"@@ Obs: para o exemplo, estou selecionando. Na interface, sao os dados do proxy.
"@@      Tipificar os dados, não usar a mesma estrutura do proxy, que contem geralmente strings.

SELECT  vbeln
        erdat
        auart
        netwr
        waerk
        kunnr
  FROM vbak
  INTO TABLE lt_header.

CHECK lines( lt_header ) > 0.

SELECT  vbeln
        posnr
        matnr
        arktx
        erdat
        netwr
        waerk
  INTO TABLE lt_item
 FROM vbap
  FOR ALL ENTRIES IN lt_header
WHERE vbeln = lt_header-vbeln.

"@@ tabela de mensagens
APPEND INITIAL LINE TO gt_return ASSIGNING FIELD-SYMBOL(<fs_return>).
<fs_return>-message = 'Teste de mensagens do BO'.
<fs_return>-type    = 'E'.


"@@ Busca numeração do ID macro da interface, para numerar uma
"@@ massa de uma mesma integração. Ex.: Envio de dados que gera varios documentos contábeis
DATA(vl_id_macro) = zcacl_process_interface=>next_number( 'ZCAIN00002' ). "Intervalo de numeração criado


"@@ registra informações na bo principal, nodes root e message
zcacl_process_interface=>create_integration( EXPORTING iv_id_macro  = vl_id_macro
                                                       iv_direct    = '2'                 " 2-Entrada / 1-Saída
                                                       iv_process   = 'CROSSAPLICATION'   " Nome do processo cadastrado
                                                       it_return    = gt_return
                                             IMPORTING ev_id_number = DATA(vl_id_number)
                                              CHANGING ct_key       = lt_key
                                                       ct_mod       = lt_mod ).

"@@ Guarda informações de cabeçalho na BO padrão interface
GET REFERENCE OF lt_header INTO lr_data.

zcacl_process_interface=>add_data( EXPORTING is_data = lr_data
                                             it_key = lt_key
                                    CHANGING ct_mod = lt_mod ).

"@@ Guarda informações de itens na BO padrão interface
GET REFERENCE OF lt_item INTO lr_data.

zcacl_process_interface=>add_data( EXPORTING is_data = lr_data
                                             it_key = lt_key
                                    CHANGING ct_mod = lt_mod ).

"@@ Registra modificações/inclusões da BO de interface
zcacl_process_interface=>modify( lt_mod ).

"@@ Atribuicao de mensagens
zcacl_process_interface=>set_messages(
  EXPORTING
    iv_key      = lt_key[ 1 ]-root_key
    it_messages = gt_return
).

"@@ Veriricar se ha erros, afim de atribuir o status.
"@@ OBS: para o exemplo, atribuo ok = 1
*    IF lines( ITAB_ERROR ) = 0.

zcacl_process_interface=>set_status(
  EXPORTING
    iv_status = '1'
    iv_key    = lt_key[ 1 ]-root_key
).

*    ELSE.
*
*      zcacl_process_interface=>set_status(
*        EXPORTING
*        iv_status = '3'
*        iv_key    = lt_key[ 1 ]-root_key
*        ).

*    ENDIF.

zcacl_process_interface=>save( ).
