CREATE OR REPLACE TRIGGER FIN_EXTRATOS_BB_biu
   Before Insert or update ON FIN_EXTRATOS_BB    For Each Row
   
  -- Author  : CARLOS
  -- Created : 03/08/2015 14:08:22
  -- Purpose : Classificar os r3egistros recebidos do TXT
Declare

  v_seq_instituicao  FINANCEIRO.FIN_EXTRATOS.seq_instituicao %Type := 0;

  e_saida Exception;

Begin

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Registro 0 - Classificar
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  If :New.fpa_conta = 0 Then
    Raise e_saida;
  End If;

  Select seq_instituicao  Into v_seq_instituicao  From FIN_EXTRATOS Where SEQ_EXTRATO = :New.SEQ_EXTRATO;

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Trata casos possiveis Extrato BB (Modelo 1)
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  --  /10-Conta Corrente/1001-Creditos/100101-Transit/10010101-Pgto salario
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  If :New.dsc_lancto Like 'Proventos%' And
     to_char(:New.dat_lancto , 'DD') Between 3 And 12 Then
    :New.fpa_conta := 10010101;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --  /10-Conta Corrente/1001-Creditos/100101-Transit/10010101-Pgto salario
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'TEC-Transf Esp Crédito' And
        to_char(:New.dat_lancto , 'DD') Between 5 And 9 And
        :New.val_lancto  Between 4000.00 And 24600.00 Then
    :New.fpa_conta := 10010101;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1001-Creditos/100101-Transit/10010102-Adt salario
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  
  Elsif (:New.dsc_lancto = 'TEC-Transf Esp Crédito' Or
        :New.dsc_lancto Like 'Proventos%') And
        to_char(:New.dat_lancto , 'DD') Between 19 And 24 And
        :New.val_lancto  Between 2400.00 And 2600.00 Then
    :New.fpa_conta := 10010102;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1001-Creditos/100101-Transit/10010104-Depositos transit
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto In ('Proventos TED', 'TEC-Transf Esp Crédito') And
        :New.val_lancto  < 200.00 Then
    :New.fpa_conta := 10010104;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1001-Creditos/100103-Resgates de aplicaçoes/10010301-Brasil prev
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Brasilprev%' And
        :New.val_lancto  > 0 Then
    :New.fpa_conta := 10010301;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --   /10-Conta Corrente/1001-Creditos/100102-Denise/10010201-Denise emprestimo
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Transferência on line%' And
        :New.val_lancto > 2500 Then
    :New.fpa_conta := 10010201;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1001-Creditos/100103-Resgates de aplicaçoes/10010302-Poupança
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Transferido da poupança' And
        :New.val_lancto > 0 Then
    :New.fpa_conta := 10010302;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --   /10-Conta Corrente/1001-Creditos/100102-Denise/10010202-Denise Ajuste Contas
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Transferência on line%' And
        :New.val_lancto Between 150.00 And 2499.00 Then
    :New.fpa_conta := 10010202;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100201-Saques,  cheques e débitos/10020101-Saques com cartao
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Saque no TAA%' Or
        :New.dsc_lancto = 'Banco 24 Horas' Then
    :New.fpa_conta := 10020101;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100201-Saques,  cheques e débitos/10020103-Compra com cartao
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Compra com Cartão%' Then
    :New.fpa_conta := 10020103;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100204-Despesas com veiculo/10020401-Prestaçao carro
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Pagamento de Título%' And
        :New.val_lancto = -1540.72 Then
    :New.fpa_conta := 10020401;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100205-Lazer/10020503-Clube Ipiranga
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Pagamento de Título%' And
        to_char(:New.dat_lancto , 'DD') Between 5 And 9 And
        :New.val_lancto Between - 270.00 And - 200.00 Then
    :New.fpa_conta := 10020503;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100203-Pagamentos de Cartoes/10020301-Visa
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Pagto cartão crédito' And
        to_char(:New.dat_lancto , 'DD') Between 21 And 25 Then
    :New.fpa_conta := 10020301;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100203-Pagamentos de Cartoes/10020302-Master
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Pagto cartão crédito' And
        to_char(:New.dat_lancto, 'DD') Between 6 And 12 Then
    :New.fpa_conta := 10020302;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100203-Pagamentos de Cartoes/10020303-Hipercard
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Pagamento de Título' And
        to_char(:New.dat_lancto, 'DD') Between 15 And 19 Then
    :New.fpa_conta := 10020303;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1002-Debitos/100207-Apartamento/10020701-Condominio
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif (:New.dsc_lancto In
        ('Pagamento de Título - BANCO ITAU S.A.', 'Pagamento de Título') And
        to_char(:New.dat_lancto, 'DD') Between 9 And 15 And
        :New.val_lancto Between - 590.00 And - 490.00) Or
        (:New.dsc_lancto In
        ('Pagamento de Título - BANCO ITAU S.A.', 'Pagamento de Título') And
        to_char(:New.dat_lancto, 'DD') Between 9 And 15 And
        :New.val_lancto Between - 42.00 And - 39.00) Then
    :New.fpa_conta := 10020701;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1002-Debitos/100202-Encargos BB/10020202-Tarifas de pacotes e serviços BB
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Tarifa Pacote de Serviços%' Then
    :New.fpa_conta := 10020202;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100208-Empretimos CDC/10020801-Empretimo CDC 1
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Pgto CDC%' Then
    :New.fpa_conta := 10020801;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100205-Lazer/10020501-NET
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Net Serviços%' Then
    :New.fpa_conta := 10020501;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100205-Lazer/10020502-UOL
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Uol Universo Online' Or
        :New.dsc_lancto = 'Pgto Mensalidade Internet' Then
    :New.fpa_conta := 10020502;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100202-Encargos BB/10020201-Juros
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Cobrança de Juros' Then
    :New.fpa_conta := 10020201;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1002-Debitos/100202-Encargos BB/10020203-IOF
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Cobrança de I.O.F.' Then
    :New.fpa_conta := 10020203;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100209-Investimentos/10020901-Brasil Prev
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'Brasilprev%' And
        :New.val_lancto < 0 Then
    :New.fpa_conta := 10020901;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1002-Debitos/100201-Saques,  cheques e débitos/10020102-Cheques compensados
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Cheque Compensado' Then
    :New.fpa_conta := 10020102;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1002-Debitos/100204-Despesas com veiculo/10020402-Pedagio
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Pagamento Pedágio' Then
    :New.fpa_conta := 10020402;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1002-Debitos/100209-Investimentos/10020902-Ourocap
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Pagamento OUROCAP' Then
    :New.fpa_conta := 10020902;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100207-Apartamento/10020702-Energia Eletrica
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Pagto Energia Elétrica' Then
    :New.fpa_conta := 10020702;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100207-Apartamento/10020703-Recarga de Celular
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Telefone Pre-Pago' Then
    :New.fpa_conta := 10020703;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    -- /10-Conta Corrente/1002-Debitos/100206-Impostos/10020601-IPVA
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Pagamento de Impostos' And
        to_char(:New.dat_lancto, 'MM') = 1 Then
    :New.fpa_conta := 10020601;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/10-Conta Corrente/1002-Debitos/100206-Impostos/10020602-IPTU
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Pagamento de Impostos' And
        to_char(:New.dat_lancto, 'MM') = 2 Then
    :New.fpa_conta := 10020602;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --  /-1 - Saldo Anterior
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Saldo Anterior' Then
    :New.fpa_conta := -1;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'S A L D O' Then
    :New.fpa_conta := -2;
  
  End If;

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Trata casos possiveis Extrato Visa (Modelo 2) e MASTER (Modelo 3)
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  --/    -4 Vencimento do cartão
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  If :New.dsc_lancto Like 'Vencimento%' Then
  
    :New.fpa_conta := -4;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3001-Creditos/300101-Pagto debito em conta corente
    --/20-Visa/2001-Creditos/200101-Pagto debito em conta corente
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'PGTO DEBITO CONTA%' Then
    Select decode(v_seq_instituicao , 2, 200101, 300101)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300201-Taxas e anuidades/30020101-Anuidade
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'ANUIDADE%' Then
    Select decode(v_seq_instituicao , 2, 20020101, 30020101)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300202-Saude/30020201-Farmacias
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'DROG EXTRA%' Or
        :New.dsc_lancto Like 'DROGARIA SAO PAULO%' Or
        :New.dsc_lancto Like 'ULTRAFARMA%' Or
        :New.dsc_lancto Like 'DROGASIL%' Then
    Select decode(v_seq_instituicao , 2, 20020201, 30020201)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300202-Saude/30020202-Oculoas e assessorios
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'OTICA MAX%' Then
    Select decode(v_seq_instituicao, 2, 20020202, 30020202)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30 - Master/3002 - debitos/300202 - Saude/30020203 - Cabelo e estética
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'VIVIAN SHINE%' Then
    Select decode(v_seq_instituicao, 2, 20020203, 30020203)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300203-Lazer/30020301-Refeiçoes
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'CEPAM%' Or
        :New.dsc_lancto Like 'NOSSA CASA PAD%' Or
        :New.dsc_lancto Like 'ESQUINA DO ESPETO%' Then
    Select decode(v_seq_instituicao, 2, 20020301, 30020301)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/20-Visa/2002-debitos/200203-Lazer/20020302-Clube Atletico Ipiranga
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'CLUBE ATLETICO YPIRANG%' Then
    Select decode(v_seq_instituicao, 2, 20020302, 30020302)
      Into :New.fpa_conta
      From dual;
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300204-Carro/30020401-Gasolina e alcool
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'AUTO POSTO%' Or
        :New.dsc_lancto Like 'POSTO%' Or
        :New.dsc_lancto Like 'CENTRO AUTOMOTIVO FINL%' Or
        :New.dsc_lancto Like 'AUTO TREND%' Then
    Select decode(v_seq_instituicao, 2, 20020401, 30020401)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300204-Carro/30020402-Manutençao
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'AMAZON%' Or
        :New.dsc_lancto Like 'VW AMAZON%' Then
    Select decode(v_seq_instituicao, 2, 20020402, 30020402)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/20-Visa/2002-debitos/200204-Carro/20020403-Seguro
    --/30-Master/3002-debitos/300204-Carro/30020403-Seguro
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'BB SEGURO AUTO%' Then
    Select decode(v_seq_instituicao, 2, 20020403, 30020403)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300205-Apartamento/30020501-Reformas e serviços
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'LEROY MERLIN%' Or
        :New.dsc_lancto Like 'CAMICADO%' Then
    Select decode(v_seq_instituicao, 2, 20020501, 30020501)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300205-Apartamento/30020502-Mercados
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'CARREFOUR%' Or
        :New.dsc_lancto Like 'WALMART%' Or
        :New.dsc_lancto Like 'EXTRA%' Or
        :New.dsc_lancto Like 'CASA CARNES%' Then
    Select decode(v_seq_instituicao, 2, 20020502, 30020502)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300206-Presentes/30020601-Familia Carlos
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'MR2 SERVICOS%' Or
        :New.dsc_lancto Like 'BESNI LOJA%' Or
        :New.dsc_lancto Like 'SCENE%' Or
        :New.dsc_lancto Like 'LOJAS RENNER%' Then
    Select decode(v_seq_instituicao, 2, 20020601, 30020601)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300206-Presentes/30020602-Familia Denise
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30 - Master/3002 - debitos/300208 - Computadores Eletronicos/30020801 - Macfee antiviris
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'MICROSOFT%' Then
    Select decode(v_seq_instituicao, 2, 20020801, 30020801)
      Into :New.fpa_conta
      From dual;
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30 - Master/3002 - debitos/300207 - Viagens e turismo/30020704 - Campinas
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'GRUPO FARTURA%' Then
    Select decode(v_seq_instituicao, 2, 20020704, 30020704)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300207-Viagens e turismo/30020702-Pacotes CVC
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'CVC VIAGENS%' Or
        :New.dsc_lancto Like 'NASCIMENTO TU%' Then
    Select decode(v_seq_instituicao, 2, 20020702, 30020702)
      Into :New.fpa_conta
      From dual;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/30-Master/3002-debitos/300207-Viagens e turismo/30020703-Passeios, ingressos e Alimentaçao
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'RAFAEL R MUHL%' Or
        :New.dsc_lancto Like 'FA LJ SJC %' Then
    Select decode(v_seq_instituicao, 2, 20020703, 30020703)
      Into :New.fpa_conta
      From dual;
  
  End If;

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Trata casos possiveis Extrato Itau (Modelo 5)
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  --  /50 - Conta Corrente/5001 - Créditos/500101 - Pgto salario
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  If :New.dsc_lancto Like 'TED 237%' Then
    :New.fpa_conta := 500101;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --  /50 - Conta Corrente/5001 - Créditos/500102 - Poupança Automatica
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'REND PAGO APLIC AUT MAIS' Then
    :New.fpa_conta := 500102;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/50 - Conta Corrente/5002 - Débitos/500204 - Tarifas Banco Itau/50020401 - Tarifa Mensal
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'TAR CONTA CERTA    %' Then
    :New.fpa_conta := 50020401;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/50 - Conta Corrente/5002 - Débitos/500204 - Tarifas Banco Itau/50020402 - Tarifa excedente
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto Like 'TAR CTA CERTA EXCED%' Then
    :New.fpa_conta := 50020402;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/50 - Conta Corrente/5002 - Débitos/500201 - Banco do Brasil/50020101 - Transferencia
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'DOC INT BB' Then
    :New.fpa_conta := 50020101;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/50 - Conta Corrente/5002 - Débitos/500202 - Transit/50020201 - Causa Trabalhista
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'DOC INT FAB' Then
    :New.fpa_conta := 50020201;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/50 - Conta Corrente/5002 - Débitos/500203 - Empresa/50020301 - Honorarios Contador
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Honorarios' Then
    :New.fpa_conta := 50020301;
  
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
    --/50 - Conta Corrente/5002 - Débitos/500203 - Empresa/50020302 - Impostos
    --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  Elsif :New.dsc_lancto = 'Impostos' Then
    :New.fpa_conta := 50020302;
  
  End If;

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Descartes
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

  If :New.fpa_conta Is Null Then
    :New.fpa_conta := -0;
  
  End If;

  /*  Select a.dat_lancto, a.dsc_lancto, a.val_lancto, b.fpa_conta, b.fpa_descricao
      From cc.FIN_EXTRATOS_BB a, cc.fc_plano_contas b
     Where a.fpa_conta is null and
           a.fab_sq <> 15 and
          a.fpa_conta = b.fpa_conta(+);
          
  
  Update cc.FIN_EXTRATOS_BB
       Set val_lancto = val_lancto * 1*/

  If :New.seq_extratos_bb  Is Null Then
    Select SQ_EXTRATOS_BB.Nextval Into :New.seq_extratos_bb  From dual;
  
  End If;

Exception
  When e_saida Then
    Null;
  
End;
/
