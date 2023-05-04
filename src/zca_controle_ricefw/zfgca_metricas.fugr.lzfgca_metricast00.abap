*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVCA_METRICAS...................................*
TABLES: ZVCA_METRICAS, *ZVCA_METRICAS. "view work areas
CONTROLS: TCTRL_ZVCA_METRICAS
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZVCA_METRICAS. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVCA_METRICAS.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVCA_METRICAS_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVCA_METRICAS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVCA_METRICAS_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVCA_METRICAS_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVCA_METRICAS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVCA_METRICAS_TOTAL.

*.........table declarations:.................................*
TABLES: ZTCA_METRICAS                  .
