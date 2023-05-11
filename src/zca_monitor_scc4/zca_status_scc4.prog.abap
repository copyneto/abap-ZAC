*&---------------------------------------------------------------------*
*& Report ZCA_STATUS_SCC4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zca_status_scc4.

DATA: lt_t000      TYPE TABLE OF t000,
      lt_dest_mail TYPE TABLE OF ztca_scc4_mail.

*validacao dos parametros
PERFORM parameters_t000.
*&---------------------------------------------------------------------*
*&      Form  parameters
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM parameters_t000 .
* Ini.1- Seleciona os mandantes que estao abertos
  SELECT *
    FROM t000
    INTO TABLE @lt_t000
    WHERE mandt <> '000'
    AND cccoractiv EQ ''.
  "WHERE cccoractiv <> '2' OR ccnocliind <> '3'.
* End.1

* Ini.2 - Verifica se existe algum ambiente aberto, se verdadeiro ele vai selecionar
* os emails que devem receber a notificacao, caso contrario nao executa o programa.
  IF lt_t000 IS NOT INITIAL.
    PERFORM select_mail.
  ELSE.
    EXIT.
  ENDIF.
* End.2
ENDFORM.                    " parameters_t000
*&---------------------------------------------------------------------*
*&      Form  SELECIONA_EMAIL
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM select_mail .
* Ini. 3 - Seleciona os emails
  SELECT *
   FROM ztca_scc4_mail
   INTO TABLE @lt_dest_mail.
* End. 3
* Ini 4. Verifica se existe algum email cadastrado para enviar a notificacao.
* e realiza a chamada.
  IF lt_dest_mail[] IS INITIAL.
    MESSAGE TEXT-001 TYPE 'S'.
    STOP.
  ENDIF.

  PERFORM send_mail.

ENDFORM.                    " select_mail
*&---------------------------------------------------------------------*
*&      Form  send_mail
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM send_mail .
  DATA: lt_txt       TYPE TABLE OF solisti1.
  DATA: ls_doc_data TYPE sodocchgi1,
        ls_txt      TYPE solisti1.

  REFRESH: lt_txt.
  CLEAR: ls_txt, ls_doc_data.

  ls_doc_data-obj_descr = 'Status dos Ambientes T-code SCC4 -  ' && sy-host && sy-mandt.
  ls_txt-line =           'Ambientes Alterados: ' .
  APPEND ls_txt TO lt_txt.

  LOOP AT lt_t000 INTO DATA(ls_t000).
    ls_txt-line(32) = ls_t000-mtext.
    WRITE ls_t000-mandt        TO ls_txt-line+35(12).
    WRITE ls_t000-changeuser   TO ls_txt-line+50(11).
    WRITE ls_t000-changedate   TO ls_txt-line+70(13).
    APPEND ls_txt TO lt_txt.
  ENDLOOP.

  TRY.
      "-> cria o e-mail
      DATA(lo_email) = cl_bcs=>create_persistent( ).
      DATA(lo_corpo_email) = cl_document_bcs=>create_document( i_type    = 'RAW'
                                                               i_text    = lt_txt
                                                               i_subject = ls_doc_data-obj_descr ).

      lo_email->set_document( lo_corpo_email ).

      "-> define o remetente
      DATA(lo_remetente) = cl_sapuser_bcs=>create( sy-uname ).
      lo_email->set_sender( lo_remetente ).

      "-> define os destinatários
      LOOP AT lt_dest_mail INTO DATA(ls_dest_mail).

        DATA(lo_destinatarios) = cl_cam_address_bcs=>create_internet_address( ls_dest_mail-email ).

        lo_email->add_recipient( i_recipient = lo_destinatarios
                                 i_express   = abap_true ).

      ENDLOOP.

      "enviar
      lo_email->set_send_immediately( abap_true ).
      DATA(lv_email_enviado) = lo_email->send( abap_true ).

      IF NOT lv_email_enviado IS INITIAL.
        COMMIT WORK.
      ENDIF.

    CATCH cx_bcs INTO DATA(lo_cx_bcs).
      MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.

ENDFORM.                    " send_mail
