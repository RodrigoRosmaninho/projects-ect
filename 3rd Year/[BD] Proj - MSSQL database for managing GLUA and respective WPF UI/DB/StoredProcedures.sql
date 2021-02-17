GO
CREATE PROC ModifyUtente (@ID int , @Name varchar(30), @Notas varchar(240), @Contacto varchar(40), @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO PESSOA (Nome, Notas) VALUES (@Name, @Notas);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO UTENTE VALUES (@p_id, @Contacto);
		IF @IsStudent = 'true' 
			INSERT INTO ESTUDANTE VALUES(@p_id, @Nmec, @Curso_Sigla, @Ano_Matricula)
	END;
	ELSE
	BEGIN
		UPDATE PESSOA SET Nome = @Name, Notas = @Notas WHERE ID = @ID;
		UPDATE UTENTE SET Contacto = @Contacto WHERE ID = @ID;

		DECLARE @result_id as int;
		SET @result_id = (SELECT ID FROM ESTUDANTE WHERE ID = @ID);

		IF @IsStudent = 'true'
		BEGIN
			IF @result_id is NULL
				INSERT INTO ESTUDANTE VALUES(@ID, @Nmec, @Curso_Sigla, @Ano_Matricula)
			ELSE
				UPDATE ESTUDANTE SET Nmec = @Nmec, Curso = @Curso_Sigla, Ano_matricula = @Ano_Matricula WHERE ID = @ID
		END;
		ELSE
		BEGIN
			IF @result_id is not NULL
				DELETE FROM ESTUDANTE WHERE ID = @ID;
		END;	
	END;

	COMMIT TRAN;
RETURN;

GO
CREATE PROC ModifyMembro (@ID int , @Name varchar(30), @Notas varchar(240), @Email varchar(40), @Num_telemovel int, @Tipo int, @Estado int, @Data_entrada DATE,  @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO PESSOA (Nome, Notas) VALUES (@Name, @Notas);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO Membro VALUES (@p_id, @Email, @Num_telemovel, @Tipo, @Estado, @Data_entrada);
		IF @IsStudent = 'true' 
			INSERT INTO ESTUDANTE VALUES(@p_id, @Nmec, @Curso_Sigla, @Ano_Matricula)
	END;
	ELSE
	BEGIN
		UPDATE PESSOA SET Nome = @Name, Notas = @Notas WHERE ID = @ID;
		UPDATE MEMBRO SET Email = @Email, Num_telemovel = @Num_telemovel, Tipo = @Tipo, Estado = @Estado, Data_entrada = @Data_entrada WHERE ID = @ID;

		DECLARE @result_id as int;
		SET @result_id = (SELECT ID FROM ESTUDANTE WHERE ID = @ID);

		IF @IsStudent = 'true'
		BEGIN
			IF @result_id is NULL
				INSERT INTO ESTUDANTE VALUES(@ID, @Nmec, @Curso_Sigla, @Ano_Matricula)
			ELSE
				UPDATE ESTUDANTE SET Nmec = @Nmec, Curso = @Curso_Sigla, Ano_matricula = @Ano_Matricula WHERE ID = @ID
		END;
		ELSE
		BEGIN
			IF @result_id is not NULL
				DELETE FROM ESTUDANTE WHERE ID = @ID;
		END;
	END;

	COMMIT TRAN;
RETURN;

GO
CREATE PROC ModifyEquipamento (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		IF @Membro_id = -1
			INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, Null);
		ELSE
			INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
	END;
	ELSE
	BEGIN
		IF @Membro_id = -1
			UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador WHERE ID = @ID;
		ELSE
			UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;
	END;
	COMMIT TRAN;
RETURN;

GO
CREATE PROC ModifyFlashDrive (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int, @Fabricante varchar(30), @Capacidade int,
										@Velocidade int, @Conteudo varchar(240), @SO_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		IF @Membro_id = -1
		BEGIN
			INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, Null);
			DECLARE @p_id as int;
			SET @p_id = SCOPE_IDENTITY();
			INSERT INTO FLASH_DRIVE VALUES (@p_id, @Fabricante, @Capacidade, @Velocidade, @Conteudo, @SO_id);
		END;
		ELSE
		BEGIN
			INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
			DECLARE @pid as int;
			SET @pid = SCOPE_IDENTITY();
			INSERT INTO FLASH_DRIVE VALUES (@pid, @Fabricante, @Capacidade, @Velocidade, @Conteudo, @SO_id);
		END;
	END;
	ELSE
	BEGIN
		IF @Membro_id = -1
		BEGIN
			UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador WHERE ID = @ID;
			UPDATE FLASH_DRIVE SET Fabricante=@Fabricante, Capacidade=@Capacidade, Velocidade=@Velocidade, Conteudo=@Conteudo, SO_id=@SO_id WHERE ID = @ID;
		END;
		ELSE
		BEGIN
			UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;
			UPDATE FLASH_DRIVE SET Fabricante=@Fabricante, Capacidade=@Capacidade, Velocidade=@Velocidade, Conteudo=@Conteudo, SO_id=@SO_id WHERE ID = @ID;
		END;
	END;

	COMMIT TRAN;
RETURN;

GO
CREATE PROC ModifySistemaOperativo (@ID int, @Name varchar(30), @Versao varchar(30))
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO SISTEMA_OPERATIVO VALUES (@Name, @Versao);
	ELSE
		UPDATE SISTEMA_OPERATIVO SET Nome = @Name, Versao=@Versao WHERE ID = @ID;

	COMMIT TRAN;
RETURN;

GO
CREATE PROC ModifyCurso (@Sigla varchar(10), @Departamento varchar(10))
AS
	INSERT INTO Curso VALUES (@Sigla, @Departamento);
RETURN;

GO

CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;

GO

CREATE PROC UpdatePlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30), @PK varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @PK;
RETURN;

GO

CREATE PROC ModifyTopico (@ID int , @Nome varchar(40))
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO TOPICO (Nome) VALUES (@Nome);
    END;
    ELSE
    BEGIN
        UPDATE TOPICO SET Nome = @Nome WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;

GO

CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGINc
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;

GO

CREATE PROC ModifyAtendimentos (@ID int, @Data datetime, @Local varchar(30), @Tempo_despendido int, @PC_id int, @Sessao_id int, @Utente_id int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO ATENDIMENTO(Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES (@Data, @Local, @Tempo_despendido,@PC_id, @Sessao_id, @Utente_id);
    END;
    ELSE
    BEGIN
        UPDATE ATENDIMENTO SET Data = @Data, Local = @Local, Tempo_despendido = @Tempo_despendido, PC_id = @PC_id, Sessao_id = @Sessao_id, Utente_id = @Utente_id WHERE ID = @ID;
    END;
    COMMIT TRAN;
RETURN;

GO

CREATE PROC ModifyProblemas (@ID int, @Descricao varchar(240), @Componente_id int, @SO_id int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO PROBLEMA(Descricao, Componente_id, SO_id) VALUES (@Descricao, @Componente_id, @SO_id);
    END;
    ELSE
    BEGIN
        UPDATE PROBLEMA SET Descricao = @Descricao, Componente_id = @Componente_id, SO_id = @SO_id WHERE ID = @ID;
    END;
    COMMIT TRAN;
RETURN;

GO

CREATE PROC ModifyComponente (@ID int , @Fabricante varchar(30), @Modelo varchar(30))
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES (@Fabricante, @Modelo);
    END;
    ELSE
    BEGIN
        UPDATE COMPONENTE SET Fabricante = @Fabricante, Modelo = @Modelo WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;

GO

CREATE PROC ModifyPC (@ID int , @Fabricante varchar(30), @Modelo varchar(30))
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO PC (Fabricante, Modelo) VALUES (@Fabricante, @Modelo);
    END;
    ELSE
    BEGIN
        UPDATE COMPONENTE SET Fabricante = @Fabricante, Modelo = @Modelo WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;

GO

CREATE PROC ModifyTentativa (@PID int, @AID int, @Estado int, @Procedimento varchar(500))
AS
    BEGIN TRAN

    IF EXISTS(SELECT 1 FROM dbo.TENTATIVA
          WHERE Problema_id = @PID AND Atendimento_id = @AID)
    BEGIN
        UPDATE TENTATIVA SET Estado = @Estado, Procedimento = @Procedimento WHERE Problema_id = @PID AND Atendimento_id = @AID;
    END;
    ELSE
    BEGIN
		INSERT INTO TENTATIVA(Problema_id, Atendimento_id, Estado, Procedimento) VALUES (@PID, @AID, @Estado, @Procedimento);
    END;
    COMMIT TRAN;
RETURN;

GO

CREATE PROC dbo.ModifyAccount
  @MembroID    INT,
  @AccountPwd VARCHAR(100)
AS
BEGIN

  SET NOCOUNT ON;

  DECLARE @Salt VARCHAR(25);
  DECLARE @PwdWithSalt VARCHAR(125);

  DECLARE @Seed int;
  DECLARE @LCV tinyint;
  DECLARE @CTime DATETIME;

  SET @CTime = GETDATE();
  SET @Seed = (DATEPART(hh, @Ctime) * 10000000) + (DATEPART(n, @CTime) * 100000)
      + (DATEPART(s, @CTime) * 1000) + DATEPART(ms, @CTime);
  SET @LCV = 1;
  SET @Salt = CHAR(ROUND((RAND(@Seed) * 94.0) + 32, 3));

  WHILE (@LCV < 25)
  BEGIN
    SET @Salt = @Salt + CHAR(ROUND((RAND() * 94.0) + 32, 3));
 SET @LCV = @LCV + 1;
  END;


  SET @PwdWithSalt = @Salt + @AccountPwd;

  IF EXISTS(SELECT 1 FROM dbo.ACCOUNT
          WHERE Membro_ID = @MembroID)
	BEGIN
		UPDATE dbo.ACCOUNT SET Salt = @Salt, AccountPwd =  HASHBYTES('SHA1', @PwdWithSalt) WHERE Membro_ID = @MembroID
    END;
	ELSE
    BEGIN
        INSERT INTO dbo.ACCOUNT 
			(Membro_ID, Salt, AccountPwd)
			VALUES (@MembroID, @Salt, HASHBYTES('SHA1', @PwdWithSalt));
    END;
END;

GO

CREATE PROC dbo.VerifyAccount
  @AccountEmail VARCHAR(50),
  @AccountPwd VARCHAR(100)
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @Salt CHAR(25);
  DECLARE @PwdWithSalt VARCHAR(125);
  DECLARE @PwdHash VARBINARY(20);  

  SELECT @Salt = Salt, @PwdHash = AccountPwd 
  FROM dbo.ACCOUNT WHERE Membro_ID = (SELECT ID FROM dbo.MEMBRO WHERE Email = @AccountEmail);
  
  SET @PwdWithSalt = @Salt + @AccountPwd;

  IF (HASHBYTES('SHA1', @PwdWithSalt) = @PwdHash)
    RETURN 0;
  ELSE
    RETURN 1;

END;
GO
