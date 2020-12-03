--
-- Create Schema Script 
--   Database Version   : 11.2.0.1.0 
--   TOAD Version       : 9.0.1.8 
--   DB Connect String  : TESTE 
--   Schema             : FINANCEIRO 
--   Script Created by  : PORTAL 
--   Script Created at  : 03/12/2020 16:31:16 
--   Physical Location  :  
--   Notes              :  
--

-- Object Counts: 
--   Indexes: 7         Columns: 11         
--   Packages: 3        Lines of Code: 372 
--   Package Bodies: 3  Lines of Code: 1419 
--   Sequences: 4 
--   Tables: 7          Columns: 49         Constraints: 23     
--   Triggers: 2 


CREATE SEQUENCE SEQ_PROJECAO_ARQUIVOS
  START WITH 7
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SEQ_PROJECAO_ARQUIVOS_LANC
  START WITH 91
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE SEQUENCE SEQ_PROJECAO_CONTAS
  START WITH 26
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
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
  TPO_CAMPO        VARCHAR2(1 BYTE)             DEFAULT 'C',
  STA_TABELA       VARCHAR2(1 BYTE)             DEFAULT 'S'                   NOT NULL
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
  DSC_PREFICO      VARCHAR2(40 BYTE)            NOT NULL
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


CREATE TABLE FIN_INSTITUICAO
(
  SEQ_INSTITUICAO  NUMBER                       NOT NULL,
  DSC_INSTITUICAO  VARCHAR2(60 BYTE)            NOT NULL,
  STA_FECHAMENTO   VARCHAR2(1 BYTE)             NOT NULL,
  TPO_INTERFACE    VARCHAR2(3 BYTE)             DEFAULT 'CSV'                 NOT NULL,
  NOM_IMAGEM       VARCHAR2(80 BYTE),
  STA_BLOQ         VARCHAR2(1 BYTE)             NOT NULL
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


CREATE TABLE FIN_PLANO_CONTAS
(
  COD_CONTA        NUMBER                       NOT NULL,
  CONTA_CHAR       VARCHAR2(30 BYTE)            NOT NULL,
  DSC_CONTA        VARCHAR2(80 BYTE)            NOT NULL,
  SEQ_INSTITUICAO  NUMBER                       NOT NULL,
  COD_CONTA_REF    NUMBER,
  STA_CONTA        VARCHAR2(1 BYTE)             NOT NULL,
  STA_BLOQ         VARCHAR2(1 BYTE)             NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE UNIQUE INDEX PAL_PK ON PROJECAO_ARQUIVOS_LANC
(PRA_SQ, PAL_SQ)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX PRA_PK ON PROJECAO_ARQUIVOS
(PRA_SQ)
LOGGING
NOPARALLEL;


CREATE UNIQUE INDEX FIN_PLANO_CONTAS_PK ON FIN_PLANO_CONTAS
(COD_CONTA)
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


CREATE OR REPLACE TRIGGER FIN_PLANO_CONTAS_BIU
 BEFORE INSERT OR UPDATE
 ON FIN_PLANO_CONTAS
 REFERENCING OLD AS OLD NEW AS NEW
 FOR EACH ROW
BEGIN

  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
  -- VERIFICAR SE CAMPOS DE REFERENCIA FORAM DIGITADOS
  --+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

  IF :NEW.COD_CONTA_REF IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20001, 'CAMPO NÃO PODE SER PREENCHIDO ');
  END IF;

  :NEW.COD_CONTA_REF := SUBSTR(:NEW.COD_CONTA, 1, LENGTH(:NEW.COD_CONTA) - 2);
  :NEW.CONTA_CHAR := :NEW.COD_CONTA;


END;
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



ALTER TABLE FIN_INTERFACE ADD (
  CONSTRAINT AVCON_1607014898_STA_T_000
 CHECK (STA_TABELA IN ('S', 'N')),
  CONSTRAINT AVCON_1607014898_TPO_C_000
 CHECK (TPO_CAMPO IN ('C', 'N', 'D')),
  CONSTRAINT FIN_INTERFACE_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO, COD_PREFIXO, SEQ_INTERFACE));

ALTER TABLE FIN_INTERFACE_PREFIXO ADD (
  CONSTRAINT INTERFACE_PREFIXO_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO, COD_PREFIXO));

ALTER TABLE PROJECAO_ARQUIVOS_LANC ADD (
  CONSTRAINT PAL_PK
 PRIMARY KEY
 (PAL_SQ, PRA_SQ));

ALTER TABLE FIN_INSTITUICAO ADD (
  CONSTRAINT FIN_INSTITUICAO_CK01
 CHECK (TPO_INTERFACE IN ('CSV', 'POS', 'SEM')),
  CONSTRAINT MODELO_CK01
 CHECK ("STA_FECHAMENTO"='S' OR "STA_FECHAMENTO"='N'),
  CONSTRAINT MODELO_CK02
 CHECK (STA_BLOQ IN ('S', 'N')),
  CONSTRAINT FIN_INSTITUICAO_PK
 PRIMARY KEY
 (SEQ_INSTITUICAO));

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

ALTER TABLE FIN_PLANO_CONTAS ADD (
  CONSTRAINT FIN_PLANO_CONTAS_PK
 PRIMARY KEY
 (COD_CONTA));

ALTER TABLE FIN_INTERFACE ADD (
  CONSTRAINT INE_FIO_FK 
 FOREIGN KEY (SEQ_INSTITUICAO, COD_PREFIXO) 
 REFERENCES FIN_INTERFACE_PREFIXO (SEQ_INSTITUICAO,COD_PREFIXO));

ALTER TABLE FIN_INTERFACE_PREFIXO ADD (
  CONSTRAINT IPO_FIO_FK 
 FOREIGN KEY (SEQ_INSTITUICAO) 
 REFERENCES FIN_INSTITUICAO (SEQ_INSTITUICAO));

ALTER TABLE PROJECAO_ARQUIVOS_LANC ADD (
  CONSTRAINT PAL_PCA_FK 
 FOREIGN KEY (PCA_SQ) 
 REFERENCES PROJECAO_CONTAS (PCA_SQ),
  CONSTRAINT PAL_PRA_FK 
 FOREIGN KEY (PRA_SQ) 
 REFERENCES PROJECAO_ARQUIVOS (PRA_SQ));

ALTER TABLE FIN_PLANO_CONTAS ADD (
  CONSTRAINT FPA_FIO_FK 
 FOREIGN KEY (SEQ_INSTITUICAO) 
 REFERENCES FIN_INSTITUICAO (SEQ_INSTITUICAO),
  CONSTRAINT FPA_FPA_FK 
 FOREIGN KEY (COD_CONTA_REF) 
 REFERENCES FIN_PLANO_CONTAS (COD_CONTA));

