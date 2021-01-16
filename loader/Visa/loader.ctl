OPTIONS( ROWS=5000, ERRORS=100 )
LOAD DATA infile 'c:\desenv\fluxo\loader\visa\loader.TXT'
APPEND
--CONTINUEIF (1) = '*' nao sei usar isto.
INTO TABLE fc_lcto_base_cartao_tmp
-- WHEN DBC_DT	= '20050601' Este funciona...
(
     fab_sq		   char "pkg_loader_arq.fnc_arquivo_loader",
     flp_sq		   char "fc_lcto_base_cartao_tmp_sq.nextval",
     flp_linha		   POSITION(1:199) char 
)






