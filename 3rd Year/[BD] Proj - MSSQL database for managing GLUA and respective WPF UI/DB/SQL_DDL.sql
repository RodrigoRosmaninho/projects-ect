CREATE TABLE PESSOA (
    ID      INT NOT NULL IDENTITY(1,1),
    Nome    VARCHAR(30) NOT NULL,
    Notas   VARCHAR(240),

    PRIMARY KEY (ID)
);

CREATE TABLE CURSO (
    Sigla 			VARCHAR(10) NOT NULL,
    Departamento 	VARCHAR(10) NOT NULL,

    PRIMARY KEY (Sigla)
);

CREATE TABLE ESTUDANTE (
    ID 				INT NOT NULL,
    Nmec 			INT CHECK (Nmec > 0),
    Curso 			VARCHAR(10),
    Ano_matricula   DATE,

    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES PESSOA(ID) ON DELETE CASCADE,
	FOREIGN KEY (Curso) REFERENCES CURSO(Sigla) ON DELETE SET NULL ON UPDATE CASCADE
    
);

CREATE TABLE UTENTE (
    ID          INT NOT NULL,
    Contacto    VARCHAR(40),

    PRIMARY KEY (ID),
    FOREIGN KEY (ID) REFERENCES PESSOA(ID) ON DELETE CASCADE
);

CREATE TABLE SESSAO (
    ID              INT NOT NULL IDENTITY(1,1),
    Data            DATETIME NOT NULL,
    Local           VARCHAR(30) NOT NULL,
    Num_previstos   INT CHECK (Num_previstos >= 0), 

    PRIMARY KEY (ID),
    UNIQUE (Data)
);

CREATE TABLE PC (
    ID              INT NOT NULL IDENTITY(1,1),  
    Fabricante      VARCHAR(30) NOT NULL,
    Modelo          VARCHAR(40),

    PRIMARY KEY (ID),
    UNIQUE (Fabricante, Modelo)
);

CREATE TABLE ATENDIMENTO (
    ID                  INT NOT NULL IDENTITY(1,1),
    Data                DATETIME NOT NULL,
    Local               VARCHAR(30),
    Tempo_despendido    INT CHECK (Tempo_despendido >= 0),
    PC_id               INT,
    Sessao_id           INT,
    Utente_id           INT,

    PRIMARY KEY (ID),
    FOREIGN KEY (PC_id) REFERENCES PC(ID) ON DELETE SET NULL,
    FOREIGN KEY (Sessao_id) REFERENCES SESSAO(ID) ON DELETE CASCADE,
    FOREIGN KEY (Utente_id) REFERENCES UTENTE(ID) ON DELETE SET NULL
);

CREATE TABLE SISTEMA_OPERATIVO (
    ID      INT NOT NULL IDENTITY(1,1),
    Nome    VARCHAR(30) NOT NULL, 
    Versao  VARCHAR(30),

    PRIMARY KEY (ID),
    UNIQUE (Nome, Versao)
);

CREATE TABLE MEMBRO (
    ID              INT NOT NULL,
    Email           VARCHAR(40) NOT NULL,
    Num_telemovel   INT CHECK(Num_telemovel > 0),
    Tipo            INT NOT NULL DEFAULT 0 CHECK (Tipo >= 0),      -- 0 -> Efetivo, 1 -> Colaborador, 3 -> Senior, 4 -> Honorario, (possivelmente mais no futuro)
    Estado          INT NOT NULL DEFAULT 1 CHECK (Estado >= 0),    -- 0 -> Inativo, 1 -> Ativo, (possivelmente algo intermédio no futuro)
    Data_entrada    DATE,

    PRIMARY KEY (ID),
    UNIQUE (Email),
    FOREIGN KEY (ID) REFERENCES PESSOA(ID) ON DELETE CASCADE
);

CREATE TABLE EQUIPAMENTO (
    ID              INT NOT NULL IDENTITY(1,1),
    Nome            VARCHAR(40) NOT NULL,
    Descricao       VARCHAR(240),    
    Localizacao     VARCHAR(120) NOT NULL,
    Estado          INT NOT NULL DEFAULT 0 CHECK (Estado >= 0),    -- 0 -> Ativo, 1 -> Perdido, 3 -> Inutilizavel, 4 -> Sub-ótimo, (possivelmente mais no futuro)  
    Dador           VARCHAR(40),
    Membro_id       INT,

    PRIMARY KEY (ID),
    FOREIGN KEY (Membro_id) REFERENCES MEMBRO(ID) ON DELETE SET NULL
);

CREATE TABLE FLASH_DRIVE (
	ID				INT NOT NULL,
	Fabricante		VARCHAR(30),
	Capacidade		INT NOT NULL, -- em GB
	Velocidade		INT NOT NULL, -- USB 2.0 / USB 3.0 / ...
	Conteudo		VARCHAR(240),
	SO_id			INT,

	PRIMARY KEY (ID),
	FOREIGN KEY (ID) REFERENCES EQUIPAMENTO(ID) ON DELETE CASCADE,
	FOREIGN KEY (SO_id) REFERENCES SISTEMA_OPERATIVO(ID) ON DELETE SET NULL
);

CREATE TABLE PARTICIPACAO (
	Membro_id		INT NOT NULL,
	Sessao_id		INT NOT NULL,

	PRIMARY KEY (Membro_id, Sessao_id),
	FOREIGN KEY (Membro_id) REFERENCES MEMBRO(ID) ON DELETE CASCADE,
	FOREIGN KEY (Sessao_id) REFERENCES SESSAO(ID) ON DELETE CASCADE
);


CREATE TABLE PRESTACAO (
	Membro_id		INT NOT NULL,
	Atendimento_id	INT NOT NULL,

	PRIMARY KEY (Membro_id, Atendimento_id),
	FOREIGN KEY (Membro_id) REFERENCES MEMBRO(ID) ON DELETE CASCADE,
	FOREIGN KEY (Atendimento_id) REFERENCES ATENDIMENTO(ID) ON DELETE CASCADE
);

CREATE TABLE PLATAFORMA (
	Nome			VARCHAR(30) NOT NULL,
	Link			VARCHAR(30) NOT NULL,
	Descricao		VARCHAR(30),

	PRIMARY KEY (Nome),
	UNIQUE (Link)
);

CREATE TABLE ACESSO (
	Plataforma_nome	VARCHAR(30) NOT NULL,
	Membro_id		INT NOT NULL,
	Username		VARCHAR(30) NOT NULL,
	Tipo			VARCHAR(30),

	PRIMARY KEY (Plataforma_nome, Membro_id),
	FOREIGN KEY (Plataforma_nome) REFERENCES PLATAFORMA(Nome) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Membro_id) REFERENCES MEMBRO(ID) ON DELETE CASCADE
);

CREATE TABLE TOPICO (
	ID		INT NOT NULL IDENTITY(1,1),
	Nome	VARCHAR(40) NOT NULL,

	PRIMARY KEY (ID),
	UNIQUE (Nome)
);

CREATE TABLE COMPONENTE (
	ID				INT NOT NULL IDENTITY(1,1),
	Fabricante		VARCHAR(30) NOT NULL,
	Modelo			VARCHAR(30)

	PRIMARY KEY (ID),
	UNIQUE (Fabricante, Modelo)
);

CREATE TABLE PROBLEMA (
	ID				INT NOT NULL IDENTITY(1,1),
	Descricao		VARCHAR(240) NOT NULL,
	Componente_id	INT,
	SO_id			INT,

	PRIMARY KEY (ID),
	FOREIGN KEY (Componente_id) REFERENCES COMPONENTE(ID) ON DELETE SET NULL,
	FOREIGN KEY (SO_id) REFERENCES SISTEMA_OPERATIVO(ID) ON DELETE SET NULL
);

CREATE TABLE TENTATIVA (
	Problema_id		INT NOT NULL,
	Atendimento_id	INT,
	Estado			INT DEFAULT 0 CHECK (Estado >= 0), 	-- 0 -> Bem sucedido, 1 -> Mal sucedido, 2 -> Melhoria parcial, (possivelmente mais no futuro)
	Procedimento    VARCHAR(500),

	PRIMARY KEY (Problema_id, Atendimento_id),
	FOREIGN KEY (Problema_id) REFERENCES PROBLEMA(ID) ON DELETE CASCADE,
	FOREIGN KEY (Atendimento_id) REFERENCES ATENDIMENTO(ID) ON DELETE CASCADE,
);

CREATE TABLE TOPICO_PROBLEMA (
	Topico_id		INT NOT NULL,
	Problema_id		INT NOT NULL,

	PRIMARY KEY (Topico_id, Problema_id),
	FOREIGN KEY (Topico_id) REFERENCES TOPICO(ID) ON DELETE CASCADE,
	FOREIGN KEY (Problema_id) REFERENCES PROBLEMA(ID) ON DELETE CASCADE,
);

CREATE TABLE dbo.ACCOUNT (
  Membro_ID INT,
  Salt CHAR(25),
  AccountPwd VARBINARY(20),
  CONSTRAINT PK_SecurityAccounts PRIMARY KEY (Membro_ID),
  FOREIGN KEY (Membro_ID) REFERENCES MEMBRO(ID) ON DELETE CASCADE
);



