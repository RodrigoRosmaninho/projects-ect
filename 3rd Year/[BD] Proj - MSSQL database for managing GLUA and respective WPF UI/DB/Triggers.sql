CREATE TRIGGER addMembro ON dbo.MEMBRO
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

CREATE TRIGGER deleteMembro ON dbo.MEMBRO
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

CREATE TRIGGER deleteUtente ON dbo.UTENTE
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

CREATE TRIGGER deleteFlashDrive ON dbo.FLASH_DRIVE
AFTER DELETE
AS
BEGIN
    DECLARE @ID INT;
    SELECT @ID=ID FROM deleted;
    DELETE FROM dbo.EQUIPAMENTO WHERE ID = @ID
END