OPTIONS( ROWS=5000, ERRORS=100000 )
LOAD DATA infile 'c:\desenv\fluxo\loader\extrato\loader.TXT'
APPEND
INTO TABLE cc.fc_lcto_base
   -- WHEN (01:02) =  '59' and duracao <> '30'
fields terminated by ','  optionally enclosed by '"'
trailing nullcols
(
	FLB_DATA    date "MM/DD/YYYY",
	FILED1	    FILLER, -- Pular coluna;
	FLB_DESC,       
	FILED2	    FILLER, -- Pular coluna;
	FILED3	    FILLER, -- Pular coluna;
	FLB_VALOR   DECIMAL EXTERNAL "replace(:FLB_VALOR, '.' , ',')",
	FLB_SQ "fc_lcto_base_sq.nextval",
	FAB_SQ char "pkg_loader_arq.fnc_arquivo_loader"
)

