conn financeiro/financeiro@teste

    ------------------------------------------------------
    -- Gerar FIN_EXTRATO_TMP (HEADER DAS LINHAS)
    ------------------------------------------------------

    --exec financeiro.pkg_extratos.prc_excluir_extrato;
    exec financeiro.pkg_extratos.prc_incluir_header;

exit

