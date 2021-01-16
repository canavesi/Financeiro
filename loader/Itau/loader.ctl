OPTIONS( ROWS=5000, ERRORS=100000 )
LOAD DATA infile 'c:\desenv\fluxo\loader\itau\loader.TXT'
APPEND
INTO TABLE cc.fc_lcto_base
   -- WHEN (01:02) =  '59' and duracao <> '30'
fields terminated by ';'  optionally enclosed by '"'
trailing nullcols
(
	FLB_DATA    date "DD/MM/YYYY",
	FLB_DESC,       
	FLB_VALOR   DECIMAL EXTERNAL,
	FLB_SQ "fc_lcto_base_sq.nextval",
	FAB_SQ char "pkg_loader_arq.fnc_arquivo_loader"
)

