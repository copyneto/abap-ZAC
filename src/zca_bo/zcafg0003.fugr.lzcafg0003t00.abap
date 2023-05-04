*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZCAT0002........................................*
DATA:  BEGIN OF STATUS_ZCAT0002                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZCAT0002                      .
CONTROLS: TCTRL_ZCAT0002
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZCAT0005........................................*
DATA:  BEGIN OF STATUS_ZCAT0005                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZCAT0005                      .
CONTROLS: TCTRL_ZCAT0005
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZCAT0002                      .
TABLES: *ZCAT0005                      .
TABLES: ZCAT0002                       .
TABLES: ZCAT0005                       .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
