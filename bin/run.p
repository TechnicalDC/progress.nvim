DEFINE VARIABLE ch_prog AS CHARACTER NO-UNDO.
DEFINE VARIABLE ch_mess AS CHARACTER NO-UNDO.
DEFINE VARIABLE i       AS INTEGER   NO-UNDO.

/* Extracts the parameters */
ASSIGN ch_prog = ENTRY( 1, SESSION:PARAMETER ).
IF NUM-ENTRIES(SESSION:PARAMETER) >= 2 THEN DO :
  ASSIGN PROPATH = PROPATH + ":" + ENTRY( 2, SESSION:PARAMETER ).
END.

/* Compile without saving */
COMPILE VALUE( ch_prog ) SAVE=NO NO-ERROR.

/* If there are compilation messages */
IF COMPILER:NUM-MESSAGES > 0 THEN DO:

  ASSIGN ch_mess = "".

  /* For each messages */
  DO i = 1 TO COMPILER:NUM-MESSAGES:

    /* Generate an error line */
    ASSIGN ch_mess =
      SUBSTITUTE( "~n&1 File: '&2'~n      Line #: &3~n      Col: &4~n      Code: &5~n      Message: &6~n",
        IF COMPILER:WARNING = TRUE THEN "WARNING" ELSE "ERROR",
        COMPILER:GET-FILE-NAME  ( i ),
        COMPILER:GET-ROW        ( i ),
        COMPILER:GET-COLUMN     ( i ),
        COMPILER:GET-NUMBER     ( i ),
        COMPILER:GET-MESSAGE    ( i )
      )
    .

    /* display the message to the standard output */
    UNIX VALUE("echo '" + ch_mess + "'").
  END.
END.
ELSE DO :
  /* display to the standard output */
  UNIX VALUE("echo SUCCESS: Syntax is correct.").
END.

/* End of program */
QUIT.
