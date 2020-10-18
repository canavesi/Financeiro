Create Or Replace Trigger trg_PROJECAO_CONTAS_biu
   Before Insert or update On PROJECAO_CONTAS
   For Each Row
Begin

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Sequência
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	If :New.PCA_SQ Is Null Then
    Select seq_PROJECAO_CONTAS.Nextval Into :New.pca_sq From dual;
  End If;
	
	:new.pca_descricao := initcap(:new.pca_descricao);
	
End;
/
