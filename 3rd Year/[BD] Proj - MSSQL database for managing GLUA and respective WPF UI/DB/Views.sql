CREATE VIEW dbo.Atendimentos AS
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

CREATE VIEW dbo.Atendimentos_membros AS
SELECT        dbo.PRESTACAO.Atendimento_id, dbo.ATENDIMENTO.Data, dbo.ATENDIMENTO.Local, dbo.ATENDIMENTO.Tempo_despendido, dbo.PESSOA.Nome, dbo.PRESTACAO.Membro_id
FROM            dbo.PRESTACAO INNER JOIN
                         dbo.ATENDIMENTO ON dbo.PRESTACAO.Atendimento_id = dbo.ATENDIMENTO.ID INNER JOIN
                         dbo.PESSOA ON dbo.ATENDIMENTO.Utente_id = dbo.PESSOA.ID

GO

CREATE VIEW dbo.Atendimentos_Problemas_PC AS
SELECT        dbo.ATENDIMENTO.Data, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.TENTATIVA.Estado, dbo.PROBLEMA.Descricao, dbo.ATENDIMENTO.Utente_id, dbo.ATENDIMENTO.ID AS Atendimento_ID
FROM            dbo.ATENDIMENTO LEFT OUTER JOIN
                         dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID INNER JOIN
                         dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id INNER JOIN
                         dbo.PROBLEMA ON dbo.TENTATIVA.Problema_id = dbo.PROBLEMA.ID

GO

CREATE VIEW dbo.Componentes AS
SELECT        dbo.COMPONENTE.ID, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, COUNT(CASE WHEN dbo.PROBLEMA.ID IS NOT NULL THEN 1 END) AS num_problemas
FROM            dbo.COMPONENTE LEFT OUTER JOIN
                         dbo.PROBLEMA ON dbo.COMPONENTE.ID = dbo.PROBLEMA.Componente_id
GROUP BY dbo.COMPONENTE.ID, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo

GO

CREATE VIEW dbo.Equipamentos_FlashDrive_SistemaOp AS
SELECT        dbo.EQUIPAMENTO.ID, dbo.EQUIPAMENTO.Nome, dbo.EQUIPAMENTO.Estado, dbo.EQUIPAMENTO.Localizacao, dbo.EQUIPAMENTO.Membro_id, dbo.EQUIPAMENTO.Dador, dbo.EQUIPAMENTO.Descricao, 
                         dbo.FLASH_DRIVE.Fabricante, dbo.FLASH_DRIVE.Capacidade, dbo.FLASH_DRIVE.Velocidade, dbo.FLASH_DRIVE.Conteudo, dbo.SISTEMA_OPERATIVO.Nome AS SistemaOp_Nome, dbo.SISTEMA_OPERATIVO.Versao
FROM            dbo.EQUIPAMENTO INNER JOIN
                         dbo.FLASH_DRIVE ON dbo.EQUIPAMENTO.ID = dbo.FLASH_DRIVE.ID LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.FLASH_DRIVE.SO_id = dbo.SISTEMA_OPERATIVO.ID

GO

CREATE VIEW dbo.Equipamentos_FlashDrive_SistemaOp_Responsavel AS
SELECT        dbo.Equipamentos_FlashDrive_SistemaOp.ID, dbo.Equipamentos_FlashDrive_SistemaOp.Nome, dbo.Equipamentos_FlashDrive_SistemaOp.Estado, dbo.Equipamentos_FlashDrive_SistemaOp.Localizacao, 
                         dbo.Equipamentos_FlashDrive_SistemaOp.Dador, dbo.Equipamentos_FlashDrive_SistemaOp.Descricao, dbo.Equipamentos_FlashDrive_SistemaOp.Fabricante, dbo.Equipamentos_FlashDrive_SistemaOp.Capacidade, 
                         dbo.Equipamentos_FlashDrive_SistemaOp.Velocidade, dbo.Equipamentos_FlashDrive_SistemaOp.Conteudo, dbo.Equipamentos_FlashDrive_SistemaOp.Versao, dbo.PESSOA.Nome AS Membro_Nome, 
                         dbo.Equipamentos_FlashDrive_SistemaOp.SistemaOp_Nome
FROM            dbo.Equipamentos_FlashDrive_SistemaOp LEFT OUTER JOIN
                         dbo.PESSOA ON dbo.Equipamentos_FlashDrive_SistemaOp.Membro_id = dbo.PESSOA.ID

GO

CREATE VIEW dbo.Equipamentos_NaoFlashDrive AS
SELECT        dbo.EQUIPAMENTO.ID, dbo.EQUIPAMENTO.Nome, dbo.EQUIPAMENTO.Descricao, dbo.EQUIPAMENTO.Localizacao, dbo.EQUIPAMENTO.Estado, dbo.EQUIPAMENTO.Dador
FROM            dbo.EQUIPAMENTO LEFT OUTER JOIN
                         dbo.FLASH_DRIVE ON dbo.EQUIPAMENTO.ID = dbo.FLASH_DRIVE.ID
WHERE        (dbo.FLASH_DRIVE.ID IS NULL)

GO

CREATE VIEW dbo.Equipamentos_Responsaveis AS
SELECT        dbo.EQUIPAMENTO.ID, dbo.EQUIPAMENTO.Nome, dbo.EQUIPAMENTO.Estado, dbo.EQUIPAMENTO.Localizacao, dbo.PESSOA.Nome AS Membro_Nome, dbo.EQUIPAMENTO.Dador, dbo.EQUIPAMENTO.Descricao
FROM            dbo.PESSOA RIGHT OUTER JOIN
                         dbo.EQUIPAMENTO ON dbo.PESSOA.ID = dbo.EQUIPAMENTO.Membro_id

GO

CREATE VIEW dbo.Membros AS
SELECT        dbo.PESSOA.ID, dbo.PESSOA.Nome, dbo.MEMBRO.Num_telemovel, dbo.MEMBRO.Tipo, dbo.MEMBRO.Estado, dbo.MEMBRO.Data_entrada, dbo.PESSOA.Notas, dbo.MEMBRO.Email
FROM            dbo.MEMBRO INNER JOIN
                         dbo.PESSOA ON dbo.MEMBRO.ID = dbo.PESSOA.ID

GO

CREATE VIEW dbo.PCs AS
SELECT        dbo.PC.ID, dbo.PC.Fabricante, dbo.PC.Modelo, SUM(dbo.ATENDIMENTO.Tempo_despendido) AS Tempo_despendido, COUNT(CASE WHEN dbo.ATENDIMENTO.Tempo_despendido IS NOT NULL THEN 1 END) 
                         AS num_vistos
FROM            dbo.PC LEFT OUTER JOIN
                         dbo.ATENDIMENTO ON dbo.PC.ID = dbo.ATENDIMENTO.PC_id
GROUP BY dbo.PC.ID, dbo.PC.Fabricante, dbo.PC.Modelo

GO

CREATE VIEW dbo.Plataformas AS
SELECT        dbo.PLATAFORMA.Nome, dbo.PLATAFORMA.Link, dbo.PLATAFORMA.Descricao, COUNT(CASE WHEN dbo.ACESSO.Membro_id IS NOT NULL THEN 1 END) AS acessos_num
FROM            dbo.ACESSO RIGHT OUTER JOIN
                         dbo.PLATAFORMA ON dbo.ACESSO.Plataforma_nome = dbo.PLATAFORMA.Nome
GROUP BY dbo.PLATAFORMA.Nome, dbo.PLATAFORMA.Link, dbo.PLATAFORMA.Descricao

GO

CREATE VIEW dbo.Prestacoes AS
SELECT        dbo.PESSOA.Nome, dbo.PESSOA.ID, dbo.PRESTACAO.Atendimento_id
FROM            dbo.PESSOA INNER JOIN
                         dbo.PRESTACAO ON dbo.PESSOA.ID = dbo.PRESTACAO.Membro_id

GO

CREATE VIEW dbo.Problemas AS
SELECT        dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome AS SO, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, COUNT(DISTINCT dbo.TENTATIVA.Atendimento_id) 
                         AS atendimentos_num, COUNT(CASE WHEN dbo.TENTATIVA.Estado = 0 THEN 1 END) AS resolucoes_num, dbo.PROBLEMA.ID
FROM            dbo.PROBLEMA LEFT OUTER JOIN
                         dbo.TENTATIVA ON dbo.PROBLEMA.ID = dbo.TENTATIVA.Problema_id LEFT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.COMPONENTE ON dbo.PROBLEMA.Componente_id = dbo.COMPONENTE.ID
GROUP BY dbo.PROBLEMA.Descricao, dbo.SISTEMA_OPERATIVO.Nome, dbo.SISTEMA_OPERATIVO.Versao, dbo.COMPONENTE.Fabricante, dbo.COMPONENTE.Modelo, dbo.PROBLEMA.ID

GO

CREATE VIEW dbo.Problemas_Utentes AS
SELECT        dbo.ATENDIMENTO.Data, dbo.PROBLEMA.Descricao, dbo.PC.Fabricante, dbo.PC.Modelo, dbo.ATENDIMENTO.Utente_id, dbo.PROBLEMA.ID AS Problema_ID
FROM            dbo.ATENDIMENTO INNER JOIN
                         dbo.PC ON dbo.ATENDIMENTO.PC_id = dbo.PC.ID INNER JOIN
                         dbo.TENTATIVA ON dbo.ATENDIMENTO.ID = dbo.TENTATIVA.Atendimento_id INNER JOIN
                         dbo.PROBLEMA ON dbo.TENTATIVA.Problema_id = dbo.PROBLEMA.ID

GO

CREATE VIEW dbo.Sessoes AS
SELECT        j.ID, j.Data, j.Local, j.Num_previstos, j.atendimentos_num, COUNT(CASE WHEN dbo.PARTICIPACAO.Membro_id IS NOT NULL THEN 1 END) AS membros_num
FROM            dbo.PARTICIPACAO RIGHT OUTER JOIN
                             (SELECT        dbo.SESSAO.ID, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.SESSAO.Num_previstos, COUNT(CASE WHEN dbo.ATENDIMENTO.ID IS NOT NULL THEN 1 END) AS atendimentos_num
                               FROM            dbo.SESSAO LEFT OUTER JOIN
                                                         dbo.ATENDIMENTO ON dbo.SESSAO.ID = dbo.ATENDIMENTO.Sessao_id
                               GROUP BY dbo.SESSAO.ID, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.SESSAO.Num_previstos) AS j ON dbo.PARTICIPACAO.Sessao_id = j.ID
GROUP BY j.ID, j.Data, j.Local, j.Num_previstos, j.atendimentos_num

GO

CREATE VIEW dbo.Sessoes_Membros AS
SELECT        dbo.SESSAO.ID, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.SESSAO.Num_previstos, COUNT(*) AS Num_realizados, dbo.PARTICIPACAO.Membro_id
FROM            dbo.PARTICIPACAO INNER JOIN
                         dbo.SESSAO ON dbo.PARTICIPACAO.Sessao_id = dbo.SESSAO.ID INNER JOIN
                         dbo.ATENDIMENTO ON dbo.PARTICIPACAO.Sessao_id = dbo.ATENDIMENTO.Sessao_id
GROUP BY dbo.SESSAO.ID, dbo.SESSAO.Data, dbo.SESSAO.Local, dbo.SESSAO.Num_previstos, dbo.PARTICIPACAO.Membro_id

GO

CREATE VIEW dbo.SistemasOperativos AS
SELECT        dbo.SISTEMA_OPERATIVO.ID, dbo.SISTEMA_OPERATIVO.Nome, dbo.SISTEMA_OPERATIVO.Versao, COUNT(CASE WHEN dbo.FLASH_DRIVE.ID IS NOT NULL THEN 1 END) AS flashDrives_num, 
                         COUNT(CASE WHEN dbo.PROBLEMA.ID IS NOT NULL THEN 1 END) AS problems_num
FROM            dbo.PROBLEMA RIGHT OUTER JOIN
                         dbo.SISTEMA_OPERATIVO ON dbo.PROBLEMA.SO_id = dbo.SISTEMA_OPERATIVO.ID LEFT OUTER JOIN
                         dbo.FLASH_DRIVE ON dbo.SISTEMA_OPERATIVO.ID = dbo.FLASH_DRIVE.SO_id
GROUP BY dbo.SISTEMA_OPERATIVO.ID, dbo.SISTEMA_OPERATIVO.Nome, dbo.SISTEMA_OPERATIVO.Versao

GO

CREATE VIEW dbo.Tentativas AS
SELECT        dbo.TENTATIVA.Problema_id, dbo.TENTATIVA.Atendimento_id, dbo.TENTATIVA.Estado, dbo.TENTATIVA.Procedimento, dbo.ATENDIMENTO.Data
FROM            dbo.TENTATIVA LEFT OUTER JOIN
                         dbo.ATENDIMENTO ON dbo.TENTATIVA.Atendimento_id = dbo.ATENDIMENTO.ID

GO

CREATE VIEW dbo.Topicos AS
SELECT        dbo.TOPICO.Nome, COUNT(CASE WHEN dbo.TOPICO_PROBLEMA.Problema_id IS NOT NULL THEN 1 END) AS problemas_num, dbo.TOPICO.ID
FROM            dbo.TOPICO LEFT OUTER JOIN
                         dbo.TOPICO_PROBLEMA ON dbo.TOPICO.ID = dbo.TOPICO_PROBLEMA.Topico_id
GROUP BY dbo.TOPICO.Nome, dbo.TOPICO.ID

GO

CREATE VIEW dbo.Utentes AS
SELECT        dbo.PESSOA.Nome, dbo.UTENTE.Contacto, dbo.PESSOA.Notas, dbo.UTENTE.ID
FROM            dbo.PESSOA INNER JOIN
                         dbo.UTENTE ON dbo.PESSOA.ID = dbo.UTENTE.ID