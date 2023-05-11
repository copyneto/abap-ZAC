*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTCA_SCC4_MAIL..................................*
DATA:  BEGIN OF STATUS_ZTCA_SCC4_MAIL                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTCA_SCC4_MAIL                .
CONTROLS: TCTRL_ZTCA_SCC4_MAIL
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZTCA_SCC4_MAIL                .
TABLES: ZTCA_SCC4_MAIL                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
