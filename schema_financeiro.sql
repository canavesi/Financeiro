--
-- Create Schema Script 
--   Database Version   : 11.2.0.1.0 
--   TOAD Version       : 9.0.1.8 
--   DB Connect String  : TESTE 
--   Schema             : FINANCEIRO 
--   Script Created by  : ARTBOX 
--   Script Created at  : 07/05/2021 17:04:42 
--   Physical Location  :  
--   Notes              :  
--

-- Object Counts: 
--   Indexes: 13        Columns: 26         
--   Packages: 6        Lines of Code: 475 
--   Package Bodies: 6  Lines of Code: 2427 
--   Procedures: 3      Lines of Code: 112 
--   Sequences: 9 
--   Tables: 14         Columns: 97         Constraints: 43     
--   Triggers: 4 


CREATE SEQUENCE SEQ_PROJECAO_ARQUIVOS
  START WITH 14
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SEQ_PROJECAO_ARQUIVOS_LANC
  START WITH 223
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SEQ_PROJECAO_CONTAS
  START WITH 28
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_FIN_EXTRATOS
  START WITH 191
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_FIN_EXTRATOS_ITENS
  START WITH 24
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_FIN_EXTRATOS_ITENS_TMP
  START WITH 3382
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_FIN_EXTRATOS_TMP
  START WITH 40
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_FIN_INSTITUICAO
  START WITH 8
  MAXVALUE 9999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SQ_FIN_PLANO_CLASSIFICAR
  START WITH 377
  INCREMENT BY 2
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE TABLE FIN_PLANO_CONTAS_OLD
(
  COD_CONTA        NUMBER                       NOT NULL,
  CONTA_CHAR       VARCHAR2(30 BYTE)            NOT NULL,
  DSC_CONTA        VARCHAR2(80 BYTE)            NOT NULL,
  SEQ_INSTITUICAO  NUMBER                       NOT NULL,
  COD_CONTA_REF    NUMBER,
  STA_CONTA        VARCHAR2(1 BYTE)             NOT NULL,
  DSC_CLASSIFICAR  VARCHAR2(240 BYTE),
  STA_BLOQ         VARCHAR2(1 BYTE)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_INSTITUICAO
(
  SEQ_INSTITUICAO  NUMBER                       NOT NULL,
  DSC_INSTITUICAO  VARCHAR2(60 BYTE)            NOT NULL,
  NOM_IMAGEM       VARCHAR2(80 BYTE),
  DSC_FRASE        VARCHAR2(80 BYTE),
  TPO_EXTRATO      VARCHAR2(1 BYTE)             DEFAULT 'B'                   NOT NULL,
  STA_BLOQ         VARCHAR2(1 BYTE)             DEFAULT 'N'                   NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_EXTRATOS_TMP
(
  SEQ_EXTRATO      NUMBER                       NOT NULL,
  SEQ_INSTITUICAO  NUMBER,
  DSC_EXTRATO      VARCHAR2(60 BYTE),
  DAT_EXE          DATE,
  USUARIO          VARCHAR2(20 BYTE),
  STA_EXTRATO      VARCHAR2(1 BYTE)             DEFAULT 'A'                   NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_EXTRATOS_ITENS_TMP
(
  SEQ_EXTRATO  NUMBER                           NOT NULL,
  SEQ_LINHA    NUMBER                           NOT NULL,
  DSC_LINHA    VARCHAR2(600 BYTE),
  COD_CONTA    NUMBER                           DEFAULT 3000003
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_INTERFACE_PREFIXO
(
  SEQ_INSTITUICAO  NUMBER                       NOT NULL,
  COD_PREFIXO      VARCHAR2(3 BYTE)             NOT NULL,
  DSC_PREFIXO      VARCHAR2(40 BYTE)            NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_EXTRATOS
(
  SEQ_INSTITUICAO    NUMBER                     NOT NULL,
  SEQ_EXTRATO        NUMBER                     NOT NULL,
  DSC_EXTRATO        VARCHAR2(40 BYTE)          NOT NULL,
  MES_LANCTO         NUMBER(2)                  NOT NULL,
  ANO_LANCTO         NUMBER(4)                  NOT NULL,
  VAL_SALDO_INICIAL  NUMBER(10,2)               DEFAULT 0,
  VAL_CREDITOS       NUMBER(10,2)               DEFAULT 0                     NOT NULL,
  VAL_DEBITOS        NUMBER(10,2)               DEFAULT 0                     NOT NULL,
  VAL_SALDO          NUMBER(10,2)               DEFAULT 0,
  VAL_SALDO_FINAL    NUMBER(10,2)               DEFAULT 0,
  SEQ_EXTRATO_TMP    NUMBER
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE PROJECAO_ARQUIVOS_LANC
(
  PRA_SQ     NUMBER(5)                          NOT NULL,
  PAL_SQ     NUMBER(4)                          NOT NULL,
  PCA_SQ     NUMBER(4)                          NOT NULL,
  PAL_DATA   DATE                               NOT NULL,
  PAL_VALOR  NUMBER(10,2)                       NOT NULL,
  PAL_OBS    VARCHAR2(60 BYTE)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_EXTRATOS_CTB
(
  SEQ_INSTITUICAO  NUMBER                       NOT NULL,
  SEQ_EXTRATO      NUMBER                       NOT NULL,
  MES_LANCTO       NUMBER(2)                    NOT NULL,
  ANO_LANCTO       NUMBER(4)                    NOT NULL,
  VAL_NIVEL        NUMBER(2)                    NOT NULL,
  COD_CONTA        NUMBER                       NOT NULL,
  VAL_CONTA        NUMBER(10,2)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_INTERFACE
(
  SEQ_INSTITUICAO  NUMBER                       NOT NULL,
  COD_PREFIXO      VARCHAR2(3 BYTE)             NOT NULL,
  SEQ_INTERFACE    NUMBER(5)                    NOT NULL,
  NOM_CAMPO        VARCHAR2(30 BYTE)            NOT NULL,
  DSC_CAMPO        VARCHAR2(40 BYTE)            NOT NULL,
  SEQ_CAMPO        NUMBER(5)                    NOT NULL,
  VAL_TAMANHO      NUMBER(5)                    NOT NULL,
  POS_INICIAL      NUMBER(5)                    NOT NULL,
  POS_FINAL        NUMBER(5)                    NOT NULL,
  DSC_MASCARA      VARCHAR2(20 BYTE),
  TPO_CAMPO        VARCHAR2(1 BYTE)             DEFAULT 'C'
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE PROJECAO_CONTAS
(
  PCA_SQ             NUMBER(4)                  NOT NULL,
  PCA_DESCRICAO      VARCHAR2(40 BYTE)          NOT NULL,
  PCA_DM_TP_CONTA    VARCHAR2(1 BYTE)           DEFAULT 'C'                   NOT NULL,
  PCA_DM_FL_PARCIAL  VARCHAR2(1 BYTE)           NOT NULL,
  PCA_DM_FL_BLOQ     VARCHAR2(1 BYTE)           NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE PROJECAO_ARQUIVOS
(
  PRA_SQ              NUMBER(5)                 NOT NULL,
  PRA_DATA            DATE                      NOT NULL,
  PRA_DESCRICAO       VARCHAR2(40 BYTE)         NOT NULL,
  PRA_DM_TP_PROJECAO  VARCHAR2(1 BYTE)          DEFAULT 'C'                   NOT NULL,
  PRA_DM_TP_ARQUIVO   VARCHAR2(1 BYTE)          DEFAULT 'C'                   NOT NULL,
  PRA_VALOR_INICIAL   NUMBER(10,2)              DEFAULT 0                     NOT NULL,
  PRA_VALOR_CREDITOS  NUMBER(10,2)              DEFAULT 0                     NOT NULL,
  PRA_VALOR_DEBITOS   NUMBER(10,2)              DEFAULT 0                     NOT NULL,
  PRA_VALOR_SALDO     NUMBER(10,2)              DEFAULT 0                     NOT NULL,
  PRA_VALOR_FINAL     NUMBER(10,2)              DEFAULT 0                     NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_PLANO_CONTAS_CLASSIFICAR
(
  SEQ_ITEM      NUMBER                          NOT NULL,
  COD_CONTA     NUMBER                          NOT NULL,
  DSC_CONDICAO  VARCHAR2(800 BYTE)              NOT NULL,
  STA_BLOQ      VARCHAR2(1 BYTE)                DEFAULT 'N'                   NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_PLANO_CONTAS
(
  COD_CONTA        NUMBER                       NOT NULL,
  DSC_CONTA        VARCHAR2(80 BYTE)            NOT NULL,
  TPO_CONTA_PLANO  VARCHAR2(1 BYTE)             NOT NULL,
  COD_CONTA_REF    NUMBER,
  STA_COMPLEMENTO  VARCHAR2(1 BYTE)             DEFAULT 'N'                   NOT NULL,
  DM_TP_CONTA      VARCHAR2(1 BYTE)             DEFAULT 'D'                   NOT NULL,
  STA_HOLDING      VARCHAR2(1 BYTE)             DEFAULT 'S'                   NOT NULL,
  STA_BLOQ         VARCHAR2(1 BYTE)             DEFAULT 'N'                   NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE FIN_EXTRATOS_ITENS
(
  SEQ_INSTITUICAO  NUMBER                       NOT NULL,
  SEQ_EXTRATO      NUMBER                       NOT NULL,
  SEQ_ITEM         NUMBER                       NOT NULL,
  COD_CONTA        NUMBER                       NOT NULL,
  DAT_LANCTO       DATE                         NOT NULL,
  DSC_LANCTO       VARCHAR2(80 BYTE)            NOT NULL,
  VAL_LANCTO       NUMBER(10,2)                 NOT NULL,
  VAL_SALDO        NUMBER(10,2)
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX FIN_EXTRATOS1_PK ON FIN_EXTRATOS
(SEQ_INSTITUICAO, SEQ_EXTRATO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_PLANO_CONTAS_CLASS_PK ON FIN_PLANO_CONTAS_CLASSIFICAR
(SEQ_ITEM)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_PLANO_CONTAS_PK ON FIN_PLANO_CONTAS
(COD_CONTA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX PAL_PK ON PROJECAO_ARQUIVOS_LANC
(PRA_SQ, PAL_SQ)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_EXTRATOS_BB_PK ON FIN_EXTRATOS_ITENS_TMP
(SEQ_EXTRATO, SEQ_LINHA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_EXTRATOS_PK ON FIN_EXTRATOS_TMP
(SEQ_EXTRATO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX PRA_PK ON PROJECAO_ARQUIVOS
(PRA_SQ)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX INTERFACE_PREFIXO_PK ON FIN_INTERFACE_PREFIXO
(SEQ_INSTITUICAO, COD_PREFIXO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_INTERFACE_PK ON FIN_INTERFACE
(SEQ_INSTITUICAO, COD_PREFIXO, SEQ_INTERFACE)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_INSTITUICAO_PK ON FIN_INSTITUICAO
(SEQ_INSTITUICAO)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX PCA_PK ON PROJECAO_CONTAS
(PCA_SQ)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_EXTRATOS_CTB_PK ON FIN_EXTRATOS_CTB
(SEQ_INSTITUICAO, SEQ_EXTRATO, MES_LANCTO, ANO_LANCTO, VAL_NIVEL, 
COD_CONTA)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_EXTRATOS_ITENS_PK ON FIN_EXTRATOS_ITENS
(SEQ_INSTITUICAO, SEQ_EXTRATO, SEQ_ITEM)
LOGGING
NOPARALLEL;


CREATE OR REPLACE Package pkg_teste Is

	 -- Author  : CARLOS
	 -- Created : 14/12/2020 14:17:06
	 -- Purpose : tesar alterar ordem

	 Procedure prc_move(p_seq_instituicao In fin_interface.seq_instituicao%Type,
											p_cod_prefixo     In fin_interface.cod_prefixo%Type,
											p_seq_interface   In fin_interface.seq_interface%Type,
											p_seq_campo       In fin_interface.seq_campo%Type,
											p_novo_campo      In fin_interface.seq_campo%Type,
											p_tpo_alt         In Varchar2);

End pkg_teste;
/

SHOW ERRORS;


CREATE OR REPLACE Package pkg_projecao Is

	 -- Author  : CARLOS
	 -- Created : 19/10/2020 09:53:55
	 -- Purpose : Encapsulamento dos métodos do modulo Projeção

	 -- Atualizar PROJECAO_ARQUIVOS
	 Procedure prc_atualizartotais_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type);

	 -- Criar arquivo historico a partir do Cadastro
	 Procedure prc_criar_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type);

	 -- excluir arquivo historico
	 Procedure prc_excluir_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type);

End pkg_projecao;
/

SHOW ERRORS;


CREATE OR REPLACE Package pkg_extratos Is

   -- Author  : CARLOS
   -- Created : 23/12/2020 08:19:14
   -- Purpose : Encapsular os metodos de Rceber e tratar extratos bancários

   -- tabela de interface layout de entrada
   Type r_layout Is Record(
	  nome        Varchar2(100),
	  descricao   Varchar2(100),
	  pos_inicial Number,
	  tamanho     Number,
	  mascara     Varchar2(100),
	  tipo        Varchar2(1),
	  conteudo    Varchar2(100));
   Type t_layout Is Table Of r_layout Index By Binary_Integer;
   tb_layout t_layout;
   v_id      Number := 0;

   v_dat_anterior      Date;
   v_val_saldo_inicial fin_extratos.val_saldo_inicial%Type := 0;
   v_tpo_extrato       fin_instituicao.tpo_extrato%Type := Null;

   Procedure prc_excluir_extrato_tmp(p_seq_extrato In fin_extratos_tmp.seq_extrato%Type);

   Procedure prc_incluir_header;

   Procedure prc_encerra_extrato_tmp;

   Function fnc_rec_num_extrato Return Number;

   Procedure prc_classificar_tmp(p_seq_extrato In fin_extratos_tmp.seq_extrato%Type);

   Procedure prc_gerar_holding
   (
	  p_seq_instituicao In fin_extratos.seq_instituicao%Type,
	  p_seq_extrato     In fin_extratos.seq_extrato%Type,
	  p_mes_lancto      In fin_extratos.mes_lancto%Type,
	  p_ano_lancto      In fin_extratos.ano_lancto%Type
   );

   Procedure prc_excluir_extrato(p_seq_extrato In fin_extratos_tmp.seq_extrato%Type);

   Procedure prc_gerar_extrato(p_seq_extrato_tmp In fin_extratos_tmp.seq_extrato%Type);

   Procedure prc_gerar_det
   (
	  p_seq_extrato_tmp In fin_extratos_tmp.seq_extrato%Type,
	  p_seq_extrato     In fin_extratos.seq_extrato%Type,
	  p_seq_instituicao In fin_extratos.seq_instituicao%Type
   );

   Procedure prc_gerar_vencimentos
   (
	  p_seq_extrato_tmp In fin_extratos_tmp.seq_extrato%Type,
	  p_seq_extrato     In fin_extratos.seq_extrato%Type,
	  p_seq_instituicao In fin_extratos.seq_instituicao%Type,
	  p_mes_lancto      In Out fin_extratos.mes_lancto%Type,
	  p_ano_lancto      In Out fin_extratos.ano_lancto%Type
   );

   Procedure prc_popula_interface
   (
	  p_seq_instituicao In fin_extratos_tmp.seq_extrato%Type,
	  p_cod_prefixo     In fin_interface.cod_prefixo%Type
   );

   -- Retorna o saldo da somatoria da conta (3 NIVEIS hierarquia)
   Function fnc_rec_saldo
   (
	  p_seq_instituicao In fin_extratos.seq_extrato%Type,
	  p_seq_extrato     In fin_extratos.seq_extrato%Type,
	  p_cod_conta       In fin_plano_contas.cod_conta%Type
	  
   ) Return Number;

End pkg_extratos;
/

SHOW ERRORS;


CREATE OR REPLACE Package pac_interface Is

	 /* Movimentação do Registros na Tela de Interface */
	 /* Conversão de Linha de Arquivo Texto */

	 Procedure prc_movimenta_registro(p_seq_instituicao In fin_interface.seq_instituicao%Type,
																		p_cod_prefixo     In fin_interface.cod_prefixo%Type,
																		p_seq_interface   In fin_interface.seq_interface%Type,
																		p_seq_campo       In fin_interface.seq_campo%Type,
																		p_reg_corrente    In fin_interface.seq_campo%Type,
																		p_tpo_atualiz     In Varchar2);
End pac_interface;
/

SHOW ERRORS;


CREATE OR REPLACE PACKAGE cg$PROJECAO_ARQUIVOS_LANC IS


called_from_package BOOLEAN := FALSE;

--  Repository User-Defined Error Messages
PAL_PK CONSTANT VARCHAR2(240) := '';
PAL_PRA_FK CONSTANT VARCHAR2(240) := '';
PAL_PCA_FK CONSTANT VARCHAR2(240) := '';

--  Column default prompts. Format PSEQNO_COL
P10PRA_SQ CONSTANT VARCHAR2(240) := 'Pra Pra Sq';
P20PCA_SQ CONSTANT VARCHAR2(240) := 'Pca Pca Sq';
P22PAL_SQ CONSTANT VARCHAR2(240) := 'Pal Sq';
P24PAL_VALOR CONSTANT VARCHAR2(240) := 'Pal Valor';

cg$row PROJECAO_ARQUIVOS_LANC%ROWTYPE;

--  PROJECAO_ARQUIVOS_LANC row type variable
TYPE cg$row_type IS RECORD
(PRA_SQ cg$row.PRA_SQ%TYPE
,PCA_SQ cg$row.PCA_SQ%TYPE
,PAL_SQ cg$row.PAL_SQ%TYPE
,PAL_VALOR cg$row.PAL_VALOR%TYPE
,the_rowid ROWID)
;

--  PROJECAO_ARQUIVOS_LANC indicator type variable
TYPE cg$ind_type IS RECORD
(PRA_SQ BOOLEAN DEFAULT FALSE
,PCA_SQ BOOLEAN DEFAULT FALSE
,PAL_SQ BOOLEAN DEFAULT FALSE
,PAL_VALOR BOOLEAN DEFAULT FALSE);

cg$ind_true cg$ind_type;

--  PROJECAO_ARQUIVOS_LANC primary key type variable
TYPE cg$pk_type IS RECORD
(PRA_SQ cg$row.PRA_SQ%TYPE
,the_rowid ROWID)
;

--  PL/SQL Table Type variable for triggers
TYPE cg$table_type IS TABLE OF PROJECAO_ARQUIVOS_LANC%ROWTYPE
     INDEX BY BINARY_INTEGER;
cg$table cg$table_type;

TYPE cg$tableind_type IS TABLE OF cg$ind_type
     INDEX BY BINARY_INTEGER;
cg$tableind cg$tableind_type;
idx BINARY_INTEGER := 1;

PROCEDURE   ins(cg$rec IN OUT cg$row_type,
                cg$ind IN OUT cg$ind_type,
                do_ins IN BOOLEAN DEFAULT TRUE
               );
PROCEDURE   upd(cg$rec             IN OUT cg$row_type,
                cg$ind             IN OUT cg$ind_type,
                do_upd             IN BOOLEAN     DEFAULT TRUE,
                cg$pk              IN cg$row_type DEFAULT NULL
               );
PROCEDURE   del(cg$pk  IN cg$pk_type,
                do_del IN BOOLEAN DEFAULT TRUE
               );
PROCEDURE   lck(cg$old_rec  IN cg$row_type,
                cg$old_ind  IN cg$ind_type,
                nowait_flag IN BOOLEAN DEFAULT TRUE
               );
PROCEDURE   slct(cg$sel_rec IN OUT cg$row_type);

PROCEDURE   validate_arc(cg$rec IN OUT cg$row_type);

PROCEDURE   validate_domain(cg$rec IN OUT cg$row_type,
                            cg$ind IN cg$ind_type DEFAULT cg$ind_true);

PROCEDURE   validate_foreign_keys_ins(cg$rec IN cg$row_type);
PROCEDURE   validate_foreign_keys_upd(cg$rec IN cg$row_type,
                                      cg$old_rec IN cg$row_type,
                                      cg$ind IN cg$ind_type);
PROCEDURE   validate_foreign_keys_del(cg$rec IN cg$row_type);

PROCEDURE   validate_domain_cascade_delete(cg$old_rec IN cg$row_type);
PROCEDURE   validate_domain_cascade_update(cg$old_rec IN cg$row_type);

PROCEDURE   cascade_update(cg$new_rec IN OUT cg$row_type,
                           cg$old_rec IN cg$row_type );
PROCEDURE   domain_cascade_update(cg$new_rec IN OUT cg$row_type,
                                  cg$new_ind IN OUT cg$ind_type,
                                  cg$old_rec IN     cg$row_type);
PROCEDURE   domain_cascade_upd( cg$rec     IN OUT cg$row_type,
                                cg$ind     IN OUT cg$ind_type,
                                cg$old_rec IN     cg$row_type);

PROCEDURE   cascade_delete(cg$old_rec IN OUT cg$row_type);
PROCEDURE   domain_cascade_delete(cg$old_rec IN cg$row_type);

PROCEDURE   upd_denorm2( cg$rec IN cg$row_type,
                         cg$ind IN cg$ind_type );
PROCEDURE   upd_oper_denorm2( cg$rec IN cg$row_type,
                              cg$old_rec IN cg$row_type,
                              cg$ind IN cg$ind_type,
                              operation IN VARCHAR2 DEFAULT 'UPD' );
END cg$PROJECAO_ARQUIVOS_LANC;
/

SHOW ERRORS;


CREATE OR REPLACE PACKAGE cg$errors IS


   CG$ERROR_PACKAGE_VERSION CONSTANT VARCHAR2(20) := '1.1.0';


   -----------------------------------------------------------------------------
   -- Name:        GetErrors
   -- Description: Pops all messages off the stack and returns them in the order
   --              in which they were raised.
   -- Parameters:  none
   -- Returns:     The messages
   -----------------------------------------------------------------------------
   FUNCTION GetVersion return VARCHAR2;

   -----------------------------------------------------------------------------
   -- Name:        GetErrors
   -- Description: Pops all messages off the stack and returns them in the order
   --              in which they were raised.
   -- Parameters:  none
   -- Returns:     The messages
   -----------------------------------------------------------------------------
   FUNCTION GetErrors
        return varchar2;

   -----------------------------------------------------------------------------
   -- Name:        pop
   -- Description: Take a message off stack
   --              Gets the error message that was last raised and removes it
   --              from the error stack.
   -- Parameters:  msg     Text message
   -- Returns:     TRUE    Message popped successfully
   --              FALSE   Stack was empty
   -----------------------------------------------------------------------------
   FUNCTION pop(msg OUT VARCHAR2)
           RETURN BOOLEAN;


   -----------------------------------------------------------------------------
   -- Name:        pop (overload)
   -- Description: Take a message off stack with full info
   -- Parameters:  msg      Ttext message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -- Returns:     TRUE     Message popped successfully
   --              FALSE    Stack was empty
   -----------------------------------------------------------------------------
   FUNCTION pop(msg        OUT VARCHAR2
               ,error      OUT VARCHAR2
               ,msg_type   OUT VARCHAR2
               ,msgid      OUT INTEGER
               ,loc        OUT VARCHAR2)
           RETURN BOOLEAN;


   -----------------------------------------------------------------------------
   -- Name:        pop_head
   -- Description: Take a message off stack from head
   --              Gets the error message that was last raised and removes it
   --              from the error stack.
   -- Parameters:  msg     Text message
   -- Returns:     TRUE    Message popped successfully
   --              FALSE   Stack was empty
   -----------------------------------------------------------------------------
   FUNCTION pop_head(msg OUT VARCHAR2)
           RETURN BOOLEAN;


   -----------------------------------------------------------------------------
   -- Name:        pop_head (overload)
   -- Description: Take a message off stack from head with full info
   -- Parameters:  msg      Ttext message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -- Returns:     TRUE     Message popped successfully
   --              FALSE    Stack was empty
   -----------------------------------------------------------------------------
   FUNCTION pop_head(msg        OUT VARCHAR2
                     ,error      OUT VARCHAR2
                     ,msg_type   OUT VARCHAR2
                     ,msgid      OUT INTEGER
                     ,loc        OUT VARCHAR2)
           RETURN BOOLEAN;


   -----------------------------------------------------------------------------
   -- Name:        raise_failure
   --
   -- Description: To raise the cg$error failure exception handler
   -----------------------------------------------------------------------------
   PROCEDURE raise_failure;


   -----------------------------------------------------------------------------
   -- Name:        clear
   -- Description: Clears the stack
   -- Parameters:  none
   -----------------------------------------------------------------------------
   PROCEDURE clear;


   -----------------------------------------------------------------------------
   -- Name:        push
   --
   -- Description: Put a message on stack with full info
   --
   -- Parameters:  msg      Text message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -----------------------------------------------------------------------------
   PROCEDURE push(msg          IN VARCHAR2
                 ,error        IN VARCHAR2 DEFAULT 'E'
                 ,msg_type     IN VARCHAR2 DEFAULT NULL
                 ,msgid        IN INTEGER  DEFAULT 0
                 ,loc          IN VARCHAR2 DEFAULT NULL);


   -----------------------------------------------------------------------------
   -- Name:        MsgGetText
   -- Description: Provides a mechanism for text translation.
   -- Parameters:  p_MsgNo    The Id of the message
   --              p_DfltText The Default Text
   --              p_Subst1 (to 4) Substitution strings
   --              p_LangId   The Language ID
   -- Returns:		Translated message
   -----------------------------------------------------------------------------
   FUNCTION MsgGetText(p_MsgNo    IN NUMBER,
                       p_DfltText IN VARCHAR2 DEFAULT NULL,
                       p_Subst1   IN VARCHAR2 DEFAULT NULL,
                       p_Subst2   IN VARCHAR2 DEFAULT NULL,
                       p_Subst3   IN VARCHAR2 DEFAULT NULL,
                       p_Subst4   IN VARCHAR2 DEFAULT NULL,
                       p_LangId   IN NUMBER   DEFAULT NULL)
           RETURN VARCHAR2;


   -----------------------------------------------------------------------------
   -- Name:        parse_constraint
   -- Description: Isolate constraint name from an Oracle error message
   -- Parameters:  msg     The actual Oracle error message
   --              type    type of constraint to find
   --                      (ERR_FOREIGN_KEY     Foreign key,
   --                       ERR_CHECK_CON       Check,
   --                       ERR_UNIQUE_KEY      Unique key,
   --                       ERR_DELETE_RESTRICT Restricted delete)
   -- Returns:     con_name Constraint found (NULL if none found)
   -----------------------------------------------------------------------------
   FUNCTION parse_constraint(msg  IN VARCHAR2
                            ,type IN INTEGER)
           RETURN VARCHAR2;



   --
   -- Exception raised when any API validation fails
   --
   cg$error EXCEPTION;


   --
   -- Standard Oracle Errors that are caught and processed by the API
   --
   mandatory_missing   EXCEPTION;
   check_violation     EXCEPTION;
   fk_violation        EXCEPTION;
   upd_mandatory_null  EXCEPTION;
   delete_restrict     EXCEPTION;
   uk_violation        EXCEPTION;
   resource_busy       EXCEPTION;
   no_data_found       EXCEPTION;
   trg_mutate          EXCEPTION;

   ERR_UK_UPDATE    CONSTANT VARCHAR2(240) := 'Unique key <p1> not updateable';
   ERR_FK_TRANS     CONSTANT VARCHAR2(240) := 'Foreign key <p1> not transferable';
   ERR_DEL_RESTRICT CONSTANT VARCHAR2(240) := 'Cannot delete <p1> row, matching <p2> found';
   VAL_MAND         CONSTANT VARCHAR2(240) := 'Value for <p1> is required';
   ROW_MOD	        CONSTANT VARCHAR2(240) := 'Update failed - please re-query as value for <p1> has been modified by another user<p2><p3>';
   ROW_LCK          CONSTANT VARCHAR2(240) := 'Row is locked by another user';
   ROW_DEL          CONSTANT VARCHAR2(240) := 'Row no longer exists';
   APIMSG_PK_VIOLAT CONSTANT VARCHAR2(240) := 'Primary key <p1> on table <p2> violated';
   APIMSG_UK_VIOLAT CONSTANT VARCHAR2(240) := 'Unique constraint <p1> on table <p2> violated';
   APIMSG_FK_VIOLAT CONSTANT VARCHAR2(240) := 'Foreign key <p1> on table <p2> violated';
   APIMSG_CK_VIOLAT CONSTANT VARCHAR2(240) := 'Check constraint <p1> on table <p2> violated';
   APIMSG_ARC_MAND_VIOLAT   CONSTANT VARCHAR2(240) := 'Mandatory Arc <p1> on <p2> has not been satisfied';
   APIMSG_ARC_VIOLAT        CONSTANT VARCHAR2(240) := 'Too many members in Arc <p1> on <p2>';
   APIMSG_RV_TAB_NOT_FOUND  CONSTANT VARCHAR2(240) := 'Reference code table <p1> has not been created used for <p2>';
   APIMSG_RV_LOOKUP_FAIL    CONSTANT VARCHAR2(240) := 'Invalid value <p1> for column <p2>.<p3>';
   APIMSG_RV_LOOKUP_DO_FAIL CONSTANT VARCHAR2(240) := 'Invalid value <p1> in domain <p2> for column <p3>.<p4>';
   APIMSG_CODE_CTL_LOCKED   CONSTANT VARCHAR2(240) := 'Control table sequence value <p1> is being used by another user';
   APIMSG_FK_VALUE_REQUIRED CONSTANT VARCHAR2(240) := 'Value required for <p1> foreign key';
   APIMSG_CASC_ERROR        CONSTANT VARCHAR2(240) := 'Error in cascade <p1>';
   APIMSG_DO_LOOKUP_DO_FAIL CONSTANT VARCHAR2(240) := 'Invalid values in domain constraint <p1> referring domain table <p2> for table <p3>';


   API_UNIQUE_KEY_UPDATE   CONSTANT    INTEGER := 1001;
   API_FOREIGN_KEY_TRANS   CONSTANT    INTEGER := 1002;
   API_MODIFIED            CONSTANT    INTEGER := 1003;
   API_CK_CON_VIOLATED     CONSTANT    INTEGER := 1004;
   API_FK_CON_VIOLATED     CONSTANT    INTEGER := 1005;
   API_UQ_CON_VIOLATED     CONSTANT    INTEGER := 1006;
   API_PK_CON_VIOLATED     CONSTANT    INTEGER := 1007;
   API_MAND_COLUMN_ISNULL  CONSTANT    INTEGER := 1008;
   API_MAND_ARC_EMPTY      CONSTANT    INTEGER := 1009;
   API_ARC_TOO_MANY_VAL    CONSTANT    INTEGER := 1010;
   API_DEL_RESTRICT        CONSTANT    INTEGER := 1011;
   API_RV_TAB_NOT_FOUND    CONSTANT    INTEGER := 1012;
   API_RV_LOOKUP_FAIL      CONSTANT    INTEGER := 1013;
   API_RV_LOOKUP_DO_FAIL   CONSTANT    INTEGER := 1014;
   API_CODE_CTL_LOCKED     CONSTANT    INTEGER := 1015;
   API_FK_VALUE_REQUIRED   CONSTANT    INTEGER := 1016;
   API_CASC_ERROR          CONSTANT    INTEGER := 1017;
   API_ROW_MOD             CONSTANT    INTEGER := 1018;
   API_ROW_LCK             CONSTANT    INTEGER := 1019;
   API_ROW_DEL             CONSTANT    INTEGER := 1020;


   ERR_FOREIGN_KEY     CONSTANT    INTEGER := -2291;
   ERR_CHECK_CON       CONSTANT    INTEGER := -2290;
   ERR_UNIQUE_KEY      CONSTANT    INTEGER := -1;
   ERR_MAND_MISSING    CONSTANT    INTEGER := -1400;
   ERR_UPDATE_MAND     CONSTANT    INTEGER := -1407;
   ERR_RESOURCE_BUSY   CONSTANT    INTEGER := -54;
   ERR_NO_DATA         CONSTANT    INTEGER :=  1403;
   ERR_DELETE_RESTRICT CONSTANT    INTEGER := -2292;



   PRAGMA EXCEPTION_INIT(mandatory_missing,    -1400);
   PRAGMA EXCEPTION_INIT(check_violation,      -2290);
   PRAGMA EXCEPTION_INIT(fk_violation,         -2291);
   PRAGMA EXCEPTION_INIT(upd_mandatory_null,   -1407);
   PRAGMA EXCEPTION_INIT(delete_restrict,      -2292);
   PRAGMA EXCEPTION_INIT(uk_violation,         -0001);
   PRAGMA EXCEPTION_INIT(resource_busy,        -0054);
   PRAGMA EXCEPTION_INIT(trg_mutate,           -4091);

   PRAGMA EXCEPTION_INIT(cg$error,           -20999);

   TYPE cg$err_msg_t       IS TABLE OF VARCHAR2(512)   INDEX BY BINARY_INTEGER;
   TYPE cg$err_error_t     IS TABLE OF VARCHAR2(1)     INDEX BY BINARY_INTEGER;
   TYPE cg$err_msg_type_t  IS TABLE OF VARCHAR2(3)     INDEX BY BINARY_INTEGER;
   TYPE cg$err_msgid_t     IS TABLE OF INTEGER         INDEX BY BINARY_INTEGER;
   TYPE cg$err_loc_t       IS TABLE OF VARCHAR2(240)   INDEX BY BINARY_INTEGER;
   cg$err_tab_i INTEGER := 1;


END cg$errors;
/

SHOW ERRORS;


CREATE OR REPLACE Package Body pkg_teste Is
	 -- Author  : CARLOS
	 -- Created : 14/12/2020 14:17:06
	 -- Purpose : tesar alterar ordem

	 Procedure prc_move(p_seq_instituicao In fin_interface.seq_instituicao%Type,
											p_cod_prefixo     In fin_interface.cod_prefixo%Type,
											p_seq_interface   In fin_interface.seq_interface%Type,
											p_seq_campo       In fin_interface.seq_campo%Type,
											p_novo_campo      In fin_interface.seq_campo%Type,
											p_tpo_alt         In Varchar2) Is
	 
			Cursor c1 Is
				 Select seq_interface, seq_campo, val_tamanho
					 From fin_interface
					Where seq_instituicao = p_seq_instituicao And
								cod_prefixo = p_cod_prefixo
					Order By seq_campo;
			r1 c1%Rowtype;
	 
			v_seq_interface fin_interface.seq_interface%Type;
			v_pos_inicial		fin_interface.pos_inicial%type;
			v_pos_final			fin_interface.pos_final%type;
			
	 
	 Begin
	 
			If p_tpo_alt = 'A' Then
			
				 Begin
						-- guardar o seq_imterface do novo campo no caso 3
						Select seq_interface
							Into v_seq_interface
							From fin_interface
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_campo = p_novo_campo; ----no caso aqui é 3
				 Exception
						When Others Then
							 raise_application_error(-20001, 'Erro selecionar');
				 End;
				 Commit; -- apenas para teste.
			
				 Begin
						Update fin_interface
						-- Alterar o registro a ser trocado, 
							 Set seq_campo = 9999 -- altear onde sera o destino neste caso 4
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_campo = p_seq_interface; -- 
				 Exception
						When Others Then
							 raise_application_error(-20002, 'Erro Alterar o registro a ser trocado, 9999');
				 End;
				 Commit;
			
				 Begin
						Update fin_interface
							 Set seq_campo = p_seq_campo
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_interface = v_seq_interface;
				 Exception
						When Others Then
							 raise_application_error(-20003, 'Erro ao colocar novo campo');
				 End;
				 Commit;
			
				 Begin
						Update fin_interface
						-- Alterar o registro a ser trocado, 
							 Set seq_campo = v_seq_interface -- altear onde sera o destino neste caso 4
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_interface = p_seq_interface;
				 Exception
						When Others Then
							 raise_application_error(-20004, 'erro ao acertar origem');
				 End;
				 Commit;
			
			End If;
	 
			Open c1;
			Loop
				 Fetch c1
						Into r1.seq_interface, r1.seq_campo, r1.val_tamanho;
				 Exit When c1%Notfound;
			
				 If r1.seq_campo = 1 Then
						v_pos_inicial := 1;
				 Else
						v_pos_inicial := v_pos_final + 1;
				 End If;
			
				 v_pos_final := v_pos_inicial + r1.val_tamanho - 1;
			
				 Update fin_interface fi
						Set fi.pos_inicial = v_pos_inicial,
								fi.pos_final   = v_pos_final,
								fi.val_tamanho = r1.val_tamanho
					Where seq_instituicao = p_seq_instituicao And
								cod_prefixo = p_cod_prefixo And
								fi.seq_interface = r1.seq_interface;
			
			End Loop;
	 
			Close c1;
	 
	 End;

End pkg_teste;
/

SHOW ERRORS;


CREATE OR REPLACE Package Body pkg_projecao Is

	 -- Author  : CARLOS
	 -- Created : 19/10/2020 09:53:55
	 -- Purpose : Encapsulamento dos métodos do modulo Projeção

	 -- Atualizar PROJECAO_ARQUIVOS
	 Procedure prc_atualizartotais_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type) Is
	 
			v_pra_valor_creditos projecao_arquivos.pra_valor_creditos%Type := Null;
			v_pra_valor_debitos  projecao_arquivos.pra_valor_debitos%Type := Null;
			v_pra_valor_saldo    projecao_arquivos.pra_valor_saldo%Type := Null;
	 
	 Begin
			-- Calcula valores totais
			Select Sum(x.valor_creditos), Sum(x.valor_debitos), Sum(x.valor_saldo)
				Into v_pra_valor_creditos, v_pra_valor_debitos, v_pra_valor_saldo
				From (Select Case
												When pal_valor > 0 Then
												 pal_valor
												Else
												 0
										 End valor_creditos,
										 Case
												When pal_valor < 0 Then
												 pal_valor
												Else
												 0
										 End valor_debitos,
										 pal_valor valor_saldo
								From projecao_arquivos_lanc
							 Where pra_sq = p_pra_sq) x;
	 
			Commit;
	 
	 End;

	 -- Criar arquivo historico a partir do Cadastro
	 Procedure prc_criar_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type) Is
	 
			v_pra_sq projecao_arquivos.pra_sq%Type := Null;
	 
	 Begin
	 
			Begin
				 --seleco da proximas SEQ para o cadastro
				 Select seq_projecao_arquivos.Nextval Into v_pra_sq From dual;
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20001,
																		' Erro ao ler sequencie seq_projecao_arquivos! ' || Sqlerrm);
			End;
	 
			Begin
				 Insert Into projecao_arquivos
						(pra_sq,
						 pra_data,
						 pra_descricao,
						 pra_dm_tp_projecao,
						 pra_dm_tp_arquivo,
						 pra_valor_inicial,
						 pra_valor_creditos,
						 pra_valor_debitos,
						 pra_valor_saldo)
						Select v_pra_sq,
									 pra_data,
									 pra_descricao,
									 pra_dm_tp_projecao,
									 'H', -- pra_dm_tp_arquivo,
									 pra_valor_inicial,
									 pra_valor_creditos,
									 pra_valor_debitos,
									 pra_valor_saldo
							From projecao_arquivos
						 Where pra_sq = p_pra_sq;
			
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20002, Sqlerrm || ' Erro ao incluir a Tabela projecao_arquivos!');
			End;
	 
			Begin
				 Insert Into projecao_arquivos_lanc
						(pra_sq, pca_sq, pal_sq, pal_data, pal_valor)
						Select v_pra_sq,
									 pal.pca_sq,
									 seq_projecao_arquivos_lanc.Nextval,
									 pal.pal_data,
									 pal.pal_valor
							From projecao_arquivos_lanc pal
						 Where pra_sq = p_pra_sq;
			
			Exception
				 When Others Then
						Rollback;
						raise_application_error(-20003,
																		Sqlerrm || ' Erro ao incluir a Tabela projecao_arquivos_lanc!');
			End;
	 
			Commit;
	 
	 End prc_criar_arquivo;

	 -- excluir arquivo historico
	 Procedure prc_excluir_arquivo(p_pra_sq In projecao_arquivos.pra_sq%Type) Is
	 
	 Begin
	 
			Delete projecao_arquivos_lanc Where pra_sq = p_pra_sq;
			Delete projecao_arquivos Where pra_sq = p_pra_sq;
			Commit;
	 
	 Exception
			When Others Then
				 Rollback;
				 raise_application_error(-20003, Sqlerrm || ' Erro ao excluir arquivo: ' || p_pra_sq || ' !');
	 End prc_excluir_arquivo;

End pkg_projecao;
/

SHOW ERRORS;


CREATE OR REPLACE Package Body pkg_extratos Is

   -- Author  : CARLOS
   -- Created : 23/12/2020 08:19:14
   -- Purpose : Encapsular os metodos de Rceber e tratar extratos bancários

   Procedure prc_excluir_extrato_tmp(p_seq_extrato In fin_extratos_tmp.seq_extrato%Type) Is
   
   Begin
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Deletar arquivos 
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
   
	  Delete fin_extratos_itens_tmp ei
	  Where  ei.seq_extrato = p_seq_extrato;
   
	  Delete fin_extratos_tmp ei
	  Where  ei.seq_extrato = p_seq_extrato;
   
	  Commit;
   
   Exception
	  When no_data_found Then
		 Null;
	  When Others Then
		 raise_application_error(-20001, 'Erro ao deletar arquivo tmp! ' || Sqlerrm);
   End prc_excluir_extrato_tmp;

   Procedure prc_incluir_header Is
   
	  v_seq_extrato fin_extratos_tmp.seq_extrato%Type;
   
   Begin
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Incluir Hearder para permitir o LOADER das linhas 
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
   
	  Select sq_fin_extratos_tmp.Nextval
	  Into   v_seq_extrato
	  From   dual;
   
	  Insert Into fin_extratos_tmp
		 (seq_extrato, dsc_extrato, dat_exe, usuario, sta_extrato)
	  Values
		 (v_seq_extrato, 'CLASSIFICAR', Sysdate, User, 'A');
   
	  Commit;
   
   Exception
	  When Others Then
		 raise_application_error(-20002, 'Erro ao incluir tabela fin_extratos_tmp! ' || Sqlerrm);
   End prc_incluir_header;

   Procedure prc_encerra_extrato_tmp Is
   
	  v_seq_extrato     fin_extratos_tmp.seq_extrato%Type;
	  v_aux             Number := 0;
	  v_seq_instituicao fin_extratos_tmp.seq_instituicao%Type;
	  v_dsc_extrato     fin_extratos_tmp.dsc_extrato%Type;
   Begin
   
	  v_seq_extrato := fnc_rec_num_extrato;
   
	  --Recupera seq_instituicao atraves da frase
	  For r In (Select seq_instituicao, dsc_instituicao, dsc_frase
				From   fin_instituicao
				Where  dsc_instituicao Is Not Null And
					   sta_bloq <> 'S') Loop
	  
		 Select Count(1)
		 Into   v_aux
		 From   financeiro.fin_extratos_itens_tmp
		 Where  seq_extrato = v_seq_extrato And
				upper(dsc_linha) Like
				(Select '%' || upper(dsc_frase) || '%'
				 From   financeiro.fin_instituicao
				 Where  seq_instituicao = r.seq_instituicao);
	  
		 If v_aux > 0 Then
			v_seq_instituicao := r.seq_instituicao;
			v_dsc_extrato     := r.dsc_instituicao;
			Exit;
		 End If;
	  
	  End Loop;
   
	  /*      IF v_seq_instituicao = 1 then 
        prc_padronizar_arquivo((v_seq_extrato);
      end if;*/
   
	  prc_classificar_tmp(v_seq_extrato);
   
	  Update fin_extratos_tmp
	  Set    seq_instituicao = v_seq_instituicao,
			 dsc_extrato     = v_dsc_extrato,
			 sta_extrato     = decode(sta_extrato, 'A', 'R', sta_extrato)
	  Where  seq_extrato = v_seq_extrato;
   
   End prc_encerra_extrato_tmp;

   Function fnc_rec_num_extrato Return Number Is
   
	  v_seq_extrato fin_extratos_tmp.seq_extrato%Type;
   
   Begin
	  Select seq_extrato
	  Into   v_seq_extrato
	  From   fin_extratos_tmp
	  Where  usuario = User And
			 sta_extrato = 'A';
   
	  Return v_seq_extrato;
   
   End;

   Procedure prc_classificar_tmp(p_seq_extrato In fin_extratos_tmp.seq_extrato%Type) Is
   
	  Type rc Is Ref Cursor;
	  l_cursor       rc;
	  sql_stmt       Varchar2(2000);
	  v_linha_cursor Varchar2(2000);
	  v_linha        Number;
	  v_select       Varchar2(2000);
	  v_classificar  Number := 0;
	  v_referencia   Number := 0;
	  v_tpo_extrato  fin_instituicao.tpo_extrato%Type;
   
	  Cursor c_classif Is
		 Select pc.cod_conta, upper(pc.dsc_condicao) dsc_condicao
		 From   financeiro.fin_plano_contas_classificar pc
		 Where  pc.sta_bloq = 'N' /* And
                                                             pc.seq_item = 78*/
		 Order  By pc.seq_item;
   
   Begin
   
	  For r_cod In c_classif Loop
	  
		 v_select := 'SELECT 
			                DSC_LINHA HOT_LINHA, SEQ_LINHA ' ||
					 'FROM FINANCEIRO.FIN_EXTRATOS_ITENS_TMP ' || 'WHERE seq_extrato = ' ||
					 p_seq_extrato || ' and cod_conta <> 3000004' || ' and UPPER(DSC_LINHA) ' ||
					 r_cod.dsc_condicao;
	  
		 sql_stmt := v_select;
		 Open l_cursor For sql_stmt;
		 Loop
			Fetch l_cursor
			   Into v_linha_cursor, v_linha;
			Exit When l_cursor%Notfound;
		 
			Update financeiro.fin_extratos_itens_tmp
			Set    cod_conta = r_cod.cod_conta
			Where  seq_extrato = p_seq_extrato And
				   seq_linha = v_linha;
		 
		 End Loop;
		 Close l_cursor;
	  
	  End Loop;
   
	  -- Verifica se todas as linhas foram classificadas. 
	  Select Count(*)
	  Into   v_classificar
	  From   financeiro.fin_extratos_itens_tmp
	  Where  seq_extrato = p_seq_extrato And
			 cod_conta = 3000001;
   
	  If v_classificar = 0 Then
		 Update fin_extratos_tmp
		 Set    sta_extrato = 'C'
		 Where  seq_extrato = p_seq_extrato;
	  End If;
   
	  Commit;
   
   Exception
	  When Others Then
		 Rollback;
		 raise_application_error(-20002, 'Erro ao classificar arquivo temporário');
	  
   End prc_classificar_tmp;

   Procedure prc_gerar_holding
   (
	  p_seq_instituicao In fin_extratos.seq_instituicao%Type,
	  p_seq_extrato     In fin_extratos.seq_extrato%Type,
	  p_mes_lancto      In fin_extratos.mes_lancto%Type,
	  p_ano_lancto      In fin_extratos.ano_lancto%Type
   ) Is
   
	  v_seq_extrato fin_extratos.seq_extrato%Type := 0;
	  v_seq_item    fin_extratos_itens.seq_item%Type := 0;
   
	  v_val_creditos    fin_extratos.val_creditos%Type := 0;
	  v_val_debitos     fin_extratos.val_debitos%Type := 0;
	  v_val_saldo       fin_extratos.val_saldo%Type := 0;
	  v_val_saldo_final fin_extratos.val_saldo_final%Type := 0;
   
	  Cursor c_ext Is
		 Select 0 seq_instituicao, v_seq_extrato,
				'Holding ' || lpad(p_mes_lancto, 2, '0') || '/' || p_ano_lancto dsc_extrato,
				mes_lancto, ano_lancto, val_saldo_inicial, val_creditos, val_debitos, val_saldo,
				val_saldo_final, seq_extrato
		 From   fin_extratos
		 Where  seq_instituicao = p_seq_instituicao And
				seq_extrato = p_seq_extrato;
	  r_ext c_ext%Rowtype;
   
	  Cursor c_itens Is
		 Select 0 seq_instituicao, v_seq_extrato seq_extrato, Int.seq_item, Int.cod_conta,
				Int.dat_lancto, ins.seq_instituicao || ' ' || Int.dsc_lancto dsc_lancto,
				Int.val_lancto, Int.val_saldo
		 From   fin_extratos ext, fin_extratos_itens Int, fin_plano_contas plc, fin_instituicao ins
		 Where  ext.seq_instituicao = Int.seq_instituicao And
				ext.seq_extrato = Int.seq_extrato And
				Int.seq_instituicao = ins.seq_instituicao And
				Int.cod_conta = plc.cod_conta And
				plc.sta_holding = 'S' And
				ext.mes_lancto = p_mes_lancto And
				ext.ano_lancto = p_ano_lancto;
   
   Begin
   
	  -- sequence do FIN_EXTRATOS   
	  Select sq_fin_extratos.Nextval
	  Into   v_seq_extrato
	  From   dual;
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Incluir registro extrato na Holding
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  Begin
		 Open c_ext;
		 Fetch c_ext
			Into r_ext;
	  
		 v_val_saldo_inicial := r_ext.val_saldo_inicial;
	  
		 Insert Into fin_extratos
			(seq_instituicao, seq_extrato, dsc_extrato, mes_lancto, ano_lancto, val_saldo_inicial,
			 val_creditos, val_debitos, val_saldo, val_saldo_final, seq_extrato_tmp)
		 Values
			(r_ext.seq_instituicao, v_seq_extrato, r_ext.dsc_extrato, r_ext.mes_lancto,
			 r_ext.ano_lancto, r_ext.val_saldo_inicial, 0, 0, 0, 0, Null);
	  
		 Close c_ext;
	  
	  Exception
		 When no_data_found Then
			v_val_saldo_inicial := 0;
		 When Others Then
			raise_application_error(-20003, 'Erro ao inserir Extrato Holding');
	  End;
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Incluir itens na Holding
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  Begin
	  
		 v_val_saldo := v_val_saldo_inicial;
	  
		 For r_itens In c_itens Loop
		 
			v_seq_item := v_seq_item + 1;
		 
			v_val_saldo := v_val_saldo + r_itens.val_lancto;
		 
			Insert Into fin_extratos_itens
			   (seq_instituicao, seq_extrato, seq_item, cod_conta, dat_lancto, dsc_lancto,
				val_lancto, val_saldo)
			Values
			   (r_itens.seq_instituicao, r_itens.seq_extrato, v_seq_item, r_itens.cod_conta,
				r_itens.dat_lancto, r_itens.dsc_lancto, r_itens.val_lancto, v_val_saldo);
		 
		 End Loop;
	  
		 --#--#--#--#--#--#--#--#--#--#--#--#--#--#
		 -- Totais v_tpo_extrato B-Banco ou C-Cartão
		 --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  
		 Begin
		 
			Select Sum(Case
						   When pc.dm_tp_conta = 'C' Then -- Debito ou créditos
							ei.val_lancto
						   Else
							0
						End)
			Into   v_val_creditos
			From   fin_extratos_itens ei, fin_plano_contas pc
			Where  ei.cod_conta = pc.cod_conta And
				   ei.seq_instituicao = 0 And
				   ei.seq_extrato = v_seq_extrato;
		 
			Select Sum(Case
						   When pc.dm_tp_conta = 'D' Then
							ei.val_lancto
						   Else
							0
						End)
			Into   v_val_debitos
			From   fin_extratos_itens ei, fin_plano_contas pc
			Where  ei.cod_conta = pc.cod_conta And
				   ei.seq_instituicao = 0 And
				   ei.seq_extrato = v_seq_extrato;
		 
			Update fin_extratos ex
			Set    val_saldo_inicial = v_val_saldo_inicial,
				   val_creditos      = v_val_creditos,
				   val_debitos       = v_val_debitos,
				   val_saldo         = v_val_creditos + v_val_debitos,
				   val_saldo_final   = v_val_saldo_inicial + v_val_creditos + v_val_debitos
			Where  ex.seq_instituicao = 0 And
				   ex.seq_extrato = v_seq_extrato;
		 
		 Exception
			When Others Then
			   Rollback;
			   raise_application_error(-20102, Sqlerrm || ' Erro ao atualizar fin_extrato ');
		 End;
	  
		 Begin
			Insert Into fin_extratos_ctb
			   (seq_instituicao, seq_extrato, mes_lancto, ano_lancto, val_nivel, cod_conta,
				val_conta)
			
			   Select 0, v_seq_extrato, r_ext.mes_lancto, r_ext.ano_lancto, Level,
					  pc.cod_conta,
					  pkg_extratos.fnc_rec_saldo(0, v_seq_extrato, pc.cod_conta) valor
			   From   financeiro.fin_plano_contas pc
			   Where  pkg_extratos.fnc_rec_saldo(0, v_seq_extrato, pc.cod_conta) <> 0
			   Start  With cod_conta_ref Is Null
			   Connect By Prior pc.cod_conta = pc.cod_conta_ref
			   Order  Siblings By pc.cod_conta, pc.dsc_conta;
		 Exception
			When Others Then
			   raise_application_error(-210005, 'Erro ao gerar resumo! ' || Sqlerrm);
		 End;
	  
		 Update fin_extratos_tmp
		 Set    sta_extrato = 'I'
		 Where  seq_instituicao = 0 And
				seq_extrato = v_seq_extrato;
		 Commit;
	  
	  Exception
		 When no_data_found Then
			v_val_saldo_inicial := 0;
		 When Others Then
			raise_application_error(-20003, 'Erro ao Incluir itens Holding');
	  End;
   
   End prc_gerar_holding;

   Procedure prc_excluir_extrato(p_seq_extrato In fin_extratos_tmp.seq_extrato%Type) Is
   
   Begin
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Deletar arquivos 
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#
   
	  Delete fin_extratos_ctb ei
	  Where  ei.seq_extrato = p_seq_extrato;
   
	  Delete fin_extratos_itens ei
	  Where  ei.seq_extrato = p_seq_extrato;
   
	  Delete fin_extratos ei
	  Where  ei.seq_extrato = p_seq_extrato;
   
	  Commit;
   
   Exception
	  When no_data_found Then
		 Null;
	  When Others Then
		 raise_application_error(-20001, 'Erro ao deletar arquivo tmp! ' || Sqlerrm);
   End prc_excluir_extrato;

   Procedure prc_gerar_extrato(p_seq_extrato_tmp In fin_extratos_tmp.seq_extrato%Type) Is
   
	  v_seq_instituicao fin_extratos.seq_instituicao%Type := 0;
	  v_seq_extrato     fin_extratos.seq_extrato%Type := 0;
	  v_dsc_extrato     fin_extratos.dsc_extrato%Type := Null;
	  v_mes_lancto      fin_extratos.mes_lancto%Type := 0;
	  v_ano_lancto      fin_extratos.ano_lancto%Type := 0;
	  v_val_creditos    fin_extratos.val_creditos%Type := 0;
	  v_val_debitos     fin_extratos.val_debitos%Type := 0;
	  v_val_saldo       fin_extratos.val_saldo%Type := 0;
	  v_val_saldo_final fin_extratos.val_saldo_final%Type := 0;
   
   Begin
   
	  -- -- recupera dados fin_extratos_tmp   
	  Begin
		 Select ex.seq_instituicao, ex.dsc_extrato, i.tpo_extrato
		 Into   v_seq_instituicao, v_dsc_extrato, v_tpo_extrato
		 From   fin_extratos_tmp ex, fin_instituicao i
		 Where  ex.seq_instituicao = i.seq_instituicao And
				seq_extrato = p_seq_extrato_tmp;
	  Exception
		 When Others Then
			raise_application_error(-20002, 'Erro ao selecionar dados do arquivo TMP');
	  End;
   
	  -- sequence do FIN_EXTRATOS   
	  Select sq_fin_extratos.Nextval
	  Into   v_seq_extrato
	  From   dual;
   
	  Insert Into fin_extratos
		 (seq_instituicao, seq_extrato, dsc_extrato, mes_lancto, ano_lancto, val_saldo_inicial,
		  val_creditos, val_debitos, val_saldo, val_saldo_final, seq_extrato_tmp)
	  Values
		 (v_seq_instituicao, v_seq_extrato, v_dsc_extrato, v_mes_lancto, v_ano_lancto,
		  v_val_saldo_inicial, v_val_creditos, v_val_debitos, v_val_saldo, v_val_saldo_final,
		  p_seq_extrato_tmp);
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Vencimentos
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  prc_gerar_vencimentos(p_seq_extrato_tmp => p_seq_extrato_tmp, p_seq_extrato => v_seq_extrato,
							p_seq_instituicao => v_seq_instituicao, p_mes_lancto => v_mes_lancto,
							p_ano_lancto => v_ano_lancto);
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Recupera saldo final mes Anterir para saldo inicial do mes atual
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  Begin
		 Select val_saldo_final
		 Into   v_val_saldo_inicial
		 From   fin_extratos
		 Where  seq_instituicao = v_seq_instituicao And
				last_day(to_date(lpad(mes_lancto, 2, '0') || ano_lancto, 'MMYYYY')) =
				v_dat_anterior And
				rownum < 2;
	  Exception
		 When no_data_found Then
			v_val_saldo_inicial := 0;
		 When Others Then
			raise_application_error(-20003, 'Erro ao rec. saldo anterior');
	  End;
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Itens dos interfaces
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  prc_gerar_det(p_seq_extrato_tmp => p_seq_extrato_tmp, p_seq_extrato => v_seq_extrato,
					p_seq_instituicao => v_seq_instituicao);
   
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
	  -- Totais v_tpo_extrato B-Banco ou C-Cartão
	  --#--#--#--#--#--#--#--#--#--#--#--#--#--#
   
	  Begin
	  
		 Select Sum(Case
						When v_tpo_extrato = 'B' And -- Banco ou Cartão
							 pc.dm_tp_conta = 'C' Then -- Debito ou créditos
						 ei.val_lancto
						Else
						 0
					 End)
		 Into   v_val_creditos
		 From   fin_extratos_itens ei, fin_plano_contas pc
		 Where  ei.cod_conta = pc.cod_conta And
				ei.seq_instituicao = v_seq_instituicao And
				ei.seq_extrato = v_seq_extrato;
	  
		 Select Sum(Case
						When pc.dm_tp_conta = 'D' Then
						 ei.val_lancto
						Else
						 0
					 End)
		 Into   v_val_debitos
		 From   fin_extratos_itens ei, fin_plano_contas pc
		 Where  ei.cod_conta = pc.cod_conta And
				ei.seq_instituicao = v_seq_instituicao And
				ei.seq_extrato = v_seq_extrato;
	  
		 Update fin_extratos ex
		 Set    val_saldo_inicial = v_val_saldo_inicial,
				val_creditos      = v_val_creditos,
				val_debitos       = v_val_debitos,
				val_saldo         = v_val_creditos + v_val_debitos,
				val_saldo_final   = v_val_saldo_inicial + v_val_creditos + v_val_debitos
		 Where  ex.seq_instituicao = v_seq_instituicao And
				ex.seq_extrato = v_seq_extrato;
	  
	  Exception
		 When Others Then
			Rollback;
			raise_application_error(-20102, Sqlerrm || ' Erro ao atualizar fin_extrato ');
	  End;
   
	  Begin
		 Insert Into fin_extratos_ctb
			(seq_instituicao, seq_extrato, mes_lancto, ano_lancto, val_nivel, cod_conta, val_conta)
		 
			Select v_seq_instituicao, v_seq_extrato, v_mes_lancto, v_ano_lancto, Level,
				   pc.cod_conta,
				   pkg_extratos.fnc_rec_saldo(v_seq_instituicao, v_seq_extrato, pc.cod_conta) valor
			From   financeiro.fin_plano_contas pc
			Where  pkg_extratos.fnc_rec_saldo(v_seq_instituicao, v_seq_extrato, pc.cod_conta) <> 0
			Start  With cod_conta_ref Is Null
			Connect By Prior pc.cod_conta = pc.cod_conta_ref
			Order  Siblings By pc.cod_conta, pc.dsc_conta;
	  Exception
		 When Others Then
			raise_application_error(-210005, 'Erro ao gerar resumo! ' || Sqlerrm);
	  End;
   
	  Update fin_extratos_tmp
	  Set    sta_extrato = 'I'
	  Where  seq_extrato = p_seq_extrato_tmp;
   
	  Commit;
   
   Exception
	  When Others Then
		 Rollback;
		 raise_application_error(-20102, Sqlerrm || ' Erro na Procedure prc_gerar_extrato ');
   End prc_gerar_extrato;

   Procedure prc_gerar_det
   (
	  p_seq_extrato_tmp In fin_extratos_tmp.seq_extrato%Type,
	  p_seq_extrato     In fin_extratos.seq_extrato%Type,
	  p_seq_instituicao In fin_extratos.seq_instituicao%Type
   ) Is
   
	  v_seq_item    Number := 0;
	  v_complemento Varchar2(60);
	  v_val_saldo   fin_extratos_itens.val_saldo%Type := 0;
   
   Begin
   
	  prc_popula_interface(p_seq_instituicao => p_seq_instituicao, p_cod_prefixo => 'DET');
   
	  v_val_saldo := v_val_saldo_inicial;
   
	  For r In (Select fe.seq_linha, fe.dsc_linha, fe.cod_conta, fc.dm_tp_conta, fc.sta_complemento,
					   -- linha anterior (apenas para conhecimento)
					   lag(fe.dsc_linha, 1) over(Order By fe.seq_linha) As anterior,
					   -- Linha posterior (Complemento)
					   lead(fe.dsc_linha, 1) over(Order By fe.seq_linha) As posterior
				From   fin_extratos_itens_tmp fe, fin_plano_contas fc
				Where  fe.seq_extrato = p_seq_extrato_tmp
					  /*And  fe.seq_linha > 1875*/
					   And
					   fe.cod_conta = fc.cod_conta And
					   (substr(fe.cod_conta, 1, 1) < 3 Or fe.cod_conta = 3000004)
				Order  By seq_linha) Loop
	  
		 v_id := tb_layout.First;
		 If substr(r.cod_conta, 1, 1) < 3 Then
			While v_id Is Not Null Loop
			
			   tb_layout(v_id).conteudo := Null;
			   If tb_layout(v_id).tipo = 'D' Then
				  tb_layout(v_id).conteudo := to_date(substr(r.dsc_linha,
															 tb_layout(v_id).pos_inicial,
															 tb_layout(v_id).tamanho),
													  tb_layout(v_id).mascara);
			   Elsif tb_layout(v_id).tipo = 'C' Then
				  tb_layout(v_id).conteudo := substr(r.dsc_linha, tb_layout(v_id).pos_inicial,
													 tb_layout(v_id).tamanho);
			   Elsif tb_layout(v_id).tipo = 'N' Then
				  tb_layout(v_id).conteudo := Replace(substr(r.dsc_linha,
															 tb_layout(v_id).pos_inicial,
															 tb_layout(v_id).tamanho), '.', '');
			   
			   End If;
			   v_id := tb_layout.Next(v_id);
			End Loop;
		 
			-- le a proxima linha retira os caracteres especiais         
		 
			If r.sta_complemento = 'S' Then
			   v_complemento := ltrim(ltrim(pkg_consistir_dados.fnc_retorna_alfabeto(p_reg => r.posterior)));
			   tb_layout(2).conteudo := tb_layout(2).conteudo || ' (' || v_complemento || ')';
			End If;
		 
			If r.dm_tp_conta = 'D' Then
			   tb_layout(3).conteudo := tb_layout(3).conteudo * -1;
			End If;
			v_val_saldo := v_val_saldo + tb_layout(3).conteudo;
		 
			v_seq_item := v_seq_item + 1;
		 
			Insert Into fin_extratos_itens
			   (seq_instituicao, seq_extrato, seq_item, cod_conta, dat_lancto, dsc_lancto,
				val_lancto, val_saldo)
			Values
			   (p_seq_instituicao, p_seq_extrato, v_seq_item, r.cod_conta, tb_layout(1).conteudo,
				tb_layout(2).conteudo, tb_layout(3).conteudo, v_val_saldo);
		 
		 End If;
	  
	  End Loop;
   
   Exception
	  When Others Then
		 Rollback;
		 raise_application_error(-20102, Sqlerrm || ' Erro na Procedure prc_gerar_det ');
   End prc_gerar_det;

   Procedure prc_gerar_vencimentos
   (
	  p_seq_extrato_tmp In fin_extratos_tmp.seq_extrato%Type,
	  p_seq_extrato     In fin_extratos.seq_extrato%Type,
	  p_seq_instituicao In fin_extratos.seq_instituicao%Type,
	  p_mes_lancto      In Out fin_extratos.mes_lancto%Type,
	  p_ano_lancto      In Out fin_extratos.ano_lancto%Type
   ) Is
   
   Begin
   
	  prc_popula_interface(p_seq_instituicao => p_seq_instituicao, p_cod_prefixo => 'VEN');
   
	  For r In (Select dsc_linha, cod_conta
				From   fin_extratos_itens_tmp
				Where  seq_extrato = p_seq_extrato_tmp And
					   cod_conta = 3000002) Loop
	  
		 v_id := tb_layout.First;
	  
		 While v_id Is Not Null Loop
		 
			--    vencimento :07.11.2020
		 
			tb_layout(v_id).conteudo := Null;
			If tb_layout(v_id).tipo = 'D' Then
			   tb_layout(v_id).conteudo := to_date(substr(r.dsc_linha, tb_layout(v_id).pos_inicial,
														  tb_layout(v_id).tamanho),
												   tb_layout(v_id).mascara);
			Elsif tb_layout(v_id).tipo = 'C' Then
			   tb_layout(v_id).conteudo := substr(r.dsc_linha, tb_layout(v_id).pos_inicial,
												  tb_layout(v_id).tamanho);
			Elsif tb_layout(v_id).tipo = 'N' Then
			   tb_layout(v_id).conteudo := Replace(substr(r.dsc_linha, tb_layout(v_id).pos_inicial,
														  tb_layout(v_id).tamanho), '.', '');
			
			End If;
		 
			v_id := tb_layout.Next(v_id);
		 End Loop;
	  
		 --salva fechamento anterior (Saldo Inicial)
		 v_dat_anterior := add_months(tb_layout(1).conteudo, -1);
	  	 p_mes_lancto := to_char(to_date(tb_layout(1).conteudo, 'DD/MM/YY'), 'MM');
		 p_ano_lancto := to_char(to_date(tb_layout(1).conteudo, 'DD/MM/YY'), 'YYYY');
	  
	  
		 Update fin_extratos
		 Set    mes_lancto = p_mes_lancto,
				ano_lancto = p_ano_lancto
		 Where  seq_instituicao = p_seq_instituicao And
				seq_extrato = p_seq_extrato;
	  
	  End Loop;
   Exception
	  When Others Then
		 Rollback;
		 raise_application_error(-20102, Sqlerrm || ' Erro na Procedure prc_gerar_vencimentos ');
   End prc_gerar_vencimentos;

   Procedure prc_popula_interface
   (
	  p_seq_instituicao In fin_extratos_tmp.seq_extrato%Type,
	  p_cod_prefixo     In fin_interface.cod_prefixo%Type
   ) Is
   
	  v_indice Number(4) := 0;
   
   Begin
   
	  tb_layout.Delete;
   
	  --- Carrega matriz do layout (INTERFACE)
   
	  For c In (Select seq_instituicao, cod_prefixo, seq_interface, nom_campo, dsc_campo, seq_campo,
					   val_tamanho, pos_inicial, pos_final, dsc_mascara, tpo_campo
				From   fin_interface
				Where  seq_instituicao = p_seq_instituicao And
					   cod_prefixo = p_cod_prefixo And
					   tpo_campo <> 'F'
				Order  By seq_campo) Loop
	  
		 v_indice := v_indice + 1;
	  
		 tb_layout(v_indice).nome := c.nom_campo;
	  
		 tb_layout(v_indice).descricao := c.dsc_campo;
		 tb_layout(v_indice).pos_inicial := c.pos_inicial;
		 tb_layout(v_indice).tamanho := c.val_tamanho;
		 tb_layout(v_indice).mascara := c.dsc_mascara;
		 tb_layout(v_indice).tipo := c.tpo_campo;
	  End Loop;
   
   Exception
	  When Others Then
		 Rollback;
		 raise_application_error(-20102, Sqlerrm || ' Erro na Procedure prc_popula_interface ');
	  
   End prc_popula_interface;

   -- Retorna o saldo da somatoria da conta (3 NIVEIS hierarquia)
   Function fnc_rec_saldo
   (
	  p_seq_instituicao In fin_extratos.seq_extrato%Type,
	  p_seq_extrato     In fin_extratos.seq_extrato%Type,
	  p_cod_conta       In fin_plano_contas.cod_conta%Type
	  
   ) Return Number Is
   
	  v_saldo_conta fin_extratos.val_creditos%Type := 0;
   
   Begin
   
	  Select nvl(Sum(val_lancto), 0)
	  Into   v_saldo_conta
	  From   financeiro.fin_extratos_itens ex
	  Where  ex.seq_instituicao = p_seq_instituicao And
			 ex.seq_extrato = p_seq_extrato And
			 substr(ex.cod_conta, 1, length(p_cod_conta)) = p_cod_conta;
   
	  Return(v_saldo_conta);
   
   Exception
	  When Others Then
		 raise_application_error(-20002, 'Erro ao calcular saldo da conta: ' || p_cod_conta);
	  
   End fnc_rec_saldo;

End pkg_extratos;
/

SHOW ERRORS;


CREATE OR REPLACE Package Body pac_interface Is

	 Procedure prc_movimenta_registro(p_seq_instituicao In fin_interface.seq_instituicao%Type,
																		p_cod_prefixo     In fin_interface.cod_prefixo%Type,
																		p_seq_interface   In fin_interface.seq_interface%Type,
																		p_seq_campo       In fin_interface.seq_campo%Type,
																		p_reg_corrente    In fin_interface.seq_campo%Type,
																		p_tpo_atualiz     In Varchar2) Is
	 
			Cursor c1 Is
				 Select seq_interface, seq_campo, val_tamanho
					 From fin_interface
					Where seq_instituicao = p_seq_instituicao And
								cod_prefixo = p_cod_prefixo
					Order By seq_campo;
			reg_c1          c1%Rowtype;
			v_pos_inicial   fin_interface.pos_inicial%Type;
			v_pos_final     fin_interface.pos_inicial%Type;
			v_seq_interface fin_interface.seq_interface%Type;
			v_seq_campo     Number := 0;
			v_contador      Number := 0;
	 
			-- PL/SQL Block
	 
			-- PL/SQL Block
	 Begin
			If p_tpo_atualiz = 'A' Then
				 -- Acerta posicionamento dos Campos
				 Begin
						Select seq_interface
							Into v_seq_interface
							From fin_interface
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_campo = p_reg_corrente;
				 Exception
						When Others Then
							 raise_application_error(-20100,
																			 'Erro ao Selecionar a Sequência do Item. Erro: ' || Sqlerrm);
				 End;
				 Begin
						-- ORIGEM
						Update fin_interface
							 Set seq_campo = 99999
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_interface = p_seq_interface;
				 Exception
						When Others Then
							 raise_application_error(-20101,
																			 'Erro ao Atualizar Item de Origem (99999). Erro: ' || Sqlerrm);
				 End;  COMMIT;
				 Begin
						-- DESTINO
						Update fin_interface
							 Set seq_campo = p_seq_campo
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_interface = v_seq_interface;
				 Exception
						When Others Then
							 raise_application_error(-20102, 'Erro ao Atualizar Item de Destino. Erro: ' || Sqlerrm);
				 End;   COMMIT;
				 Begin
						-- ORIGEM
						Update fin_interface
							 Set seq_campo = p_reg_corrente
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_interface = p_seq_interface;
				 Exception
						When Others Then
							 raise_application_error(-20103, 'Erro ao Atualizar Item de Origem. Erro: ' || Sqlerrm);
				 End;  COMMIT;
			Elsif p_tpo_atualiz In ('I', 'E') Then
				 -- Inclusão E Exclusão de Campos
				 If p_tpo_atualiz = 'E' Then
						-- Exclusão de Campos
						Begin
							 Delete fin_interface
								Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
											seq_interface = p_seq_interface;
						Exception
							 When Others Then
									raise_application_error(-20104, 'Erro na Exclusão do Item. Erro: ' || Sqlerrm);
						End;
				 End If;
				 If p_tpo_atualiz = 'E' Then
						v_contador  := 0;
						v_seq_campo := p_seq_campo;
				 Else
						v_contador  := 1;
						v_seq_campo := p_reg_corrente;
				 End If;
				 Open c1;
				 Loop
						Fetch c1
							 Into reg_c1.seq_interface, reg_c1.seq_campo, reg_c1.val_tamanho;
						Exit When c1%Notfound;
						If reg_c1.seq_campo >= v_seq_campo And
							 reg_c1.seq_campo <> 99999 Then
							 Begin
									Update fin_interface
										 Set seq_campo = v_seq_campo + v_contador
									 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
												 seq_interface = reg_c1.seq_interface;
							 Exception
									When Others Then
										 raise_application_error(-20105,
																						 'Erro na Atualização do SEQ_CAMPO. Erro: ' || Sqlerrm);
							 End;
							 v_contador := v_contador + 1;
						End If;
				 End Loop;
				 Close c1;
				 If p_tpo_atualiz = 'I' Then
						-- Inclusão de Campos
						Begin
							 Update fin_interface Set seq_campo = v_seq_campo Where seq_campo = 99999;
						Exception
							 When Others Then
									raise_application_error(-20106,
																					'Erro na Atualização do SEQ_CAMPO 99999. Erro: ' || Sqlerrm);
						End;
				 End If;
			End If;
			Open c1;
			Loop
				 Fetch c1
						Into reg_c1.seq_interface, reg_c1.seq_campo, reg_c1.val_tamanho;
				 Exit When c1%Notfound;
				 If reg_c1.seq_campo = 1 Then
						-- Guarda Posição 1 se for Posição Inicial
						v_pos_inicial := 1;
				 Else
						v_pos_inicial := v_pos_final + 1;
				 End If;
				 v_pos_final := v_pos_inicial + reg_c1.val_tamanho - 1;
				 Begin
						Update fin_interface
							 Set pos_inicial = v_pos_inicial, pos_final = v_pos_final
						 Where seq_instituicao = p_seq_instituicao And
									 cod_prefixo = p_cod_prefixo And
									 seq_interface = reg_c1.seq_interface;
				 Exception
						When Others Then
							 raise_application_error(-20107,
																			 'Erro ao Atualizar Posição Inicial e Final. Erro: ' || Sqlerrm);
				 End;
			End Loop;
			Close c1;
			Commit;
	 End;

End pac_interface;
/

SHOW ERRORS;


CREATE OR REPLACE PACKAGE BODY cg$PROJECAO_ARQUIVOS_LANC IS


PROCEDURE   validate_mandatory(cg$val_rec IN cg$row_type,
                               loc        IN VARCHAR2 DEFAULT '');
PROCEDURE   up_autogen_columns(cg$rec    IN OUT cg$row_type,
                               cg$ind    IN OUT cg$ind_type,
                               operation IN VARCHAR2 DEFAULT 'INS',
                               do_denorm IN BOOLEAN DEFAULT TRUE);
PROCEDURE   err_msg(msg  IN VARCHAR2,
                    type IN INTEGER,
                    loc  IN VARCHAR2 DEFAULT '');

--------------------------------------------------------------------------------
-- Name:        raise_uk_not_updateable
--
-- Description: Raise appropriate error when unique key updated
--
-- Parameters:  none
--------------------------------------------------------------------------------
PROCEDURE raise_uk_not_updateable(uk IN VARCHAR2) IS
BEGIN
    cg$errors.push(cg$errors.MsgGetText(cg$errors.API_UNIQUE_KEY_UPDATE, cg$errors.ERR_UK_UPDATE, uk),
                   'E',
                   'API',
                   cg$errors.API_UNIQUE_KEY_UPDATE,
                   'cg$PROJECAO_ARQUIVOS_LANC.raise_uk_not_updateable');
                   cg$errors.raise_failure;
END raise_uk_not_updateable;


--------------------------------------------------------------------------------
-- Name:        raise_fk_not_transferable
--
-- Description: Raise appropriate error when foreign key updated
--
-- Parameters:  none
--------------------------------------------------------------------------------
PROCEDURE raise_fk_not_transferable(fk IN VARCHAR2) IS
BEGIN
    cg$errors.push(cg$errors.MsgGetText(cg$errors.API_FOREIGN_KEY_TRANS, cg$errors.ERR_FK_TRANS, fk),
                   'E',
                   'API',
                   cg$errors.API_FOREIGN_KEY_TRANS,
                   'cg$PROJECAO_ARQUIVOS_LANC.raise_fk_not_transferable');
    cg$errors.raise_failure;
END raise_fk_not_transferable;


--------------------------------------------------------------------------------
-- Name:        up_autogen_columns
--
-- Description: Specific autogeneration of column values and conversion to
--              uppercase
--
-- Parameters:  cg$rec    Record of row to be manipulated
--              cg$ind    Indicators for row
--              operation Procedure where this procedure was called
--------------------------------------------------------------------------------
PROCEDURE up_autogen_columns(cg$rec IN OUT cg$row_type,
                             cg$ind IN OUT cg$ind_type,
                             operation IN VARCHAR2 DEFAULT 'INS',
                             do_denorm IN BOOLEAN DEFAULT TRUE) IS
BEGIN
  IF (operation = 'INS') THEN
    NULL;
  ELSE      -- (operation = 'UPD')
    NULL;
  END IF;   -- (operation = 'INS') ELSE (operation = 'UPD')

  -- Statements executed for both 'INS' and 'UPD'


EXCEPTION
  WHEN no_data_found THEN
    NULL;
  WHEN others THEN
    cg$errors.push( SQLERRM, 'E', 'ORA', SQLCODE,
                    'cg$PROJECAO_ARQUIVOS_LANC.up_autogen_columns');
    cg$errors.raise_failure;
END up_autogen_columns;


--------------------------------------------------------------------------------
-- Name:        validate_mandatory
--
-- Description: Checks all mandatory columns are not null and raises appropriate
--              error if not satisfied
--
-- Parameters:  cg$val_rec Record of row to be checked
--              loc        Place where this procedure was called for error
--                         trapping
--------------------------------------------------------------------------------
PROCEDURE validate_mandatory(cg$val_rec IN cg$row_type,
                             loc        IN VARCHAR2 DEFAULT '') IS
BEGIN
    IF (cg$val_rec.PRA_SQ IS NULL) THEN
        cg$errors.push(cg$errors.MsgGetText(cg$errors.API_MAND_COLUMN_ISNULL, cg$errors.VAL_MAND, P10PRA_SQ),
                       'E',
                       'API',
                       cg$errors.API_MAND_COLUMN_ISNULL,
                       loc);
    END IF;
    IF (cg$val_rec.PCA_SQ IS NULL) THEN
        cg$errors.push(cg$errors.MsgGetText(cg$errors.API_MAND_COLUMN_ISNULL, cg$errors.VAL_MAND, P20PCA_SQ),
                       'E',
                       'API',
                       cg$errors.API_MAND_COLUMN_ISNULL,
                       loc);
    END IF;
    IF (cg$val_rec.PAL_SQ IS NULL) THEN
        cg$errors.push(cg$errors.MsgGetText(cg$errors.API_MAND_COLUMN_ISNULL, cg$errors.VAL_MAND, P22PAL_SQ),
                       'E',
                       'API',
                       cg$errors.API_MAND_COLUMN_ISNULL,
                       loc);
    END IF;
    IF (cg$val_rec.PAL_VALOR IS NULL) THEN
        cg$errors.push(cg$errors.MsgGetText(cg$errors.API_MAND_COLUMN_ISNULL, cg$errors.VAL_MAND, P24PAL_VALOR),
                       'E',
                       'API',
                       cg$errors.API_MAND_COLUMN_ISNULL,
                       loc);
    END IF;
    NULL;
END validate_mandatory;


--------------------------------------------------------------------------------
-- Name:        validate_foreign_keys
--
-- Description: Checks all mandatory columns are not null and raises appropriate
--              error if not satisfied
--
-- Parameters:  cg$rec Record of row to be checked
--------------------------------------------------------------------------------
PROCEDURE validate_foreign_keys_ins(cg$rec IN cg$row_type) IS
    fk_check INTEGER;
BEGIN
NULL;
END;

PROCEDURE validate_foreign_keys_upd( cg$rec IN cg$row_type,
                                     cg$old_rec IN cg$row_type,
                                     cg$ind IN cg$ind_type) IS
    fk_check INTEGER;
BEGIN
NULL;
END;

PROCEDURE validate_foreign_keys_del(cg$rec IN cg$row_type) IS
    fk_check INTEGER;
BEGIN
NULL;
END;


--------------------------------------------------------------------------------
-- Name:        slct
--
-- Description: Selects into the given parameter all the attributes for the row
--              given by the primary key
--
-- Parameters:  cg$sel_rec  Record of row to be selected into using its PK
--------------------------------------------------------------------------------
PROCEDURE slct(cg$sel_rec IN OUT cg$row_type) IS

BEGIN

    IF cg$sel_rec.the_rowid is null THEN
       SELECT    PRA_SQ
       ,         PCA_SQ
       ,         PAL_SQ
       ,         PAL_VALOR
       , rowid
       INTO      cg$sel_rec.PRA_SQ
       ,         cg$sel_rec.PCA_SQ
       ,         cg$sel_rec.PAL_SQ
       ,         cg$sel_rec.PAL_VALOR
       ,cg$sel_rec.the_rowid
       FROM   PROJECAO_ARQUIVOS_LANC
       WHERE        PRA_SQ = cg$sel_rec.PRA_SQ;
    ELSE
       SELECT    PRA_SQ
       ,         PCA_SQ
       ,         PAL_SQ
       ,         PAL_VALOR
       , rowid
       INTO      cg$sel_rec.PRA_SQ
       ,         cg$sel_rec.PCA_SQ
       ,         cg$sel_rec.PAL_SQ
       ,         cg$sel_rec.PAL_VALOR
       ,cg$sel_rec.the_rowid
       FROM   PROJECAO_ARQUIVOS_LANC
       WHERE  rowid = cg$sel_rec.the_rowid;
    END IF;

EXCEPTION WHEN OTHERS THEN
    cg$errors.push(SQLERRM,
                   'E',
                   'ORA',
                   SQLCODE,
                   'cg$PROJECAO_ARQUIVOS_LANC.slct.others');
    cg$errors.raise_failure;

END slct;


--------------------------------------------------------------------------------
-- Name:        cascade_update
--
-- Description: Updates all child tables affected by a change to PROJECAO_ARQUIVOS_LANC
--
-- Parameters:  cg$rec     Record of PROJECAO_ARQUIVOS_LANC current values
--              cg$old_rec Record of PROJECAO_ARQUIVOS_LANC previous values
--------------------------------------------------------------------------------
PROCEDURE cascade_update(cg$new_rec IN OUT cg$row_type,
                         cg$old_rec IN     cg$row_type) IS
BEGIN
  NULL;
END cascade_update;


--------------------------------------------------------------------------------
-- Name:        validate_domain_cascade_update
--
-- Description: Implement the Domain Key Constraint Cascade Updates Resticts rule
--              of each child table that references this tablePROJECAO_ARQUIVOS_LANC
--
-- Parameters:  cg$old_rec     Record of PROJECAO_ARQUIVOS_LANC current values
--------------------------------------------------------------------------------
PROCEDURE validate_domain_cascade_update( cg$old_rec IN cg$row_type ) IS
  dk_check INTEGER;
BEGIN
  NULL;
END validate_domain_cascade_update;


-----------------------------------------------------------------------------------------
-- Name:        domain_cascade_update
--
-- Description: Implement the Domain Key Constraint Cascade Updates rules of each
--              child table that references this table PROJECAO_ARQUIVOS_LANC
--
-- Parameters:  cg$new_rec  New values for PROJECAO_ARQUIVOS_LANC's domain key constraint columns
--              cg$new_ind  Indicates changed PROJECAO_ARQUIVOS_LANC's domain key constraint columns
--              cg$old_rec  Current values for PROJECAO_ARQUIVOS_LANC's domain key constraint columns
-----------------------------------------------------------------------------------------
PROCEDURE domain_cascade_update(cg$new_rec IN OUT cg$row_type,
                                cg$new_ind IN OUT cg$ind_type,
                                cg$old_rec IN     cg$row_type) IS
BEGIN
  NULL;
END domain_cascade_update;


--------------------------------------------------------------------------------
-- Name:        cascade_delete
--
-- Description: Delete all child tables affected by a delete to PROJECAO_ARQUIVOS_LANC
--
-- Parameters:  cg$rec     Record of PROJECAO_ARQUIVOS_LANC current values
--------------------------------------------------------------------------------
PROCEDURE cascade_delete(cg$old_rec IN OUT cg$row_type)
IS
BEGIN
  NULL;
END cascade_delete;

--------------------------------------------------------------------------------
-- Name:        domain_cascade_delete
--
-- Description: Implement the Domain Key Constraint Cascade Delete rules of each
--              child table that references this tablePROJECAO_ARQUIVOS_LANC
--
-- Parameters:  cg$old_rec     Record of PROJECAO_ARQUIVOS_LANC current values
--------------------------------------------------------------------------------
PROCEDURE domain_cascade_delete( cg$old_rec IN cg$row_type )
IS
BEGIN
  NULL;
END domain_cascade_delete;


--------------------------------------------------------------------------------
-- Name:        validate_domain_cascade_delete
--
-- Description: Implement the Domain Key Constraint Cascade Delete Restricts rule
--              of each child table that references this tablePROJECAO_ARQUIVOS_LANC
--
-- Parameters:  cg$old_rec     Record of PROJECAO_ARQUIVOS_LANC current values
--------------------------------------------------------------------------------
PROCEDURE validate_domain_cascade_delete(cg$old_rec IN cg$row_type)
IS
    dk_check INTEGER;
BEGIN
  NULL;
END validate_domain_cascade_delete;



--------------------------------------------------------------------------------
-- Name:        validate_arc
--
-- Description: Checks for adherence to arc relationship
--
-- Parameters:  cg$rec     Record of PROJECAO_ARQUIVOS_LANC current values
--------------------------------------------------------------------------------
PROCEDURE validate_arc(cg$rec IN OUT cg$row_type) IS
i NUMBER;
BEGIN
    NULL;
END validate_arc;


--------------------------------------------------------------------------------
-- Name:        validate_domain
--
-- Description: Checks against reference table for values lying in a domain
--
-- Parameters:  cg$rec     Record of PROJECAO_ARQUIVOS_LANC current values
--------------------------------------------------------------------------------
PROCEDURE validate_domain(cg$rec IN OUT cg$row_type,
                          cg$ind IN cg$ind_type DEFAULT cg$ind_true)
IS
  dummy NUMBER;
  found BOOLEAN;
  no_tabview EXCEPTION;
  PRAGMA EXCEPTION_INIT(no_tabview, -942);
BEGIN






    NULL;

EXCEPTION
    WHEN cg$errors.cg$error THEN
        cg$errors.raise_failure;
    WHEN no_tabview THEN
        cg$errors.push(cg$errors.MsgGetText(cg$errors.API_RV_TAB_NOT_FOUND,
                                            cg$errors.APIMSG_RV_TAB_NOT_FOUND,
                                            'CG_REF_CODES','PROJECAO_ARQUIVOS_LANC'),
                       'E',
                       'API',
                       cg$errors.API_RV_TAB_NOT_FOUND,
                       'cg$PROJECAO_ARQUIVOS_LANC.v_domain.no_reftable_found');
        cg$errors.raise_failure;
    WHEN OTHERS THEN
        cg$errors.push(SQLERRM,
                       'E',
                       'ORA',
                       SQLCODE,
                       'cg$PROJECAO_ARQUIVOS_LANC.v_domain.others');
        cg$errors.raise_failure;
END validate_domain;


--------------------------------------------------------------------------------
-- Name:        err_msg
--
-- Description: Pushes onto stack appropriate user defined error message
--              depending on the rule violated
--
-- Parameters:  msg     Oracle error message
--              type    Type of violation e.g. check_constraint: ERR_CHECK_CON
--              loc     Place where this procedure was called for error
--                      trapping
--------------------------------------------------------------------------------
PROCEDURE err_msg(msg   IN VARCHAR2,
                  type  IN INTEGER,
                  loc   IN VARCHAR2 DEFAULT '') IS
con_name VARCHAR2(240);
BEGIN
    con_name := cg$errors.parse_constraint(msg, type);
    IF (con_name = 'PAL_PK') THEN
        cg$errors.push(nvl(PAL_PK
                  ,cg$errors.MsgGetText(cg$errors.API_PK_CON_VIOLATED
					                 ,cg$errors.APIMSG_PK_VIOLAT
                                     ,'PAL_PK'
                                     ,'PROJECAO_ARQUIVOS_LANC')),
                       'E',
                       'API',
                       cg$errors.API_PK_CON_VIOLATED,
                       loc);

    ELSIF (con_name = 'PAL_PRA_FK') THEN
        cg$errors.push(nvl(PAL_PRA_FK
                      ,cg$errors.MsgGetText(cg$errors.API_FK_CON_VIOLATED
					                 ,cg$errors.APIMSG_FK_VIOLAT
                                     ,'PAL_PRA_FK'
                                     ,'PROJECAO_ARQUIVOS_LANC')),
                       'E',
                       'API',
                       cg$errors.API_FK_CON_VIOLATED,
                       loc);
    ELSIF (con_name = 'PAL_PCA_FK') THEN
        cg$errors.push(nvl(PAL_PCA_FK
                      ,cg$errors.MsgGetText(cg$errors.API_FK_CON_VIOLATED
					                 ,cg$errors.APIMSG_FK_VIOLAT
                                     ,'PAL_PCA_FK'
                                     ,'PROJECAO_ARQUIVOS_LANC')),
                       'E',
                       'API',
                       cg$errors.API_FK_CON_VIOLATED,
                       loc);
    ELSE
        cg$errors.push(SQLERRM,
                       'E',
                       'ORA',
                       SQLCODE,
                       loc);
    END IF;
END err_msg;




--------------------------------------------------------------------------------
-- Name:        doLobs
--
-- Description: This function is updating lob columns
--
-- Parameters:  cg$rec  Record of row to be inserted
--              cg$ind  Record of columns specifically set
--------------------------------------------------------------------------------
PROCEDURE doLobs(cg$rec IN OUT cg$row_type,
                 cg$ind IN OUT cg$ind_type) IS
BEGIN
   NULL;
END doLobs;


--------------------------------------------------------------------------------
-- Name:        ins
--
-- Description: API insert procedure
--
-- Parameters:  cg$rec  Record of row to be inserted
--              cg$ind  Record of columns specifically set
--              do_ins  Whether we want the actual INSERT to occur
--------------------------------------------------------------------------------
PROCEDURE ins(cg$rec IN OUT cg$row_type,
              cg$ind IN OUT cg$ind_type,
              do_ins IN BOOLEAN DEFAULT TRUE) IS
cg$tmp_rec cg$row_type;

--  Constant default values


BEGIN
--  Application_logic Pre-Insert <<Start>>
--  Application_logic Pre-Insert << End >>

--  Defaulted

--  Auto-generated and uppercased columns

    up_autogen_columns(cg$rec, cg$ind, 'INS', do_ins);

    called_from_package := TRUE;

    IF (do_ins) THEN
        validate_foreign_keys_ins(cg$rec);
        validate_arc(cg$rec);
        validate_domain(cg$rec);

        INSERT INTO PROJECAO_ARQUIVOS_LANC
            (PRA_SQ
            ,PCA_SQ
            ,PAL_SQ
            ,PAL_VALOR)
        VALUES
            (cg$rec.PRA_SQ
            ,cg$rec.PCA_SQ
            ,cg$rec.PAL_SQ
            ,cg$rec.PAL_VALOR
);
        doLobs(cg$rec, cg$ind);
        slct(cg$rec);

        upd_oper_denorm2(cg$rec, cg$tmp_rec, cg$ind, 'INS');
    END IF;

    called_from_package := FALSE;



--  Application logic Post-Insert <<Start>>
--  Application logic Post-Insert << End >>

EXCEPTION
    WHEN cg$errors.cg$error THEN
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.mandatory_missing THEN
        validate_mandatory(cg$rec, 'cg$PROJECAO_ARQUIVOS_LANC.ins.mandatory_missing');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.check_violation THEN
        err_msg(SQLERRM, cg$errors.ERR_CHECK_CON, 'cg$PROJECAO_ARQUIVOS_LANC.ins.check_violation');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.fk_violation THEN
        err_msg(SQLERRM, cg$errors.ERR_FOREIGN_KEY, 'cg$PROJECAO_ARQUIVOS_LANC.ins.fk_violation');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.uk_violation THEN
        err_msg(SQLERRM, cg$errors.ERR_UNIQUE_KEY, 'cg$PROJECAO_ARQUIVOS_LANC.ins.uk_violation');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN OTHERS THEN
        cg$errors.push(SQLERRM,
                       'E',
                       'ORA',
                       SQLCODE,
                       'cg$PROJECAO_ARQUIVOS_LANC.ins.others');
        called_from_package := FALSE;
        cg$errors.raise_failure;
END ins;


--------------------------------------------------------------------------------
-- Name:        upd
--
-- Description: API update procedure
--
-- Parameters:  cg$rec  Record of row to be updated
--              cg$ind  Record of columns specifically set
--              do_upd  Whether we want the actual UPDATE to occur
--------------------------------------------------------------------------------
PROCEDURE upd(cg$rec             IN OUT cg$row_type,
              cg$ind             IN OUT cg$ind_type,
              do_upd             IN BOOLEAN DEFAULT TRUE,
              cg$pk              IN cg$row_type DEFAULT NULL )
IS
  cg$upd_rec    cg$row_type;
  cg$old_rec    cg$row_type;
  RECORD_LOGGED BOOLEAN := FALSE;
BEGIN
--  Application_logic Pre-Update <<Start>>
--  Application_logic Pre-Update << End >>


    IF ( cg$pk.PRA_SQ IS NULL ) THEN
      cg$upd_rec.PRA_SQ := cg$rec.PRA_SQ;
    ELSE
      cg$upd_rec.PRA_SQ := cg$pk.PRA_SQ;
    END IF;
    cg$old_rec.PRA_SQ := cg$upd_rec.PRA_SQ;

    IF ( cg$pk.the_rowid IS NULL ) THEN
      cg$upd_rec.the_rowid := cg$rec.the_rowid;
    ELSE
      cg$upd_rec.the_rowid := cg$pk.the_rowid;
    END IF;
    cg$old_rec.the_rowid := cg$upd_rec.the_rowid;

    IF ( do_upd ) THEN

        slct(cg$upd_rec);


        --  Report error if attempt to update non updateable Primary Key PAL_PK
        IF (cg$ind.PRA_SQ AND cg$rec.PRA_SQ != cg$upd_rec.PRA_SQ) THEN
            raise_uk_not_updateable('PAL_PK');
        END IF;
        IF NOT (cg$ind.PRA_SQ) THEN
            cg$rec.PRA_SQ := cg$upd_rec.PRA_SQ;
        END IF;
        IF NOT (cg$ind.PCA_SQ) THEN
            cg$rec.PCA_SQ := cg$upd_rec.PCA_SQ;
        END IF;
        IF NOT (cg$ind.PAL_SQ) THEN
            cg$rec.PAL_SQ := cg$upd_rec.PAL_SQ;
        END IF;
        IF NOT (cg$ind.PAL_VALOR) THEN
            cg$rec.PAL_VALOR := cg$upd_rec.PAL_VALOR;
        END IF;
    ELSE
	     -- Perform checks if called from a trigger
	     -- Indicators are only set on changed values
	     null;
        --  Report error if attempt to update non updateable Primary Key PAL_PK
        IF ( cg$ind.PRA_SQ ) THEN
          raise_uk_not_updateable('PAL_PK');
        END IF;
    END IF;

    up_autogen_columns(cg$rec, cg$ind, 'UPD', do_upd);  --  Auto-generated and uppercased columns

--  Now do update if updateable columns exist
    IF (do_upd) THEN
        DECLARE
            called_from BOOLEAN := called_from_package;
        BEGIN
          called_from_package := TRUE;

          slct(cg$old_rec);
          validate_foreign_keys_upd(cg$rec, cg$old_rec, cg$ind);
          validate_arc(cg$rec);
          validate_domain(cg$rec, cg$ind);
          validate_domain_cascade_update(cg$old_rec);

          IF cg$rec.the_rowid is null THEN
            UPDATE PROJECAO_ARQUIVOS_LANC
            SET
              PCA_SQ = cg$rec.PCA_SQ
              ,PAL_SQ = cg$rec.PAL_SQ
              ,PAL_VALOR = cg$rec.PAL_VALOR
            WHERE  PRA_SQ = cg$rec.PRA_SQ;
            null;
          ELSE
            UPDATE PROJECAO_ARQUIVOS_LANC
            SET
              PCA_SQ = cg$rec.PCA_SQ
              ,PAL_SQ = cg$rec.PAL_SQ
              ,PAL_VALOR = cg$rec.PAL_VALOR
            WHERE rowid = cg$rec.the_rowid;

            null;
          END IF;

          slct(cg$rec);

          upd_denorm2(cg$rec, cg$ind);
          upd_oper_denorm2(cg$rec, cg$old_rec, cg$ind, 'UPD');
          cascade_update(cg$rec, cg$old_rec);
          domain_cascade_update(cg$rec, cg$ind, cg$old_rec);
          called_from_package := called_from;
        END;
    END IF;



    IF NOT (do_upd) THEN
        cg$table(idx).PRA_SQ := cg$rec.PRA_SQ;
        cg$tableind(idx).PRA_SQ := cg$ind.PRA_SQ;
        cg$table(idx).PCA_SQ := cg$rec.PCA_SQ;
        cg$tableind(idx).PCA_SQ := cg$ind.PCA_SQ;
        cg$table(idx).PAL_SQ := cg$rec.PAL_SQ;
        cg$tableind(idx).PAL_SQ := cg$ind.PAL_SQ;
        cg$table(idx).PAL_VALOR := cg$rec.PAL_VALOR;
        cg$tableind(idx).PAL_VALOR := cg$ind.PAL_VALOR;
        idx := idx + 1;
    END IF;

--  Application_logic Post-Update <<Start>>
--  Application_logic Post-Update << End >>

EXCEPTION
    WHEN cg$errors.cg$error THEN
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.upd_mandatory_null THEN
        validate_mandatory(cg$rec, 'cg$PROJECAO_ARQUIVOS_LANC.upd.upd_mandatory_null');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.check_violation THEN
        err_msg(SQLERRM, cg$errors.ERR_CHECK_CON, 'cg$PROJECAO_ARQUIVOS_LANC.upd.check_violation');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.fk_violation THEN
        err_msg(SQLERRM, cg$errors.ERR_FOREIGN_KEY, 'cg$PROJECAO_ARQUIVOS_LANC.upd.fk_violation');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.uk_violation THEN
        err_msg(SQLERRM, cg$errors.ERR_UNIQUE_KEY, 'cg$PROJECAO_ARQUIVOS_LANC.upd.uk_violation');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN OTHERS THEN
        cg$errors.push(SQLERRM,
                       'E',
                       'ORA',
                       SQLCODE,
                       'cg$PROJECAO_ARQUIVOS_LANC.upd.others');
        called_from_package := FALSE;
        cg$errors.raise_failure;
END upd;


----------------------------------------------------------------------------------------
-- Name:        domain_cascade_upd
--
-- Description: Update the Domain Constraint Key columns of PROJECAO_ARQUIVOS_LANC when the
--              Cascade Update rule is Cascades and the domain table has been
--              updated. Called from <Domain Table pkg>.domain_cascade_update().
--
-- Parameters:  cg$rec      New values for PROJECAO_ARQUIVOS_LANC's domain key constraint columns
--              cg$ind      Indicates changed PROJECAO_ARQUIVOS_LANC's domain key constraint columns
--              cg$old_rec  Current values for PROJECAO_ARQUIVOS_LANC's domain key constraint columns
----------------------------------------------------------------------------------------
PROCEDURE   domain_cascade_upd( cg$rec     IN OUT cg$row_type,
                                cg$ind     IN OUT cg$ind_type,
                                cg$old_rec IN     cg$row_type )
IS
  called_from BOOLEAN := called_from_package;
BEGIN

  null;
END domain_cascade_upd;


--------------------------------------------------------------------------------
-- Name:        upd_denorm
--
-- Description: API procedure for simple denormalization
--
-- Parameters:  cg$rec  Record of row to be updated
--              cg$ind  Record of columns specifically set
--              do_upd  Whether we want the actual UPDATE to occur
--------------------------------------------------------------------------------
PROCEDURE upd_denorm2( cg$rec IN cg$row_type,
                       cg$ind IN cg$ind_type ) IS
BEGIN
  NULL;
END upd_denorm2;


--------------------------------------------------------------------------------
-- Name:        upd_oper_denorm
--
-- Description: API procedure for operation denormalization
--
-- Parameters:  cg$rec  Record of row to be updated
--              cg$ind  Record of columns specifically set
--              do_upd  Whether we want the actual UPDATE to occur
--------------------------------------------------------------------------------
PROCEDURE upd_oper_denorm2( cg$rec IN cg$row_type,
                            cg$old_rec IN cg$row_type,
                            cg$ind IN cg$ind_type,
                            operation IN VARCHAR2 DEFAULT 'UPD'
					           )
IS
BEGIN




NULL;
END upd_oper_denorm2;

--------------------------------------------------------------------------------
-- Name:        del
--
-- Description: API delete procedure
--
-- Parameters:  cg$pk  Primary key record of row to be deleted
--------------------------------------------------------------------------------
PROCEDURE del(cg$pk IN cg$pk_type,
              do_del IN BOOLEAN DEFAULT TRUE) IS
BEGIN
--  Application_logic Pre-Delete <<Start>>
--  Application_logic Pre-Delete << End >>

--  Delete the record

    called_from_package := TRUE;

    IF (do_del) THEN
        DECLARE
           cg$rec cg$row_type;
           cg$old_rec cg$row_type;
           cg$ind cg$ind_type;
        BEGIN
           cg$rec.PRA_SQ := cg$pk.PRA_SQ;
           slct(cg$rec);

           validate_foreign_keys_del(cg$rec);
           validate_domain_cascade_delete(cg$rec);

           IF cg$pk.the_rowid is null THEN
              DELETE PROJECAO_ARQUIVOS_LANC
              WHERE                    PRA_SQ = cg$pk.PRA_SQ;
           ELSE
              DELETE PROJECAO_ARQUIVOS_LANC
              WHERE  rowid = cg$pk.the_rowid;
           END IF;

           upd_oper_denorm2(cg$rec, cg$old_rec, cg$ind, 'DEL');
           cascade_delete(cg$rec);
           domain_cascade_delete(cg$rec);
        END;
    END IF;

    called_from_package := FALSE;


--  Application_logic Post-Delete <<Start>>
--  Application_logic Post-Delete << End >>

EXCEPTION
    WHEN cg$errors.cg$error THEN
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN cg$errors.delete_restrict THEN
        err_msg(SQLERRM, cg$errors.ERR_DELETE_RESTRICT, 'cg$PROJECAO_ARQUIVOS_LANC.del.delete_restrict');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN no_data_found THEN
        cg$errors.push(cg$errors.MsgGetText(cg$errors.API_ROW_DEL, cg$errors.ROW_DEL),
                       'E',
                       'ORA',
                       SQLCODE,
                       'cg$PROJECAO_ARQUIVOS_LANC.del.no_data_found');
        called_from_package := FALSE;
        cg$errors.raise_failure;
    WHEN OTHERS THEN
        cg$errors.push(SQLERRM,
                       'E',
                       'ORA',
                       SQLCODE,
                       'cg$PROJECAO_ARQUIVOS_LANC.del.others');
        called_from_package := FALSE;
        cg$errors.raise_failure;
END del;


--------------------------------------------------------------------------------
-- Name:        lck
--
-- Description: API lock procedure
--
-- Parameters:  cg$old_rec  Calling apps view of record of row to be locked
--              cg$old_ind  Record of columns to raise error if modified
--              nowait_flag TRUE lock with NOWAIT, FALSE don't fail if busy
--------------------------------------------------------------------------------
PROCEDURE lck(cg$old_rec IN cg$row_type,
              cg$old_ind IN cg$ind_type,
              nowait_flag IN BOOLEAN DEFAULT TRUE) IS
cg$tmp_rec cg$row_type;
any_modified BOOLEAN := FALSE;

BEGIN
--  Application_logic Pre-Lock <<Start>>
--  Application_logic Pre-Lock << End >>

--  Do the row lock

    BEGIN
        IF (nowait_flag) THEN
            IF cg$old_rec.the_rowid is null THEN
               SELECT       PRA_SQ
               ,            PCA_SQ
               ,            PAL_SQ
               ,            PAL_VALOR
               INTO         cg$tmp_rec.PRA_SQ
               ,            cg$tmp_rec.PCA_SQ
               ,            cg$tmp_rec.PAL_SQ
               ,            cg$tmp_rec.PAL_VALOR
               FROM      PROJECAO_ARQUIVOS_LANC
               WHERE              PRA_SQ = cg$old_rec.PRA_SQ
               FOR UPDATE NOWAIT;
            ELSE
               SELECT       PRA_SQ
               ,            PCA_SQ
               ,            PAL_SQ
               ,            PAL_VALOR
               INTO         cg$tmp_rec.PRA_SQ
               ,            cg$tmp_rec.PCA_SQ
               ,            cg$tmp_rec.PAL_SQ
               ,            cg$tmp_rec.PAL_VALOR
               FROM      PROJECAO_ARQUIVOS_LANC
               WHERE rowid = cg$old_rec.the_rowid
               FOR UPDATE NOWAIT;
            END IF;
        ELSE
            IF cg$old_rec.the_rowid is null THEN
               SELECT       PRA_SQ
               ,            PCA_SQ
               ,            PAL_SQ
               ,            PAL_VALOR
               INTO         cg$tmp_rec.PRA_SQ
               ,            cg$tmp_rec.PCA_SQ
               ,            cg$tmp_rec.PAL_SQ
               ,            cg$tmp_rec.PAL_VALOR
               FROM      PROJECAO_ARQUIVOS_LANC
               WHERE              PRA_SQ = cg$old_rec.PRA_SQ
               FOR UPDATE;
            ELSE
               SELECT       PRA_SQ
               ,            PCA_SQ
               ,            PAL_SQ
               ,            PAL_VALOR
               INTO         cg$tmp_rec.PRA_SQ
               ,            cg$tmp_rec.PCA_SQ
               ,            cg$tmp_rec.PAL_SQ
               ,            cg$tmp_rec.PAL_VALOR
               FROM      PROJECAO_ARQUIVOS_LANC
               WHERE rowid = cg$old_rec.the_rowid
               FOR UPDATE;
            END IF;
        END IF;

    EXCEPTION
        WHEN cg$errors.cg$error THEN
            cg$errors.raise_failure;
        WHEN cg$errors.resource_busy THEN
            cg$errors.push(cg$errors.MsgGetText(cg$errors.API_ROW_LCK, cg$errors.ROW_LCK),
                           'E',
                           'ORA',
                           SQLCODE,
                           'cg$PROJECAO_ARQUIVOS_LANC.lck.resource_busy');
            cg$errors.raise_failure;
        WHEN no_data_found THEN
            cg$errors.push(cg$errors.MsgGetText(cg$errors.API_ROW_DEL, cg$errors.ROW_DEL),
                           'E',
                           'ORA',
                           SQLCODE,
                           'cg$PROJECAO_ARQUIVOS_LANC.lck.no_data_found');
            cg$errors.raise_failure;
        WHEN OTHERS THEN
            cg$errors.push(SQLERRM,
                           'E',
                           'ORA',
                           SQLCODE,
                           'cg$PROJECAO_ARQUIVOS_LANC.lck.others');
            cg$errors.raise_failure;
    END;

-- Optional Columns


-- Mandatory Columns

    IF (cg$old_ind.PRA_SQ) THEN
        IF (cg$tmp_rec.PRA_SQ != cg$old_rec.PRA_SQ) THEN
            cg$errors.push(cg$errors.MsgGetText(cg$errors.API_ROW_MOD, cg$errors.ROW_MOD, P10PRA_SQ
                ),'E', 'API', CG$ERRORS.API_MODIFIED, 'cg$PROJECAO_ARQUIVOS_LANC.lck');
            any_modified := TRUE;
        END IF;
    END IF;
    IF (cg$old_ind.PCA_SQ) THEN
        IF (cg$tmp_rec.PCA_SQ != cg$old_rec.PCA_SQ) THEN
            cg$errors.push(cg$errors.MsgGetText(cg$errors.API_ROW_MOD, cg$errors.ROW_MOD, P20PCA_SQ
                ),'E', 'API', CG$ERRORS.API_MODIFIED, 'cg$PROJECAO_ARQUIVOS_LANC.lck');
            any_modified := TRUE;
        END IF;
    END IF;
    IF (cg$old_ind.PAL_SQ) THEN
        IF (cg$tmp_rec.PAL_SQ != cg$old_rec.PAL_SQ) THEN
            cg$errors.push(cg$errors.MsgGetText(cg$errors.API_ROW_MOD, cg$errors.ROW_MOD, P22PAL_SQ
                ),'E', 'API', CG$ERRORS.API_MODIFIED, 'cg$PROJECAO_ARQUIVOS_LANC.lck');
            any_modified := TRUE;
        END IF;
    END IF;
    IF (cg$old_ind.PAL_VALOR) THEN
        IF (cg$tmp_rec.PAL_VALOR != cg$old_rec.PAL_VALOR) THEN
            cg$errors.push(cg$errors.MsgGetText(cg$errors.API_ROW_MOD, cg$errors.ROW_MOD, P24PAL_VALOR
                ),'E', 'API', CG$ERRORS.API_MODIFIED, 'cg$PROJECAO_ARQUIVOS_LANC.lck');
            any_modified := TRUE;
        END IF;
    END IF;

    IF (any_modified) THEN
        cg$errors.raise_failure;
    END IF;

--  Application_logic Post-Lock <<Start>>
--  Application_logic Post-Lock << End >>

END lck;


BEGIN
      cg$ind_true.PRA_SQ := TRUE;
      cg$ind_true.PCA_SQ := TRUE;
      cg$ind_true.PAL_SQ := TRUE;
      cg$ind_true.PAL_VALOR := TRUE;


END cg$PROJECAO_ARQUIVOS_LANC;
/

SHOW ERRORS;


CREATE OR REPLACE PACKAGE BODY cg$errors IS


   cg$err_msg      cg$err_msg_t;
   cg$err_error    cg$err_error_t;
   cg$err_msg_type cg$err_msg_type_t;
   cg$err_msgid    cg$err_msgid_t;
   cg$err_loc      cg$err_loc_t;

   FUNCTION GetVersion
   RETURN varchar2 IS
   BEGIN
      return CG$ERROR_PACKAGE_VERSION;
   END;

   -----------------------------------------------------------------------------
   -- Name:        GetErrors
   -- Description: Pops all messages off the stack and returns them in the
   --              reverse order in which they were raised.
   -- Parameters:  none
   -- Returns:     The messages
   -----------------------------------------------------------------------------
   FUNCTION GetErrors RETURN varchar2
   IS
      maxMessageLength  constant integer := 32767;
      agregatedMessage  varchar2(32767);
      nextMessage       varchar2(512);
   BEGIN
     while cg$errors.pop(nextMessage)
     loop
       if agregatedMessage IS null
       then
          agregatedMessage := nextMessage;
       else
         if ( (length(agregatedMessage)+length(nextMessage)+4) < maxMessageLength )  -- B2401878 : add length check
         then
           agregatedMessage := nextMessage || chr(10) || '   ' || agregatedMessage;
         end if;
       end if;
     end loop;

     return agregatedMessage;
   END;

   -----------------------------------------------------------------------------
   -- Name:        LookErrors
   -- Description: Pops all messages off the stack and returns them in the
   --              reverse order in which they were raised.
   -- Parameters:  none
   -- Returns:     The messages
   -----------------------------------------------------------------------------
   FUNCTION LookErrors RETURN varchar2
   IS
      maxMessageLength  constant integer := 32767;
      agregatedMessage  varchar2(32767);
      nextMessage       varchar2(512);
   BEGIN
     -- B2401878 : Return errors in reverse order like GetErrors
     -- for i in 1..cg$err_tab_i-1 loop
     for i in reverse 1..cg$err_tab_i-1
     loop
       if agregatedMessage IS NULL
       then
         agregatedMessage := 'TAPI-' || to_char(cg$err_msgid(i)) || ':' || cg$err_msg(i);
       else
         if ( (  length(agregatedMessage)
               + length(cg$err_msg(i))
               + length(to_char(cg$err_msgid(i))) + 16 ) < maxMessageLength )  -- B2401878 : add length check
         then
           agregatedMessage := agregatedMessage || chr(10) ||
                               '           TAPI-' || to_char(cg$err_msgid(i)) || ':' || cg$err_msg(i);
          end if;
       end if;
     end loop;

     return agregatedMessage;
   END;

   --------------------------------------------------------------------------------
   -- Name:        raise_failure
   --
   -- Description: To raise the cg$error failure exception handler
   --------------------------------------------------------------------------------
   PROCEDURE raise_failure
   IS
   BEGIN
       raise_application_error(-20999, LookErrors);
   END raise_failure;

   --------------------------------------------------------------------------------
   -- Name:        parse_constraint
   -- Description: Isolate constraint name from an Oracle error message
   -- Parameters:  msg     The actual Oracle error message
   --              type    type of constraint to find
   --                      (ERR_FOREIGN_KEY     Foreign key,
   --                       ERR_CHECK_CON       Check,
   --                       ERR_UNIQUE_KEY      Unique key,
   --                       ERR_DELETE_RESTRICT Restricted delete)
   -- Returns:     con_name Constraint found (NULL if none found)
   --------------------------------------------------------------------------------
   FUNCTION parse_constraint(msg   in varchar2
                            ,type  in integer)
   RETURN varchar2 IS
       con_name    varchar2(100) := '';
   BEGIN

       if (type = ERR_FOREIGN_KEY	or
           type = ERR_CHECK_CON	    or
           type = ERR_UNIQUE_KEY	or
           type = ERR_DELETE_RESTRICT)
       then
           con_name := substr(msg, instr(msg, '.') + 1, instr(msg, ')') - instr(msg, '.') - 1);
       end if;

       return con_name;
   END;

   --------------------------------------------------------------------------------
   -- Name:        push
   --
   -- Description: Put a message on stack with full info
   --
   -- Parameters:  msg      Text message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   --------------------------------------------------------------------------------
   PROCEDURE push(msg      in varchar2
                 ,error    in varchar2  DEFAULT 'E'
                 ,msg_type in varchar2  DEFAULT NULL
                 ,msgid    in integer   DEFAULT 0
                 ,loc      in varchar2  DEFAULT NULL)
   IS
   BEGIN

       cg$err_msg(cg$err_tab_i)        := msg;
       cg$err_error(cg$err_tab_i)      := error;
       cg$err_msg_type(cg$err_tab_i)   := msg_type;
       cg$err_msgid(cg$err_tab_i)      := msgid;
       cg$err_loc(cg$err_tab_i)        := loc;
       cg$err_tab_i                    := cg$err_tab_i + 1;

   END push;

   --------------------------------------------------------------------------------
   -- Name:        pop
   -- Description: Take a message off stack
   -- Parameters:  msg     Text message
   -- Returns:     TRUE    Message popped successfully
   --              FALSE   Stack was empty
   --------------------------------------------------------------------------------
   FUNCTION pop(msg OUT varchar2)
   RETURN boolean IS
   BEGIN

       if (cg$err_tab_i > 1 and cg$err_msg(cg$err_tab_i - 1) IS NOT NULL)
       then
           cg$err_tab_i := cg$err_tab_i - 1;
           msg          := cg$err_msg(cg$err_tab_i);
           cg$err_msg(cg$err_tab_i) := '';
           return TRUE;
       else
           return FALSE;
       end if;

   END pop;

   --------------------------------------------------------------------------------
   -- Name:        pop (overload)
   -- Description: Take a message off stack with full info
   -- Parameters:  msg      Ttext message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -- Returns:     TRUE     Message popped successfully
   --              FALSE    Stack was empty
   --------------------------------------------------------------------------------
   FUNCTION pop(msg        OUT varchar2
               ,error      OUT varchar2
               ,msg_type   OUT varchar2
               ,msgid      OUT integer
               ,loc        OUT varchar2)
   RETURN boolean IS
   BEGIN

       if (cg$err_tab_i > 1 and cg$err_msg(cg$err_tab_i - 1) IS NOT NULL)
       then
           cg$err_tab_i := cg$err_tab_i - 1;
           msg          := cg$err_msg(cg$err_tab_i);
           cg$err_msg(cg$err_tab_i) := '';
           error        := cg$err_error(cg$err_tab_i);
           msg_type     := cg$err_msg_type(cg$err_tab_i);
           msgid        := cg$err_msgid(cg$err_tab_i);
           loc          := cg$err_loc(cg$err_tab_i);
           return TRUE;
       else
           return FALSE;
       end if;

   END pop;


   --------------------------------------------------------------------------------
   -- Name:        pop_head
   -- Description: Take a message off stack from head
   -- Parameters:  msg     Text message
   -- Returns:     TRUE    Message popped successfully
   --              FALSE   Stack was empty
   --------------------------------------------------------------------------------
   FUNCTION pop_head(msg OUT varchar2)
   RETURN boolean IS
   BEGIN

       if (cg$err_tab_i > 1 and cg$err_msg(cg$err_tab_i - 1) IS NOT NULL)
       then
           msg := cg$err_msg(1);

           for i in 1..cg$err_tab_i-2 loop
              cg$err_msg(i) := cg$err_msg(i+1);
              cg$err_error(i) := cg$err_error(i+1);
              cg$err_msg_type(i) := cg$err_msg_type(i+1);
              cg$err_msgid(i) := cg$err_msgid(i+1);
              cg$err_loc(i) := cg$err_loc(i+1);
           end loop;

           cg$err_tab_i := cg$err_tab_i - 1;
           cg$err_msg(cg$err_tab_i) := '';
           return TRUE;
       else
           return FALSE;
       end if;

   END pop_head;


   --------------------------------------------------------------------------------
   -- Name:        pop_head (overload)
   -- Description: Take a message off stack from head with full info
   -- Parameters:  msg      Ttext message
   --              error    ERRor or WARNing
   --              msg_type ORA, API or user TLA
   --              msg_id   Id of message
   --              loc      Location where error occured
   -- Returns:     TRUE     Message popped successfully
   --              FALSE    Stack was empty
   --------------------------------------------------------------------------------
   FUNCTION pop_head(msg        OUT varchar2
                     ,error      OUT varchar2
                     ,msg_type   OUT varchar2
                     ,msgid      OUT integer
                     ,loc        OUT varchar2)
   RETURN boolean IS
   BEGIN

       if (cg$err_tab_i > 1 and cg$err_msg(cg$err_tab_i - 1) IS NOT NULL) then
           msg          := cg$err_msg(1);
           error        := cg$err_error(1);
           msg_type     := cg$err_msg_type(1);
           msgid        := cg$err_msgid(1);
           loc          := cg$err_loc(1);

           for i in 1..cg$err_tab_i-2 loop
              cg$err_msg(i) := cg$err_msg(i+1);
              cg$err_error(i) := cg$err_error(i+1);
              cg$err_msg_type(i) := cg$err_msg_type(i+1);
              cg$err_msgid(i) := cg$err_msgid(i+1);
              cg$err_loc(i) := cg$err_loc(i+1);
           end loop;

           cg$err_tab_i := cg$err_tab_i - 1;
           cg$err_msg(cg$err_tab_i) := '';

           return TRUE;
       else
           return FALSE;
       end if;

   END pop_head;


   --------------------------------------------------------------------------------
   -- Name:        clear
   -- Description: Clears the stack
   -- Parameters:  none
   --------------------------------------------------------------------------------
   PROCEDURE clear
   IS
   BEGIN
       cg$err_tab_i := 1;
   END clear;

   --------------------------------------------------------------------------------
   -- Name:        MsgGetText
   -- Description: Provides a mechanism for text translation.
   -- Parameters:  p_MsgNo    The Id of the message
   --              p_DfltText The Default Text
   --              p_Subst1 (to 4) Substitution strings
   --              p_LangId   The Language ID
   -- Returns:		Translated message
   --------------------------------------------------------------------------------
   FUNCTION MsgGetText(p_MsgNo in number
                      ,p_DfltText in varchar2
                      ,p_Subst1 in varchar2
                      ,p_Subst2 in varchar2
                      ,p_Subst3 in varchar2
                      ,p_Subst4 in varchar2
                      ,p_LangId in number)
   RETURN varchar2 IS
      l_temp varchar2(10000) := p_DfltText;
   BEGIN

      l_temp := replace(l_temp, '<p>',  p_Subst1);
      l_temp := replace(l_temp, '<p1>', p_Subst1);
      l_temp := replace(l_temp, '<p2>', p_Subst2);
      l_temp := replace(l_temp, '<p3>', p_Subst3);
      l_temp := replace(l_temp, '<p4>', p_Subst4);

      return l_temp;

   END MsgGetText;

END cg$errors;
/

SHOW ERRORS;


CREATE OR REPLACE Procedure temp2 Is

   v_dsc_linha fin_extratos_itens_tmp.dsc_linha%Type;

Begin

   --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
   -- ATUALIZA STA_LINHA DE DESCARTE PARA ABERTO QUANDO NÃO INICIAR POR DATA
   --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
   -- Tipo de Cota Master

   For r In (Select dsc_linha From fin_extratos_itens_tmp Where seq_linha = 2129) Loop
   
	 
	 delete fin_extratos_itens_tmp Where seq_linha = 2129;
	  Insert Into fin_extratos_itens_tmp
		 (seq_extrato, seq_linha, dsc_linha, cod_conta)
	  Values
		 (28, 2129, r.dsc_linha, 3);
   
   End Loop;

End temp2;
/

SHOW ERRORS;


CREATE OR REPLACE Procedure temp1 Is

  v_dsc_linha fin_extratos_itens_tmp.dsc_linha%Type;

Begin

	--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	-- ATUALIZA STA_LINHA DE DESCARTE PARA ABERTO QUANDO NÃO INICIAR POR DATA
	--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	-- Tipo de Cota Master

	For r In (Select dsc_linha From fin_extratos_itens_tmp
	                 where seq_linha = 1977)
	Loop
	
	   update fin_extratos_itens_tmp
		 set dsc_linha = r.dsc_linha
		where seq_linha = 1977;
	
		v_dsc_linha := pkg_consistir_dados.fnc_valida_numero(substr(r.dsc_linha, 1, 2));
	
		If nvl(substr(v_dsc_linha, 1, 2), 32) Between 0 And 31 Then
		
		v_dsc_linha := v_dsc_linha;
		
		
		End If;

		v_dsc_linha := v_dsc_linha;



	End Loop;
End temp1;
/

SHOW ERRORS;


CREATE OR REPLACE Procedure temp(p_seq_extrato In fin_extratos_itens_tmp.seq_extrato%Type) Is

	Type rc Is Ref Cursor;
	l_cursor       rc;
	sql_stmt       Varchar2(2000);
	v_linha_cursor Varchar2(2000);
	v_linha        Number;
	v_select       Varchar2(2000);

	Cursor c_classif Is
		Select cod_conta, dsc_condicao
		  From financeiro.fin_plano_contas_classificar
		 Where sta_bloq = 'N' And
			   seq_item = 282
		 Order By seq_item;

Begin

  	v_select := pkg_consistir_dados.FNC_VALIDA_NUMERO('v_select');

	For r_cod In c_classif
	Loop
	
		v_select := 'SELECT 
			DSC_LINHA HOT_LINHA, SEQ_LINHA ' || 'FROM FINANCEIRO.FIN_EXTRATOS_ITENS_TMP ' ||
					'WHERE seq_extrato = ' || p_seq_extrato || 
					'and sta_linha =' || '''A''' || 
					' and UPPER(DSC_LINHA) ' ||	r_cod.dsc_condicao;
	
		sql_stmt := v_select;
		Open l_cursor For sql_stmt;
		Loop
			Fetch l_cursor
				Into v_linha_cursor, v_linha;
			Exit When l_cursor%Notfound;
		
			Update financeiro.fin_extratos_itens_tmp
			   Set cod_conta = r_cod.cod_conta
			 Where seq_extrato = p_seq_extrato And
				   seq_linha = v_linha;
		
			Commit;
		
			v_linha_cursor := v_linha_cursor;
			v_linha        := v_linha;
		
		End Loop;
		Close l_cursor;
	
	End Loop;
Exception
	When Others Then
		raise_application_error(-20002, v_select);
	
End temp;
/

SHOW ERRORS;


CREATE OR REPLACE TRIGGER trg_FIN_PLANO_CLASSIFICAR_biu
   Before Insert or update On FIN_PLANO_CONTAS_CLASSIFICAR
   For Each Row
Begin

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Sequência
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
 If :New.SEQ_ITEM Is Null Then
    Select SQ_FIN_PLANO_CLASSIFICAR.Nextval Into :New.SEQ_ITEM From dual;
  End If;

End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER FIN_PLANO_CONTAS_BIU
 BEFORE INSERT OR UPDATE
 ON FIN_PLANO_CONTAS
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- VERIFICAR SE CAMPOS DE REFERENCIA FORAM DIGITADOS
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	-- Tipo de Cota Master
	IF LENGTH(:NEW.COD_CONTA) = 1 THEN 
	 :NEW.COD_CONTA_REF := '';
	 :NEW.TPO_CONTA_PLANO := 'M';
	ELSIF LENGTH(:NEW.COD_CONTA) = 3 THEN 
   :NEW.COD_CONTA_REF := SUBSTR(:NEW.COD_CONTA, 1, 1);
	 :NEW.TPO_CONTA_PLANO := 'S';
	ELSIF LENGTH(:NEW.COD_CONTA) = 7 THEN 
   :NEW.COD_CONTA_REF := SUBSTR(:NEW.COD_CONTA, 1, 3);
	 :NEW.TPO_CONTA_PLANO := 'A';
	ELSE
    RAISE_APPLICATION_ERROR(-20001, 'CAMPO NÃO PODE SER PREENCHIDO ');
  END IF;


END;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER FIN_EXTRATOS_ITENS_TMP_BI
 BEFORE INSERT
 ON FIN_EXTRATOS_ITENS_TMP
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
Begin

   --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
   -- ATUALIZA STA_LINHA DE DESCARTE PARA ABERTO QUANDO NÃO INICIAR POR DATA
   --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+


   begin
   If nvl(substr(:New.dsc_linha, 1, 2), 32) Between 1 And 31 Then
	  :New.cod_conta := 3000001;
	 end if;
   exception
    when invalid_number then 	  :New.cod_conta := 3000003;
	when value_error  then 	  :New.cod_conta := 3000003;
   end;
	 
	 -- Linhas de Complemento
   If substr(:New.dsc_linha, 1, 17) = '                 ' 
	    and :New.dsc_linha not like '%SISBB - Sistema de Informações Banco do Brasil%'
			         and :New.dsc_linha not like '%Fatura do Cartão de Crédito%' 
			         and :New.dsc_linha not like '% Extrato de conta corrente%' 
							 Then
	  :New.cod_conta := 3000004;
	 end if;
	 
	 -- Linhas de resumo do cartão de credito	
   If translate(:New.dsc_linha, '-+=., 01234567893', '-+=')  = '--+=-=' Then
	  :New.cod_conta := 3000003;
   End If;

End;
/
SHOW ERRORS;



CREATE OR REPLACE TRIGGER trg_PROJECAO_CONTAS_biu
   Before Insert or update On PROJECAO_CONTAS
   For Each Row
Begin

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- Sequência
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
	If :New.PCA_SQ Is Null Then
    Select seq_PROJECAO_CONTAS.Nextval Into :New.pca_sq From dual;
  End If;
	
	:new.pca_descricao := initcap(:new.pca_descricao);
	
End;
/
SHOW ERRORS;



ALTER TABLE FIN_INSTITUICAO ADD (
  CONSTRAINT FIN_INSTITUICAO_CK01
 CHECK (TPO_EXTRATO in ('B', 'C', 'H')),
  CONSTRAINT FIN_INSTITUICAO_CK02
 CHECK (STA_BLOQ in ('S', 'N')),
  CONSTRAINT FIN_INSTITUICAO_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO));

ALTER TABLE FIN_EXTRATOS_TMP ADD (
  CONSTRAINT AVCON_1610977552_STA_E_000
 CHECK (STA_EXTRATO IN ('A', 'R', 'C', 'I')),
  CONSTRAINT FIN_EXTRATOS_PK
 PRIMARY KEY
 (SEQ_EXTRATO));

ALTER TABLE FIN_EXTRATOS_ITENS_TMP ADD (
  CONSTRAINT FIN_EXTRATOS_BB_PK
 PRIMARY KEY
 (SEQ_EXTRATO, SEQ_LINHA));

ALTER TABLE FIN_INTERFACE_PREFIXO ADD (
  CONSTRAINT INTERFACE_PREFIXO_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO, COD_PREFIXO));

ALTER TABLE FIN_EXTRATOS ADD (
  CONSTRAINT FIN_EXTRATOS1_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO, SEQ_EXTRATO));

ALTER TABLE PROJECAO_ARQUIVOS_LANC ADD (
  CONSTRAINT PAL_PK
 PRIMARY KEY
 (PAL_SQ, PRA_SQ));

ALTER TABLE FIN_EXTRATOS_CTB ADD (
  CONSTRAINT FIN_EXTRATOS_CTB_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO, SEQ_EXTRATO, MES_LANCTO, ANO_LANCTO, VAL_NIVEL, COD_CONTA));

ALTER TABLE FIN_INTERFACE ADD (
  CONSTRAINT AVCON_1607014898_TPO_C_000
 CHECK (TPO_CAMPO IN ('C', 'N', 'D', 'F')),
  CONSTRAINT FIN_INTERFACE_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO, COD_PREFIXO, SEQ_INTERFACE));

ALTER TABLE PROJECAO_CONTAS ADD (
  CONSTRAINT PROJECAO_CONTAS_CK01
 CHECK ("PCA_DM_TP_CONTA"='C' OR "PCA_DM_TP_CONTA"='D'),
  CONSTRAINT PROJECAO_CONTAS_CK02
 CHECK (PCA_DM_FL_PARCIAL IN ('S', 'N')),
  CONSTRAINT PROJECAO_CONTAS_CK03
 CHECK (PCA_DM_FL_BLOQ IN ('S', 'N')),
  CONSTRAINT PCA_PK
 PRIMARY KEY
 (PCA_SQ));

ALTER TABLE PROJECAO_ARQUIVOS ADD (
  CONSTRAINT PROJECAO_ARQUIVOS_CK01
 CHECK (PRA_DM_TP_PROJECAO IN ('C', 'D')),
  CONSTRAINT PROJECAO_ARQUIVOS_CK02
 CHECK (PRA_DM_TP_ARQUIVO IN ('C', 'H')),
  CONSTRAINT PRA_PK
 PRIMARY KEY
 (PRA_SQ));

ALTER TABLE FIN_PLANO_CONTAS_CLASSIFICAR ADD (
  CONSTRAINT AVCON_1609790150_STA_B_000
 CHECK (STA_BLOQ IN ('N', 'S')),
  CONSTRAINT FIN_PLANO_CONTAS_CLASS_PK
 PRIMARY KEY
 (SEQ_ITEM));

ALTER TABLE FIN_PLANO_CONTAS ADD (
  CONSTRAINT FIN_PLANO_CONTAS_CK01
 CHECK (STA_BLOQ  in ('S', 'N')),
  CONSTRAINT FIN_PLANO_CONTAS_CK02
 CHECK ("TPO_CONTA_PLANO"='M' OR "TPO_CONTA_PLANO"='S' OR "TPO_CONTA_PLANO"='A'),
  CONSTRAINT FIN_PLANO_CONTAS_CK03
 CHECK (sta_complemento in ('S', 'N')),
  CONSTRAINT FIN_PLANO_CONTAS_CK04
 CHECK (DM_TP_CONTA in ('D', 'C')),
  CONSTRAINT FIN_PLANO_CONTAS_CK05
 CHECK (sta_holding  in ('S', 'N')),
  CONSTRAINT FIN_PLANO_CONTAS_PK
 PRIMARY KEY
 (COD_CONTA));

ALTER TABLE FIN_EXTRATOS_ITENS ADD (
  CONSTRAINT FIN_EXTRATOS_ITENS_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO, SEQ_EXTRATO, SEQ_ITEM));

ALTER TABLE FIN_EXTRATOS_TMP ADD (
  CONSTRAINT FIN_EXTRATOS_TMP_FK 
 FOREIGN KEY (SEQ_INSTITUICAO) 
 REFERENCES FIN_INSTITUICAO (SEQ_INSTITUICAO));

ALTER TABLE FIN_EXTRATOS_ITENS_TMP ADD (
  CONSTRAINT FEP_FPA_FK 
 FOREIGN KEY (COD_CONTA) 
 REFERENCES FIN_PLANO_CONTAS (COD_CONTA),
  CONSTRAINT FIN_EXTRATOS_BB_FK01 
 FOREIGN KEY (SEQ_EXTRATO) 
 REFERENCES FIN_EXTRATOS_TMP (SEQ_EXTRATO));

ALTER TABLE FIN_INTERFACE_PREFIXO ADD (
  CONSTRAINT IPO_FIO_FK 
 FOREIGN KEY (SEQ_INSTITUICAO) 
 REFERENCES FIN_INSTITUICAO (SEQ_INSTITUICAO));

ALTER TABLE FIN_EXTRATOS ADD (
  CONSTRAINT FEO_FEP_FK 
 FOREIGN KEY (SEQ_EXTRATO_TMP) 
 REFERENCES FIN_EXTRATOS_TMP (SEQ_EXTRATO),
  CONSTRAINT FEO_FIO_FK 
 FOREIGN KEY (SEQ_INSTITUICAO) 
 REFERENCES FIN_INSTITUICAO (SEQ_INSTITUICAO));

ALTER TABLE PROJECAO_ARQUIVOS_LANC ADD (
  CONSTRAINT PAL_PRA_FK 
 FOREIGN KEY (PRA_SQ) 
 REFERENCES PROJECAO_ARQUIVOS (PRA_SQ),
  CONSTRAINT PAL_PCA_FK 
 FOREIGN KEY (PCA_SQ) 
 REFERENCES PROJECAO_CONTAS (PCA_SQ));

ALTER TABLE FIN_EXTRATOS_CTB ADD (
  CONSTRAINT FEB_FPA_FK 
 FOREIGN KEY (COD_CONTA) 
 REFERENCES FIN_PLANO_CONTAS (COD_CONTA),
  CONSTRAINT FEB_FEO_FK 
 FOREIGN KEY (SEQ_INSTITUICAO, SEQ_EXTRATO) 
 REFERENCES FIN_EXTRATOS (SEQ_INSTITUICAO,SEQ_EXTRATO));

ALTER TABLE FIN_INTERFACE ADD (
  CONSTRAINT INE_FIO_FK 
 FOREIGN KEY (SEQ_INSTITUICAO, COD_PREFIXO) 
 REFERENCES FIN_INTERFACE_PREFIXO (SEQ_INSTITUICAO,COD_PREFIXO));

ALTER TABLE FIN_PLANO_CONTAS_CLASSIFICAR ADD (
  CONSTRAINT FPR_FPA_FK 
 FOREIGN KEY (COD_CONTA) 
 REFERENCES FIN_PLANO_CONTAS (COD_CONTA));

ALTER TABLE FIN_PLANO_CONTAS ADD (
  CONSTRAINT FPA_FPA_FK 
 FOREIGN KEY (COD_CONTA_REF) 
 REFERENCES FIN_PLANO_CONTAS (COD_CONTA));

ALTER TABLE FIN_EXTRATOS_ITENS ADD (
  CONSTRAINT FEN_FPA_FK 
 FOREIGN KEY (COD_CONTA) 
 REFERENCES FIN_PLANO_CONTAS (COD_CONTA),
  CONSTRAINT FEN_FEO_FK 
 FOREIGN KEY (SEQ_INSTITUICAO, SEQ_EXTRATO) 
 REFERENCES FIN_EXTRATOS (SEQ_INSTITUICAO,SEQ_EXTRATO));

