!     ******   ZYEAR.INC   ******
!     zero annual accumulators
      CALL ZEROA(NLAYER, VRFLYI, INFLYI, BYFLYI, DSFLYI)
      CALL ZEROA(NLAYER, NTFLYI, TRANYI, TRANVPI, DUMM)
      CALL ZERO(SRFLY, GWFLY, SEEPY, SLFLY, DUMMY, DUMMY)
      CALL ZERO(IRVPY, ISVPY, SLVPY, SNVPY, SFALY, DUMMY)
      CALL ZERO(IRVPVP, ISVPVP, SLVPVP, SNVPVP, TRANVP, DUMMY)
      CALL ZERO(RFALY, SINTY, RINTY, RSNOY, SMLTY, DUMMY)
      CALL ZERO(MESFLY, PTRANY, PINTY,PSLVPY, DUMMY, DUMMY)
      CALL ZERO(MESFLVP, PTRANVP, PINTVP,PSLVPVP, DUMMY, DUMMY)
