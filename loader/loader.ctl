OPTIONS( ROWS=5000, ERRORS=100 )
LOAD DATA infile 'C:\Desenv\Oracle\Financeiro\loader\loader.TXT'
APPEND
--CONTINUEIF (1) = '*' nao sei usar isto.
INTO TABLE fin_extratos_itens_tmp
-- WHEN DBC_DT	= '20050601' Este funciona...
(
     seq_extrato           char "pkg_extratos.fnc_rec_num_extrato",
     seq_linha		   char "SQ_FIN_EXTRATOS_ITENS_TMP.nextval",
     dsc_linha		   POSITION(1:299) char
)






