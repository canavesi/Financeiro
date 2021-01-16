conn cc/cc@teste

    ------------------------------------------------------
    -- Gerar DTF_BATIMENTO_ARQ com seq disponivel
    -- 3 Extrato Mastercard
    ------------------------------------------------------

    exec cc.pkg_loader_arq.prc_gera_arq_ini(p_modelo => 3);

exit

