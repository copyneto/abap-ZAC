*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVCA_CENARIO....................................*
TABLES: ZVCA_CENARIO, *ZVCA_CENARIO. "view work areas
CONTROLS: TCTRL_ZVCA_CENARIO
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZVCA_CENARIO. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVCA_CENARIO.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVCA_CENARIO_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVCA_CENARIO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVCA_CENARIO_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVCA_CENARIO_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVCA_CENARIO.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVCA_CENARIO_TOTAL.

*.........table declarations:.................................*
TABLES: ZTCA_CENARIO                   .
TABLES: ZTCA_CENARIOT                  .
