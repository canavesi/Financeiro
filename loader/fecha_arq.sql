conn cc/cc@teste

exec cc.pkg_loader_arq.prc_gera_base_cartao(cc.pkg_loader_arq.fnc_arquivo_loader);

exec pkg_loader_arq.prc_gera_arq_fim;

exit

