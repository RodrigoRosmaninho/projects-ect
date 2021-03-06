USE [master]
GO
/****** Object:  Database [p1g4]    Script Date: 12/06/2020 02:49:25 ******/
CREATE DATABASE [p1g4]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'p1g4', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\p1g4.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'p1g4_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSERVER\MSSQL\DATA\p1g4_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [p1g4] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [p1g4].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [p1g4] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [p1g4] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [p1g4] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [p1g4] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [p1g4] SET ARITHABORT OFF 
GO
ALTER DATABASE [p1g4] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [p1g4] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [p1g4] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [p1g4] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [p1g4] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [p1g4] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [p1g4] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [p1g4] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [p1g4] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [p1g4] SET  ENABLE_BROKER 
GO
ALTER DATABASE [p1g4] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [p1g4] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [p1g4] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [p1g4] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [p1g4] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [p1g4] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [p1g4] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [p1g4] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [p1g4] SET  MULTI_USER 
GO
ALTER DATABASE [p1g4] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [p1g4] SET DB_CHAINING OFF 
GO
ALTER DATABASE [p1g4] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [p1g4] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [p1g4] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [p1g4] SET QUERY_STORE = OFF
GO
USE [p1g4]
GO
/****** Object:  User [p1g4]    Script Date: 12/06/2020 02:49:25 ******/
CREATE USER [p1g4] FOR LOGIN [p1g4] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [p1g4]
GO
/****** Object:  Schema [ex5]    Script Date: 12/06/2020 02:49:25 ******/
CREATE SCHEMA [ex5]
GO
/****** Object:  UserDefinedFunction [dbo].[getIdFromComponenteFabricante]    Script Date: 12/06/2020 02:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
*/

--Exec InsertPlataformas 'Slack', 'detiuaveiro.slack.com', 'Slack do DETI';

/*
CREATE PROC UpdatePlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30), @PK varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @PK;
RETURN;
*/

/*
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
*/

/*
CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;
*/

/*
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
*/

/*
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
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END

CREATE TRIGGER deleteTentativa ON dbo.TENTATIVA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.TENTATIVA WHERE Problema_id,  IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
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
*/

/*
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
*/

CREATE FUNCTION [dbo].[getIdFromComponenteFabricante](@Fabricante varchar(30), @Modelo varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
    IF @Modelo is NULL
        SET @ID = (SELECT ID FROM COMPONENTE WHERE Fabricante = @Fabricante);
    ELSE
        SET @ID = (SELECT ID FROM COMPONENTE WHERE Fabricante = @Fabricante and Modelo = @Modelo);
    RETURN(@ID)
END
GO
/****** Object:  UserDefinedFunction [dbo].[getIdFromPCFabricante]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getIdFromPCFabricante](@Fabricante varchar(30), @Modelo varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
    IF @Modelo is NULL
        SET @ID = (SELECT ID FROM PC WHERE Fabricante = @Fabricante);
    ELSE
        SET @ID = (SELECT ID FROM PC WHERE Fabricante = @Fabricante and Modelo = @Modelo);
    RETURN(@ID)
END
GO
/****** Object:  UserDefinedFunction [dbo].[getIdFromSystemOpName]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersID (@ID int) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID*/

/*CREATE FUNCTION getAtendimentosListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome FROM dbo.Atendimentos_Membros WHERE Membro_ID = @ID;*/

/*CREATE FUNCTION getOpSystemByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Versao FROM SISTEMA_OPERATIVO WHERE ID = @ID;*/

/*CREATE FUNCTION getUtenteByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Contacto, Notas FROM dbo.Utentes WHERE dbo.Utentes.ID = @ID;*/


/*CREATE FUNCTION getLastAtendimentoByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT TOP 1 Atendimento_ID, Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID ORDER BY Data;*/

/*CREATE FUNCTION getProblemsByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Problema_ID, Data, Descricao, Fabricante, Modelo FROM dbo.Problemas_Utentes WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAtendimentosListByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAcessListByPlatformName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Username, ACESSO.Tipo as Tipo_Acesso, Nome, Email FROM (ACESSO JOIN PESSOA ON ACESSO.Membro_id = PESSOA.ID) JOIN MEMBRO ON PESSOA.ID = MEMBRO.ID WHERE ACESSO.Plataforma_nome = @Name;*/

/*CREATE FUNCTION getMembersBySessionID (@ID int) RETURNS Table
AS
RETURN SELECT Membro_id, Nome, Email, Data_entrada, Estado FROM (SELECT * FROM dbo.Membros) as X JOIN dbo.SESSOES_Membros ON X.ID = Membro_id WHERE SESSOES_Membros.ID = @ID and Estado = 1*/

/*CREATE FUNCTION getCoursesByDepName (@Name varchar(10)) RETURNS Table
AS
RETURN SELECT Sigla FROM Curso WHERE Departamento = @Name*/

/*CREATE FUNCTION isPersonAlsoStudent(@ID INT) RETURNS INT AS
BEGIN
    DECLARE @res AS INT, @verif AS INT
	SET @verif = (SELECT ID FROM ESTUDANTE WHERE ID = @ID)
	IF @verif is NULL
		SET @res = 0;
	ELSE
		SET @res = 1;
    RETURN(@res)
END*/


/*CREATE FUNCTION getStudentByID (@ID INT) RETURNS Table
AS
RETURN SELECT * FROM ESTUDANTE JOIN CURSO ON Curso = Sigla WHERE ID = @ID*/

CREATE FUNCTION [dbo].[getIdFromSystemOpName](@Name varchar(30), @Version varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
	IF @Version is NULL
		SET @ID = (SELECT ID FROM SISTEMA_OPERATIVO WHERE Nome = @Name);
	ELSE
		SET @ID = (SELECT ID FROM SISTEMA_OPERATIVO WHERE Nome = @Name and Versao = @Version);
    RETURN(@ID)
END
GO
/****** Object:  UserDefinedFunction [dbo].[getMembroIDByEmail]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

/*
CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
*/

--SELECT * FROM getCursoStats()

/*
CREATE FUNCTION getPCStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getPCStats()

/*
CREATE FUNCTION getComponenteStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.COMPONENTE.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.COMPONENTE ON dbo.ATENDIMENTO.PC_id = dbo.COMPONENTE.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getComponenteStats()

/*
CREATE FUNCTION getMonthStats() RETURNS Table AS
	RETURN(SELECT MONTH(Data) AS mes, COUNT(ID) AS atendimentos_num 
			FROM ATENDIMENTOS 
			WHERE DATEDIFF(MM, Data, GETDATE()) < 12 
			GROUP BY MONTH(Data), YEAR(Data))
*/

--SELECT * FROM getMonthStats()

CREATE FUNCTION [dbo].[getMembroIDByEmail](@Email VARCHAR(40)) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=ID
	FROM dbo.MEMBRO
	WHERE Email = @Email

	RETURN(@res)
END

GO
/****** Object:  UserDefinedFunction [dbo].[isFlashDrive]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

/*
CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
*/

--SELECT * FROM getCursoStats()

/*
CREATE FUNCTION getPCStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getPCStats()

/*
CREATE FUNCTION getComponenteStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.COMPONENTE.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.COMPONENTE ON dbo.ATENDIMENTO.PC_id = dbo.COMPONENTE.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getComponenteStats()

/*
CREATE FUNCTION getMonthStats() RETURNS Table AS
	RETURN(SELECT MONTH(Data) AS mes, COUNT(ID) AS atendimentos_num 
			FROM ATENDIMENTOS 
			WHERE DATEDIFF(MM, Data, GETDATE()) < 12 
			GROUP BY MONTH(Data), YEAR(Data))
*/

--SELECT * FROM getMonthStats()

/*
CREATE FUNCTION getMembroIDByEmail(@Email VARCHAR(40)) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=ID
	FROM dbo.MEMBRO
	WHERE Email = @Email

	RETURN(@res)
END
*/

--SELECT * FROM Atendimentos_Membros ORDER BY Nome ASC
--SELECT * FROM Atendimentos ORDER BY Utente ASC

CREATE FUNCTION [dbo].[isFlashDrive](@ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	IF EXISTS(SELECT 1 FROM dbo.FLASH_DRIVE
          WHERE ID = @ID)
		RETURN 1;
    RETURN 0;
END
GO
/****** Object:  UserDefinedFunction [dbo].[isPersonAlsoStudent]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersID (@ID int) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID*/

/*CREATE FUNCTION getAtendimentosListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome FROM dbo.Atendimentos_Membros WHERE Membro_ID = @ID;*/

/*CREATE FUNCTION getOpSystemByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Versao FROM SISTEMA_OPERATIVO WHERE ID = @ID;*/

/*CREATE FUNCTION getUtenteByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Contacto, Notas FROM dbo.Utentes WHERE dbo.Utentes.ID = @ID;*/


/*CREATE FUNCTION getLastAtendimentoByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT TOP 1 Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID ORDER BY Data;*/

/*CREATE FUNCTION getProblemsByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Data, Descricao, Fabricante, Modelo FROM dbo.Problemas_Utentes WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAtendimentosListByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAcessListByPlatformName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Username, ACESSO.Tipo as Tipo_Acesso, Nome, Email FROM (ACESSO JOIN PESSOA ON ACESSO.Membro_id = PESSOA.ID) JOIN MEMBRO ON PESSOA.ID = MEMBRO.ID WHERE ACESSO.Plataforma_nome = @Name;*/

/*CREATE FUNCTION getMembersBySessionID (@ID int) RETURNS Table
AS
RETURN SELECT Membro_id, Nome, Email, Data_entrada, Estado FROM (SELECT * FROM dbo.Membros) as X JOIN dbo.SESSOES_Membros ON X.ID = Membro_id WHERE SESSOES_Membros.ID = @ID and Estado = 1*/

/*CREATE FUNCTION getCoursesByDepName (@Name varchar(10)) RETURNS Table
AS
RETURN SELECT Sigla FROM Curso WHERE Departamento = @Name*/

CREATE FUNCTION [dbo].[isPersonAlsoStudent](@ID INT) RETURNS INT AS
BEGIN
    DECLARE @res AS INT, @verif AS INT
	SET @verif = (SELECT ID FROM ESTUDANTE WHERE ID = @ID)
	IF @verif is NULL
		SET @res = 0;
	ELSE
		SET @res = 1;
    RETURN(@res)
END

GO
/****** Object:  UserDefinedFunction [dbo].[wasProblemResolvedByProblemID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)


CREATE FUNCTION [dbo].[wasProblemResolvedByProblemID] (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END


--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)


/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT        dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END) 
                         AS membros_num
FROM            dbo.ATENDIMENTO INNER JOIN
                         dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                         dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                         dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                         dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                         dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
WHERE dbo.SESSAO.ID = @Helpdesk_ID
GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)


GO
/****** Object:  Table [dbo].[EQUIPAMENTO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EQUIPAMENTO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](40) NOT NULL,
	[Descricao] [varchar](240) NULL,
	[Localizacao] [varchar](120) NOT NULL,
	[Estado] [int] NOT NULL,
	[Dador] [varchar](40) NULL,
	[Membro_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FLASH_DRIVE]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLASH_DRIVE](
	[ID] [int] NOT NULL,
	[Fabricante] [varchar](30) NULL,
	[Capacidade] [int] NOT NULL,
	[Velocidade] [int] NOT NULL,
	[Conteudo] [varchar](240) NULL,
	[SO_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Equipamentos_NaoFlashDrive]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[Equipamentos_NaoFlashDrive] AS SELECT        dbo.EQUIPAMENTO.ID, dbo.EQUIPAMENTO.Nome, dbo.EQUIPAMENTO.Descricao, dbo.EQUIPAMENTO.Localizacao, dbo.EQUIPAMENTO.Estado, dbo.EQUIPAMENTO.Dador
FROM            dbo.EQUIPAMENTO LEFT OUTER JOIN
                         dbo.FLASH_DRIVE ON dbo.EQUIPAMENTO.ID = dbo.FLASH_DRIVE.ID
WHERE FLASH_DRIVE.ID is Null; 
GO
/****** Object:  Table [dbo].[SISTEMA_OPERATIVO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SISTEMA_OPERATIVO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](30) NOT NULL,
	[Versao] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Equipamentos_FlashDrive_SistemaOp]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Equipamentos_FlashDrive_SistemaOp]
AS
SELECT        dbo.EQUIPAMENTO.ID, dbo.EQUIPAMENTO.Nome, dbo.EQUIPAMENTO.Estado, dbo.EQUIPAMENTO.Localizacao, dbo.EQUIPAMENTO.Membro_id, dbo.EQUIPAMENTO.Dador, dbo.EQUIPAMENTO.Descricao, 
                         dbo.FLASH_DRIVE.Fabricante, dbo.FLASH_DRIVE.Capacidade, dbo.FLASH_DRIVE.Velocidade, dbo.FLASH_DRIVE.Conteudo, dbo.SISTEMA_OPERATIVO.Nome AS SistemaOp_Nome, dbo.SISTEMA_OPERATIVO.Versao
FROM            dbo.EQUIPAMENTO INNER JOIN
                         dbo.FLASH_DRIVE ON dbo.EQUIPAMENTO.ID = dbo.FLASH_DRIVE.ID LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.FLASH_DRIVE.SO_id = dbo.SISTEMA_OPERATIVO.ID
GO
/****** Object:  Table [dbo].[PESSOA]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PESSOA](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](30) NOT NULL,
	[Notas] [varchar](240) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ACESSO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACESSO](
	[Plataforma_nome] [varchar](30) NOT NULL,
	[Membro_id] [int] NOT NULL,
	[Username] [varchar](30) NOT NULL,
	[Tipo] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Plataforma_nome] ASC,
	[Membro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getMembersByPlatform]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

CREATE FUNCTION [dbo].[getMembersByPlatform] (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
GO
/****** Object:  Table [dbo].[PLATAFORMA]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLATAFORMA](
	[Nome] [varchar](30) NOT NULL,
	[Link] [varchar](30) NOT NULL,
	[Descricao] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Plataformas]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Plataformas]
AS
SELECT        dbo.PLATAFORMA.Nome, dbo.PLATAFORMA.Link, dbo.PLATAFORMA.Descricao, COUNT(CASE WHEN dbo.ACESSO.Membro_id IS NOT NULL THEN 1 END) AS acessos_num
FROM            dbo.ACESSO RIGHT OUTER JOIN
                         dbo.PLATAFORMA ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
GROUP BY dbo.PLATAFORMA.Nome, dbo.PLATAFORMA.Link, dbo.PLATAFORMA.Descricao
GO
/****** Object:  UserDefinedFunction [dbo].[getPlatformByName]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

CREATE FUNCTION [dbo].[getPlatformByName] (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)

GO
/****** Object:  Table [dbo].[PARTICIPACAO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARTICIPACAO](
	[Membro_id] [int] NOT NULL,
	[Sessao_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Membro_id] ASC,
	[Sessao_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEMBRO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEMBRO](
	[ID] [int] NOT NULL,
	[Email] [varchar](40) NOT NULL,
	[Num_telemovel] [int] NULL,
	[Tipo] [int] NOT NULL,
	[Estado] [int] NOT NULL,
	[Data_entrada] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Membros]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Membros]
AS
SELECT        TOP (100) PERCENT dbo.PESSOA.ID, dbo.PESSOA.Nome, dbo.MEMBRO.Num_telemovel, dbo.MEMBRO.Tipo, dbo.MEMBRO.Estado, dbo.MEMBRO.Data_entrada, dbo.PESSOA.Notas, dbo.MEMBRO.Email
FROM            dbo.MEMBRO INNER JOIN
                         dbo.PESSOA ON dbo.MEMBRO.ID = dbo.PESSOA.ID
GO
/****** Object:  UserDefinedFunction [dbo].[getMembersBySessionID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersID (@ID int) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID*/

/*CREATE FUNCTION getAtendimentosListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome FROM dbo.Atendimentos_Membros WHERE Membro_ID = @ID;*/

/*CREATE FUNCTION getOpSystemByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Versao FROM SISTEMA_OPERATIVO WHERE ID = @ID;*/

/*CREATE FUNCTION getUtenteByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Contacto, Notas FROM dbo.Utentes WHERE dbo.Utentes.ID = @ID;*/


/*CREATE FUNCTION getLastAtendimentoByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT TOP 1 Atendimento_ID, Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID ORDER BY Data;*/

/*CREATE FUNCTION getProblemsByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Problema_ID, Data, Descricao, Fabricante, Modelo FROM dbo.Problemas_Utentes WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAtendimentosListByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAcessListByPlatformName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Username, ACESSO.Tipo as Tipo_Acesso, Nome, Email FROM (ACESSO JOIN PESSOA ON ACESSO.Membro_id = PESSOA.ID) JOIN MEMBRO ON PESSOA.ID = MEMBRO.ID WHERE ACESSO.Plataforma_nome = @Name;*/

CREATE FUNCTION [dbo].[getMembersBySessionID] (@ID int) RETURNS Table
AS
RETURN SELECT Membro_id, Nome, Email, Data_entrada, Estado FROM dbo.Membros as X JOIN dbo.PARTICIPACAO ON X.ID = Membro_id WHERE Sessao_ID = @ID

/*CREATE FUNCTION getCoursesByDepName (@Name varchar(10)) RETURNS Table
AS
RETURN SELECT Sigla FROM Curso WHERE Departamento = @Name*/

/*CREATE FUNCTION isPersonAlsoStudent(@ID INT) RETURNS INT AS
BEGIN
    DECLARE @res AS INT, @verif AS INT
	SET @verif = (SELECT ID FROM ESTUDANTE WHERE ID = @ID)
	IF @verif is NULL
		SET @res = 0;
	ELSE
		SET @res = 1;
    RETURN(@res)
END*/


/*CREATE FUNCTION getStudentByID (@ID INT) RETURNS Table
AS
RETURN SELECT * FROM ESTUDANTE JOIN CURSO ON Curso = Sigla WHERE ID = @ID*/

/*CREATE FUNCTION getIdFromSystemOpName(@Name varchar(30), @Version varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
	IF @Version is NULL
		SET @ID = (SELECT ID FROM SISTEMA_OPERATIVO WHERE Nome = @Name);
	ELSE
		SET @ID = (SELECT ID FROM SISTEMA_OPERATIVO WHERE Nome = @Name and Versao = @Version);
    RETURN(@ID)
END*/
GO
/****** Object:  Table [dbo].[TOPICO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOPICO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TOPICO_PROBLEMA]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOPICO_PROBLEMA](
	[Topico_id] [int] NOT NULL,
	[Problema_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Topico_id] ASC,
	[Problema_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Topicos]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Topicos]
AS
SELECT        dbo.TOPICO.Nome, COUNT(CASE WHEN dbo.TOPICO_PROBLEMA.Problema_id IS NOT NULL THEN 1 END) AS problemas_num, dbo.TOPICO.ID
FROM            dbo.TOPICO LEFT OUTER JOIN
                         dbo.TOPICO_PROBLEMA ON dbo.TOPICO.ID = dbo.TOPICO_PROBLEMA.Topico_id
GROUP BY dbo.TOPICO.Nome, dbo.TOPICO.ID
GO
/****** Object:  View [dbo].[Equipamentos_FlashDrive_SistemaOp_Responsavel]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Equipamentos_FlashDrive_SistemaOp_Responsavel]
AS
SELECT        dbo.Equipamentos_FlashDrive_SistemaOp.ID, dbo.Equipamentos_FlashDrive_SistemaOp.Nome, dbo.Equipamentos_FlashDrive_SistemaOp.Estado, dbo.Equipamentos_FlashDrive_SistemaOp.Localizacao, 
                         dbo.Equipamentos_FlashDrive_SistemaOp.Dador, dbo.Equipamentos_FlashDrive_SistemaOp.Descricao, dbo.Equipamentos_FlashDrive_SistemaOp.Fabricante, dbo.Equipamentos_FlashDrive_SistemaOp.Capacidade, 
                         dbo.Equipamentos_FlashDrive_SistemaOp.Velocidade, dbo.Equipamentos_FlashDrive_SistemaOp.Conteudo, dbo.Equipamentos_FlashDrive_SistemaOp.Versao, dbo.PESSOA.Nome AS Membro_Nome, 
                         dbo.Equipamentos_FlashDrive_SistemaOp.SistemaOp_Nome
FROM            dbo.Equipamentos_FlashDrive_SistemaOp LEFT OUTER JOIN
                         dbo.PESSOA ON dbo.Equipamentos_FlashDrive_SistemaOp.Membro_id = dbo.PESSOA.ID
GO
/****** Object:  Table [dbo].[UTENTE]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UTENTE](
	[ID] [int] NOT NULL,
	[Contacto] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Utentes]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Utentes]
AS
SELECT        dbo.PESSOA.Nome, dbo.UTENTE.Contacto, dbo.PESSOA.Notas, dbo.UTENTE.ID
FROM            dbo.PESSOA INNER JOIN
                         dbo.UTENTE ON dbo.PESSOA.ID = dbo.UTENTE.ID
GO
/****** Object:  Table [dbo].[PC]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PC](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Fabricante] [varchar](30) NOT NULL,
	[Modelo] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ATENDIMENTO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ATENDIMENTO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Data] [datetime] NOT NULL,
	[Local] [varchar](30) NULL,
	[Tempo_despendido] [int] NULL,
	[PC_id] [int] NULL,
	[Sessao_id] [int] NULL,
	[Utente_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROBLEMA]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROBLEMA](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Descricao] [varchar](240) NOT NULL,
	[Componente_id] [int] NULL,
	[SO_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TENTATIVA]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TENTATIVA](
	[Problema_id] [int] NOT NULL,
	[Atendimento_id] [int] NOT NULL,
	[Estado] [int] NULL,
	[Procedimento] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Problema_id] ASC,
	[Atendimento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Atendimentos_Problemas_PC]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Atendimentos_Problemas_PC]
AS
SELECT        dbo.ATENDIMENTO.Data, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.ATENDIMENTO.Utente_id, dbo.ATENDIMENTO.ID AS Atendimento_ID, dbo.TENTATIVA.Estado, dbo.PROBLEMA.Descricao
FROM            dbo.ATENDIMENTO LEFT OUTER JOIN
                         dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID INNER JOIN
                         dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id INNER JOIN
                         dbo.PROBLEMA ON dbo.TENTATIVA.Problema_id = dbo.PROBLEMA.ID
GO
/****** Object:  Table [dbo].[COMPONENTE]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMPONENTE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Fabricante] [varchar](30) NOT NULL,
	[Modelo] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Problemas]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Problemas]
AS
SELECT        dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, COUNT(DISTINCT dbo.TENTATIVA.Atendimento_id) 
                         AS atendimentos_num, COUNT(CASE WHEN dbo.TENTATIVA.Estado = 0 THEN 1 END) AS resolucoes_num, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA LEFT OUTER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
GROUP BY dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
GO
/****** Object:  UserDefinedFunction [dbo].[getAtendimentosListByUtenteID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM getAtendimentosListByUtenteID (49 );
CREATE FUNCTION [dbo].[getAtendimentosListByUtenteID] (@ID int) RETURNS Table AS
	RETURN (SELECT DISTINCT Atendimento_ID,  Data, Fabricante, Modelo
			FROM Atendimentos_Problemas_PC 
			WHERE Utente_id = @ID);
GO
/****** Object:  UserDefinedFunction [dbo].[getLastAtendimentoByUtenteID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getLastAtendimentoByUtenteID] (@ID int) RETURNS Table AS
	RETURN (SELECT TOP 1 Atendimento_ID, Data, Fabricante, Modelo 
			FROM Atendimentos_Problemas_PC 
			WHERE Utente_id = @ID 
			ORDER BY Data);
GO
/****** Object:  View [dbo].[Problemas_Utentes]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Problemas_Utentes]
AS
SELECT        dbo.ATENDIMENTO.Data, dbo.PROBLEMA.Descricao, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.ATENDIMENTO.Utente_id, dbo.PROBLEMA.ID AS Problema_ID
FROM            dbo.ATENDIMENTO INNER JOIN
                         dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID INNER JOIN
                         dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id INNER JOIN
                         dbo.PROBLEMA ON dbo.TENTATIVA.Problema_id = dbo.PROBLEMA.ID
GO
/****** Object:  View [dbo].[Tentativas]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Tentativas]
AS
SELECT        dbo.TENTATIVA.Problema_id, dbo.TENTATIVA.Atendimento_id, dbo.TENTATIVA.Estado, dbo.TENTATIVA.Procedimento, dbo.ATENDIMENTO.Data
FROM            dbo.TENTATIVA LEFT OUTER JOIN
                         dbo.ATENDIMENTO ON dbo.TENTATIVA.Atendimento_id = dbo.ATENDIMENTO.ID
GO
/****** Object:  UserDefinedFunction [dbo].[getAttemptsByProblemID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Problemas
			WHERE Topico = @Topic_Name)
*/

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Topico
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

CREATE FUNCTION [dbo].[getAttemptsByProblemID] (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
GO
/****** Object:  Table [dbo].[SESSAO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SESSAO](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Data] [datetime] NOT NULL,
	[Local] [varchar](30) NOT NULL,
	[Num_previstos] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PRESTACAO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRESTACAO](
	[Membro_id] [int] NOT NULL,
	[Atendimento_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Membro_id] ASC,
	[Atendimento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Atendimentos]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Atendimentos]
AS
SELECT        dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data AS Helpdesk_Data, 
                         dbo.SESSAO.Local AS Helpdesk_Local, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END) 
                         AS membros_num, dbo.ATENDIMENTO.Utente_id, dbo.ATENDIMENTO.Sessao_id
FROM            dbo.ATENDIMENTO LEFT OUTER JOIN
                         dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                         dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                         dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                         dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                         dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, 
                         dbo.ATENDIMENTO.Utente_id, dbo.ATENDIMENTO.Sessao_id
GO
/****** Object:  View [dbo].[Equipamentos_Responsaveis]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Equipamentos_Responsaveis]
AS
SELECT        dbo.EQUIPAMENTO.ID, dbo.EQUIPAMENTO.Nome, dbo.EQUIPAMENTO.Estado, dbo.EQUIPAMENTO.Localizacao, dbo.PESSOA.Nome AS Membro_Nome, dbo.EQUIPAMENTO.Dador, dbo.EQUIPAMENTO.Descricao
FROM            dbo.PESSOA RIGHT OUTER JOIN
                         dbo.EQUIPAMENTO ON dbo.PESSOA.ID = dbo.EQUIPAMENTO.Membro_id
GO
/****** Object:  UserDefinedFunction [dbo].[getEquipmentByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getEquipmentByID] (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);
GO
/****** Object:  View [dbo].[Prestacoes]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Prestacoes]
AS
SELECT        dbo.PESSOA.Nome, dbo.PESSOA.ID, dbo.PRESTACAO.Atendimento_id
FROM            dbo.PESSOA INNER JOIN
                         dbo.PRESTACAO ON dbo.PESSOA.ID = dbo.PRESTACAO.Membro_id
GO
/****** Object:  UserDefinedFunction [dbo].[getFlashDrivesByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


CREATE FUNCTION [dbo].[getFlashDrivesByID] (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);


GO
/****** Object:  UserDefinedFunction [dbo].[getPCsByFabricante]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)


CREATE FUNCTION [dbo].[getPCsByFabricante] (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
GO
/****** Object:  UserDefinedFunction [dbo].[getSystemVersionByName]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

CREATE FUNCTION [dbo].[getSystemVersionByName] (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;


GO
/****** Object:  UserDefinedFunction [dbo].[getMembersByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

CREATE FUNCTION [dbo].[getMembersByID] (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);


GO
/****** Object:  Table [dbo].[CURSO]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURSO](
	[Sigla] [varchar](10) NOT NULL,
	[Departamento] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Sigla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getCoursesByDepName]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersID (@ID int) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID*/

/*CREATE FUNCTION getAtendimentosListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome FROM dbo.Atendimentos_Membros WHERE Membro_ID = @ID;*/

/*CREATE FUNCTION getOpSystemByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Versao FROM SISTEMA_OPERATIVO WHERE ID = @ID;*/

/*CREATE FUNCTION getUtenteByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Contacto, Notas FROM dbo.Utentes WHERE dbo.Utentes.ID = @ID;*/


/*CREATE FUNCTION getLastAtendimentoByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT TOP 1 Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID ORDER BY Data;*/

/*CREATE FUNCTION getProblemsByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Data, Descricao, Fabricante, Modelo FROM dbo.Problemas_Utentes WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAtendimentosListByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAcessListByPlatformName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Username, ACESSO.Tipo as Tipo_Acesso, Nome, Email FROM (ACESSO JOIN PESSOA ON ACESSO.Membro_id = PESSOA.ID) JOIN MEMBRO ON PESSOA.ID = MEMBRO.ID WHERE ACESSO.Plataforma_nome = @Name;*/

/*CREATE FUNCTION getMembersBySessionID (@ID int) RETURNS Table
AS
RETURN SELECT Membro_id, Nome, Email, Data_entrada, Estado FROM (SELECT * FROM dbo.Membros) as X JOIN dbo.SESSOES_Membros ON X.ID = Membro_id WHERE SESSOES_Membros.ID = @ID and Estado = 1*/

CREATE FUNCTION [dbo].[getCoursesByDepName] (@Name varchar(10)) RETURNS Table
AS
RETURN SELECT Sigla FROM Curso WHERE Departamento = @Name

GO
/****** Object:  UserDefinedFunction [dbo].[getEquipmentListByMemberID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersName (@Name varchar(30)) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @Name);*/

CREATE FUNCTION [dbo].[getEquipmentListByMemberID] (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);

GO
/****** Object:  UserDefinedFunction [dbo].[getProblemsByTopic]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas


CREATE FUNCTION [dbo].[getProblemsByTopic] (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)


-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Topico
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Problemas
			WHERE Atendimento_id = @Atendimento_ID)
*/
GO
/****** Object:  View [dbo].[PCs]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PCs]
AS
SELECT        dbo.PC.ID, dbo.PC.Fabricante, dbo.PC.Modelo, SUM(dbo.ATENDIMENTO.Tempo_despendido) AS Tempo_despendido, COUNT(CASE WHEN dbo.ATENDIMENTO.Tempo_despendido IS NOT NULL THEN 1 END) 
                         AS num_vistos
FROM            dbo.PC LEFT OUTER JOIN
                         dbo.ATENDIMENTO ON dbo.PC.ID = dbo.ATENDIMENTO.PC_id
GROUP BY dbo.PC.ID, dbo.PC.Fabricante, dbo.PC.Modelo
GO
/****** Object:  UserDefinedFunction [dbo].[getTopicsByProblemID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)


CREATE FUNCTION [dbo].[getTopicsByProblemID] (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)


--DROP FUNCTION getTopicsByProblemID

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Problemas
			WHERE Atendimento_id = @Atendimento_ID)
*/
GO
/****** Object:  UserDefinedFunction [dbo].[getPCByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs


CREATE FUNCTION [dbo].[getPCByID] (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
GO
/****** Object:  View [dbo].[Sessoes_Membros]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Sessoes_Membros]
AS
SELECT        dbo.SESSAO.ID, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.SESSAO.Num_previstos, COUNT(*) AS Num_realizados, dbo.PARTICIPACAO.Membro_id
FROM            dbo.PARTICIPACAO INNER JOIN
                         dbo.SESSAO ON dbo.PARTICIPACAO.Sessao_id = dbo.SESSAO.ID INNER JOIN
                         dbo.ATENDIMENTO ON dbo.PARTICIPACAO.Sessao_id = dbo.ATENDIMENTO.Sessao_id
GROUP BY dbo.SESSAO.ID, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.SESSAO.Num_previstos, dbo.PARTICIPACAO.Membro_id
GO
/****** Object:  Table [dbo].[ESTUDANTE]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTUDANTE](
	[ID] [int] NOT NULL,
	[Nmec] [int] NULL,
	[Curso] [varchar](10) NULL,
	[Ano_matricula] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getStudentByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersID (@ID int) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID*/

/*CREATE FUNCTION getAtendimentosListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome FROM dbo.Atendimentos_Membros WHERE Membro_ID = @ID;*/

/*CREATE FUNCTION getOpSystemByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Versao FROM SISTEMA_OPERATIVO WHERE ID = @ID;*/

/*CREATE FUNCTION getUtenteByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Contacto, Notas FROM dbo.Utentes WHERE dbo.Utentes.ID = @ID;*/


/*CREATE FUNCTION getLastAtendimentoByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT TOP 1 Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID ORDER BY Data;*/

/*CREATE FUNCTION getProblemsByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Data, Descricao, Fabricante, Modelo FROM dbo.Problemas_Utentes WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAtendimentosListByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAcessListByPlatformName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Username, ACESSO.Tipo as Tipo_Acesso, Nome, Email FROM (ACESSO JOIN PESSOA ON ACESSO.Membro_id = PESSOA.ID) JOIN MEMBRO ON PESSOA.ID = MEMBRO.ID WHERE ACESSO.Plataforma_nome = @Name;*/

/*CREATE FUNCTION getMembersBySessionID (@ID int) RETURNS Table
AS
RETURN SELECT Membro_id, Nome, Email, Data_entrada, Estado FROM (SELECT * FROM dbo.Membros) as X JOIN dbo.SESSOES_Membros ON X.ID = Membro_id WHERE SESSOES_Membros.ID = @ID and Estado = 1*/

/*CREATE FUNCTION getCoursesByDepName (@Name varchar(10)) RETURNS Table
AS
RETURN SELECT Sigla FROM Curso WHERE Departamento = @Name*/

/*CREATE FUNCTION isPersonAlsoStudent(@ID INT) RETURNS INT AS
BEGIN
    DECLARE @res AS INT, @verif AS INT
	SET @verif = (SELECT ID FROM ESTUDANTE WHERE ID = @ID)
	IF @verif is NULL
		SET @res = 0;
	ELSE
		SET @res = 1;
    RETURN(@res)
END*/


CREATE FUNCTION [dbo].[getStudentByID] (@ID INT) RETURNS Table
AS
RETURN SELECT * FROM ESTUDANTE JOIN CURSO ON Curso = Sigla WHERE ID = @ID

GO
/****** Object:  UserDefinedFunction [dbo].[getHelpSessionsListByMemberID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersName (@Name varchar(30)) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @Name);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

CREATE FUNCTION [dbo].[getHelpSessionsListByMemberID] (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID

GO
/****** Object:  UserDefinedFunction [dbo].[getComponentesByFabricante]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

CREATE FUNCTION [dbo].[getComponentesByFabricante] (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
GO
/****** Object:  View [dbo].[Atendimentos_Membros]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Atendimentos_Membros]
AS
SELECT        dbo.PRESTACAO.Atendimento_id, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PESSOA.Nome, dbo.PRESTACAO.Membro_id
FROM            dbo.PRESTACAO INNER JOIN
                         dbo.ATENDIMENTO ON dbo.PRESTACAO.Atendimento_id = dbo.ATENDIMENTO.ID INNER JOIN
                         dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID
GO
/****** Object:  UserDefinedFunction [dbo].[getProblemsByAtendimentoID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)


CREATE FUNCTION [dbo].[getProblemsByAtendimentoID] (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)


--SELECT * FROM getProblemsByAtendimentoID(171)

GO
/****** Object:  UserDefinedFunction [dbo].[getAtendimentosListByMemberID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersName (@Name varchar(30)) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @Name);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID*/

CREATE FUNCTION [dbo].[getAtendimentosListByMemberID] (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome FROM dbo.Atendimentos_Membros WHERE Membro_ID = @ID;

GO
/****** Object:  View [dbo].[Sessoes]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Sessoes]
AS
SELECT        j.ID, j.Data, j.Local, j.Num_previstos, j.atendimentos_num, COUNT(CASE WHEN dbo.PARTICIPACAO.Membro_id IS NOT NULL THEN 1 END) AS membros_num
FROM            dbo.PARTICIPACAO RIGHT OUTER JOIN
                             (SELECT        dbo.SESSAO.ID, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.SESSAO.Num_previstos, COUNT(CASE WHEN dbo.ATENDIMENTO.ID IS NOT NULL THEN 1 END) AS atendimentos_num
                               FROM            dbo.SESSAO LEFT OUTER JOIN
                                                         dbo.ATENDIMENTO ON dbo.SESSAO.ID = dbo.ATENDIMENTO.Sessao_id
                               GROUP BY dbo.SESSAO.ID, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.SESSAO.Num_previstos) AS j ON dbo.PARTICIPACAO.Sessao_id = j.ID
GROUP BY j.ID, j.Data, j.Local, j.Num_previstos, j.atendimentos_num
GO
/****** Object:  UserDefinedFunction [dbo].[getProblemByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getProblemByID] (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)

GO
/****** Object:  UserDefinedFunction [dbo].[getOpSystemByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOpSystemByID] (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Versao FROM SISTEMA_OPERATIVO WHERE ID = @ID;
GO
/****** Object:  View [dbo].[Componentes]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Componentes]
AS
SELECT        dbo.COMPONENTE.ID, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, COUNT(CASE WHEN dbo.PROBLEMA.ID IS NOT NULL THEN 1 END) AS num_problemas
FROM            dbo.COMPONENTE LEFT OUTER JOIN
                         dbo.PROBLEMA ON dbo.COMPONENTE.ID = dbo.PROBLEMA.Componente_id
GROUP BY dbo.COMPONENTE.ID, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo
GO
/****** Object:  UserDefinedFunction [dbo].[getUtenteByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersName (@Name varchar(30)) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @Name);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID*/

/*CREATE FUNCTION getAtendimentosListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome FROM dbo.Atendimentos_Membros WHERE Membro_ID = @ID;*/

/*CREATE FUNCTION getOpSystemByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Versao FROM SISTEMA_OPERATIVO WHERE ID = @ID;*/

CREATE FUNCTION [dbo].[getUtenteByID] (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Contacto, Notas FROM dbo.Utentes WHERE dbo.Utentes.ID = @ID;

GO
/****** Object:  UserDefinedFunction [dbo].[getComponenteByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

CREATE FUNCTION [dbo].[getComponenteByID] (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
GO
/****** Object:  UserDefinedFunction [dbo].[getHelpdeskByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

--SELECT * FROM dbo.Sessoes

CREATE FUNCTION [dbo].[getHelpdeskByID] (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)

GO
/****** Object:  UserDefinedFunction [dbo].[getAttemptByIDs]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);


CREATE FUNCTION [dbo].[getAttemptByIDs] (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
GO
/****** Object:  View [dbo].[SistemasOperativos]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SistemasOperativos]
AS
SELECT        dbo.SISTEMA_OPERATIVO.ID, dbo.SISTEMA_OPERATIVO.Nome, dbo.SISTEMA_OPERATIVO.Versao, COUNT(CASE WHEN dbo.FLASH_DRIVE.ID IS NOT NULL THEN 1 END) AS flashDrives_num, 
                         COUNT(CASE WHEN dbo.PROBLEMA.ID IS NOT NULL THEN 1 END) AS problems_num
FROM            dbo.PROBLEMA RIGHT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.FLASH_DRIVE ON dbo.SISTEMA_OPERATIVO.ID = dbo.FLASH_DRIVE.SO_id
GROUP BY dbo.SISTEMA_OPERATIVO.ID, dbo.SISTEMA_OPERATIVO.Nome, dbo.SISTEMA_OPERATIVO.Versao
GO
/****** Object:  UserDefinedFunction [dbo].[getOSStats]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOSStats]() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)


--SELECT * FROM getOSStats()

GO
/****** Object:  UserDefinedFunction [dbo].[getCursoStats]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

CREATE FUNCTION [dbo].[getCursoStats]() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
GO
/****** Object:  UserDefinedFunction [dbo].[getPCStats]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

/*
CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
*/

--SELECT * FROM getCursoStats()


CREATE FUNCTION [dbo].[getPCStats]() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)


--SELECT * FROM getPCStats()
GO
/****** Object:  UserDefinedFunction [dbo].[getComponenteStats]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

/*
CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
*/

--SELECT * FROM getCursoStats()

/*
CREATE FUNCTION getPCStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getPCStats()

CREATE FUNCTION [dbo].[getComponenteStats]() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.COMPONENTE.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.COMPONENTE ON dbo.ATENDIMENTO.PC_id = dbo.COMPONENTE.ID
			GROUP BY Fabricante)
GO
/****** Object:  UserDefinedFunction [dbo].[getMonthStats]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/

--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

/*
CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
*/

--SELECT * FROM getCursoStats()

/*
CREATE FUNCTION getPCStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getPCStats()

/*
CREATE FUNCTION getComponenteStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.COMPONENTE.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.COMPONENTE ON dbo.ATENDIMENTO.PC_id = dbo.COMPONENTE.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getComponenteStats()

CREATE FUNCTION [dbo].[getMonthStats]() RETURNS Table AS
	RETURN(SELECT MONTH(Data) AS mes, COUNT(ID) AS atendimentos_num 
			FROM ATENDIMENTOS 
			WHERE DATEDIFF(MM, Data, GETDATE()) < 12 
			GROUP BY MONTH(Data), YEAR(Data))
GO
/****** Object:  UserDefinedFunction [dbo].[getPlataformsAcessListByMembersID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM getMembersByID (20)

--SELECT * FROM getPlataformsAcessListByMembersName ('Quamar');

CREATE FUNCTION [dbo].[getPlataformsAcessListByMembersID] (@ID int) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @ID);
GO
/****** Object:  UserDefinedFunction [dbo].[getProblemsByUtenteID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_Responsaveis WHERE dbo.Equipamentos_Responsaveis.ID = @ID);*/


/*CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);*/

/*CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Versao FROM dbo.SISTEMA_OPERATIVO WHERE Nome = @Name;*/

/*CREATE FUNCTION getMembersByID (@ID int) RETURNS Table
AS
RETURN (SELECT * FROM dbo.Membros WHERE dbo.Membros.ID = @ID);*/

/*CREATE FUNCTION getPlataformsAcessListByMembersID (@ID int) RETURNS Table
AS
RETURN (SELECT Plataforma_nome, Username, Tipo FROM dbo.ACESSO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table
AS
RETURN (SELECT ID, Nome, Descricao, Estado FROM dbo.EQUIPAMENTO WHERE Membro_id = @ID);*/

/*CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT ID, Data, Local, Num_previstos, Num_realizados FROM dbo.Sessoes_Membros WHERE Membro_id = @ID*/

/*CREATE FUNCTION getAtendimentosListByMemberID (@ID int) RETURNS Table
AS
RETURN SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome FROM dbo.Atendimentos_Membros WHERE Membro_ID = @ID;*/

/*CREATE FUNCTION getOpSystemByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Versao FROM SISTEMA_OPERATIVO WHERE ID = @ID;*/

/*CREATE FUNCTION getUtenteByID (@ID int) RETURNS Table
AS
RETURN SELECT Nome, Contacto, Notas FROM dbo.Utentes WHERE dbo.Utentes.ID = @ID;*/


/*CREATE FUNCTION getLastAtendimentoByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT TOP 1 Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID ORDER BY Data;*/

CREATE FUNCTION [dbo].[getProblemsByUtenteID] (@ID int) RETURNS Table
AS
RETURN SELECT Problema_ID, Data, Descricao, Fabricante, Modelo FROM dbo.Problemas_Utentes WHERE Utente_id = @ID;

/*CREATE FUNCTION getAtendimentosListByUtenteID (@ID int) RETURNS Table
AS
RETURN SELECT Data, Fabricante, Modelo, Estado, Descricao FROM Atendimentos_Problemas_PC WHERE Utente_id = @ID;*/

/*CREATE FUNCTION getAcessListByPlatformName (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Username, ACESSO.Tipo as Tipo_Acesso, Nome, Email FROM (ACESSO JOIN PESSOA ON ACESSO.Membro_id = PESSOA.ID) JOIN MEMBRO ON PESSOA.ID = MEMBRO.ID WHERE ACESSO.Plataforma_nome = @Name;*/

/*CREATE FUNCTION getMembersBySessionID (@ID int) RETURNS Table
AS
RETURN SELECT Membro_id, Nome, Email, Data_entrada, Estado FROM (SELECT * FROM dbo.Membros) as X JOIN dbo.SESSOES_Membros ON X.ID = Membro_id WHERE SESSOES_Membros.ID = @ID and Estado = 1*/

/*CREATE FUNCTION getCoursesByDepName (@Name varchar(10)) RETURNS Table
AS
RETURN SELECT Sigla FROM Curso WHERE Departamento = @Name*/

/*CREATE FUNCTION isPersonAlsoStudent(@ID INT) RETURNS INT AS
BEGIN
    DECLARE @res AS INT, @verif AS INT
	SET @verif = (SELECT ID FROM ESTUDANTE WHERE ID = @ID)
	IF @verif is NULL
		SET @res = 0;
	ELSE
		SET @res = 1;
    RETURN(@res)
END*/


/*CREATE FUNCTION getStudentByID (@ID INT) RETURNS Table
AS
RETURN SELECT * FROM ESTUDANTE JOIN CURSO ON Curso = Sigla WHERE ID = @ID*/

GO
/****** Object:  UserDefinedFunction [dbo].[getAcessListByPlatformName]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAcessListByPlatformName] (@Name varchar(30)) RETURNS Table
AS
RETURN SELECT Username, ACESSO.Tipo as Tipo_Acesso, Nome, Email FROM (ACESSO JOIN PESSOA ON ACESSO.Membro_id = PESSOA.ID) JOIN MEMBRO ON PESSOA.ID = MEMBRO.ID WHERE ACESSO.Plataforma_nome = @Name;
GO
/****** Object:  UserDefinedFunction [dbo].[getAtendimentoByID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS


CREATE FUNCTION [dbo].[getAtendimentoByID] (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)



--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO INNER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

/*
CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
*/

--SELECT * FROM getCursoStats()

/*
CREATE FUNCTION getPCStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getPCStats()

/*
CREATE FUNCTION getComponenteStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.COMPONENTE.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.COMPONENTE ON dbo.ATENDIMENTO.PC_id = dbo.COMPONENTE.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getComponenteStats()

/*
CREATE FUNCTION getMonthStats() RETURNS Table AS
	RETURN(SELECT MONTH(Data) AS mes, COUNT(ID) AS atendimentos_num 
			FROM ATENDIMENTOS 
			WHERE DATEDIFF(MM, Data, GETDATE()) < 12 
			GROUP BY MONTH(Data), YEAR(Data))
*/

--SELECT * FROM getMonthStats()

/*
CREATE FUNCTION getMembroIDByEmail(@Email VARCHAR(40)) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=ID
	FROM dbo.MEMBRO
	WHERE Email = @Email

	RETURN(@res)
END
*/

--SELECT * FROM Atendimentos_Membros ORDER BY Nome ASC
--SELECT * FROM Atendimentos ORDER BY Utente ASC

/*
CREATE FUNCTION isFlashDrive(@ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	IF EXISTS(SELECT 1 FROM dbo.FLASH_DRIVE
          WHERE ID = @ID)
		RETURN 1;
    RETURN 0;
END
*/
GO
/****** Object:  UserDefinedFunction [dbo].[getAtendimentosByHelpdeskID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/


--SELECT * FROM getAtendimentoByID(12)

/*
CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT ID, Nome
			FROM dbo.Prestacoes
			WHERE Atendimento_id = @Atendimento_ID)
*/

--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)



CREATE FUNCTION [dbo].[getAtendimentosByHelpdeskID] (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO LEFT OUTER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)


--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

/*
CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
*/

--SELECT * FROM getCursoStats()

/*
CREATE FUNCTION getPCStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getPCStats()

/*
CREATE FUNCTION getComponenteStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.COMPONENTE.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.COMPONENTE ON dbo.ATENDIMENTO.PC_id = dbo.COMPONENTE.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getComponenteStats()

/*
CREATE FUNCTION getMonthStats() RETURNS Table AS
	RETURN(SELECT MONTH(Data) AS mes, COUNT(ID) AS atendimentos_num 
			FROM ATENDIMENTOS 
			WHERE DATEDIFF(MM, Data, GETDATE()) < 12 
			GROUP BY MONTH(Data), YEAR(Data))
*/

--SELECT * FROM getMonthStats()

/*
CREATE FUNCTION getMembroIDByEmail(@Email VARCHAR(40)) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=ID
	FROM dbo.MEMBRO
	WHERE Email = @Email

	RETURN(@res)
END
*/

--SELECT * FROM Atendimentos_Membros ORDER BY Nome ASC
--SELECT * FROM Atendimentos ORDER BY Utente ASC

/*
CREATE FUNCTION isFlashDrive(@ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	IF EXISTS(SELECT 1 FROM dbo.FLASH_DRIVE
          WHERE ID = @ID)
		RETURN 1;
    RETURN 0;
END
*/

--SELECT * FROM dbo.ATENDIMENTO ORDER BY Local
--SELECT * FROM getAtendimentosByHelpdeskID(8)
GO
/****** Object:  UserDefinedFunction [dbo].[getMembersByAtendimentoID]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM dbo.Plataforma FULL OUTER JOIN dbo.ACESSO ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
--SELECT * FROM dbo.Plataformas

--INSERT INTO dbo.Plataforma(Nome, Link, Descricao) VALUES ('Teste', 'Teste', 'Teste')
--SELECT * FROM dbo.Plataforma

/*
CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)
*/

--SELECT * FROM getMembersByPlatform('Duobam')

/*
CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)
*/

--SELECT * FROM getPlatformByName('Duobam')

--SELECT * FROM dbo.Topicos

--SELECT * FROM dbo.Problemas 

/*
CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)
*/

-- DROP FUNCTION getProblemsByTopic

--SELECT * FROM getProblemsByTopic('Bloqueios no Arranque')

/*
CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)
*/

--SELECT * FROM getProblemByID(2)

/*
CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)
*/

--SELECT * FROM getTopicsByProblemID(2)

--SELECT * FROM dbo.Tentativas

/*
CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)
*/

--SELECT * FROM getAttemptsByProblemID(2)

--SELECT * FROM dbo.ATENDIMENTOS

/*
CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)
*/


--SELECT * FROM getAtendimentoByID(12)


CREATE FUNCTION [dbo].[getMembersByAtendimentoID] (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT X.ID, X.Nome, Email, Data_entrada, Estado FROM dbo.Membros as X JOIN dbo.Prestacoes ON X.ID = dbo.Prestacoes.ID
			WHERE Atendimento_id = @Atendimento_ID)


--SELECT * FROM getMembersByAtendimentoID(12)

/*
CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)
*/


--SELECT * FROM getProblemsByAtendimentoID(171)

/*
CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END
*/

--SELECT * FROM dbo.Sessoes

/*
CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)
*/

--SELECT * FROM getHelpdeskByID(2)

/*
CREATE FUNCTION getAtendimentosByHelpdeskID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.PESSOA.Nome AS Utente, COUNT(DISTINCT dbo.TENTATIVA.Problema_id) AS problemas_num, COUNT(CASE WHEN dbo.PRESTACAO.Membro_id IS NOT NULL THEN 1 END)
                AS membros_num, dbo.TENTATIVA.Estado
		   FROM dbo.ATENDIMENTO LEFT OUTER JOIN
                dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id LEFT OUTER JOIN
                dbo.PRESTACAO ON dbo.ATENDIMENTO.ID = dbo.PRESTACAO.Atendimento_id LEFT OUTER JOIN
                dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID LEFT OUTER JOIN
                dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID LEFT OUTER JOIN
                dbo.SESSAO ON dbo.ATENDIMENTO.Sessao_id = dbo.SESSAO.ID
		   WHERE dbo.SESSAO.ID = @Helpdesk_ID
		   GROUP BY dbo.ATENDIMENTO.ID, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.PESSOA.Nome, dbo.TENTATIVA.Estado)
*/

--SELECT * FROM getAtendimentosByHelpdeskID(2)

/*
CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.PCs

/*
CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)
*/

--SELECT * FROM getPCByID(1);

/*
CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)
*/

--SELECT * FROM dbo.Componentes

/*
CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)
*/

--SELECT * FROM getComponenteByID(21);

/*
CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)
*/

/*
CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)
*/

--SELECT * FROM SistemasOperativos

--SELECT * FROM getOSStats()

/*
CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)
*/

--SELECT * FROM getCursoStats()

/*
CREATE FUNCTION getPCStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getPCStats()

/*
CREATE FUNCTION getComponenteStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.COMPONENTE.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.COMPONENTE ON dbo.ATENDIMENTO.PC_id = dbo.COMPONENTE.ID
			GROUP BY Fabricante)
*/

--SELECT * FROM getComponenteStats()

/*
CREATE FUNCTION getMonthStats() RETURNS Table AS
	RETURN(SELECT MONTH(Data) AS mes, COUNT(ID) AS atendimentos_num 
			FROM ATENDIMENTOS 
			WHERE DATEDIFF(MM, Data, GETDATE()) < 12 
			GROUP BY MONTH(Data), YEAR(Data))
*/

--SELECT * FROM getMonthStats()

/*
CREATE FUNCTION getMembroIDByEmail(@Email VARCHAR(40)) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=ID
	FROM dbo.MEMBRO
	WHERE Email = @Email

	RETURN(@res)
END
*/

--SELECT * FROM Atendimentos_Membros ORDER BY Nome ASC
--SELECT * FROM Atendimentos ORDER BY Utente ASC

/*
CREATE FUNCTION isFlashDrive(@ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	IF EXISTS(SELECT 1 FROM dbo.FLASH_DRIVE
          WHERE ID = @ID)
		RETURN 1;
    RETURN 0;
END
*/

--SELECT * FROM dbo.ATENDIMENTO ORDER BY Local
--SELECT * FROM getAtendimentosByHelpdeskID(8)

--SELECT Membro_id, Nome, Email, Data_entrada, Estado FROM dbo.Membros as X JOIN dbo.PARTICIPACAO ON X.ID = Membro_id WHERE Sessao_ID = @ID
GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 12/06/2020 02:49:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[Membro_ID] [int] NOT NULL,
	[Salt] [char](25) NULL,
	[AccountPwd] [varbinary](20) NULL,
 CONSTRAINT [PK_SecurityAccounts] PRIMARY KEY CLUSTERED 
(
	[Membro_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ACCOUNT] ([Membro_ID], [Salt], [AccountPwd]) VALUES (101, N'WZ)0A!Dzs_W\0@^j+x7GdpccW', 0xCD9A7A467165CA798D760BEF0DBF447EE0A0150B)
INSERT [dbo].[ACCOUNT] ([Membro_ID], [Salt], [AccountPwd]) VALUES (102, N'?J''${XnQyotLau}J|X0k!@rZ>', 0xBF270A9DA1E80DD020DFE6731B7C190C21FC18C9)
INSERT [dbo].[ACCOUNT] ([Membro_ID], [Salt], [AccountPwd]) VALUES (103, N'WnMOexNS}CqA9*b1U{DN6Sug,', 0xAE9605983A57B2E50EB69CF99018E7AA918F6F74)
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Duobam', 11, N'Babara', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Duobam', 13, N'Ninnette', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Duobam', 16, N'Brier', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Duobam', 23, N'Lothaire', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Duobam', 25, N'Armin', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Duobam', 27, N'Gale', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Fintone', 11, N'Hill', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Fintone', 15, N'Toddy', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Fintone', 19, N'Kayle', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Fintone', 29, N'Patin', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Hatity', 25, N'Martino', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Hatity', 27, N'Onofredo', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Holdlamis', 18, N'Bernadine', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Holdlamis', 20, N'Tabbatha', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Holdlamis', 21, N'Emlynn', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Holdlamis', 22, N'Stevana', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Holdlamis', 24, N'Cassandra', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Holdlamis', 27, N'Brody', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Holdlamis', 28, N'Marwin', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Holdlamis', 29, N'Tam', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'It', 18, N'Galvan', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'It', 21, N'Karrie', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'It', 26, N'Modesty', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'It', 29, N'Mirelle', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Job', 12, N'Benedick', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Job', 13, N'Silvana', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Job', 20, N'Annetta', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Job', 22, N'Eleanor', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Job', 23, N'Pam', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Job', 24, N'Arabela', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Keylex', 11, N'Gennifer', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Keylex', 17, N'Silvana', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Keylex', 23, N'Sena', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Latlux', 12, N'Genna', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Lotlux', 13, N'rrosmaninho', N'Admin')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Lotlux', 14, N'Alina', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Lotlux', 17, N'Zonda', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Lotlux', 27, N'Barbra', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Lotlux', 29, N'Annis', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Mat Lam Tam', 16, N'Tandie', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Matsoft', 24, N'Hercules', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Matsoft', 27, N'Omero', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Opela', 15, N'Lynde', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Opela', 19, N'Hirsch', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Pannier', 13, N'Salli', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Pannier', 16, N'Cathrin', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Quo Lux', 19, N'Wyn', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Quo Lux', 20, N'Cortie', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Quo Lux', 26, N'Lilian', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Quo Lux', 28, N'Amy', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Rank', 12, N'Nathan', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Rank', 22, N'Nomi', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Rank', 27, N'Simonne', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Regrant', 16, N'Charissa', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Regrant', 21, N'Oren', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Regrant', 22, N'Rossy', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Solarbreeze', 11, N'Sinclair', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Solarbreeze', 28, N'Byram', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Span', 11, N'Yoshi', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Span', 18, N'Sonya', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Span', 19, N'Bronny', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Stronghold', 20, N'Nancie', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Stronghold', 28, N'Brooke', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tampflex', 11, N'Seward', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tampflex', 17, N'Kipper', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tampflex', 20, N'Malchy', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tampflex', 25, N'Ashton', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tampflex', 26, N'Carlen', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tampflex', 27, N'Hillary', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tampflex', 28, N'Shepherd', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tin', 14, N'Aurore', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Tin', 15, N'Broddy', N'Owner')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Trippledex', 12, N'Christoforo', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Trippledex', 21, N'Josephina', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Trippledex', 28, N'Reynard', N'Moderador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Voltsillam', 20, N'Margy', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Voltsillam', 24, N'Yvonne', N'Membro')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Zontrax', 12, N'Rainer', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Zontrax', 13, N'Nelson', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Zontrax', 16, N'Grady', N'Administrador')
INSERT [dbo].[ACESSO] ([Plataforma_nome], [Membro_id], [Username], [Tipo]) VALUES (N'Zontrax', 21, N'Jessy', N'Owner')
SET IDENTITY_INSERT [dbo].[ATENDIMENTO] ON 

INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (1, CAST(N'2019-09-23T13:44:50.000' AS DateTime), N'consequat', 34, 9, NULL, 51)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (2, CAST(N'2019-08-05T06:35:19.000' AS DateTime), N'vel dapibus at', 32, 17, 2, 39)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (3, CAST(N'2019-11-07T11:05:02.000' AS DateTime), N'adipiscing', 91, 3, NULL, 100)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (4, CAST(N'2019-12-08T03:19:07.000' AS DateTime), N'mauris enim', 3, 2, 5, 49)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (5, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'mattis odio', 51, 25, 14, 58)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (6, CAST(N'2019-11-06T13:08:57.000' AS DateTime), N'non velit donec', 88, 3, 2, 63)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (7, CAST(N'2019-10-11T20:35:23.000' AS DateTime), N'felis sed lacus', 21, 23, 19, 94)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (8, CAST(N'2019-12-08T03:19:07.000' AS DateTime), N'vel est donec', 93, 12, NULL, 85)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (9, CAST(N'2019-07-15T17:42:48.000' AS DateTime), N'eu', 36, 26, NULL, 24)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (10, CAST(N'2019-11-27T18:02:13.000' AS DateTime), NULL, NULL, NULL, 9, 21)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (11, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'dictumst etiam faucibus', 95, 5, 13, 61)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (12, CAST(N'2020-01-21T18:31:59.000' AS DateTime), N'duis', 91, 30, NULL, 1)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (13, CAST(N'2020-03-09T06:35:56.000' AS DateTime), N'ultrices', 66, 25, NULL, 2)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (14, CAST(N'2019-10-29T14:30:52.000' AS DateTime), N'ipsum dolor sit', 53, 13, 6, 14)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (15, CAST(N'2019-08-24T14:25:42.000' AS DateTime), N'non lectus aliquam', 98, 11, 20, 62)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (16, CAST(N'2019-10-16T03:25:15.000' AS DateTime), NULL, NULL, NULL, 17, 29)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (17, CAST(N'2020-01-17T04:49:59.000' AS DateTime), N'sem', 2, 5, 13, 20)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (18, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'lorem quisque ut', 50, 3, NULL, 37)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (19, CAST(N'2020-02-27T12:31:00.000' AS DateTime), N'pede malesuada', 35, 20, NULL, 49)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (20, CAST(N'2019-06-10T14:00:19.000' AS DateTime), N'consequat', 96, 18, 10, 12)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (21, CAST(N'2019-10-30T02:16:09.000' AS DateTime), N'vel', 66, 10, 14, 63)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (22, CAST(N'2019-09-29T09:50:58.000' AS DateTime), N'dapibus', 74, 20, 10, 2)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (23, CAST(N'2020-02-20T03:38:14.000' AS DateTime), N'lacus morbi', 40, 27, NULL, 81)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (24, CAST(N'2019-10-30T02:16:09.000' AS DateTime), N'ipsum primis', 33, 14, NULL, 28)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (25, CAST(N'2019-08-05T06:35:19.000' AS DateTime), N'pellentesque quisque', 10, 11, 5, 65)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (26, CAST(N'2019-06-25T18:28:45.000' AS DateTime), N'augue vestibulum rutrum', 60, 15, 3, 8)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (27, CAST(N'2020-01-21T18:31:59.000' AS DateTime), N'leo odio', 112, 12, NULL, 21)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (28, CAST(N'2019-11-03T23:41:39.000' AS DateTime), N'accumsan', 4, 16, NULL, 59)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (29, CAST(N'2019-11-03T23:41:39.000' AS DateTime), N'vestibulum rutrum', 111, 8, 10, 63)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (30, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'primis', 112, 17, 8, 91)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (31, CAST(N'2019-10-11T20:35:23.000' AS DateTime), N'blandit non', 99, 28, NULL, 38)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (32, CAST(N'2019-09-20T11:40:52.000' AS DateTime), N'ridiculus', 26, 2, 17, 85)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (33, CAST(N'2019-11-06T13:08:57.000' AS DateTime), N'pellentesque viverra', 83, 26, 5, 64)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (34, CAST(N'2019-07-15T17:42:48.000' AS DateTime), N'justo', 46, 25, NULL, 63)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (35, CAST(N'2020-02-22T16:54:48.000' AS DateTime), N'non ligula pellentesque', 64, 15, 9, 81)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (36, CAST(N'2019-08-05T06:35:19.000' AS DateTime), N'duis ac nibh', 107, 26, 2, 48)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (37, CAST(N'2019-06-10T14:00:19.000' AS DateTime), N'duis mattis egestas', 47, 14, 2, 12)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (38, CAST(N'2020-01-01T13:23:15.000' AS DateTime), N'turpis', 53, 8, NULL, 29)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (39, CAST(N'2020-01-01T13:23:15.000' AS DateTime), N'pellentesque ultrices', 79, 8, 11, 17)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (40, CAST(N'2020-03-02T02:36:24.000' AS DateTime), N'nisi venenatis', 29, 20, NULL, 11)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (41, CAST(N'2019-11-06T13:08:57.000' AS DateTime), NULL, NULL, NULL, NULL, 87)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (42, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'sapien cursus vestibulum', 64, 13, NULL, 32)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (43, CAST(N'2019-09-26T14:54:30.000' AS DateTime), N'phasellus sit', 76, 11, 9, 66)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (44, CAST(N'2019-10-16T03:25:15.000' AS DateTime), N'eget nunc', 117, 27, NULL, 45)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (45, CAST(N'2020-01-21T18:31:59.000' AS DateTime), N'sapien', 100, 5, 2, 95)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (46, CAST(N'2020-03-09T17:22:56.000' AS DateTime), N'mattis egestas metus', 7, 16, 1, 20)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (47, CAST(N'2020-01-17T04:49:59.000' AS DateTime), N'odio', 24, 29, 7, 81)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (48, CAST(N'2019-10-29T14:30:52.000' AS DateTime), N'orci luctus', 45, 23, NULL, 71)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (49, CAST(N'2019-09-20T11:40:52.000' AS DateTime), N'libero quis orci', 41, 6, 17, 27)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (50, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'aliquam', 48, 4, NULL, 83)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (51, CAST(N'2019-10-29T14:30:52.000' AS DateTime), NULL, NULL, NULL, NULL, 10)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (52, CAST(N'2019-07-27T21:16:26.000' AS DateTime), N'elit', 40, 20, 8, 56)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (53, CAST(N'2019-10-04T17:14:16.000' AS DateTime), N'massa', 59, 26, 17, 100)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (54, CAST(N'2019-11-27T18:02:13.000' AS DateTime), N'consequat nulla', 19, 15, 19, 25)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (55, CAST(N'2019-06-25T18:28:45.000' AS DateTime), N'elementum nullam varius', 110, 8, NULL, 20)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (56, CAST(N'2019-10-04T17:14:16.000' AS DateTime), N'platea', 18, 10, NULL, 86)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (57, CAST(N'2019-11-07T11:05:02.000' AS DateTime), N'pharetra magna', 105, 24, 1, 65)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (58, CAST(N'2019-06-25T18:28:45.000' AS DateTime), N'magna', 112, 4, NULL, 80)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (59, CAST(N'2019-10-11T20:35:23.000' AS DateTime), N'sed nisl', 24, 23, NULL, 80)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (60, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'habitasse platea dictumst', 110, 28, NULL, 92)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (61, CAST(N'2020-01-21T18:31:59.000' AS DateTime), N'nec', 118, 25, 7, 49)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (62, CAST(N'2020-01-01T13:23:15.000' AS DateTime), N'non mauris', 98, 3, 10, 4)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (63, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'pretium nisl ut', 28, 17, NULL, 25)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (64, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'sapien in sapien', 61, 6, NULL, 14)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (65, CAST(N'2020-03-09T06:35:56.000' AS DateTime), N'blandit lacinia', 93, 23, NULL, 60)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (66, CAST(N'2019-09-18T05:20:51.000' AS DateTime), NULL, NULL, NULL, 3, 9)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (67, CAST(N'2019-06-02T10:56:29.000' AS DateTime), N'non sodales', 6, 20, 8, 79)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (68, CAST(N'2019-11-06T13:08:57.000' AS DateTime), N'amet nunc', 116, 1, NULL, 92)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (69, CAST(N'2019-06-25T18:28:45.000' AS DateTime), N'leo odio porttitor', 11, 24, NULL, 15)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (70, CAST(N'2019-08-05T06:35:19.000' AS DateTime), N'sapien in', 37, 10, NULL, 85)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (71, CAST(N'2019-10-30T02:16:09.000' AS DateTime), N'adipiscing', 68, 16, 12, 73)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (72, CAST(N'2020-02-27T12:31:00.000' AS DateTime), N'vestibulum', 48, 11, 10, 60)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (73, CAST(N'2019-10-04T17:14:16.000' AS DateTime), N'vestibulum', 31, 12, 16, 12)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (74, CAST(N'2020-02-27T12:31:00.000' AS DateTime), N'habitasse platea dictumst', 58, 19, 13, 63)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (75, CAST(N'2019-06-25T18:28:45.000' AS DateTime), N'dolor sit amet', 81, 18, NULL, 26)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (76, CAST(N'2019-09-18T05:20:51.000' AS DateTime), N'pharetra', 24, 5, NULL, 68)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (77, CAST(N'2019-10-04T17:14:16.000' AS DateTime), N'nunc', 106, 3, 8, 85)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (78, CAST(N'2019-09-18T05:20:51.000' AS DateTime), N'tellus nisi', 35, 6, 2, 59)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (79, CAST(N'2019-08-03T23:58:35.000' AS DateTime), N'integer aliquet massa', 37, 10, NULL, 50)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (80, CAST(N'2019-07-27T21:16:26.000' AS DateTime), N'cursus id', 88, 22, NULL, 51)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (81, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'pellentesque viverra', 24, 10, NULL, 99)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (82, CAST(N'2020-02-22T16:54:48.000' AS DateTime), NULL, NULL, NULL, 16, 27)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (83, CAST(N'2019-08-03T23:58:35.000' AS DateTime), N'cubilia curae duis', 87, 20, 8, 37)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (84, CAST(N'2020-03-02T02:36:24.000' AS DateTime), N'ut suscipit', 1, 10, 20, 41)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (85, CAST(N'2019-08-03T23:58:35.000' AS DateTime), N'in ante vestibulum', 56, 3, 10, 3)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (86, CAST(N'2019-07-27T21:16:26.000' AS DateTime), N'blandit mi', 30, 9, NULL, 86)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (87, CAST(N'2019-09-23T13:44:50.000' AS DateTime), N'viverra', 60, 10, 15, 51)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (88, CAST(N'2019-09-18T05:20:51.000' AS DateTime), N'orci nullam molestie', 117, 27, NULL, 29)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (89, CAST(N'2020-01-21T18:31:59.000' AS DateTime), NULL, NULL, NULL, 6, 29)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (90, CAST(N'2019-09-20T11:40:52.000' AS DateTime), N'id ligula', 59, 16, 12, 56)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (91, CAST(N'2019-11-27T18:02:13.000' AS DateTime), N'massa donec', 30, 15, NULL, 76)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (92, CAST(N'2019-08-03T23:58:35.000' AS DateTime), N'sed ante', 47, 15, 13, 55)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (93, CAST(N'2019-10-11T20:35:23.000' AS DateTime), N'etiam faucibus', 83, 11, 6, 90)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (94, CAST(N'2019-08-07T16:39:20.000' AS DateTime), N'vel lectus in', 99, 15, 10, 89)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (95, CAST(N'2020-02-27T12:31:00.000' AS DateTime), N'sollicitudin', 91, 28, NULL, 68)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (96, CAST(N'2019-11-27T18:02:13.000' AS DateTime), N'duis bibendum', 60, 18, 19, 85)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (97, CAST(N'2019-05-18T19:54:52.000' AS DateTime), N'phasellus in felis', 98, 17, 1, 99)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (98, CAST(N'2019-10-04T17:14:16.000' AS DateTime), N'ultrices posuere cubilia', 49, 8, 19, 50)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (99, CAST(N'2019-11-27T18:02:13.000' AS DateTime), N'orci pede', 71, 24, 15, 91)
GO
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (100, CAST(N'2019-11-27T02:08:51.000' AS DateTime), NULL, NULL, NULL, 4, 60)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (101, CAST(N'2019-10-11T20:35:23.000' AS DateTime), N'tortor', 96, 17, 11, 54)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (102, CAST(N'2019-07-15T17:42:48.000' AS DateTime), N'quis', 17, 16, 14, 23)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (103, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'lacus', 20, 29, NULL, 39)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (104, CAST(N'2020-02-27T12:31:00.000' AS DateTime), N'aliquam lacus morbi', 63, 20, NULL, 12)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (105, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'ipsum integer', 65, 17, 3, 63)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (106, CAST(N'2019-07-15T17:42:48.000' AS DateTime), N'vehicula consequat', 15, 20, 3, 39)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (107, CAST(N'2020-02-27T12:31:00.000' AS DateTime), N'pretium', 78, 6, 8, 93)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (108, CAST(N'2019-08-07T16:39:20.000' AS DateTime), NULL, NULL, NULL, NULL, 37)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (109, CAST(N'2019-08-05T06:35:19.000' AS DateTime), N'ac neque duis', 97, 16, NULL, 92)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (110, CAST(N'2019-10-30T02:16:09.000' AS DateTime), N'id pretium', 100, 23, NULL, 85)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (111, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'in eleifend quam', 6, 16, NULL, 25)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (112, CAST(N'2019-07-15T17:42:48.000' AS DateTime), N'duis bibendum', 4, 6, 5, 75)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (113, CAST(N'2019-09-26T14:54:30.000' AS DateTime), NULL, NULL, NULL, 7, 64)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (114, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'erat', 87, 11, 5, 21)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (115, CAST(N'2019-08-05T06:35:19.000' AS DateTime), N'elementum eu interdum', 3, 2, NULL, 24)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (116, CAST(N'2019-10-29T14:30:52.000' AS DateTime), N'semper', 8, 3, 9, 37)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (117, CAST(N'2020-01-17T04:49:59.000' AS DateTime), N'duis bibendum', 96, 4, 15, 55)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (118, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'lectus', 75, 6, 11, 12)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (119, CAST(N'2019-11-06T13:08:57.000' AS DateTime), N'dui', 58, 14, 5, 61)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (120, CAST(N'2020-02-22T16:54:48.000' AS DateTime), N'euismod scelerisque quam', 71, 22, 9, 43)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (121, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'ante ipsum primis', 103, 21, 9, 98)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (122, CAST(N'2019-12-08T03:19:07.000' AS DateTime), NULL, NULL, NULL, NULL, 97)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (123, CAST(N'2019-06-10T14:00:19.000' AS DateTime), N'volutpat', 40, 22, 8, 48)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (124, CAST(N'2019-08-03T23:58:35.000' AS DateTime), N'nisi eu orci', 8, 19, NULL, 88)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (125, CAST(N'2019-05-18T19:54:52.000' AS DateTime), N'augue vestibulum', 49, 5, NULL, 22)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (126, CAST(N'2020-03-09T06:35:56.000' AS DateTime), N'nec', 42, 12, 13, 65)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (127, CAST(N'2020-03-09T17:22:56.000' AS DateTime), NULL, NULL, NULL, NULL, 47)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (128, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'platea dictumst morbi', 56, 5, 11, 92)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (129, CAST(N'2019-11-27T02:08:51.000' AS DateTime), NULL, NULL, NULL, 20, 36)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (130, CAST(N'2019-11-03T23:41:39.000' AS DateTime), N'risus dapibus augue', 85, 12, 13, 79)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (131, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'in est risus', 61, 23, 5, 29)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (132, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'purus eu magna', 56, 13, NULL, 82)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (133, CAST(N'2020-03-02T02:36:24.000' AS DateTime), N'duis', 13, 14, NULL, 75)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (134, CAST(N'2019-06-02T10:56:29.000' AS DateTime), N'iaculis', 7, 20, 6, 94)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (135, CAST(N'2019-12-08T03:19:07.000' AS DateTime), NULL, NULL, NULL, 20, 64)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (136, CAST(N'2019-07-15T17:42:48.000' AS DateTime), N'semper sapien', 40, 2, NULL, 50)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (137, CAST(N'2019-09-26T14:54:30.000' AS DateTime), N'lacus morbi quis', 15, 17, NULL, 48)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (138, CAST(N'2020-02-20T03:38:14.000' AS DateTime), NULL, NULL, NULL, 11, 80)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (139, CAST(N'2019-10-30T02:16:09.000' AS DateTime), NULL, NULL, NULL, 12, 73)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (140, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'amet eros suspendisse', 102, 24, NULL, 49)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (141, CAST(N'2019-06-25T18:28:45.000' AS DateTime), N'amet eros suspendisse', 70, 27, 5, 98)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (142, CAST(N'2019-11-07T11:05:02.000' AS DateTime), N'tincidunt eget tempus', 116, 9, 17, 63)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (143, CAST(N'2019-09-29T09:50:58.000' AS DateTime), N'ante vel ipsum', 98, 18, 16, 86)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (144, CAST(N'2019-07-27T21:16:26.000' AS DateTime), N'convallis nunc', 8, 12, 8, 68)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (145, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'nunc commodo placerat', 86, 5, 19, 91)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (146, CAST(N'2019-07-15T17:42:48.000' AS DateTime), NULL, NULL, NULL, NULL, 38)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (147, CAST(N'2019-08-05T06:35:19.000' AS DateTime), N'aenean lectus pellentesque', 27, 23, 2, 19)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (148, CAST(N'2019-07-27T21:16:26.000' AS DateTime), N'id', 2, 16, 9, 64)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (149, CAST(N'2019-06-28T09:08:43.000' AS DateTime), N'elit sodales scelerisque', 82, 14, NULL, 10)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (150, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'pellentesque ultrices mattis', 21, 13, 18, 75)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (151, CAST(N'2020-03-02T02:36:24.000' AS DateTime), N'congue', 43, 26, 7, 95)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (152, CAST(N'2019-08-03T23:58:35.000' AS DateTime), NULL, NULL, NULL, 3, 49)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (153, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'quisque', 15, 25, 5, 100)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (154, CAST(N'2019-08-05T06:35:19.000' AS DateTime), NULL, NULL, NULL, NULL, 29)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (155, CAST(N'2019-10-16T03:25:15.000' AS DateTime), N'iaculis diam erat', 11, 19, 7, 61)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (156, CAST(N'2019-09-29T09:50:58.000' AS DateTime), N'diam cras pellentesque', 62, 30, 18, 90)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (157, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'odio', 37, 19, 19, 48)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (158, CAST(N'2019-11-03T23:41:39.000' AS DateTime), NULL, NULL, NULL, 4, 100)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (159, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'nec euismod', 8, 8, 20, 89)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (160, CAST(N'2019-08-07T16:39:20.000' AS DateTime), N'aliquam augue quam', 43, 5, 12, 63)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (161, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'at', 89, 19, 12, 78)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (162, CAST(N'2020-02-22T16:54:48.000' AS DateTime), N'nonummy maecenas tincidunt', 100, 23, NULL, 88)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (163, CAST(N'2019-09-26T14:54:30.000' AS DateTime), N'orci', 29, 14, 2, 82)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (164, CAST(N'2019-06-28T09:08:43.000' AS DateTime), N'diam id ornare', 64, 21, NULL, 88)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (165, CAST(N'2019-07-27T21:16:26.000' AS DateTime), N'odio curabitur', 19, 16, 5, 35)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (166, CAST(N'2020-03-09T06:35:56.000' AS DateTime), N'gravida sem', 66, 11, NULL, 70)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (167, CAST(N'2020-01-01T13:23:15.000' AS DateTime), N'cubilia', 33, 6, 4, 100)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (168, CAST(N'2019-11-27T18:02:13.000' AS DateTime), NULL, NULL, NULL, 4, 53)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (169, CAST(N'2020-03-02T02:36:24.000' AS DateTime), N'tincidunt eu felis', 64, 9, NULL, 20)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (170, CAST(N'2019-11-27T18:02:13.000' AS DateTime), N'sapien varius', 57, 19, NULL, 65)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (171, CAST(N'2020-02-20T03:38:14.000' AS DateTime), N'luctus', 85, 2, NULL, 1)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (172, CAST(N'2019-08-24T14:25:42.000' AS DateTime), N'donec diam neque', 6, 9, 19, 8)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (173, CAST(N'2019-07-27T21:16:26.000' AS DateTime), N'praesent', 71, 10, NULL, 30)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (174, CAST(N'2019-12-08T03:19:07.000' AS DateTime), N'et', 117, 26, NULL, 86)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (175, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'vel', 28, 14, NULL, 60)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (176, CAST(N'2019-06-10T14:00:19.000' AS DateTime), N'justo maecenas', 117, 8, NULL, 90)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (177, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'libero', 64, 15, NULL, 84)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (178, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'nulla tellus in', 120, 16, 5, 29)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (179, CAST(N'2020-02-27T12:31:00.000' AS DateTime), N'eu', 45, 22, 16, 48)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (180, CAST(N'2019-11-27T18:02:13.000' AS DateTime), N'neque', 119, 16, 5, 67)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (181, CAST(N'2019-08-17T20:25:25.000' AS DateTime), N'sed magna', 50, 30, 13, 98)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (182, CAST(N'2020-03-09T17:22:56.000' AS DateTime), N'nam', 11, 13, 20, 30)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (183, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'curabitur in libero', 114, 14, 14, 75)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (184, CAST(N'2019-06-28T09:08:43.000' AS DateTime), N'nisl', 5, 1, 1, 49)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (185, CAST(N'2019-08-07T16:39:20.000' AS DateTime), N'cras mi', 112, 22, 19, 65)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (186, CAST(N'2019-09-20T11:40:52.000' AS DateTime), N'diam erat', 2, 25, 7, 37)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (187, CAST(N'2020-02-20T03:38:14.000' AS DateTime), N'ultrices posuere', 58, 17, 3, 99)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (188, CAST(N'2019-05-18T19:54:52.000' AS DateTime), N'neque', 21, 27, NULL, 10)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (189, CAST(N'2019-08-07T16:39:20.000' AS DateTime), N'pulvinar', 47, 8, 11, 42)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (190, CAST(N'2019-07-15T17:42:48.000' AS DateTime), N'integer', 103, 11, 15, 66)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (191, CAST(N'2019-09-18T05:20:51.000' AS DateTime), N'tortor id nulla', 29, 2, 18, 14)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (192, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'vivamus', 49, 21, NULL, 62)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (193, CAST(N'2020-02-20T03:38:14.000' AS DateTime), N'vel', 111, 2, NULL, 45)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (194, CAST(N'2019-09-23T13:44:50.000' AS DateTime), N'ante', 94, 16, NULL, 38)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (195, CAST(N'2019-08-03T23:58:35.000' AS DateTime), N'posuere nonummy', 48, 24, 20, 75)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (196, CAST(N'2020-02-20T03:38:14.000' AS DateTime), N'fusce', 22, 23, 12, 91)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (197, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'parturient montes nascetur', 44, 27, 16, 9)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (198, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'posuere', 48, 7, 12, 60)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (199, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'pede', 120, 6, NULL, 1)
GO
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (200, CAST(N'2019-06-10T14:00:19.000' AS DateTime), N'venenatis non', 71, 21, NULL, 36)
INSERT [dbo].[ATENDIMENTO] ([ID], [Data], [Local], [Tempo_despendido], [PC_id], [Sessao_id], [Utente_id]) VALUES (201, CAST(N'2020-01-26T00:00:00.000' AS DateTime), N'vel', 60, 10, 26, 8)
SET IDENTITY_INSERT [dbo].[ATENDIMENTO] OFF
SET IDENTITY_INSERT [dbo].[COMPONENTE] ON 

INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (8, N'BlogXS', N'Ovenbird')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (9, N'Chatterpoint', N'Tiger cat')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (5, N'Dabshots', N'Mouse, four-striped grass')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (13, N'Dabtype', N'Gecko, tokay')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (2, N'DabZ', N'Swamp deer')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (21, N'Divavu', N'Long-billed corella')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (26, N'Eazzy', N'Alpaca')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (19, N'Fatz', N'Bateleur eagle')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (23, N'Flashspan', N'Kiskadee, great')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (27, N'Gabtype', N'Oryx, beisa')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (20, N'Gigabox', N'Great skua')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (12, N'InnoZ', N'Rhea, greater')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (17, N'Jabberbean', N'Capuchin, weeper')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (11, N'Jetwire', N'Eastern box turtle')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (29, N'Kanoodle', N'Mexican beaded lizard')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (7, N'LiveZ', N'Brush-tailed phascogale')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (25, N'Mybuzz', N'Rose-ringed parakeet')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (28, N'Mycat', N'Deer, roe')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (18, N'Ooba', N'American alligator')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (10, N'Rhybox', N'Buffalo, asian water')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (16, N'Rhyloo', N'White-throated toucan')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (22, N'Rhynyx', N'Goose, canada')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (30, N'Rhyzio', N'Common raccoon')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (14, N'Skippad', N'Eagle, golden')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (4, N'Talane', N'Southern lapwing')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (3, N'Teklist', N'Lion, south american sea')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (24, N'Topiclounge', N'Blue shark')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (1, N'Vipe', N'Catfish, blue')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (15, N'Vitz', N'Vulture, egyptian')
INSERT [dbo].[COMPONENTE] ([ID], [Fabricante], [Modelo]) VALUES (6, N'Wikizz', N'Eagle, bald')
SET IDENTITY_INSERT [dbo].[COMPONENTE] OFF
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'Quisque', N'ac')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'et', N'ante.')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'consequat', N'arcu')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'varius', N'Cum')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'ECT', N'DETI')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'pharetra', N'diam.')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'Fusce', N'eleifend.')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'Donec', N'et')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'bibendum', N'Etiam')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'auctor', N'euismod')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'habitant', N'euismod')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'eleifend,', N'felis.')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'vulputate,', N'lorem')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'ac,', N'massa.')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'Nullam', N'Nam')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'quis', N'neque')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'cursus', N'Nunc')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'nisl.', N'purus')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'mauris', N'tincidunt')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'nulla', N'velit')
INSERT [dbo].[CURSO] ([Sigla], [Departamento]) VALUES (N'Phasellus', N'viverra.')
SET IDENTITY_INSERT [dbo].[EQUIPAMENTO] ON 

INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (1, N'et', N'posuere metus vitae ipsum', N'etiam vel augu', 4, N'consequat metus sapien', 23)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (2, N'integer', N'augue quam sollicitudin vitae consectetuer eget rutrum', N'risus auctor sed tristique', 1, N'eros viverra eget', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (3, N'natoque penatibus', N'morbi quis tortor id nulla ultrices aliquet maecenas', N'rutrum at', 4, N'pretium nisl', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (4, N'quis lectus', N'convallis duis consequat', N'nunc rhoncus dui vel', 0, N'sagittis', 102)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (5, N'ut nulla sed', N'quam a odio in', N'sagittis dui vel', 0, N'massa tempor convallis', 13)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (6, N'nunc', N'vel accumsan', N'lacinia', 3, N'arcu adipiscing', 23)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (7, N'dictumst', NULL, N'massa tempor', 1, N'nec sem', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (8, N'ullamcorper augue', N'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis', N'venenatis lacinia aenean sit amet', 0, N'quam nec dui', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (9, N'lacinia erat', N'vel', N'mauris laoreet ut rhoncus', 2, N'a', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (10, N'blandit lacinia erat', NULL, N'pellentesque volutpat dui', 3, N'in ante', 29)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (11, N'tristique tortor eu', N'lectus in quam fringilla rhoncus mauris enim leo', N'duis ac nibh fusce lacus', 2, N'at', 14)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (12, N'elementum ligula', N'habitasse platea dictumst morbi vestibulum velit id', N'nisl venenatis lacinia aenean sit', 1, N'felis sed', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (13, N'rhoncus aliquam', N'interdum mauris', N'nullam orci pede venenatis', 2, NULL, NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (14, N'ac tellus', N'nunc proin at turpis a', N'amet', 4, N'suscipit ligula in', 16)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (15, N'dolor quis', N'quisque id justo sit amet', N'diam vitae quam suspendisse', 4, N'sollicitudin vitae', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (16, N'convallis nunc', N'pede morbi porttitor lorem id ligula suspendisse', N'ipsum primis in faucibus orci', 2, NULL, NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (17, N'nec nisi', N'fermentum justo nec condimentum neque sapien placerat', N'turpis eget elit sodales', 0, N'orci nullam molestie', 17)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (18, N'habitasse platea', N'donec quis orci eget orci vehicula', N'diam erat fermentum justo nec', 3, N'vel', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (19, N'dolor quis odio', N'at lorem integer tincidunt', N'elementum in hac habitasse', 2, N'maecenas tincidunt', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (20, N'ultricies eu nibh', N'eget rutrum at', N'lobortis est', 1, NULL, NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (21, N'posuere', N'eros viverra', N'lacinia eget', 3, NULL, NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (22, N'primis in faucibus', N'quam', N'id', 1, N'posuere', 18)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (23, N'pellentesque eget nunc', N'neque aenean auctor gravida sem praesent', N'quis', 1, N'justo aliquam', 27)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (24, N'quis odio', N'montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis', N'dolor', 4, NULL, 12)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (25, N'vel accumsan tellus', N'dolor sit amet consectetuer adipiscing elit proin risus praesent lectus', N'interdum venenatis', 0, N'tellus in', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (26, N'sapien cum', N'tellus nisi eu orci mauris lacinia', N'sit amet', 4, N'volutpat quam', 24)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (27, N'aliquam', N'phasellus id sapien in sapien iaculis congue vivamus metus', N'fusce posuere felis sed lacus', 2, N'montes', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (28, N'nisi at', NULL, N'quis augue luctus tincidunt nulla', 2, N'faucibus orci luctus', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (29, N'nibh', NULL, N'tortor', 4, N'id lobortis', 15)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (30, N'enim', N'viverra', N'nibh ligula nec sem', 2, N'felis eu', 11)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (31, N'orci luctus et', N'primis in faucibus orci', N'proin eu mi', 2, N'ipsum praesent', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (32, N'dui vel', NULL, N'eu magna', 2, N'varius nulla', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (33, N'lectus', N'justo pellentesque viverra pede ac diam cras pellentesque volutpat dui', N'cras in purus eu magna', 2, N'nec dui luctus', 14)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (34, N'in', N'tempus sit amet', N'mattis odio donec vitae', 4, N'nibh ligula', 21)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (35, N'cursus id', N'magnis', N'ut erat', 4, N'integer pede justo', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (36, N'arcu', N'eros viverra eget congue eget semper rutrum', N'condimentum id luctus', 2, N'id luctus nec', 16)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (37, N'vestibulum', N'ipsum', N'adipiscing molestie hendrerit at vulputate', 4, N'varius', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (38, N'integer ac neque', N'in libero ut', N'in lacus curabitur at ipsum', 1, N'at feugiat', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (39, N'nulla quisque', N'a suscipit', N'enim leo rhoncus sed', 3, N'quam nec', 16)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (40, N'eu', N'congue elementum in hac habitasse platea dictumst morbi', N'ullamcorper purus sit amet nulla', 4, N'luctus', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (41, N'aliquet', N'mauris enim leo rhoncus sed vestibulum sit amet cursus id', N'non', 4, N'ornare', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (42, N'natoque', N'sapien urna pretium nisl ut volutpat sapien arcu sed augue', N'felis fusce posuere felis sed', 2, N'turpis a pede', 21)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (43, N'amet justo morbi', N'id massa id nisl venenatis lacinia aenean sit', N'aenean sit amet justo morbi', 4, N'quis odio', 11)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (44, N'vel lectus in', N'ullamcorper augue a suscipit nulla', N'varius nulla', 3, NULL, NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (45, N'ac', N'nec sem duis aliquam convallis', N'quam sollicitudin vitae consectetuer eget', 1, N'erat eros', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (46, N'pellentesque ultrices', N'sed vel enim sit', N'venenatis turpis enim', 4, N'augue', 20)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (47, N'ligula', N'ligula pellentesque ultrices phasellus', N'in imperdiet', 3, N'blandit lacinia', NULL)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (48, N'fermentum donec ut', N'erat nulla', N'quis turpis', 1, N'dolor morbi', 19)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (49, N'ipsum', N'ut massa volutpat convallis morbi odio odio', N'bibendum morbi', 0, N'leo', 13)
INSERT [dbo].[EQUIPAMENTO] ([ID], [Nome], [Descricao], [Localizacao], [Estado], [Dador], [Membro_id]) VALUES (50, N'nulla', N'lacus morbi sem mauris laoreet ut rhoncus aliquet', N'dictumst', 0, N'hac habitasse', 28)
SET IDENTITY_INSERT [dbo].[EQUIPAMENTO] OFF
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (31, 80300, N'auctor', CAST(N'2020-04-29' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (32, 80310, N'Nullam', CAST(N'2019-05-18' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (33, 80320, N'habitant', CAST(N'2019-10-26' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (34, 80330, N'et', CAST(N'2020-04-26' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (35, 80340, N'Phasellus', CAST(N'2020-03-09' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (36, 80350, N'Quisque', CAST(N'2020-01-23' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (37, 80360, N'pharetra', CAST(N'2019-10-19' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (38, 80370, N'Donec', CAST(N'2020-02-29' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (39, 80380, N'habitant', CAST(N'2019-11-30' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (40, 80390, N'et', CAST(N'2019-06-19' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (71, 80700, N'et', CAST(N'2019-05-19' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (72, 80710, N'mauris', CAST(N'2019-06-20' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (73, 80720, N'Phasellus', CAST(N'2019-07-18' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (74, 80730, N'Fusce', CAST(N'2020-03-06' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (75, 80740, N'Donec', CAST(N'2019-09-12' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (76, 80750, N'quis', CAST(N'2019-06-20' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (77, 80760, N'Nullam', CAST(N'2019-07-31' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (78, 80770, N'mauris', CAST(N'2019-12-07' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (79, 80780, N'consequat', CAST(N'2019-06-26' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (80, 80790, N'mauris', CAST(N'2019-06-07' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (81, 80800, N'Quisque', CAST(N'2019-11-11' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (82, 80810, N'varius', CAST(N'2019-05-12' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (83, 80820, N'varius', CAST(N'2019-09-04' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (84, 80830, N'nulla', CAST(N'2020-01-02' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (85, 80840, N'et', CAST(N'2020-03-25' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (86, 80850, N'nisl.', CAST(N'2019-12-10' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (87, 80860, N'Donec', CAST(N'2020-02-06' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (88, 80870, N'auctor', CAST(N'2020-01-07' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (89, 80880, N'Phasellus', CAST(N'2020-05-02' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (90, 80890, N'habitant', CAST(N'2019-07-05' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (91, 80900, N'habitant', CAST(N'2019-12-10' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (92, 80910, N'habitant', CAST(N'2020-05-01' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (93, 80920, N'et', CAST(N'2019-05-25' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (94, 80930, N'Fusce', CAST(N'2019-12-28' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (95, 80940, N'bibendum', CAST(N'2019-11-21' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (96, 80950, N'quis', CAST(N'2020-01-14' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (97, 80960, N'bibendum', CAST(N'2019-09-04' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (98, 80970, N'cursus', CAST(N'2020-03-20' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (99, 80980, N'varius', CAST(N'2019-08-03' AS Date))
INSERT [dbo].[ESTUDANTE] ([ID], [Nmec], [Curso], [Ano_matricula]) VALUES (100, 80990, N'quis', CAST(N'2019-08-24' AS Date))
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (1, N'Sandisk', 64, 2, NULL, 5)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (3, N'Sandisk', 256, 3, NULL, 12)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (4, N'Sandisk', 256, 3, N'Quartus 17', NULL)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (7, N'Kingston', 16, 3, NULL, 18)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (8, N'Sandisk', 64, 3, NULL, 1)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (14, N'Sandisk', 8, 3, N'purus phasellus in felis donec semper', NULL)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (15, N'Kingston', 8, 2, N'lectus', NULL)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (20, N'Sandisk', 32, 2, N'sapien urna', NULL)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (24, N'Kingston', 8, 3, N'risus', NULL)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (27, N'Sandisk', 8, 3, N'at ipsum ac', NULL)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (31, NULL, 32, 2, NULL, 11)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (34, NULL, 32, 3, NULL, 1)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (39, N'Sandisk', 64, 3, N'libero convallis eget eleifend luctus', NULL)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (40, N'Sandisk', 4, 2, NULL, 1)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (41, N'Kingston', 8, 2, NULL, 17)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (44, NULL, 256, 2, NULL, 6)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (47, NULL, 32, 2, NULL, 8)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (48, N'Kingston', 32, 3, N'montes nascetur ridiculus mus', NULL)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (49, N'Sandisk', 64, 2, NULL, 15)
INSERT [dbo].[FLASH_DRIVE] ([ID], [Fabricante], [Capacidade], [Velocidade], [Conteudo], [SO_id]) VALUES (50, N'Kingston', 16, 3, N'luctus nec molestie sed justo pellentesque viverra pede', NULL)
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (11, N'lorem.luctus.ut@ipsum.org', 956219108, 3, 0, CAST(N'2020-11-05' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (12, N'Donec@sempererat.net', 999728165, 2, 0, CAST(N'2020-01-19' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (13, N'consequat.auctor@vulputate.net', 111111111, 1, 1, CAST(N'2020-10-08' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (14, N'erat@nibhsit.ca', 991535593, 1, 0, CAST(N'2020-09-17' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (15, N'Praesent@egetmetusIn.edu', 973718216, 0, 1, CAST(N'2020-12-19' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (16, N'erat.in.consectetuer@habitant.edu', 953960779, 1, 1, CAST(N'2021-04-02' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (17, N'vulputate@adlitoratorquent.ca', 962140384, 1, 1, CAST(N'2020-03-12' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (18, N'mattis.Cras@nondapibusrutrum.ca', 956838951, 4, 0, CAST(N'2020-10-10' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (19, N'et.nunc@congueInscelerisque.co.uk', 953028010, 0, 0, CAST(N'2019-09-14' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (20, N'vulputate.lacus@nuncnullavulputate.edu', 918309178, 0, 0, CAST(N'2019-09-25' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (21, N'laoreet.lectus@scelerisquelorem.com', 950872934, 3, 1, CAST(N'2021-03-28' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (22, N'magna.Duis@senectuset.com', 949484537, 3, 1, CAST(N'2019-10-16' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (23, N'Aliquam.fringilla@Sedmalesuada.co.uk', 971060393, 4, 1, CAST(N'2021-04-23' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (24, N'a.ultricies@penatibusetmagnis.edu', 974569191, 3, 1, CAST(N'2021-02-16' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (25, N'egestas.Fusce@duiaugueeu.co.uk', 931215233, 3, 1, CAST(N'2021-05-02' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (26, N'feugiat.nec.diam@velitQuisquevarius.edu', 907842362, 3, 0, CAST(N'2021-02-02' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (27, N'purus.accumsan.interdum@Donec.com', 931330767, 2, 1, CAST(N'2019-10-22' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (28, N'libero.Morbi.accumsan@liberoProin.org', 980726034, 2, 1, CAST(N'2021-02-07' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (29, N'et@Donecfelisorci.com', 995773340, 2, 0, CAST(N'2019-12-07' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (30, N'faucibus@mauris.com', 976272461, 3, 1, CAST(N'2019-08-13' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (101, N'r.rosmaninho@ua.pt', 999999999, 1, 1, CAST(N'2020-06-09' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (102, N'goncaloperna@ua.pt', 999999999, 1, 1, CAST(N'2020-06-10' AS Date))
INSERT [dbo].[MEMBRO] ([ID], [Email], [Num_telemovel], [Tipo], [Estado], [Data_entrada]) VALUES (103, N'bd@ua.pt', 999999999, 1, 1, CAST(N'2020-06-10' AS Date))
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (11, 20)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (12, 2)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (12, 7)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (12, 10)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (12, 17)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (12, 20)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (13, 3)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (13, 4)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (13, 5)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (13, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (13, 13)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (13, 18)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (13, 20)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (14, 1)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (14, 16)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (14, 18)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (15, 7)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (15, 12)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (15, 17)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (16, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (17, 4)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (17, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (17, 13)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (17, 16)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (17, 18)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (18, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (18, 12)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (18, 16)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (19, 16)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (19, 17)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (19, 18)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (20, 10)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (20, 19)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (21, 5)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (21, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (22, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (22, 10)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (22, 13)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (22, 14)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (23, 4)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (23, 5)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (23, 7)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (23, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (23, 12)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (24, 7)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (24, 8)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (25, 4)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (25, 13)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (25, 17)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (25, 19)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (26, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (27, 12)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (27, 13)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (28, 11)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (28, 14)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (28, 20)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (29, 5)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (29, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (29, 11)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (30, 4)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (30, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (30, 12)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (101, 9)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (101, 26)
INSERT [dbo].[PARTICIPACAO] ([Membro_id], [Sessao_id]) VALUES (102, 9)
SET IDENTITY_INSERT [dbo].[PC] ON 

INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (16, N'Acer', N'Tacoma')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (29, N'Apple', N'H1')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (10, N'Apple', N'Silverado 1500')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (13, N'Asus', NULL)
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (9, N'Asus', N'928')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (11, N'Asus', N'TT')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (18, N'Dell', N'C70')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (24, N'Dell', N'Skylark')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (28, N'HP', N'Aveo')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (3, N'HP', N'Challenger')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (25, N'HP', N'Grand Marquis')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (27, N'HP', N'SRX')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (7, N'Lenovo', NULL)
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (30, N'Lenovo', N'Expedition')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (20, N'Lenovo', N'GTI')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (17, N'Lenovo', N'M3')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (8, N'Lenovo', N'QX')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (6, N'Lenovo', N'Regal')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (14, N'Lenovo', N'Series 1')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (12, N'Lenovo', N'Sprinter 2500')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (23, N'LG', NULL)
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (21, N'Microsoft', NULL)
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (2, N'MSI', NULL)
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (22, N'MSI', N'Bonneville')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (15, N'Samsung', NULL)
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (26, N'Samsung', N'929')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (1, N'Samsung', N'Corvette')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (5, N'Samsung', N'Patriot')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (19, N'Samsung', N'Sienna')
INSERT [dbo].[PC] ([ID], [Fabricante], [Modelo]) VALUES (4, N'Samsung', N'Spirit')
SET IDENTITY_INSERT [dbo].[PC] OFF
SET IDENTITY_INSERT [dbo].[PESSOA] ON 

INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (1, N'Anthony', N'nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (2, N'Zachary', N'amet, faucibus ut, nulla. Cras eu tellus eu augue porttitor')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (3, N'Griffith', N'a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (4, N'Lamar', N'sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (5, N'Geoffrey', N'tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (6, N'Garrison', N'ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (7, N'Troy', N'dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (8, N'James', N'feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (9, N'Carter', N'et risus. Quisque libero lacus, varius et, euismod et, commodo')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (10, N'Dante', N'Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat velit.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (11, N'Evan', N'ultrices sit amet, risus. Donec nibh enim, gravida sit amet,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (12, N'Walter', N'tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (13, N'Chester', N'diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (14, N'Steven', N'malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (15, N'Merrill', N'ac facilisis facilisis, magna tellus faucibus leo, in lobortis tellus')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (16, N'Hashim', N'rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (17, N'Mason', N'purus. Nullam scelerisque neque sed sem egestas blandit. Nam nulla')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (18, N'Slade', N'lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (19, N'Seth', N'et, rutrum eu, ultrices sit amet, risus. Donec nibh enim,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (20, N'Quamar', N'ante. Nunc mauris sapien, cursus in, hendrerit consectetuer, cursus et,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (21, N'Tobias', N'non justo. Proin non massa non ante bibendum ullamcorper. Duis')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (22, N'Dillon', N'non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (23, N'Sebastian', N'non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (24, N'Harding', N'non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (25, N'Steven', N'diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (26, N'William', N'est, vitae sodales nisi magna sed dui. Fusce aliquam, enim')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (27, N'Felix', N'amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (28, N'Elijah', N'enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (29, N'Hayden', N'Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (30, N'Kadeem', N'vel, convallis in, cursus et, eros. Proin ultrices. Duis volutpat')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (31, N'Rudyard', N'urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (32, N'Abbot', N'odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (33, N'Hu', N'ut eros non enim commodo hendrerit. Donec porttitor tellus non')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (34, N'Bert', N'vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (35, N'Ferdinand', N'quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (36, N'Rooney', N'sit amet, faucibus ut, nulla. Cras eu tellus eu augue')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (37, N'Ciaran', N'auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (38, N'Beck', N'In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (39, N'Alden', N'porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (40, N'Gil', N'cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (41, N'Connor', N'tortor, dictum eu, placerat eget, venenatis a, magna. Lorem ipsum')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (42, N'Preston', N'et libero. Proin mi. Aliquam gravida mauris ut mi. Duis')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (43, N'Eric', N'ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (44, N'Slade', N'magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (45, N'Amery', N'quis diam. Pellentesque habitant morbi tristique senectus et netus et')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (46, N'Emery', N'dictum augue malesuada malesuada. Integer id magna et ipsum cursus')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (47, N'Wang', N'sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (48, N'Russell', N'dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (49, N'Berk', N'Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (50, N'Xanthus', N'tellus, imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (51, N'Ray', N'conubia nostra, per inceptos hymenaeos. Mauris ut quam vel sapien')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (52, N'Adam', N'convallis, ante lectus convallis est, vitae sodales nisi magna sed')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (53, N'Cullen', N'dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (54, N'Ross', N'enim non nisi. Aenean eget metus. In nec orci. Donec')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (55, N'Channing', N'nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (56, N'Thaddeus', N'pede. Cum sociis natoque penatibus et magnis dis parturient montes,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (57, N'Amos', N'odio a purus. Duis elementum, dui quis accumsan convallis, ante')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (58, N'Silas', N'tincidunt dui augue eu tellus. Phasellus elit pede, malesuada vel,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (59, N'Denton', N'ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (60, N'Grant', N'tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (61, N'Cairo', N'non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (62, N'Isaac', N'fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (63, N'Michael', N'ultrices. Duis volutpat nunc sit amet metus. Aliquam erat volutpat.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (64, N'Jasper', N'Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (65, N'Lane', N'hendrerit neque. In ornare sagittis felis. Donec tempor, est ac')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (66, N'Griffith', N'pellentesque eget, dictum placerat, augue. Sed molestie. Sed id risus')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (67, N'Cedric', N'Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (68, N'Cooper', N'molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (69, N'Ali', N'parturient montes, nascetur ridiculus mus. Donec dignissim magna a tortor.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (70, N'Xavier', N'enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (71, N'Ulysses', N'viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (72, N'Porter', N'tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (73, N'Travis', N'adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (74, N'Camden', N'odio a purus. Duis elementum, dui quis accumsan convallis, ante')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (75, N'Lev', N'arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (76, N'Jacob', N'est tempor bibendum. Donec felis orci, adipiscing non, luctus sit')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (77, N'Alan', N'vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (78, N'Magee', N'mollis. Duis sit amet diam eu dolor egestas rhoncus. Proin')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (79, N'Alvin', N'odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (80, N'Dalton', N'nulla. Integer vulputate, risus a ultricies adipiscing, enim mi tempor')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (81, N'Ronan', N'nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (82, N'Jacob', N'Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (83, N'Hakeem', N'ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (84, N'Plato', N'egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (85, N'Elmo', N'magna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (86, N'Upton', N'Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (87, N'Vladimir', N'Donec egestas. Duis ac arcu. Nunc mauris. Morbi non sapien')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (88, N'Tobias', N'enim mi tempor lorem, eget mollis lectus pede et risus.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (89, N'Neil', N'ante dictum mi, ac mattis velit justo nec ante. Maecenas')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (90, N'Giacomo', N'et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (91, N'Camden', N'ac mattis semper, dui lectus rutrum urna, nec luctus felis')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (92, N'Scott', N'faucibus ut, nulla. Cras eu tellus eu augue porttitor interdum.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (93, N'Tyrone', N'Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (94, N'Stone', N'Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero. Integer')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (95, N'Hayden', N'enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida.')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (96, N'Igor', N'ac metus vitae velit egestas lacinia. Sed congue, elit sed')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (97, N'Elijah', N'orci luctus et ultrices posuere cubilia Curae; Phasellus ornare. Fusce')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (98, N'Keegan', N'mi. Duis risus odio, auctor vitae, aliquet nec, imperdiet nec,')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (99, N'Prescott', N'tortor, dictum eu, placerat eget, venenatis a, magna. Lorem ipsum')
GO
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (100, N'Scott', N'convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (101, N'Rodrigo Rosmaninho', N'')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (102, N'Gonçalo Perna', N'')
INSERT [dbo].[PESSOA] ([ID], [Nome], [Notas]) VALUES (103, N'Docentes BD', N'')
SET IDENTITY_INSERT [dbo].[PESSOA] OFF
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Duobam', N'slashdot.org', N'Macropus agilis')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Fintone', N'rediff.com', N'Neophron percnopterus')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Hatity', N'seesaa.net', N'Lasiorhinus latifrons')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Holdlamis', N'nymag.com', N'Tachybaptus ruficollis')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'It', N'shutterfly.com', N'Madoqua kirkii')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Job', N'bigcartel.com', N'Semnopithecus entellus')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Keylex', N'goo.ne.jp', N'Tapirus terrestris')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Latlux', N'1688.com', N'Spermophilus lateralis')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Lotlux', N'reference.com', N'Ammospermophilus nelsoni')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Mat Lam Tam', N'weibo.com', N'Varanus salvator')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Matsoft', N'gravatar.com', N'Pteropus rufus')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Opela', N'goo.gl', N'Scolopax minor')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Pannier', N'comsenz.com', N'Sula dactylatra')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Quo Lux', N'plala.or.jp', N'Semnopithecus entellus')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Rank', N'spotify.com', N'Bison bison')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Regrant', N'networkadvertising.org', N'Thamnolaea cinnmomeiventris')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Solarbreeze', N'chron.com', N'Trichosurus vulpecula')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Span', N'fastcompany.com', N'Felis silvestris lybica')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Stronghold', N'dell.com', N'Chlidonias leucopterus')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Tampflex', N'abc.net.au', N'Notechis semmiannulatus')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Tin', N'goodreads.com', N'Phalacrocorax albiventer')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Trippledex', N'qq.com', N'Cacatua tenuirostris')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Voltsillam', N'youtu.be', N'Pseudalopex gymnocercus')
INSERT [dbo].[PLATAFORMA] ([Nome], [Link], [Descricao]) VALUES (N'Zontrax', N'webnode.com', N'Podargus strigoides')
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 14)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 40)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 51)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 55)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 81)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 84)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 111)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 129)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 140)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 159)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 182)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (11, 195)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 2)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 6)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 14)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 15)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 16)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 32)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 36)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 37)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 45)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 53)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 55)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 61)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 63)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 68)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 72)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 78)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 81)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 93)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 142)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 147)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 151)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 159)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 163)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 182)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (12, 186)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 12)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 14)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 15)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 25)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 26)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 34)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 35)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 38)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 55)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 63)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 66)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 92)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 105)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 106)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 114)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 116)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 119)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 134)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 135)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 148)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 149)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 152)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 153)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 158)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 178)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 182)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 187)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (13, 192)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 8)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 46)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 57)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 97)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 134)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 140)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 143)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 156)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 177)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 184)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (14, 197)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 3)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 16)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 32)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 47)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 58)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 59)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 63)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 71)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 103)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 139)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 160)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 186)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 188)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (15, 196)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (16, 38)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (16, 63)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (16, 70)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (16, 169)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 3)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 13)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 43)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 73)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 74)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 86)
GO
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 87)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 89)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 99)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 100)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 120)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 130)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 143)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 158)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 167)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 171)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 191)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (17, 197)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 23)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 41)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 43)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 81)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 104)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 110)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 132)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 139)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 143)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (18, 161)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 12)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 32)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 49)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 82)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 111)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 143)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 150)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 166)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 170)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 174)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 179)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 188)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 192)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (19, 197)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 7)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 20)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 29)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 54)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 55)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 62)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 64)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 72)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 80)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 85)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 96)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 98)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 140)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 145)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 149)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 157)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 171)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 172)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 185)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (20, 192)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 13)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 33)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 88)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 112)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 119)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 131)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 178)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 180)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (21, 188)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 5)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 20)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 22)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 27)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 29)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 68)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 72)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 89)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 94)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 102)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 127)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 132)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 134)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 166)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 175)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 176)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 181)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 183)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (22, 194)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 23)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 43)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 51)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 60)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 65)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 90)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 113)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 114)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 115)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 165)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (23, 186)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 19)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 30)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 52)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 55)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 67)
GO
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 77)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 83)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 86)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 104)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 107)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 113)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 123)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 142)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 144)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 154)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 155)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 166)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 171)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 174)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 175)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (24, 186)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 7)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 9)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 11)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 32)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 38)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 40)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 96)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 98)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 140)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 167)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 170)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 173)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 175)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (25, 185)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 10)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 28)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 35)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 56)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 68)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 76)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 121)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 144)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 170)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 190)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (26, 193)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 17)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 40)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 76)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 91)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 117)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 126)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 146)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 181)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (27, 200)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 21)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 39)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 69)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 76)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 101)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 118)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 128)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 138)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 159)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 175)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 182)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 183)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (28, 193)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 4)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 8)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 12)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 25)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 38)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 39)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 80)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 88)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 91)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 99)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 101)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 109)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 111)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 112)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 114)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 118)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 121)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 131)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 132)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 137)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 138)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 141)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 153)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 162)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 164)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 178)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 180)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 189)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 190)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (29, 194)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 37)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 90)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 132)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 134)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 136)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 139)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 146)
GO
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 161)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 168)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 173)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (30, 198)
INSERT [dbo].[PRESTACAO] ([Membro_id], [Atendimento_id]) VALUES (101, 201)
SET IDENTITY_INSERT [dbo].[PROBLEMA] ON 

INSERT [dbo].[PROBLEMA] ([ID], [Descricao], [Componente_id], [SO_id]) VALUES (1, N'Bloqueio do computador quando o utente faz o log-in na tela inicial', NULL, 10)
INSERT [dbo].[PROBLEMA] ([ID], [Descricao], [Componente_id], [SO_id]) VALUES (2, N'Bloqueio logo apos o grub, sob a forma de uma tela preta', NULL, 1)
INSERT [dbo].[PROBLEMA] ([ID], [Descricao], [Componente_id], [SO_id]) VALUES (3, N'O Wifi n?o funciona', 21, 2)
INSERT [dbo].[PROBLEMA] ([ID], [Descricao], [Componente_id], [SO_id]) VALUES (4, N'Quando liga os headphones, o computador n?o d? som pelos headphones nem ativa o micro', 23, 6)
SET IDENTITY_INSERT [dbo].[PROBLEMA] OFF
SET IDENTITY_INSERT [dbo].[SESSAO] ON 

INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (1, CAST(N'2019-06-02T10:56:29.000' AS DateTime), N'mauris elit,', 2)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (2, CAST(N'2019-08-05T06:35:19.000' AS DateTime), N'molestie. Sed', 0)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (3, CAST(N'2019-10-04T17:14:16.000' AS DateTime), N'dui. Cum', 0)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (4, CAST(N'2019-10-11T20:35:23.000' AS DateTime), N'Aenean gravida', 3)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (5, CAST(N'2019-08-03T23:58:35.000' AS DateTime), N'eget massa.', 5)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (6, CAST(N'2019-05-02T03:11:43.000' AS DateTime), N'erat eget', 2)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (7, CAST(N'2019-10-30T02:16:09.000' AS DateTime), N'semper auctor.', 3)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (8, CAST(N'2019-08-17T20:25:25.000' AS DateTime), N'quis, pede.', 4)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (9, CAST(N'2019-12-08T03:19:07.000' AS DateTime), N'posuere at,', 0)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (10, CAST(N'2019-10-16T03:25:15.000' AS DateTime), N'semper tellus', 0)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (11, CAST(N'2019-08-07T16:39:20.000' AS DateTime), N'scelerisque mollis.', 0)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (12, CAST(N'2019-07-15T17:42:48.000' AS DateTime), N'dui. Fusce', 2)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (13, CAST(N'2019-09-20T11:40:52.000' AS DateTime), N'molestie orci', 1)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (14, CAST(N'2019-11-07T11:05:02.000' AS DateTime), N'Vestibulum ante', 5)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (15, CAST(N'2019-05-18T00:55:53.000' AS DateTime), N'at risus.', 2)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (16, CAST(N'2019-06-28T09:08:43.000' AS DateTime), N'elit pede,', 6)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (17, CAST(N'2019-11-03T23:41:39.000' AS DateTime), N'sed dui.', 5)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (18, CAST(N'2019-09-29T09:50:58.000' AS DateTime), N'dui, nec', 1)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (19, CAST(N'2019-06-10T14:00:19.000' AS DateTime), N'vestibulum. Mauris', 5)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (20, CAST(N'2019-11-27T18:02:13.000' AS DateTime), N'orci tincidunt', 1)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (21, CAST(N'2020-02-22T16:54:48.000' AS DateTime), N'arcu.', 0)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (22, CAST(N'2020-01-17T04:49:59.000' AS DateTime), N'nec', 6)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (23, CAST(N'2019-07-27T21:16:26.000' AS DateTime), N'Integer in', 0)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (24, CAST(N'2019-11-06T13:08:57.000' AS DateTime), N'aliquam', 7)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (25, CAST(N'2019-09-26T14:54:30.000' AS DateTime), N'Pellentesque', 1)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (26, CAST(N'2020-01-26T12:46:01.000' AS DateTime), N'vel', 3)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (27, CAST(N'2019-09-23T13:44:50.000' AS DateTime), N'netus', 5)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (28, CAST(N'2020-03-02T02:36:24.000' AS DateTime), N'est', 7)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (29, CAST(N'2019-08-24T14:25:42.000' AS DateTime), N'Duis dignissim', 3)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (30, CAST(N'2020-01-21T18:31:59.000' AS DateTime), N'ullamcorper. Duis', 5)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (31, CAST(N'2019-11-27T02:08:51.000' AS DateTime), N'rutrum', 8)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (32, CAST(N'2020-01-01T13:23:15.000' AS DateTime), N'Aliquam gravida', 1)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (33, CAST(N'2020-02-27T12:31:00.000' AS DateTime), N'metus sit', 8)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (34, CAST(N'2019-05-18T19:54:52.000' AS DateTime), N'aliquet. Proin', 5)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (35, CAST(N'2019-10-29T14:30:52.000' AS DateTime), N'mauris ut', 6)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (36, CAST(N'2019-06-25T18:28:45.000' AS DateTime), N'orci.', 3)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (37, CAST(N'2020-03-09T06:35:56.000' AS DateTime), N'dui.', 4)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (38, CAST(N'2020-03-09T17:22:56.000' AS DateTime), N'et', 4)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (39, CAST(N'2020-02-20T03:38:14.000' AS DateTime), N'fermentum metus.', 0)
INSERT [dbo].[SESSAO] ([ID], [Data], [Local], [Num_previstos]) VALUES (40, CAST(N'2019-09-18T05:20:51.000' AS DateTime), N'Donec at', 7)
SET IDENTITY_INSERT [dbo].[SESSAO] OFF
SET IDENTITY_INSERT [dbo].[SISTEMA_OPERATIVO] ON 

INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (16, N'Antergos', NULL)
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (1, N'Arch', NULL)
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (4, N'CentOS', N'8')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (13, N'Debian', N'9')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (2, N'Fedora', N'21')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (6, N'Gentoo', NULL)
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (3, N'Kubuntu', N'18.04')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (17, N'Manjaro', NULL)
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (11, N'MXLinux', NULL)
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (8, N'PopOS', NULL)
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (18, N'RedHat', NULL)
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (12, N'Tails', NULL)
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (10, N'Ubuntu', N'19.10')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (15, N'Ubuntu', N'20.04')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (7, N'Windows', N'10')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (14, N'Windows', N'7')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (9, N'Windows', N'8.1')
INSERT [dbo].[SISTEMA_OPERATIVO] ([ID], [Nome], [Versao]) VALUES (5, N'Xubuntu', N'18.04.3')
SET IDENTITY_INSERT [dbo].[SISTEMA_OPERATIVO] OFF
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 9, 0, N'phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 12, 0, N'eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 25, 1, N'nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 33, 2, N'nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 37, 1, N'non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 61, 2, N'ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 67, 2, N'lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 78, 0, N'sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 110, 0, N'eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 141, 2, N'feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 153, 1, N'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 162, 0, N'praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (1, 163, 1, N'lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 2, 2, N'turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 27, 0, N'morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 29, 0, N'ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 43, 0, N'Reboot :-)')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 64, 2, N'praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 92, 1, N'quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 94, 0, N'praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 106, 2, N'lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 112, 2, N'ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 113, 2, N'platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 129, 0, N'dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (2, 176, 2, N'nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (3, 15, 0, N'nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (3, 106, 0, N'mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (3, 176, 1, N'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (3, 195, 1, N'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 14, 2, N'dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 57, 2, N'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 61, 0, N'imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 138, 2, N'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 156, 2, N'nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 171, 2, N'erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 178, 2, N'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 181, 2, N'tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus')
INSERT [dbo].[TENTATIVA] ([Problema_id], [Atendimento_id], [Estado], [Procedimento]) VALUES (4, 196, 2, N'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer')
SET IDENTITY_INSERT [dbo].[TOPICO] ON 

INSERT [dbo].[TOPICO] ([ID], [Nome]) VALUES (5, N'Bloqueios no Arranque')
INSERT [dbo].[TOPICO] ([ID], [Nome]) VALUES (3, N'Codecs de multimedia')
INSERT [dbo].[TOPICO] ([ID], [Nome]) VALUES (4, N'Drives Desatualizadas')
INSERT [dbo].[TOPICO] ([ID], [Nome]) VALUES (6, N'Microfones Externos')
INSERT [dbo].[TOPICO] ([ID], [Nome]) VALUES (2, N'Placa de Redes')
INSERT [dbo].[TOPICO] ([ID], [Nome]) VALUES (1, N'Placa Gr?fica')
SET IDENTITY_INSERT [dbo].[TOPICO] OFF
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (1, 1)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (1, 2)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (1, 4)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (2, 1)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (2, 3)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (2, 4)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (3, 1)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (3, 2)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (3, 3)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (3, 4)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (4, 2)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (4, 3)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (5, 1)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (5, 2)
INSERT [dbo].[TOPICO_PROBLEMA] ([Topico_id], [Problema_id]) VALUES (5, 3)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (1, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (2, N'mcolbertson1@redcross.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (3, N'sbofield2@e-recht24.de')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (4, N'jelder3@bbc.co.uk')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (5, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (6, N'')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (7, N'odehooge6@archive.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (8, N'ehallgate7@yellowbook.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (9, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (10, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (11, N'hgredera@dmoz.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (12, N'rdulakeb@cam.ac.uk')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (13, N'pcastellanc@hexun.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (14, N'omcgeneayd@nhs.uk')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (15, N'kmellerse@ucoz.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (16, N'vedinburoughf@amazon.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (17, N'mdianog@hao123.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (18, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (19, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (20, N'ctunnowj@auda.org.au')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (21, N'bperesk@tripod.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (22, N'rgowryl@dropbox.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (23, N'rivanishinm@jalbum.net')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (24, N'mkerranen@umich.edu')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (25, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (26, N'cmasdonp@tinyurl.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (27, N'rsuddabyq@prlog.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (28, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (29, N'eketchasides@bigcartel.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (30, N'cnovict@zdnet.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (31, N'jsandcroftu@timesonline.co.uk')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (32, N'jtithacottv@printfriendly.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (33, N'tduredenw@jugem.jp')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (34, N'bfarnallx@comcast.net')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (35, N'mmcdermidy@1688.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (36, N'calibertiz@linkedin.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (37, N'araittie10@uol.com.br')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (38, N'scram11@google.es')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (39, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (40, N'orosten13@shop-pro.jp')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (41, N'dculligan14@dion.ne.jp')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (42, N'esandels15@nps.gov')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (43, N'mgibbard16@sourceforge.net')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (44, N'fkentwell17@cnn.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (45, N'dtwittey18@ted.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (46, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (47, N'yaustins1a@eventbrite.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (48, N'bhughs1b@hexun.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (49, N'tthoma1c@google.co.uk')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (50, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (51, N'cminchindon1e@gov.uk')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (52, N'cmorrissey1f@goo.gl')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (53, N'rquantrill1g@typepad.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (54, N'loloughane1h@free.fr')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (55, N'cbeare1i@pinterest.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (56, N'sseabon1j@epa.gov')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (57, N'wfoley1k@cnet.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (58, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (59, N'lcodd1m@ow.ly')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (60, N'mreinhardt1n@nymag.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (61, N'adysart1o@linkedin.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (62, N'cwingeat1p@jimdo.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (63, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (64, N'dpilsbury1r@about.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (65, N'dgrollmann1s@xinhuanet.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (66, N'lcanto1t@state.gov')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (67, N'caristide1u@tripadvisor.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (68, N'vgaveltone1v@gizmodo.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (69, N'yvallintine1w@creativecommons.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (70, N'maddenbrooke1x@intel.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (71, N'spetyanin1y@earthlink.net')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (72, N'clawles1z@skyrock.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (73, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (74, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (75, N'eoxe22@adobe.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (76, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (77, N'kpresnall24@bing.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (78, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (79, N'driep26@techcrunch.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (80, N'mburtt27@vistaprint.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (81, N'dbracknall28@csmonitor.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (82, N'mbrignall29@unesco.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (83, N'bdanelet2a@buzzfeed.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (84, N'gkenvin2b@google.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (85, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (86, N'utesoe2d@bbb.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (87, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (88, N'pskeeles2f@qq.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (89, N'fquarton2g@nbcnews.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (90, N'atidbold2h@edublogs.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (91, NULL)
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (92, N'wvanweedenburg2j@noaa.gov')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (93, N'tklug2k@networkadvertising.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (94, N'kdavidof2l@icio.us')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (95, N'lbramelt2m@senate.gov')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (96, N'pperle2n@intel.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (97, N'cbellie2o@ca.gov')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (98, N'ryvon2p@gnu.org')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (99, N'bhannaway2q@ucoz.com')
INSERT [dbo].[UTENTE] ([ID], [Contacto]) VALUES (100, N'ktassell2r@virginia.edu')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__COMPONEN__1CDC668C0DB3B24E]    Script Date: 12/06/2020 02:49:28 ******/
ALTER TABLE [dbo].[COMPONENTE] ADD UNIQUE NONCLUSTERED 
(
	[Fabricante] ASC,
	[Modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_Fabricante_Comp]    Script Date: 12/06/2020 02:49:28 ******/
CREATE NONCLUSTERED INDEX [idx_Fabricante_Comp] ON [dbo].[COMPONENTE]
(
	[Fabricante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_Departamento]    Script Date: 12/06/2020 02:49:28 ******/
CREATE NONCLUSTERED INDEX [idx_Departamento] ON [dbo].[CURSO]
(
	[Departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__MEMBRO__A9D105341BD7FF73]    Script Date: 12/06/2020 02:49:28 ******/
ALTER TABLE [dbo].[MEMBRO] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PC__1CDC668C46145734]    Script Date: 12/06/2020 02:49:28 ******/
ALTER TABLE [dbo].[PC] ADD UNIQUE NONCLUSTERED 
(
	[Fabricante] ASC,
	[Modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_Fabricante_PC]    Script Date: 12/06/2020 02:49:28 ******/
CREATE NONCLUSTERED INDEX [idx_Fabricante_PC] ON [dbo].[PC]
(
	[Fabricante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PLATAFOR__B827DC69940E3F20]    Script Date: 12/06/2020 02:49:28 ******/
ALTER TABLE [dbo].[PLATAFORMA] ADD UNIQUE NONCLUSTERED 
(
	[Link] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__SESSAO__77387D0BA56764B0]    Script Date: 12/06/2020 02:49:28 ******/
ALTER TABLE [dbo].[SESSAO] ADD UNIQUE NONCLUSTERED 
(
	[Data] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__SISTEMA___EDF5C9C677BCA202]    Script Date: 12/06/2020 02:49:28 ******/
ALTER TABLE [dbo].[SISTEMA_OPERATIVO] ADD UNIQUE NONCLUSTERED 
(
	[Nome] ASC,
	[Versao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_Nome_SisOP]    Script Date: 12/06/2020 02:49:28 ******/
CREATE NONCLUSTERED INDEX [idx_Nome_SisOP] ON [dbo].[SISTEMA_OPERATIVO]
(
	[Nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TOPICO__7D8FE3B2F77726DA]    Script Date: 12/06/2020 02:49:28 ******/
ALTER TABLE [dbo].[TOPICO] ADD UNIQUE NONCLUSTERED 
(
	[Nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EQUIPAMENTO] ADD  DEFAULT ((0)) FOR [Estado]
GO
ALTER TABLE [dbo].[MEMBRO] ADD  DEFAULT ((0)) FOR [Tipo]
GO
ALTER TABLE [dbo].[MEMBRO] ADD  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[TENTATIVA] ADD  DEFAULT ((0)) FOR [Estado]
GO
ALTER TABLE [dbo].[ACCOUNT]  WITH CHECK ADD FOREIGN KEY([Membro_ID])
REFERENCES [dbo].[MEMBRO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ACESSO]  WITH CHECK ADD FOREIGN KEY([Membro_id])
REFERENCES [dbo].[MEMBRO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ACESSO]  WITH CHECK ADD FOREIGN KEY([Plataforma_nome])
REFERENCES [dbo].[PLATAFORMA] ([Nome])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ATENDIMENTO]  WITH CHECK ADD FOREIGN KEY([PC_id])
REFERENCES [dbo].[PC] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ATENDIMENTO]  WITH CHECK ADD FOREIGN KEY([Sessao_id])
REFERENCES [dbo].[SESSAO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ATENDIMENTO]  WITH CHECK ADD FOREIGN KEY([Utente_id])
REFERENCES [dbo].[UTENTE] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[EQUIPAMENTO]  WITH CHECK ADD FOREIGN KEY([Membro_id])
REFERENCES [dbo].[MEMBRO] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ESTUDANTE]  WITH CHECK ADD FOREIGN KEY([Curso])
REFERENCES [dbo].[CURSO] ([Sigla])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[ESTUDANTE]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[PESSOA] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FLASH_DRIVE]  WITH CHECK ADD FOREIGN KEY([SO_id])
REFERENCES [dbo].[SISTEMA_OPERATIVO] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[FLASH_DRIVE]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[EQUIPAMENTO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MEMBRO]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[PESSOA] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PARTICIPACAO]  WITH CHECK ADD FOREIGN KEY([Membro_id])
REFERENCES [dbo].[MEMBRO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PARTICIPACAO]  WITH CHECK ADD FOREIGN KEY([Sessao_id])
REFERENCES [dbo].[SESSAO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRESTACAO]  WITH CHECK ADD FOREIGN KEY([Atendimento_id])
REFERENCES [dbo].[ATENDIMENTO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PRESTACAO]  WITH CHECK ADD FOREIGN KEY([Membro_id])
REFERENCES [dbo].[MEMBRO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PROBLEMA]  WITH CHECK ADD FOREIGN KEY([Componente_id])
REFERENCES [dbo].[COMPONENTE] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[PROBLEMA]  WITH CHECK ADD FOREIGN KEY([SO_id])
REFERENCES [dbo].[SISTEMA_OPERATIVO] ([ID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[TENTATIVA]  WITH CHECK ADD FOREIGN KEY([Atendimento_id])
REFERENCES [dbo].[ATENDIMENTO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TENTATIVA]  WITH CHECK ADD FOREIGN KEY([Problema_id])
REFERENCES [dbo].[PROBLEMA] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TOPICO_PROBLEMA]  WITH CHECK ADD FOREIGN KEY([Problema_id])
REFERENCES [dbo].[PROBLEMA] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TOPICO_PROBLEMA]  WITH CHECK ADD FOREIGN KEY([Topico_id])
REFERENCES [dbo].[TOPICO] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UTENTE]  WITH CHECK ADD FOREIGN KEY([ID])
REFERENCES [dbo].[PESSOA] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ATENDIMENTO]  WITH CHECK ADD CHECK  (([Tempo_despendido]>=(0)))
GO
ALTER TABLE [dbo].[EQUIPAMENTO]  WITH CHECK ADD CHECK  (([Estado]>=(0)))
GO
ALTER TABLE [dbo].[ESTUDANTE]  WITH CHECK ADD CHECK  (([Nmec]>(0)))
GO
ALTER TABLE [dbo].[MEMBRO]  WITH CHECK ADD CHECK  (([Estado]>=(0)))
GO
ALTER TABLE [dbo].[MEMBRO]  WITH CHECK ADD CHECK  (([Num_telemovel]>(0)))
GO
ALTER TABLE [dbo].[MEMBRO]  WITH CHECK ADD CHECK  (([Tipo]>=(0)))
GO
ALTER TABLE [dbo].[SESSAO]  WITH CHECK ADD CHECK  (([Num_previstos]>=(0)))
GO
ALTER TABLE [dbo].[TENTATIVA]  WITH CHECK ADD CHECK  (([Estado]>=(0)))
GO
/****** Object:  StoredProcedure [dbo].[InsertPlataformas]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertPlataformas] (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
GO
/****** Object:  StoredProcedure [dbo].[ModifyAccount]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[ModifyAccount]
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
/****** Object:  StoredProcedure [dbo].[ModifyAtendimentos]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
*/

--Exec InsertPlataformas 'Slack', 'detiuaveiro.slack.com', 'Slack do DETI';

/*
CREATE PROC UpdatePlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @Nome;
RETURN;
*/

/*
CREATE PROC ModifyTopico (@ID int , @Nome varchar(40), @Notas varchar(240), @Contacto varchar(40))
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
*/

/*
CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
    RETURN;
*/


CREATE PROC [dbo].[ModifyAtendimentos] (@ID int, @Data datetime, @Local varchar(30), @Tempo_despendido int, @PC_id int, @Sessao_id int, @Utente_id int)
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


/*
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
*/

GO
/****** Object:  StoredProcedure [dbo].[ModifyComponente]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
*/

--Exec InsertPlataformas 'Slack', 'detiuaveiro.slack.com', 'Slack do DETI';

/*
CREATE PROC UpdatePlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @Nome;
RETURN;
*/

/*
CREATE PROC ModifyTopico (@ID int , @Nome varchar(40), @Notas varchar(240), @Contacto varchar(40))
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
*/

/*
CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;
*/

/*
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
*/

/*
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
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END

CREATE TRIGGER deleteTentativa ON dbo.TENTATIVA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.TENTATIVA WHERE Problema_id,  IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/


CREATE PROC [dbo].[ModifyComponente] (@ID int , @Fabricante varchar(30), @Modelo varchar(30))
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
/****** Object:  StoredProcedure [dbo].[ModifyCurso]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE PROC ModifyUtente (@ID int , @Name varchar(30), @Notas varchar(240), @Contacto varchar(40), @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
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
	RETURN;*/


/*CREATE PROC ModifyMembro (@ID int , @Name varchar(30), @Notas varchar(240), @Email varchar(40), @Num_telemovel int, @Tipo int, @Estado int, @Data_entrada DATE)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO PESSOA (Nome, Notas) VALUES (@Name, @Notas);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO Membro VALUES (@p_id, @Email, @Num_telemovel, @Tipo, @Estado, @Data_entrada);
	END;
	ELSE
	BEGIN
		UPDATE PESSOA SET Nome = @Name, Notas = @Notas WHERE ID = @ID;
		UPDATE MEMBRO SET Email = @Email, Num_telemovel = @Num_telemovel, Tipo = @Tipo, Estado = @Estado, Data_entrada = @Data_entrada WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyEquipamento (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
	ELSE
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyFlashDrive (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int, @Fabricante varchar(30), @Capacidade int,
										@Velocidade int, @Conteudo varchar(240), @SO_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO FLASH_DRIVE VALUES (@p_id, @Fabricante, @Capacidade, @Velocidade, @Conteudo, @SO_id);
	END;
	ELSE
	BEGIN
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;
		UPDATE FLASH_DRIVE SET Fabricante=@Fabricante, Capacidade=@Capacidade, Velocidade=@Velocidade, Conteudo=@Conteudo, SO_id=@SO_id WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifySistemaOperativo (@ID int, @Name varchar(30), @Versao varchar(30))
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO SISTEMA_OPERATIVO VALUES (@Name, @Versao);
	ELSE
		UPDATE SISTEMA_OPERATIVO SET Nome = @Name, Versao=@Versao WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/


CREATE PROC [dbo].[ModifyCurso] (@Sigla varchar(10), @Departamento varchar(10))
AS
	BEGIN TRAN

	INSERT INTO Curso VALUES (@Sigla, @Departamento);

	COMMIT TRAN;
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[ModifyEquipamento]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE PROC ModifyUtente (@ID int , @Name varchar(30), @Notas varchar(240), @Contacto varchar(40), @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
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
	RETURN;*/

/*CREATE PROC ModifyMembro (@ID int , @Name varchar(30), @Notas varchar(240), @Email varchar(40), @Num_telemovel int, @Tipo int, @Estado int, @Data_entrada DATE,  @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
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
	RETURN;*/



CREATE PROC [dbo].[ModifyEquipamento] (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int)
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


/*CREATE PROC ModifyFlashDrive (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int, @Fabricante varchar(30), @Capacidade int,
										@Velocidade int, @Conteudo varchar(240), @SO_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO FLASH_DRIVE VALUES (@p_id, @Fabricante, @Capacidade, @Velocidade, @Conteudo, @SO_id);
	END;
	ELSE
	BEGIN
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;
		UPDATE FLASH_DRIVE SET Fabricante=@Fabricante, Capacidade=@Capacidade, Velocidade=@Velocidade, Conteudo=@Conteudo, SO_id=@SO_id WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifySistemaOperativo (@ID int, @Name varchar(30), @Versao varchar(30))
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO SISTEMA_OPERATIVO VALUES (@Name, @Versao);
	ELSE
		UPDATE SISTEMA_OPERATIVO SET Nome = @Name, Versao=@Versao WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyCurso (@Sigla varchar(10), @Departamento varchar(10))
AS
	BEGIN TRAN

	INSERT INTO Curso VALUES (@Sigla, @Departamento);

	COMMIT TRAN;
	RETURN;*/
GO
/****** Object:  StoredProcedure [dbo].[ModifyFlashDrive]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE PROC ModifyUtente (@ID int , @Name varchar(30), @Notas varchar(240), @Contacto varchar(40), @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
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
	RETURN;*/

/*CREATE PROC ModifyMembro (@ID int , @Name varchar(30), @Notas varchar(240), @Email varchar(40), @Num_telemovel int, @Tipo int, @Estado int, @Data_entrada DATE,  @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
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
	RETURN;*/



/*CREATE PROC ModifyEquipamento (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int)
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
	RETURN;*/


CREATE PROC [dbo].[ModifyFlashDrive] (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int, @Fabricante varchar(30), @Capacidade int,
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


/*CREATE PROC ModifySistemaOperativo (@ID int, @Name varchar(30), @Versao varchar(30))
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO SISTEMA_OPERATIVO VALUES (@Name, @Versao);
	ELSE
		UPDATE SISTEMA_OPERATIVO SET Nome = @Name, Versao=@Versao WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyCurso (@Sigla varchar(10), @Departamento varchar(10))
AS
	BEGIN TRAN

	INSERT INTO Curso VALUES (@Sigla, @Departamento);

	COMMIT TRAN;
	RETURN;*/
GO
/****** Object:  StoredProcedure [dbo].[ModifyMembro]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE PROC ModifyUtente (@ID int , @Name varchar(30), @Notas varchar(240), @Contacto varchar(40), @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
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
	RETURN;*/

CREATE PROC [dbo].[ModifyMembro] (@ID int , @Name varchar(30), @Notas varchar(240), @Email varchar(40), @Num_telemovel int, @Tipo int, @Estado int, @Data_entrada DATE,  @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
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


/*CREATE PROC ModifyEquipamento (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
	ELSE
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyFlashDrive (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int, @Fabricante varchar(30), @Capacidade int,
										@Velocidade int, @Conteudo varchar(240), @SO_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO FLASH_DRIVE VALUES (@p_id, @Fabricante, @Capacidade, @Velocidade, @Conteudo, @SO_id);
	END;
	ELSE
	BEGIN
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;
		UPDATE FLASH_DRIVE SET Fabricante=@Fabricante, Capacidade=@Capacidade, Velocidade=@Velocidade, Conteudo=@Conteudo, SO_id=@SO_id WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifySistemaOperativo (@ID int, @Name varchar(30), @Versao varchar(30))
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO SISTEMA_OPERATIVO VALUES (@Name, @Versao);
	ELSE
		UPDATE SISTEMA_OPERATIVO SET Nome = @Name, Versao=@Versao WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyCurso (@Sigla varchar(10), @Departamento varchar(10))
AS
	BEGIN TRAN

	INSERT INTO Curso VALUES (@Sigla, @Departamento);

	COMMIT TRAN;
	RETURN;*/
GO
/****** Object:  StoredProcedure [dbo].[ModifyPC]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
*/

--Exec InsertPlataformas 'Slack', 'detiuaveiro.slack.com', 'Slack do DETI';

/*
CREATE PROC UpdatePlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @Nome;
RETURN;
*/

/*
CREATE PROC ModifyTopico (@ID int , @Nome varchar(40), @Notas varchar(240), @Contacto varchar(40))
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
*/

/*
CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;
*/

/*
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
*/

/*
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
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END

CREATE TRIGGER deleteTentativa ON dbo.TENTATIVA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.TENTATIVA WHERE Problema_id,  IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
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
*/

CREATE PROC [dbo].[ModifyPC] (@ID int , @Fabricante varchar(30), @Modelo varchar(30))
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
/****** Object:  StoredProcedure [dbo].[ModifyProblemas]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
*/

--Exec InsertPlataformas 'Slack', 'detiuaveiro.slack.com', 'Slack do DETI';

/*
CREATE PROC UpdatePlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @Nome;
RETURN;
*/

/*
CREATE PROC ModifyTopico (@ID int , @Nome varchar(40), @Notas varchar(240), @Contacto varchar(40))
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
*/

/*
CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
    RETURN;
*/

/*
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
*/


CREATE PROC [dbo].[ModifyProblemas] (@ID int, @Descricao varchar(240), @Componente_id int, @SO_id int)
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
/****** Object:  StoredProcedure [dbo].[ModifySessoes]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
*/

--Exec InsertPlataformas 'Slack', 'detiuaveiro.slack.com', 'Slack do DETI';

/*
CREATE PROC UpdatePlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @Nome;
RETURN;
*/

/*
CREATE PROC ModifyTopico (@ID int , @Nome varchar(40), @Notas varchar(240), @Contacto varchar(40))
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
*/


CREATE PROC [dbo].[ModifySessoes] (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
    RETURN;


/*
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
*/

/*
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
*/

GO
/****** Object:  StoredProcedure [dbo].[ModifySistemaOperativo]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CREATE PROC ModifyUtente (@ID int , @Name varchar(30), @Notas varchar(240), @Contacto varchar(40))
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO PESSOA (Nome, Notas) VALUES (@Name, @Notas);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO UTENTE VALUES (@p_id, @Contacto);
	END;
	ELSE
	BEGIN
		UPDATE PESSOA SET Nome = @Name, Notas = @Notas WHERE ID = @ID;
		UPDATE UTENTE SET Contacto = @Contacto WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyMembro (@ID int , @Name varchar(30), @Notas varchar(240), @Email varchar(40), @Num_telemovel int, @Tipo int, @Estado int, @Data_entrada DATE)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO PESSOA (Nome, Notas) VALUES (@Name, @Notas);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO Membro VALUES (@p_id, @Email, @Num_telemovel, @Tipo, @Estado, @Data_entrada);
	END;
	ELSE
	BEGIN
		UPDATE PESSOA SET Nome = @Name, Notas = @Notas WHERE ID = @ID;
		UPDATE MEMBRO SET Email = @Email, Num_telemovel = @Num_telemovel, Tipo = @Tipo, Estado = @Estado, Data_entrada = @Data_entrada WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyEquipamento (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
	ELSE
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyFlashDrive (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int, @Fabricante varchar(30), @Capacidade int,
										@Velocidade int, @Conteudo varchar(240), @SO_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO FLASH_DRIVE VALUES (@p_id, @Fabricante, @Capacidade, @Velocidade, @Conteudo, @SO_id);
	END;
	ELSE
	BEGIN
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;
		UPDATE FLASH_DRIVE SET Fabricante=@Fabricante, Capacidade=@Capacidade, Velocidade=@Velocidade, Conteudo=@Conteudo, SO_id=@SO_id WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


CREATE PROC [dbo].[ModifySistemaOperativo] (@ID int, @Name varchar(30), @Versao varchar(30))
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO SISTEMA_OPERATIVO VALUES (@Name, @Versao);
	ELSE
		UPDATE SISTEMA_OPERATIVO SET Nome = @Name, Versao=@Versao WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;
GO
/****** Object:  StoredProcedure [dbo].[ModifyTentativa]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
*/

--Exec InsertPlataformas 'Slack', 'detiuaveiro.slack.com', 'Slack do DETI';

/*
CREATE PROC UpdatePlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30), @PK varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @PK;
RETURN;
*/

/*
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
*/

/*
CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;
*/

/*
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
*/

/*
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
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END

CREATE TRIGGER deleteTentativa ON dbo.TENTATIVA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.TENTATIVA WHERE Problema_id,  IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
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
*/

/*
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
*/

/*
CREATE FUNCTION getIdFromComponenteFabricante(@Fabricante varchar(30), @Modelo varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
    IF @Modelo is NULL
        SET @ID = (SELECT ID FROM COMPONENTE WHERE Fabricante = @Fabricante);
    ELSE
        SET @ID = (SELECT ID FROM COMPONENTE WHERE Fabricante = @Fabricante and Modelo = @Modelo);
    RETURN(@ID)
END
*/

/*
CREATE FUNCTION getIdFromPCFabricante(@Fabricante varchar(30), @Modelo varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
    IF @Modelo is NULL
        SET @ID = (SELECT ID FROM PC WHERE Fabricante = @Fabricante);
    ELSE
        SET @ID = (SELECT ID FROM PC WHERE Fabricante = @Fabricante and Modelo = @Modelo);
    RETURN(@ID)
END
*/

CREATE PROC [dbo].[ModifyTentativa] (@PID int, @AID int, @Estado int, @Procedimento varchar(500))
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
/****** Object:  StoredProcedure [dbo].[ModifyTopico]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ModifyTopico] (@ID int , @Nome varchar(40))
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


/*
CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;
*/

/*
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
*/

/*
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
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END

CREATE TRIGGER deleteTentativa ON dbo.TENTATIVA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.TENTATIVA WHERE Problema_id,  IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
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
*/

/*
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
*/
GO
/****** Object:  StoredProcedure [dbo].[ModifyUtente]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ModifyUtente] (@ID int , @Name varchar(30), @Notas varchar(240), @Contacto varchar(40), @IsStudent varchar(5), @Nmec int, @Curso_Sigla varchar(10), @Ano_Matricula DATE)
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


/*CREATE PROC ModifyMembro (@ID int , @Name varchar(30), @Notas varchar(240), @Email varchar(40), @Num_telemovel int, @Tipo int, @Estado int, @Data_entrada DATE)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO PESSOA (Nome, Notas) VALUES (@Name, @Notas);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO Membro VALUES (@p_id, @Email, @Num_telemovel, @Tipo, @Estado, @Data_entrada);
	END;
	ELSE
	BEGIN
		UPDATE PESSOA SET Nome = @Name, Notas = @Notas WHERE ID = @ID;
		UPDATE MEMBRO SET Email = @Email, Num_telemovel = @Num_telemovel, Tipo = @Tipo, Estado = @Estado, Data_entrada = @Data_entrada WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyEquipamento (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
	ELSE
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifyFlashDrive (@ID int , @Name varchar(40), @Descricao varchar(240), @Localizacao varchar(120), @Estado int, @Dador varchar(40), @Membro_id int, @Fabricante varchar(30), @Capacidade int,
										@Velocidade int, @Conteudo varchar(240), @SO_id int)
AS
	BEGIN TRAN

	IF @ID is NULL
	BEGIN
		INSERT INTO EQUIPAMENTO VALUES (@Name, @Descricao, @Localizacao, @Estado, @Dador, @Membro_id);
		DECLARE @p_id as int;
		SET @p_id = SCOPE_IDENTITY();
		INSERT INTO FLASH_DRIVE VALUES (@p_id, @Fabricante, @Capacidade, @Velocidade, @Conteudo, @SO_id);
	END;
	ELSE
	BEGIN
		UPDATE EQUIPAMENTO SET Nome = @Name, Descricao = @Descricao, Localizacao = @Localizacao, Estado = @Estado, Dador = @Dador, Membro_id = @Membro_id WHERE ID = @ID;
		UPDATE FLASH_DRIVE SET Fabricante=@Fabricante, Capacidade=@Capacidade, Velocidade=@Velocidade, Conteudo=@Conteudo, SO_id=@SO_id WHERE ID = @ID;
	END;

	COMMIT TRAN;
	RETURN;*/


/*CREATE PROC ModifySistemaOperativo (@ID int, @Name varchar(30), @Versao varchar(30))
AS
	BEGIN TRAN

	IF @ID is NULL
		INSERT INTO SISTEMA_OPERATIVO VALUES (@Name, @Versao);
	ELSE
		UPDATE SISTEMA_OPERATIVO SET Nome = @Name, Versao=@Versao WHERE ID = @ID;

	COMMIT TRAN;
	RETURN;*/
GO
/****** Object:  StoredProcedure [dbo].[UpdatePlataformas]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE PROC InsertPlataformas (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30))
AS
    INSERT INTO PLATAFORMA(Nome, Link, Descricao) VALUES (@Nome, @Link, @Descricao);
RETURN;
*/

--Exec InsertPlataformas 'Slack', 'detiuaveiro.slack.com', 'Slack do DETI';


CREATE PROC [dbo].[UpdatePlataformas] (@Nome varchar(30) , @Link varchar(30), @Descricao varchar(30), @PK varchar(30))
AS
    UPDATE PLATAFORMA SET Nome = @Nome, Link = @Link, Descricao = @Descricao WHERE Nome = @PK;
RETURN;



/*
CREATE PROC ModifyTopico (@ID int , @Nome varchar(40), @Notas varchar(240), @Contacto varchar(40))
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
*/

/*
CREATE PROC ModifySessoes (@ID int, @Data datetime, @Local varchar(30), @Num_previstos int)
AS
    BEGIN TRAN

    IF @ID is NULL
    BEGIN
        INSERT INTO SESSAO (Data, Local, Num_previstos) VALUES (@Data, @Local, @Num_previstos);
    END;
    ELSE
    BEGIN
        UPDATE SESSAO SET Data = @Data, Local = @Local, Num_previstos = @Num_previstos WHERE ID = @ID;
    END;

    COMMIT TRAN;
RETURN;
*/

/*
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
*/

/*
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
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
CREATE TRIGGER deleteProblema ON dbo.PROBLEMA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.PROBLEMA WHERE ID IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END

CREATE TRIGGER deleteTentativa ON dbo.TENTATIVA
INSTEAD OF DELETE
AS
BEGIN
	BEGIN TRAN;
	DELETE FROM dbo.TENTATIVA WHERE Problema_id,  IN (Select ID from deleted)
	DELETE FROM dbo.TENTATIVA WHERE Problema_id IN (Select ID from deleted)
	DELETE FROM dbo.TOPICO_PROBLEMA WHERE Problema_id IN (Select ID from deleted)
	COMMIT TRAN;
END
*/

/*
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
*/

/*
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
*/
GO
/****** Object:  StoredProcedure [dbo].[VerifyAccount]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
CREATE TABLE dbo.ACCOUNT (
  Membro_ID INT,
  Salt CHAR(25),
  AccountPwd varbinary(20),
  CONSTRAINT PK_SecurityAccounts PRIMARY KEY (Membro_ID),
);
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

*/
CREATE PROC [dbo].[VerifyAccount]
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
/****** Object:  Trigger [dbo].[deleteFlashDrive]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[deleteFlashDrive] ON [dbo].[FLASH_DRIVE]
AFTER DELETE
AS
BEGIN
    DECLARE @ID INT;
    SELECT @ID=ID FROM deleted;
    DELETE FROM dbo.EQUIPAMENTO WHERE ID = @ID
END
GO
ALTER TABLE [dbo].[FLASH_DRIVE] ENABLE TRIGGER [deleteFlashDrive]
GO
/****** Object:  Trigger [dbo].[addMembro]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[addMembro] ON [dbo].[MEMBRO]
INSTEAD OF INSERT
AS
BEGIN
	BEGIN TRAN;
		DECLARE @ID INT;
		SELECT @ID=ID FROM inserted;
		INSERT INTO MEMBRO SELECT * FROM inserted;
		EXEC ModifyAccount @ID, "gluauser";
	COMMIT TRAN;
END

GO
ALTER TABLE [dbo].[MEMBRO] ENABLE TRIGGER [addMembro]
GO
/****** Object:  Trigger [dbo].[deleteMembro]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[deleteMembro] ON [dbo].[MEMBRO]
AFTER DELETE
AS
BEGIN
    DECLARE @ID INT;
    SELECT @ID=ID FROM deleted;
    IF NOT EXISTS(SELECT 1 FROM dbo.UTENTE
        WHERE ID = @ID)
        DELETE FROM dbo.PESSOA WHERE ID = @ID
END

GO
ALTER TABLE [dbo].[MEMBRO] ENABLE TRIGGER [deleteMembro]
GO
/****** Object:  Trigger [dbo].[deleteUtente]    Script Date: 12/06/2020 02:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[deleteUtente] ON [dbo].[UTENTE]
AFTER DELETE
AS
BEGIN
    DECLARE @ID INT;
    SELECT @ID=ID FROM deleted;
    IF NOT EXISTS(SELECT 1 FROM dbo.MEMBRO
        WHERE ID = @ID)
        DELETE FROM dbo.PESSOA WHERE ID = @ID
END

GO
ALTER TABLE [dbo].[UTENTE] ENABLE TRIGGER [deleteUtente]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -109
      End
      Begin Tables = 
         Begin Table = "ATENDIMENTO"
            Begin Extent = 
               Top = 153
               Left = 420
               Bottom = 283
               Right = 613
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "TENTATIVA"
            Begin Extent = 
               Top = 177
               Left = 721
               Bottom = 307
               Right = 895
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PRESTACAO"
            Begin Extent = 
               Top = 52
               Left = 725
               Bottom = 148
               Right = 899
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PC"
            Begin Extent = 
               Top = 44
               Left = 114
               Bottom = 157
               Right = 284
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PESSOA"
            Begin Extent = 
               Top = 298
               Left = 115
               Bottom = 411
               Right = 285
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SESSAO"
            Begin Extent = 
               Top = 162
               Left = 113
               Bottom = 292
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
      ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Atendimentos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Atendimentos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Atendimentos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PRESTACAO"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ATENDIMENTO"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 136
               Right = 444
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PESSOA"
            Begin Extent = 
               Top = 102
               Left = 38
               Bottom = 215
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Atendimentos_Membros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Atendimentos_Membros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ATENDIMENTO"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PC"
            Begin Extent = 
               Top = 6
               Left = 270
               Bottom = 119
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TENTATIVA"
            Begin Extent = 
               Top = 120
               Left = 270
               Bottom = 250
               Right = 444
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PROBLEMA"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Atendimentos_Problemas_PC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Atendimentos_Problemas_PC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "COMPONENTE"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PROBLEMA"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Componentes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Componentes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EQUIPAMENTO"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FLASH_DRIVE"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "SISTEMA_OPERATIVO"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipamentos_FlashDrive_SistemaOp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipamentos_FlashDrive_SistemaOp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Equipamentos_FlashDrive_SistemaOp"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "PESSOA"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipamentos_FlashDrive_SistemaOp_Responsavel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipamentos_FlashDrive_SistemaOp_Responsavel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PESSOA"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EQUIPAMENTO"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipamentos_Responsaveis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Equipamentos_Responsaveis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MEMBRO"
            Begin Extent = 
               Top = 47
               Left = 39
               Bottom = 177
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "PESSOA"
            Begin Extent = 
               Top = 0
               Left = 279
               Bottom = 113
               Right = 449
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 780
         Or = 810
         Or = 840
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Membros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Membros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PC"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ATENDIMENTO"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PCs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PCs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ACESSO"
            Begin Extent = 
               Top = 23
               Left = 256
               Bottom = 153
               Right = 439
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PLATAFORMA"
            Begin Extent = 
               Top = 21
               Left = 30
               Bottom = 134
               Right = 200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Plataformas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Plataformas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PESSOA"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PRESTACAO"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Prestacoes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Prestacoes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -22
      End
      Begin Tables = 
         Begin Table = "PROBLEMA"
            Begin Extent = 
               Top = 65
               Left = 546
               Bottom = 195
               Right = 720
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TENTATIVA"
            Begin Extent = 
               Top = 65
               Left = 801
               Bottom = 195
               Right = 975
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SISTEMA_OPERATIVO"
            Begin Extent = 
               Top = 161
               Left = 262
               Bottom = 274
               Right = 432
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "COMPONENTE"
            Begin Extent = 
               Top = 31
               Left = 266
               Bottom = 144
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Problemas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Problemas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ATENDIMENTO"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PC"
            Begin Extent = 
               Top = 6
               Left = 270
               Bottom = 119
               Right = 440
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TENTATIVA"
            Begin Extent = 
               Top = 120
               Left = 270
               Bottom = 250
               Right = 444
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PROBLEMA"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Problemas_Utentes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Problemas_Utentes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PARTICIPACAO"
            Begin Extent = 
               Top = 159
               Left = 297
               Bottom = 255
               Right = 467
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Sessoes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Sessoes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PARTICIPACAO"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SESSAO"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 136
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ATENDIMENTO"
            Begin Extent = 
               Top = 102
               Left = 38
               Bottom = 232
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Sessoes_Membros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Sessoes_Membros'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "FLASH_DRIVE"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PROBLEMA"
            Begin Extent = 
               Top = 0
               Left = 548
               Bottom = 130
               Right = 722
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SISTEMA_OPERATIVO"
            Begin Extent = 
               Top = 57
               Left = 294
               Bottom = 170
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SistemasOperativos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SistemasOperativos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TENTATIVA"
            Begin Extent = 
               Top = 12
               Left = 342
               Bottom = 142
               Right = 532
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ATENDIMENTO"
            Begin Extent = 
               Top = 29
               Left = 601
               Bottom = 159
               Right = 810
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tentativas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Tentativas'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TOPICO"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TOPICO_PROBLEMA"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Topicos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Topicos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PESSOA"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UTENTE"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Utentes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Utentes'
GO
USE [master]
GO
ALTER DATABASE [p1g4] SET  READ_WRITE 
GO
