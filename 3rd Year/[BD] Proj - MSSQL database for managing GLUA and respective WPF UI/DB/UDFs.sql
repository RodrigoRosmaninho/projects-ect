CREATE FUNCTION getMembersByPlatform (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Nome, Username, Tipo
			FROM dbo.ACESSO JOIN dbo.PESSOA ON dbo.ACESSO.Membro_id = dbo.PESSOA.ID
			WHERE dbo.ACESSO.Plataforma_nome = @Platform_Name)

GO

CREATE FUNCTION getPlatformByName (@Platform_Name VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Plataformas
			WHERE Nome = @Platform_Name)

GO

CREATE FUNCTION getProblemsByTopic (@Topic_Name VARCHAR(40)) RETURNS Table AS
	RETURN(SELECT dbo.Problemas.*
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.TOPICO.Nome = @Topic_Name)

GO

CREATE FUNCTION getProblemByID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Problemas
			WHERE ID = @Problem_ID)

GO

CREATE FUNCTION getTopicsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT Nome AS Topico
			FROM dbo.Problemas INNER JOIN 
			(dbo.TOPICO_PROBLEMA INNER JOIN dbo.TOPICO ON dbo.TOPICO_PROBLEMA.Topico_id = dbo.TOPICO.ID)
			ON dbo.Problemas.ID = dbo.TOPICO_PROBLEMA.Problema_id
			WHERE dbo.Problemas.ID = @Problem_ID)

GO

CREATE FUNCTION getAttemptsByProblemID (@Problem_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID)

GO

CREATE FUNCTION getAtendimentoByID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Atendimentos
			WHERE ID = @Atendimento_ID)

GO

CREATE FUNCTION getMembersByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT X.ID, X.Nome, Email, Data_entrada, Estado FROM dbo.Membros as X JOIN dbo.Prestacoes ON X.ID = dbo.Prestacoes.ID
			WHERE Atendimento_id = @Atendimento_ID)

GO

CREATE FUNCTION getProblemsByAtendimentoID (@Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA INNER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
			WHERE dbo.TENTATIVA.Atendimento_id = @Atendimento_ID)

GO

CREATE FUNCTION wasProblemResolvedByProblemID (@Problem_ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=MIN(dbo.TENTATIVA.Estado)
	FROM dbo.TENTATIVA
	WHERE dbo.TENTATIVA.Problema_id = @Problem_id
	GROUP BY dbo.TENTATIVA.Atendimento_ID

	RETURN(@res)
END

GO

CREATE FUNCTION getHelpdeskByID (@Helpdesk_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Sessoes
			WHERE ID = @Helpdesk_ID)

GO

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

GO

CREATE FUNCTION getPCsByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.PC
		   WHERE Fabricante = @Fabricante)

GO

CREATE FUNCTION getPCByID (@PC_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.PCs
			WHERE ID = @PC_ID)

GO

CREATE FUNCTION getComponentesByFabricante (@Fabricante VARCHAR(30)) RETURNS Table AS
	RETURN(SELECT Modelo
		   FROM dbo.COMPONENTE
		   WHERE Fabricante = @Fabricante)


GO

CREATE FUNCTION getComponenteByID (@Componente_ID INT) RETURNS Table AS
	RETURN(SELECT TOP 1 *
			FROM dbo.Componentes
			WHERE ID = @Componente_ID)

GO

CREATE FUNCTION getAttemptByIDs (@Problem_ID INT, @Atendimento_ID INT) RETURNS Table AS
	RETURN(SELECT *
			FROM dbo.Tentativas
			WHERE Problema_id = @Problem_ID AND Atendimento_id = @Atendimento_ID)

GO

CREATE FUNCTION getOSStats() RETURNS Table AS
	RETURN(SELECT Nome, COUNT(Versao) AS versao_num, SUM(flashDrives_num) AS flashDrives_num, SUM(problems_num) AS problems_num
			FROM dbo.SistemasOperativos
			GROUP BY Nome)

GO

CREATE FUNCTION getCursoStats() RETURNS Table AS
	RETURN(SELECT Curso, COUNT(Utente_id) AS atendimentos_num
			FROM dbo.ATENDIMENTO LEFT OUTER JOIN dbo.ESTUDANTE ON dbo.ATENDIMENTO.Utente_id = dbo.ESTUDANTE.ID
			GROUP BY Curso)

GO

CREATE FUNCTION getPCStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.PC.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID
			GROUP BY Fabricante)

GO

CREATE FUNCTION getComponenteStats() RETURNS Table AS
	RETURN(SELECT Fabricante, COUNT(dbo.COMPONENTE.ID) AS atendimentos_num
			FROM dbo.ATENDIMENTO JOIN dbo.COMPONENTE ON dbo.ATENDIMENTO.PC_id = dbo.COMPONENTE.ID
			GROUP BY Fabricante)

GO

CREATE FUNCTION getMonthStats() RETURNS Table AS
	RETURN(SELECT MONTH(Data) AS mes, COUNT(ID) AS atendimentos_num 
			FROM ATENDIMENTOS 
			WHERE DATEDIFF(MM, Data, GETDATE()) < 12 
			GROUP BY MONTH(Data), YEAR(Data))

GO

CREATE FUNCTION getEquipmentByID (@ID int) RETURNS Table AS
	RETURN (SELECT * 
			FROM dbo.Equipamentos_Responsaveis 
			WHERE dbo.Equipamentos_Responsaveis.ID = @ID);

GO

CREATE FUNCTION getFlashDrivesByID (@ID int) RETURNS Table AS
	RETURN (SELECT * 
			FROM dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel 
			WHERE dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel.ID = @ID);

GO

CREATE FUNCTION getSystemVersionByName (@Name varchar(30)) RETURNS Table AS
	RETURN (SELECT Versao 
			FROM dbo.SISTEMA_OPERATIVO 
			WHERE Nome = @Name);

GO

CREATE FUNCTION getMembersByID (@ID int) RETURNS Table AS
	RETURN (SELECT * 
			FROM dbo.Membros 
			WHERE dbo.Membros.ID = @ID);

GO

CREATE FUNCTION getPlataformsAcessListByMembersID (@ID int) RETURNS Table AS
	RETURN (SELECT Plataforma_nome, Username, Tipo 
			FROM dbo.ACESSO 
			WHERE Membro_id = @ID);

GO

CREATE FUNCTION getEquipmentListByMemberID (@ID int) RETURNS Table AS
	RETURN (SELECT ID, Nome, Descricao, Estado 
			FROM dbo.EQUIPAMENTO 
			WHERE Membro_id = @ID);

GO

CREATE FUNCTION getHelpSessionsListByMemberID (@ID int) RETURNS Table AS
	RETURN (SELECT ID, Data, Local, Num_previstos, Num_realizados 
			FROM dbo.Sessoes_Membros 
			WHERE Membro_id = @ID);

GO

CREATE FUNCTION getAtendimentosListByMemberID (@ID int) RETURNS Table AS
	RETURN (SELECT Atendimento_ID, Data, Local, Tempo_despendido, Nome 
			FROM dbo.Atendimentos_Membros 
			WHERE Membro_ID = @ID);

GO

CREATE FUNCTION getOpSystemByID (@ID int) RETURNS Table AS
	RETURN (SELECT Nome, Versao 
			FROM SISTEMA_OPERATIVO 
			WHERE ID = @ID);

GO

CREATE FUNCTION getUtenteByID (@ID int) RETURNS Table AS
	RETURN (SELECT Nome, Contacto, Notas 
			FROM dbo.Utentes 
			WHERE dbo.Utentes.ID = @ID);

GO

CREATE FUNCTION getLastAtendimentoByUtenteID (@ID int) RETURNS Table AS
	RETURN (SELECT TOP 1 Atendimento_ID, Data, Fabricante, Modelo 
			FROM Atendimentos_Problemas_PC 
			WHERE Utente_id = @ID 
			ORDER BY Data);

GO

CREATE FUNCTION getProblemsByUtenteID (@ID int) RETURNS Table AS
	RETURN (SELECT Problema_ID, Data, Descricao, Fabricante, Modelo
			FROM dbo.Problemas_Utentes 
			WHERE Utente_id = @ID);

GO

CREATE FUNCTION getAtendimentosListByUtenteID (@ID int) RETURNS Table AS
	RETURN (SELECT DISTINCT Atendimento_ID,  Data, Fabricante, Modelo
			FROM Atendimentos_Problemas_PC 
			WHERE Utente_id = @ID);

GO

CREATE FUNCTION getAcessListByPlatformName (@Name varchar(30)) RETURNS Table AS
	RETURN (SELECT Username, ACESSO.Tipo as Tipo_Acesso, Nome, Email 
			FROM (ACESSO JOIN PESSOA ON ACESSO.Membro_id = PESSOA.ID) JOIN MEMBRO ON PESSOA.ID = MEMBRO.ID 
			WHERE ACESSO.Plataforma_nome = @Name);

GO

CREATE FUNCTION getMembersBySessionID (@ID int) RETURNS Table AS
	RETURN (SELECT Membro_id, Nome, Email, Data_entrada, Estado 
			FROM dbo.Membros as X JOIN dbo.PARTICIPACAO ON X.ID = Membro_id 
			WHERE Sessao_ID = @ID);

GO

CREATE FUNCTION getCoursesByDepName (@Name varchar(10)) RETURNS Table AS
	RETURN (SELECT Sigla
			FROM Curso 
			WHERE Departamento = @Name);

GO

CREATE FUNCTION getStudentByID (@ID INT) RETURNS Table AS
	RETURN (SELECT * 
			FROM ESTUDANTE JOIN CURSO ON Curso = Sigla
			WHERE ID = @ID);

GO

CREATE FUNCTION getMembroIDByEmail(@Email VARCHAR(40)) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	SELECT @res=ID
	FROM dbo.MEMBRO
	WHERE Email = @Email

	RETURN(@res)
END

GO

CREATE FUNCTION isFlashDrive(@ID INT) RETURNS INT AS
BEGIN
	DECLARE @res AS INT

	IF EXISTS(SELECT 1 FROM dbo.FLASH_DRIVE
          WHERE ID = @ID)
		RETURN 1;
    RETURN 0;
END

GO

CREATE FUNCTION isPersonAlsoStudent(@ID INT) RETURNS INT AS
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

CREATE FUNCTION getIdFromSystemOpName(@Name varchar(30), @Version varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
	IF @Version is NULL
		SET @ID = (SELECT ID FROM SISTEMA_OPERATIVO WHERE Nome = @Name);
	ELSE
		SET @ID = (SELECT ID FROM SISTEMA_OPERATIVO WHERE Nome = @Name and Versao = @Version);
    RETURN(@ID)
END

GO

CREATE FUNCTION getIdFromComponenteFabricante(@Fabricante varchar(30), @Modelo varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
    IF @Modelo is NULL
        SET @ID = (SELECT ID FROM COMPONENTE WHERE Fabricante = @Fabricante);
    ELSE
        SET @ID = (SELECT ID FROM COMPONENTE WHERE Fabricante = @Fabricante and Modelo = @Modelo);
    RETURN(@ID)
END

GO

CREATE FUNCTION getIdFromPCFabricante(@Fabricante varchar(30), @Modelo varchar(30)) RETURNS INT AS
BEGIN
    DECLARE @ID AS INT
    IF @Modelo is NULL
        SET @ID = (SELECT ID FROM PC WHERE Fabricante = @Fabricante);
    ELSE
        SET @ID = (SELECT ID FROM PC WHERE Fabricante = @Fabricante and Modelo = @Modelo);
    RETURN(@ID)
END


