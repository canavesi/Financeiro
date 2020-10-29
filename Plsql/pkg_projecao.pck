Create Or Replace Package pkg_projecao Is

	 -- Author  : CARLOS
	 -- Created : 19/10/2020 09:53:55
	 -- Purpose : Encapsulamento dos métodos do modulo Projeção

	 Procedure prc_salvar_arquivo;

	 Procedure prc_excluir_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type);

End pkg_projecao;
/
Create Or Replace Package Body pkg_projecao Is

	 -- Author  : CARLOS
	 -- Created : 19/10/2020 09:53:55
	 -- Purpose : Encapsulamento dos métodos do modulo Projeção

	 Procedure prc_salvar_arquivo Is
	 
			v_pra_sq projecao_arquivos.pra_sq%Type := Null;
	 
	 Begin
	 
			Begin
				 Select seq_projecao_arquivos.Nextval Into v_pra_sq From dual;
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20001,
																		' Erro ao ler sequencie seq_projecao_arquivos! ' || Sqlerrm);
			End;
	 
			Begin
				 Insert Into projecao_arquivos
						(pra_sq, pra_data, pra_descricao)
				 Values
						(v_pra_sq, Sysdate, 'OK');
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20002, Sqlerrm || ' Erro ao incluir a Tabela projecao_arquivos!');
			End;
	 
			Begin
				 Insert Into projecao_arquivos_lanc
						(pal_sq, pra_sq, pca_sq, pal_data, pal_valor)
						Select seq_projecao_arquivos_lanc.Nextval,
									 v_pra_sq,
									 plo.pca_sq,
									 plo.plo_data,
									 plo.plo_valor
							From projecao_lancamentos plo;
			
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20003,
																		Sqlerrm || ' Erro ao incluir a Tabela projecao_arquivos_lanc!');
			End;
			Commit;
	 
	 End prc_salvar_arquivo;

	 Procedure prc_excluir_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type) Is
	 
	 Begin
	 
			Delete projecao_arquivos_lanc Where pra_sq = p_pra_sq;
			Delete projecao_arquivos Where pra_sq = p_pra_sq;
			Commit;
	 
	 Exception
			When Others Then
				 Rollback;
				 raise_application_error(-20003, Sqlerrm || ' Erro ao excluir arquivo: ' || p_pra_sq || ' !');
	 End prc_excluir_arquivo;

End pkg_projecao;
/
