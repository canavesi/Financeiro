CREATE OR REPLACE Package pkg_projecao Is

	 -- Author  : CARLOS
	 -- Created : 19/10/2020 09:53:55
	 -- Purpose : Encapsulamento dos m�todos do modulo Proje��o

	 -- Atualizar PROJECAO_ARQUIVOS
	 Procedure prc_atualizartotais_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type);

	 -- Criar arquivo historico a partir do Cadastro
	 Procedure prc_criar_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type);

	 -- excluir arquivo historico
	 Procedure prc_excluir_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type);

End pkg_projecao;
/
CREATE OR REPLACE Package Body pkg_projecao Is

	 -- Author  : CARLOS
	 -- Created : 19/10/2020 09:53:55
	 -- Purpose : Encapsulamento dos m�todos do modulo Proje��o

	 -- Atualizar PROJECAO_ARQUIVOS
	 Procedure prc_atualizartotais_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type) Is
	 
			v_pra_valor_creditos projecao_arquivos.pra_valor_creditos%Type := Null;
			v_pra_valor_debitos  projecao_arquivos.pra_valor_debitos%Type := Null;
			v_pra_valor_saldo    projecao_arquivos.pra_valor_saldo%Type := Null;
	 
	 Begin
			-- Calcula valores totais
			Select Sum(x.valor_creditos), Sum(x.valor_debitos), Sum(x.valor_saldo)
				Into v_pra_valor_creditos, v_pra_valor_debitos, v_pra_valor_saldo
				From (Select Case
												When pal_valor > 0 Then
												 pal_valor
												Else
												 0
										 End valor_creditos,
										 Case
												When pal_valor < 0 Then
												 pal_valor
												Else
												 0
										 End valor_debitos,
										 pal_valor valor_saldo
								From projecao_arquivos_lanc
							 Where pra_sq = p_pra_sq) x;
	 
			Commit;
	 
	 End;

	 -- Criar arquivo historico a partir do Cadastro
	 Procedure prc_criar_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type) Is
	 
			v_pra_sq projecao_arquivos.pra_sq%Type := Null;
	 
	 Begin
	 
			Begin
				 --seleco da proximas SEQ para o cadastro
				 Select seq_projecao_arquivos.Nextval Into v_pra_sq From dual;
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20001,
																		' Erro ao ler sequencie seq_projecao_arquivos! ' || Sqlerrm);
			End;
	 
			Begin
				 Insert Into projecao_arquivos
						(pra_sq,
						 pra_data,
						 pra_descricao,
						 pra_dm_tp_projecao,
						 pra_dm_tp_arquivo,
						 pra_valor_inicial,
						 pra_valor_creditos,
						 pra_valor_debitos,
						 pra_valor_saldo)
						Select v_pra_sq,
									 pra_data,
									 pra_descricao,
									 pra_dm_tp_projecao,
									 'H', -- pra_dm_tp_arquivo,
									 pra_valor_inicial,
									 pra_valor_creditos,
									 pra_valor_debitos,
									 pra_valor_saldo
							From projecao_arquivos
						 Where pra_sq = p_pra_sq;
			
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20002, Sqlerrm || ' Erro ao incluir a Tabela projecao_arquivos!');
			End;
	 
			Begin
				 Insert Into projecao_arquivos_lanc
						(pra_sq, pca_sq, pal_sq, pal_data, pal_valor)
						Select v_pra_sq,
									 pal.pca_sq,
									 seq_projecao_arquivos_lanc.Nextval,
									 pal.pal_data,
									 pal.pal_valor
							From projecao_arquivos_lanc pal
						 Where pra_sq = p_pra_sq;
			
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20003,
																		Sqlerrm || ' Erro ao incluir a Tabela projecao_arquivos_lanc!');
			End;
	 
			Commit;
	 
	 End prc_criar_arquivo;

	 -- excluir arquivo historico
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
