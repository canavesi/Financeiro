conn cc/cc@teste

    ------------------------------------------------------
    -- Gerar Extrato Bancario
    -- 5 Banco Itau
    ------------------------------------------------------

    exec cc.pkg_loader_arq.prc_gera_arq_ini(p_modelo => 5);

exit

