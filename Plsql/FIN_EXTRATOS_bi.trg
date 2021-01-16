CREATE OR REPLACE TRIGGER FIN_EXTRATOS_bi
   Before Insert On FIN_EXTRATOS
   For Each Row
Begin

  If :New.SEQ_EXTRATO Is Null Then
    Select SQ_FIN_EXTRATOS.Nextval Into :New.SEQ_EXTRATO From dual;
  End If;
  
  if :new.dat_exe is null then
       :new.dat_exe := sysdate;
  end if;
  
  if :new.usuario  is null then
       :new.usuario  := user;
  end if;
  

End;
/
