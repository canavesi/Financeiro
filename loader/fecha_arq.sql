conn financeiro/financeiro@teste

--exec cc.pkg_loader_arq.prc_gera_base_cartao(cc.pkg_loader_arq.fnc_arquivo_loader);


exec financeiro.pkg_extratos.PRC_ENCERRA_EXTRATO_TMP;

exit

