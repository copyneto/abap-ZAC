*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVCA_STATUS.....................................*
TABLES: ZVCA_STATUS, *ZVCA_STATUS. "view work areas
CONTROLS: TCTRL_ZVCA_STATUS
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZVCA_STATUS. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVCA_STATUS.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVCA_STATUS_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVCA_STATUS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVCA_STATUS_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVCA_STATUS_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVCA_STATUS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVCA_STATUS_TOTAL.

*.........table declarations:.................................*
TABLES: ZTCA_STATUS                    .
