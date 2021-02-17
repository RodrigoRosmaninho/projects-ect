--Queries feitas ao longo do projeto

--Atendimento
SELECT DISTINCT Fabricante FROM dbo.PC;
SELECT * FROM dbo.getAtendimentoByID( @id );
SELECT * FROM dbo.getProblemsByAtendimentoID( @id )
SELECT Pessoa.ID as ID, Nome, Contacto, Notas FROM Utente JOIN Pessoa ON Utente.ID = Pessoa.ID;
DELETE FROM ATENDIMENTO WHERE ID = {};
EXEC ModifyAtendimentos {}, {}, {}, {}, {}, {}, {};
SELECT * FROM getPCsByFabricante (@Fabricante);

--Atendimentos

SELECT * FROM dbo.Atendimentos;

--Componente

DELETE FROM COMPONENTE WHERE ID = {};
EXEC ModifyComponente {}, {}, {}
SELECT * FROM getComponenteByID ( @ID );

--Componentes 

SELECT * FROM dbo.Componentes;


--DB

SELECT dbo.getMembroIDByEmail( @Email );
SELECT dbo.getIdFromSystemOpName( @OSName , @VersionName );
SELECT dbo.getIdFromComponenteFabricante( @Fabricante , @Modelo );
SELECT dbo.getIdFromPCFabricante( @Fabricante , @Modelo );

--Equipamento 

SELECT * FROM dbo.getEquipmentByID( @ID );
SELECT * FROM dbo.MEMBROS WHERE Estado = 1;
DELETE FROM EQUIPAMENTO WHERE ID = {};
EXEC ModifyEquipamento {}, {}, {}, {}, {}, {}, {};

--Equipamentos

SELECT * FROM dbo.Equipamentos_NaoFlashDrive;
SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp;


--Estatisticas

SELECT * FROM getOSStats();
SELECT * FROM getCursoStats();
SELECT * FROM getPCStats();
SELECT TOP 8 * FROM getComponenteStats();
SELECT * FROM getMonthStats();

--Flash-Drive

SELECT DISTINCT Nome FROM dbo.SISTEMA_OPERATIVO;
SELECT * FROM dbo.getFlashDrivesByID( @ID );
DELETE FROM FLASH_DRIVE WHERE ID = {};
EXEC ModifyFlashDrive {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {};
SELECT DISTINCT Nome FROM dbo.SISTEMA_OPERATIVO;
SELECT * FROM getSystemVersionByName ( @OS );
SELECT * FROM dbo.MEMBROS WHERE Estado = 1

--MainWindow

SELECT * FROM getMembersBySessionID( @ID ); 
SELECT * FROM getMembersByAtendimentoID( @ID );
DELETE FROM PARTICIPACAO WHERE Sessao_id = {};
INSERT INTO PARTICIPACAO VALUES ( {}, {} );
DELETE FROM PRESTACAO WHERE Atendimento_id = {};
INSERT INTO PRESTACAO VALUES ( {}, {} );
INSERT INTO ACESSO VALUES ({}, {}, {}, {});
UPDATE ACESSO SET Username = {}, Tipo = {} WHERE Plataforma_nome = {} and Membro_id = {};
DELETE FROM ACESSO WHERE Plataforma_nome = {} and Membro_id = {}; 
EXEC ModifyCurso {}, {};

--Membro

SELECT * FROM getMembersByID ( @ID );
SELECT dbo.isPersonAlsoStudent( @ID );
SELECT * FROM getStudentByID ( @ID );
SELECT * FROM getPlataformsAcessListByMembersID ( @ID ) ORDER BY Plataforma_nome;
SELECT Nome FROM dbo.PLATAFORMA ORDER BY Nome;
SELECT * FROM getEquipmentListByMemberID ( @ID ) ORDER BY ID;
SELECT * FROM getHelpSessionsListByMemberID ( @ID ) ORDER BY Data DESC;
SELECT * FROM getAtendimentosListByMemberID ( @ID ) ORDER BY Data DESC;
DELETE FROM MEMBRO WHERE ID = {};
EXEC ModifyMembro {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {};
SELECT * FROM getCoursesByDepName ( @Dep );
SELECT DISTINCT Departamento FROM Curso

--Membros

SELECT * FROM dbo.Membros ORDER BY Estado DESC, Tipo ASC, Data_entrada ASC;


--PC

DELETE FROM PC WHERE ID = {};
EXEC ModifyPC {}, {}, {};
SELECT * FROM getPCByID ( @ID );

--PCs

SELECT * FROM dbo.PCs;

--Perfil

EXEC ModifyAccount {}, {};

--Plataforma

DELETE FROM PLATAFORMA WHERE Nome = {};
EXEC UpdatePlataformas {}, {}, {}, {};
SELECT * FROM getPlatformByName ( @Name );
SELECT * FROM getAcessListByPlatformName( @Name );
EXEC InsertPlataformas {}, {}, {}

--Plataformas

SELECT * FROM dbo.Plataformas ORDER BY Nome;

--Problema

SELECT DISTINCT Fabricante FROM dbo.COMPONENTE;
SELECT DISTINCT Nome FROM dbo.SISTEMA_OPERATIVO;
SELECT * FROM dbo.getProblemByID( @ID );
SELECT * FROM dbo.getAttemptsByProblemID( @ID );
DELETE FROM PROBLEMA WHERE ID = {};
EXEC ModifyProblemas {}, {}, {}, {}
SELECT * FROM getComponentesByFabricante ( @Fabricante );
SELECT * FROM getSystemVersionByName ( @OS );

--Problemas

SELECT * FROM dbo.Problemas;

--Sessao

DELETE FROM SESSAO WHERE ID = {};
EXEC ModifySessoes {}, {}, {}, {};
SELECT Data, Local, Num_previstos FROM getHelpdeskByID("+ id +") ORDER BY Data DESC;
SELECT * FROM getMembersBySessionID( @ID );
SELECT * FROM getAtendimentosByHelpdeskID( @ID );
EXEC ModifySessoes {}, {}, {}, {};

--Sessoes

SELECT * FROM dbo.SESSOES ORDER BY Data DESC;

--SistemaOp

DELETE FROM SISTEMA_OPERATIVO WHERE ID = {};
EXEC ModifySistemaOperativo {}, {}, {};
SELECT * FROM getOpSystemByID ( @ID );

--SistemasOps

SELECT * FROM SistemasOperativos ORDER BY Nome ASC;

--Tentativa

DELETE FROM TENTATIVA WHERE Problema_ID = {} AND Atendimento_ID = {};
EXEC ModifyTentativa {}, {}, {}, {};
SELECT * FROM getAttemptByIDs ( @pid , @aid );

--Topico

DELETE FROM TOPICO WHERE ID = {};
EXEC ModifyTopico {}, {};
SELECT * FROM TOPICOS WHERE ID = @ID;
SELECT * FROM dbo.getProblemsByTopic( @Nome ) ORDER BY atendimentos_num DESC;

--Topicos

SELECT * FROM TOPICOS ORDER BY problemas_num DESC;

--Utente

SELECT DISTINCT Departamento FROM Curso;
EXEC ModifyUtente {}, {}, {}, {}, {}, {}, {}, {};
SELECT * FROM getCoursesByDepName ( @Dep );
SELECT DISTINCT Departamento FROM Curso;
SELECT * FROM getUtenteByID ( @ID );
SELECT DISTINCT Departamento FROM Curso;
SELECT dbo.isPersonAlsoStudent( @ID );
SELECT * FROM getStudentByID ( @ID );
EXEC ModifyUtente {}, {}, {}, {}, {}, {}, {}, {};
SELECT * FROM getLastAtendimentoByUtenteID ( @ID ) ORDER BY Data;
SELECT * FROM getProblemsByUtenteID ( @ID );
SELECT * FROM getAtendimentosListByUtenteID ( @ID ) ORDER BY Data;
DELETE FROM UTENTE WHERE ID = {};

--Utentes

SELECT Pessoa.ID as ID, Nome, Contacto, Notas FROM Utente JOIN Pessoa ON Utente.ID = Pessoa.ID;

-- Queries de inserção geradas automaticamente por plataformas web

INSERT INTO Pessoa(Nome, Notas) VALUES('Anthony','nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam'),('Zachary','amet, faucibus ut, nulla. Cras eu tellus eu augue porttitor'),('Griffith','a, facilisis non, bibendum sed, est. Nunc laoreet lectus quis'),('Lamar','sed orci lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam'),('Geoffrey','tincidunt, nunc ac mattis ornare, lectus ante dictum mi, ac'),('Garrison','ullamcorper eu, euismod ac, fermentum vel, mauris. Integer sem elit,'),('Troy','dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam'),('James','feugiat placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam'),('Carter','et risus. Quisque libero lacus, varius et, euismod et, commodo'),('Dante','Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat velit.');
INSERT INTO Pessoa(Nome, Notas) VALUES('Evan','ultrices sit amet, risus. Donec nibh enim, gravida sit amet,'),('Walter','tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed'),('Chester','diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget,'),('Steven','malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam'),('Merrill','ac facilisis facilisis, magna tellus faucibus leo, in lobortis tellus'),('Hashim','rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at,'),('Mason','purus. Nullam scelerisque neque sed sem egestas blandit. Nam nulla'),('Slade','lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum'),('Seth','et, rutrum eu, ultrices sit amet, risus. Donec nibh enim,'),('Quamar','ante. Nunc mauris sapien, cursus in, hendrerit consectetuer, cursus et,');
INSERT INTO Pessoa(Nome, Notas) VALUES('Tobias','non justo. Proin non massa non ante bibendum ullamcorper. Duis'),('Dillon','non, lobortis quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper'),('Sebastian','non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec'),('Harding','non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum'),('Steven','diam dictum sapien. Aenean massa. Integer vitae nibh. Donec est'),('William','est, vitae sodales nisi magna sed dui. Fusce aliquam, enim'),('Felix','amet, dapibus id, blandit at, nisi. Cum sociis natoque penatibus'),('Elijah','enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus.'),('Hayden','Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi'),('Kadeem','vel, convallis in, cursus et, eros. Proin ultrices. Duis volutpat');
INSERT INTO Pessoa(Nome, Notas) VALUES('Rudyard','urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat'),('Abbot','odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque'),('Hu','ut eros non enim commodo hendrerit. Donec porttitor tellus non'),('Bert','vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu.'),('Ferdinand','quam. Curabitur vel lectus. Cum sociis natoque penatibus et magnis'),('Rooney','sit amet, faucibus ut, nulla. Cras eu tellus eu augue'),('Ciaran','auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus,'),('Beck','In lorem. Donec elementum, lorem ut aliquam iaculis, lacus pede'),('Alden','porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris'),('Gil','cubilia Curae; Donec tincidunt. Donec vitae erat vel pede blandit');
INSERT INTO Pessoa(Nome, Notas) VALUES('Connor','tortor, dictum eu, placerat eget, venenatis a, magna. Lorem ipsum'),('Preston','et libero. Proin mi. Aliquam gravida mauris ut mi. Duis'),('Eric','ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin'),('Slade','magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac'),('Amery','quis diam. Pellentesque habitant morbi tristique senectus et netus et'),('Emery','dictum augue malesuada malesuada. Integer id magna et ipsum cursus'),('Wang','sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam'),('Russell','dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae,'),('Berk','Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique'),('Xanthus','tellus, imperdiet non, vestibulum nec, euismod in, dolor. Fusce feugiat.');
INSERT INTO Pessoa(Nome, Notas) VALUES('Ray','conubia nostra, per inceptos hymenaeos. Mauris ut quam vel sapien'),('Adam','convallis, ante lectus convallis est, vitae sodales nisi magna sed'),('Cullen','dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu'),('Ross','enim non nisi. Aenean eget metus. In nec orci. Donec'),('Channing','nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse'),('Thaddeus','pede. Cum sociis natoque penatibus et magnis dis parturient montes,'),('Amos','odio a purus. Duis elementum, dui quis accumsan convallis, ante'),('Silas','tincidunt dui augue eu tellus. Phasellus elit pede, malesuada vel,'),('Denton','ligula elit, pretium et, rutrum non, hendrerit id, ante. Nunc'),('Grant','tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem, sit');
INSERT INTO Pessoa(Nome, Notas) VALUES('Cairo','non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec'),('Isaac','fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed'),('Michael','ultrices. Duis volutpat nunc sit amet metus. Aliquam erat volutpat.'),('Jasper','Curabitur vel lectus. Cum sociis natoque penatibus et magnis dis'),('Lane','hendrerit neque. In ornare sagittis felis. Donec tempor, est ac'),('Griffith','pellentesque eget, dictum placerat, augue. Sed molestie. Sed id risus'),('Cedric','Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula.'),('Cooper','molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est,'),('Ali','parturient montes, nascetur ridiculus mus. Donec dignissim magna a tortor.'),('Xavier','enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec sollicitudin');
INSERT INTO Pessoa(Nome, Notas) VALUES('Ulysses','viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum'),('Porter','tellus. Suspendisse sed dolor. Fusce mi lorem, vehicula et, rutrum'),('Travis','adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis'),('Camden','odio a purus. Duis elementum, dui quis accumsan convallis, ante'),('Lev','arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing.'),('Jacob','est tempor bibendum. Donec felis orci, adipiscing non, luctus sit'),('Alan','vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend'),('Magee','mollis. Duis sit amet diam eu dolor egestas rhoncus. Proin'),('Alvin','odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus.'),('Dalton','nulla. Integer vulputate, risus a ultricies adipiscing, enim mi tempor');
INSERT INTO Pessoa(Nome, Notas) VALUES('Ronan','nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras'),('Jacob','Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit,'),('Hakeem','ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum'),('Plato','egestas. Duis ac arcu. Nunc mauris. Morbi non sapien molestie'),('Elmo','magna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam'),('Upton','Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi pede,'),('Vladimir','Donec egestas. Duis ac arcu. Nunc mauris. Morbi non sapien'),('Tobias','enim mi tempor lorem, eget mollis lectus pede et risus.'),('Neil','ante dictum mi, ac mattis velit justo nec ante. Maecenas'),('Giacomo','et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu.');
INSERT INTO Pessoa(Nome, Notas) VALUES('Camden','ac mattis semper, dui lectus rutrum urna, nec luctus felis'),('Scott','faucibus ut, nulla. Cras eu tellus eu augue porttitor interdum.'),('Tyrone','Aliquam tincidunt, nunc ac mattis ornare, lectus ante dictum mi,'),('Stone','Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero. Integer'),('Hayden','enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida.'),('Igor','ac metus vitae velit egestas lacinia. Sed congue, elit sed'),('Elijah','orci luctus et ultrices posuere cubilia Curae; Phasellus ornare. Fusce'),('Keegan','mi. Duis risus odio, auctor vitae, aliquet nec, imperdiet nec,'),('Prescott','tortor, dictum eu, placerat eget, venenatis a, magna. Lorem ipsum'),('Scott','convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor, dictum');

INSERT INTO CURSO(Sigla, Departamento) VALUES('consequat','arcu'),('ac,','massa.'),('cursus','Nunc'),('varius','Cum'),('Nullam','Nam'),('bibendum','Etiam'),('vulputate,','lorem'),('auctor','euismod'),('Phasellus','viverra.'),('et','ante.');
INSERT INTO CURSO(Sigla, Departamento) VALUES('habitant','euismod'),('Fusce','eleifend.'),('quis','neque'),('pharetra','diam.'),('Donec','et'),('eleifend,','felis.'),('mauris','tincidunt'),('nisl.','purus'),('Quisque','ac'),('nulla','velit');

INSERT INTO ESTUDANTE(ID,Nmec,Curso,Ano_matricula) VALUES(31,80300,'auctor','2020-04-29'),(32,80310,'Nullam','2019-05-18'),(33,80320,'habitant','2019-10-26'),(34,80330,'et','2020-04-26'),(35,80340,'Phasellus','2020-03-09'),(36,80350,'Quisque','2020-01-23'),(37,80360,'pharetra','2019-10-19'),(38,80370,'Donec','2020-02-29'),(39,80380,'habitant','2019-11-30'),(40,80390,'et','2019-06-19');
INSERT INTO ESTUDANTE(ID,Nmec,Curso,Ano_matricula) VALUES(71,80700,'et','2019-05-19'),(72,80710,'mauris','2019-06-20'),(73,80720,'Phasellus','2019-07-18'),(74,80730,'Fusce','2020-03-06'),(75,80740,'Donec','2019-09-12'),(76,80750,'quis','2019-06-20'),(77,80760,'Nullam','2019-07-31'),(78,80770,'mauris','2019-12-07'),(79,80780,'consequat','2019-06-26'),(80,80790,'mauris','2019-06-07');
INSERT INTO ESTUDANTE(ID,Nmec,Curso,Ano_matricula) VALUES(81,80800,'Quisque','2019-11-11'),(82,80810,'varius','2019-05-12'),(83,80820,'varius','2019-09-04'),(84,80830,'nulla','2020-01-02'),(85,80840,'et','2020-03-25'),(86,80850,'nisl.','2019-12-10'),(87,80860,'Donec','2020-02-06'),(88,80870,'auctor','2020-01-07'),(89,80880,'Phasellus','2020-05-02'),(90,80890,'habitant','2019-07-05');
INSERT INTO ESTUDANTE(ID,Nmec,Curso,Ano_matricula) VALUES(91,80900,'habitant','2019-12-10'),(92,80910,'habitant','2020-05-01'),(93,80920,'et','2019-05-25'),(94,80930,'Fusce','2019-12-28'),(95,80940,'bibendum','2019-11-21'),(96,80950,'quis','2020-01-14'),(97,80960,'bibendum','2019-09-04'),(98,80970,'cursus','2020-03-20'),(99,80980,'varius','2019-08-03'),(100,80990,'quis','2019-08-24');

INSERT INTO UTENTE (ID, Contacto) VALUES (1, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (2, 'mcolbertson1@redcross.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (3, 'sbofield2@e-recht24.de');
INSERT INTO UTENTE (ID, Contacto) VALUES (4, 'jelder3@bbc.co.uk');
INSERT INTO UTENTE (ID, Contacto) VALUES (5, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (6, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (7, 'odehooge6@archive.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (8, 'ehallgate7@yellowbook.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (9, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (10, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (11, 'hgredera@dmoz.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (12, 'rdulakeb@cam.ac.uk');
INSERT INTO UTENTE (ID, Contacto) VALUES (13, 'pcastellanc@hexun.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (14, 'omcgeneayd@nhs.uk');
INSERT INTO UTENTE (ID, Contacto) VALUES (15, 'kmellerse@ucoz.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (16, 'vedinburoughf@amazon.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (17, 'mdianog@hao123.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (18, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (19, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (20, 'ctunnowj@auda.org.au');
INSERT INTO UTENTE (ID, Contacto) VALUES (21, 'bperesk@tripod.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (22, 'rgowryl@dropbox.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (23, 'rivanishinm@jalbum.net');
INSERT INTO UTENTE (ID, Contacto) VALUES (24, 'mkerranen@umich.edu');
INSERT INTO UTENTE (ID, Contacto) VALUES (25, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (26, 'cmasdonp@tinyurl.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (27, 'rsuddabyq@prlog.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (28, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (29, 'eketchasides@bigcartel.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (30, 'cnovict@zdnet.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (31, 'jsandcroftu@timesonline.co.uk');
INSERT INTO UTENTE (ID, Contacto) VALUES (32, 'jtithacottv@printfriendly.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (33, 'tduredenw@jugem.jp');
INSERT INTO UTENTE (ID, Contacto) VALUES (34, 'bfarnallx@comcast.net');
INSERT INTO UTENTE (ID, Contacto) VALUES (35, 'mmcdermidy@1688.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (36, 'calibertiz@linkedin.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (37, 'araittie10@uol.com.br');
INSERT INTO UTENTE (ID, Contacto) VALUES (38, 'scram11@google.es');
INSERT INTO UTENTE (ID, Contacto) VALUES (39, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (40, 'orosten13@shop-pro.jp');
INSERT INTO UTENTE (ID, Contacto) VALUES (41, 'dculligan14@dion.ne.jp');
INSERT INTO UTENTE (ID, Contacto) VALUES (42, 'esandels15@nps.gov');
INSERT INTO UTENTE (ID, Contacto) VALUES (43, 'mgibbard16@sourceforge.net');
INSERT INTO UTENTE (ID, Contacto) VALUES (44, 'fkentwell17@cnn.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (45, 'dtwittey18@ted.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (46, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (47, 'yaustins1a@eventbrite.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (48, 'bhughs1b@hexun.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (49, 'tthoma1c@google.co.uk');
INSERT INTO UTENTE (ID, Contacto) VALUES (50, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (51, 'cminchindon1e@gov.uk');
INSERT INTO UTENTE (ID, Contacto) VALUES (52, 'cmorrissey1f@goo.gl');
INSERT INTO UTENTE (ID, Contacto) VALUES (53, 'rquantrill1g@typepad.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (54, 'loloughane1h@free.fr');
INSERT INTO UTENTE (ID, Contacto) VALUES (55, 'cbeare1i@pinterest.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (56, 'sseabon1j@epa.gov');
INSERT INTO UTENTE (ID, Contacto) VALUES (57, 'wfoley1k@cnet.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (58, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (59, 'lcodd1m@ow.ly');
INSERT INTO UTENTE (ID, Contacto) VALUES (60, 'mreinhardt1n@nymag.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (61, 'adysart1o@linkedin.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (62, 'cwingeat1p@jimdo.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (63, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (64, 'dpilsbury1r@about.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (65, 'dgrollmann1s@xinhuanet.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (66, 'lcanto1t@state.gov');
INSERT INTO UTENTE (ID, Contacto) VALUES (67, 'caristide1u@tripadvisor.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (68, 'vgaveltone1v@gizmodo.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (69, 'yvallintine1w@creativecommons.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (70, 'maddenbrooke1x@intel.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (71, 'spetyanin1y@earthlink.net');
INSERT INTO UTENTE (ID, Contacto) VALUES (72, 'clawles1z@skyrock.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (73, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (74, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (75, 'eoxe22@adobe.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (76, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (77, 'kpresnall24@bing.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (78, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (79, 'driep26@techcrunch.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (80, 'mburtt27@vistaprint.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (81, 'dbracknall28@csmonitor.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (82, 'mbrignall29@unesco.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (83, 'bdanelet2a@buzzfeed.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (84, 'gkenvin2b@google.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (85, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (86, 'utesoe2d@bbb.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (87, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (88, 'pskeeles2f@qq.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (89, 'fquarton2g@nbcnews.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (90, 'atidbold2h@edublogs.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (91, null);
INSERT INTO UTENTE (ID, Contacto) VALUES (92, 'wvanweedenburg2j@noaa.gov');
INSERT INTO UTENTE (ID, Contacto) VALUES (93, 'tklug2k@networkadvertising.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (94, 'kdavidof2l@icio.us');
INSERT INTO UTENTE (ID, Contacto) VALUES (95, 'lbramelt2m@senate.gov');
INSERT INTO UTENTE (ID, Contacto) VALUES (96, 'pperle2n@intel.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (97, 'cbellie2o@ca.gov');
INSERT INTO UTENTE (ID, Contacto) VALUES (98, 'ryvon2p@gnu.org');
INSERT INTO UTENTE (ID, Contacto) VALUES (99, 'bhannaway2q@ucoz.com');
INSERT INTO UTENTE (ID, Contacto) VALUES (100, 'ktassell2r@virginia.edu');

INSERT INTO SESSAO([Data],[Local],[Num_previstos]) VALUES('2019-06-02 10:56:29','mauris elit,',2),('2019-08-05 06:35:19','molestie. Sed',0),('2019-10-04 17:14:16','dui. Cum',0),('2019-10-11 20:35:23','Aenean gravida',3),('2019-08-03 23:58:35','eget massa.',5),('2019-05-02 03:11:43','erat eget',2),('2019-10-30 02:16:09','semper auctor.',3),('2019-08-17 20:25:25','quis, pede.',4),('2019-12-08 03:19:07','posuere at,',0),('2019-10-16 03:25:15','semper tellus',0);
INSERT INTO SESSAO([Data],[Local],[Num_previstos]) VALUES('2019-08-07 16:39:20','scelerisque mollis.',0),('2019-07-15 17:42:48','dui. Fusce',2),('2019-09-20 11:40:52','molestie orci',1),('2019-11-07 11:05:02','Vestibulum ante',5),('2019-05-18 00:55:53','at risus.',2),('2019-06-28 09:08:43','elit pede,',6),('2019-11-03 23:41:39','sed dui.',5),('2019-09-29 09:50:58','dui, nec',1),('2019-06-10 14:00:19','vestibulum. Mauris',5),('2019-11-27 18:02:13','orci tincidunt',1);
INSERT INTO SESSAO([Data],[Local],[Num_previstos]) VALUES('2020-02-22 16:54:48','arcu.',0),('2020-01-17 04:49:59','nec',6),('2019-07-27 21:16:26','Integer in',0),('2019-11-06 13:08:57','aliquam',7),('2019-09-26 14:54:30','Pellentesque',1),('2020-01-26 12:46:01','vel',3),('2019-09-23 13:44:50','netus',5),('2020-03-02 02:36:24','est',7),('2019-08-24 14:25:42','Duis dignissim',3),('2020-01-21 18:31:59','ullamcorper. Duis',5);
INSERT INTO SESSAO([Data],[Local],[Num_previstos]) VALUES('2019-11-27 02:08:51','rutrum',8),('2020-01-01 13:23:15','Aliquam gravida',1),('2020-02-27 12:31:00','metus sit',8),('2019-05-18 19:54:52','aliquet. Proin',5),('2019-10-29 14:30:52','mauris ut',6),('2019-06-25 18:28:45','orci.',3),('2020-03-09 06:35:56','dui.',4),('2020-03-09 17:22:56','et',4),('2020-02-20 03:38:14','fermentum metus.',0),('2019-09-18 05:20:51','Donec at',7);

INSERT INTO PC (Fabricante, Modelo) VALUES ('Samsung', 'Corvette');
INSERT INTO PC (Fabricante, Modelo) VALUES ('MSI', null);
INSERT INTO PC (Fabricante, Modelo) VALUES ('HP', 'Challenger');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Samsung', 'Spirit');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Samsung', 'Patriot');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Lenovo', 'Regal');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Lenovo', null);
INSERT INTO PC (Fabricante, Modelo) VALUES ('Lenovo', 'QX');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Asus', '928');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Apple', 'Silverado 1500');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Asus', 'TT');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Lenovo', 'Sprinter 2500');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Asus', null);
INSERT INTO PC (Fabricante, Modelo) VALUES ('Lenovo', 'Series 1');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Samsung', null);
INSERT INTO PC (Fabricante, Modelo) VALUES ('Acer', 'Tacoma');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Lenovo', 'M3');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Dell', 'C70');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Samsung', 'Sienna');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Lenovo', 'GTI');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Microsoft', null);
INSERT INTO PC (Fabricante, Modelo) VALUES ('MSI', 'Bonneville');
INSERT INTO PC (Fabricante, Modelo) VALUES ('LG', null);
INSERT INTO PC (Fabricante, Modelo) VALUES ('Dell', 'Skylark');
INSERT INTO PC (Fabricante, Modelo) VALUES ('HP', 'Grand Marquis');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Samsung', '929');
INSERT INTO PC (Fabricante, Modelo) VALUES ('HP', 'SRX');
INSERT INTO PC (Fabricante, Modelo) VALUES ('HP', 'Aveo');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Apple', 'H1');
INSERT INTO PC (Fabricante, Modelo) VALUES ('Lenovo', 'Expedition');

INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-23 13:44:50.000', 'consequat', 34, 9, null, 51);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-05 06:35:19.000', 'vel dapibus at', 32, 17, 2, 39);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-07 11:05:02.000', 'adipiscing', 91, 3, null, 100);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-12-08 03:19:07.000', 'mauris enim', 3, 2, 5, 49);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-26 12:46:01.000', 'mattis odio', 51, 25, 14, 58);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-06 13:08:57.000', 'non velit donec', 88, 3, 2, 63);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-11 20:35:23.000', 'felis sed lacus', 21, 23, 19, 94);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-12-08 03:19:07.000', 'vel est donec', 93, 12, null, 85);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-15 17:42:48.000', 'eu', 36, 26, null, 24);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 18:02:13.000', null, null, null, 9, 21);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-26 12:46:01.000', 'dictumst etiam faucibus', 95, 5, 13, 61);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-21 18:31:59.000', 'duis', 91, 30, null, 1);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-09 06:35:56.000', 'ultrices', 66, 25, null, 2);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-29 14:30:52.000', 'ipsum dolor sit', 53, 13, 6, 14);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-24 14:25:42.000', 'non lectus aliquam', 98, 11, 20, 62);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-16 03:25:15.000', null, null, null, 17, 29);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-17 04:49:59.000', 'sem', 2, 5, 13, 20);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-26 12:46:01.000', 'lorem quisque ut', 50, 3, null, 37);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-27 12:31:00.000', 'pede malesuada', 35, 20, null, 49);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-10 14:00:19.000', 'consequat', 96, 18, 10, 12);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-30 02:16:09.000', 'vel', 66, 10, 14, 63);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-29 09:50:58.000', 'dapibus', 74, 20, 10, 2);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-20 03:38:14.000', 'lacus morbi', 40, 27, null, 81);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-30 02:16:09.000', 'ipsum primis', 33, 14, null, 28);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-05 06:35:19.000', 'pellentesque quisque', 10, 11, 5, 65);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-25 18:28:45.000', 'augue vestibulum rutrum', 60, 15, 3, 8);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-21 18:31:59.000', 'leo odio', 112, 12, null, 21);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-03 23:41:39.000', 'accumsan', 4, 16, null, 59);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-03 23:41:39.000', 'vestibulum rutrum', 111, 8, 10, 63);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 00:55:53.000', 'primis', 112, 17, 8, 91);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-11 20:35:23.000', 'blandit non', 99, 28, null, 38);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-20 11:40:52.000', 'ridiculus', 26, 2, 17, 85);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-06 13:08:57.000', 'pellentesque viverra', 83, 26, 5, 64);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-15 17:42:48.000', 'justo', 46, 25, null, 63);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-22 16:54:48.000', 'non ligula pellentesque', 64, 15, 9, 81);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-05 06:35:19.000', 'duis ac nibh', 107, 26, 2, 48);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-10 14:00:19.000', 'duis mattis egestas', 47, 14, 2, 12);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-01 13:23:15.000', 'turpis', 53, 8, null, 29);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-01 13:23:15.000', 'pellentesque ultrices', 79, 8, 11, 17);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-02 02:36:24.000', 'nisi venenatis', 29, 20, null, 11);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-06 13:08:57.000', null, null, null, null, 87);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'sapien cursus vestibulum', 64, 13, null, 32);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-26 14:54:30.000', 'phasellus sit', 76, 11, 9, 66);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-16 03:25:15.000', 'eget nunc', 117, 27, null, 45);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-21 18:31:59.000', 'sapien', 100, 5, 2, 95);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-09 17:22:56.000', 'mattis egestas metus', 7, 16, 1, 20);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-17 04:49:59.000', 'odio', 24, 29, 7, 81);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-29 14:30:52.000', 'orci luctus', 45, 23, null, 71);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-20 11:40:52.000', 'libero quis orci', 41, 6, 17, 27);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 00:55:53.000', 'aliquam', 48, 4, null, 83);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-29 14:30:52.000', null, null, null, null, 10);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-27 21:16:26.000', 'elit', 40, 20, 8, 56);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-04 17:14:16.000', 'massa', 59, 26, 17, 100);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 18:02:13.000', 'consequat nulla', 19, 15, 19, 25);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-25 18:28:45.000', 'elementum nullam varius', 110, 8, null, 20);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-04 17:14:16.000', 'platea', 18, 10, null, 86);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-07 11:05:02.000', 'pharetra magna', 105, 24, 1, 65);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-25 18:28:45.000', 'magna', 112, 4, null, 80);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-11 20:35:23.000', 'sed nisl', 24, 23, null, 80);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'habitasse platea dictumst', 110, 28, null, 92);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-21 18:31:59.000', 'nec', 118, 25, 7, 49);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-01 13:23:15.000', 'non mauris', 98, 3, 10, 4);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-02 03:11:43.000', 'pretium nisl ut', 28, 17, null, 25);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-02 03:11:43.000', 'sapien in sapien', 61, 6, null, 14);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-09 06:35:56.000', 'blandit lacinia', 93, 23, null, 60);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-18 05:20:51.000', null, null, null, 3, 9);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-02 10:56:29.000', 'non sodales', 6, 20, 8, 79);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-06 13:08:57.000', 'amet nunc', 116, 1, null, 92);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-25 18:28:45.000', 'leo odio porttitor', 11, 24, null, 15);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-05 06:35:19.000', 'sapien in', 37, 10, null, 85);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-30 02:16:09.000', 'adipiscing', 68, 16, 12, 73);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-27 12:31:00.000', 'vestibulum', 48, 11, 10, 60);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-04 17:14:16.000', 'vestibulum', 31, 12, 16, 12);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-27 12:31:00.000', 'habitasse platea dictumst', 58, 19, 13, 63);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-25 18:28:45.000', 'dolor sit amet', 81, 18, null, 26);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-18 05:20:51.000', 'pharetra', 24, 5, null, 68);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-04 17:14:16.000', 'nunc', 106, 3, 8, 85);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-18 05:20:51.000', 'tellus nisi', 35, 6, 2, 59);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-03 23:58:35.000', 'integer aliquet massa', 37, 10, null, 50);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-27 21:16:26.000', 'cursus id', 88, 22, null, 51);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-02 03:11:43.000', 'pellentesque viverra', 24, 10, null, 99);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-22 16:54:48.000', null, null, null, 16, 27);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-03 23:58:35.000', 'cubilia curae duis', 87, 20, 8, 37);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-02 02:36:24.000', 'ut suscipit', 1, 10, 20, 41);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-03 23:58:35.000', 'in ante vestibulum', 56, 3, 10, 3);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-27 21:16:26.000', 'blandit mi', 30, 9, null, 86);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-23 13:44:50.000', 'viverra', 60, 10, 15, 51);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-18 05:20:51.000', 'orci nullam molestie', 117, 27, null, 29);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-21 18:31:59.000', null, null, null, 6, 29);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-20 11:40:52.000', 'id ligula', 59, 16, 12, 56);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 18:02:13.000', 'massa donec', 30, 15, null, 76);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-03 23:58:35.000', 'sed ante', 47, 15, 13, 55);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-11 20:35:23.000', 'etiam faucibus', 83, 11, 6, 90);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-07 16:39:20.000', 'vel lectus in', 99, 15, 10, 89);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-27 12:31:00.000', 'sollicitudin', 91, 28, null, 68);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 18:02:13.000', 'duis bibendum', 60, 18, 19, 85);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 19:54:52.000', 'phasellus in felis', 98, 17, 1, 99);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-04 17:14:16.000', 'ultrices posuere cubilia', 49, 8, 19, 50);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 18:02:13.000', 'orci pede', 71, 24, 15, 91);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', null, null, null, 4, 60);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-11 20:35:23.000', 'tortor', 96, 17, 11, 54);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-15 17:42:48.000', 'quis', 17, 16, 14, 23);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 00:55:53.000', 'lacus', 20, 29, null, 39);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-27 12:31:00.000', 'aliquam lacus morbi', 63, 20, null, 12);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'ipsum integer', 65, 17, 3, 63);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-15 17:42:48.000', 'vehicula consequat', 15, 20, 3, 39);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-27 12:31:00.000', 'pretium', 78, 6, 8, 93);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-07 16:39:20.000', null, null, null, null, 37);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-05 06:35:19.000', 'ac neque duis', 97, 16, null, 92);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-30 02:16:09.000', 'id pretium', 100, 23, null, 85);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'in eleifend quam', 6, 16, null, 25);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-15 17:42:48.000', 'duis bibendum', 4, 6, 5, 75);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-26 14:54:30.000', null, null, null, 7, 64);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 00:55:53.000', 'erat', 87, 11, 5, 21);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-05 06:35:19.000', 'elementum eu interdum', 3, 2, null, 24);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-29 14:30:52.000', 'semper', 8, 3, 9, 37);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-17 04:49:59.000', 'duis bibendum', 96, 4, 15, 55);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 00:55:53.000', 'lectus', 75, 6, 11, 12);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-06 13:08:57.000', 'dui', 58, 14, 5, 61);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-22 16:54:48.000', 'euismod scelerisque quam', 71, 22, 9, 43);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-26 12:46:01.000', 'ante ipsum primis', 103, 21, 9, 98);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-12-08 03:19:07.000', null, null, null, null, 97);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-10 14:00:19.000', 'volutpat', 40, 22, 8, 48);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-03 23:58:35.000', 'nisi eu orci', 8, 19, null, 88);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 19:54:52.000', 'augue vestibulum', 49, 5, null, 22);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-09 06:35:56.000', 'nec', 42, 12, 13, 65);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-09 17:22:56.000', null, null, null, null, 47);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-26 12:46:01.000', 'platea dictumst morbi', 56, 5, 11, 92);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', null, null, null, 20, 36);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-03 23:41:39.000', 'risus dapibus augue', 85, 12, 13, 79);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 00:55:53.000', 'in est risus', 61, 23, 5, 29);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-02 03:11:43.000', 'purus eu magna', 56, 13, null, 82);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-02 02:36:24.000', 'duis', 13, 14, null, 75);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-02 10:56:29.000', 'iaculis', 7, 20, 6, 94);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-12-08 03:19:07.000', null, null, null, 20, 64);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-15 17:42:48.000', 'semper sapien', 40, 2, null, 50);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-26 14:54:30.000', 'lacus morbi quis', 15, 17, null, 48);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-20 03:38:14.000', null, null, null, 11, 80);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-30 02:16:09.000', null, null, null, 12, 73);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'amet eros suspendisse', 102, 24, null, 49);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-25 18:28:45.000', 'amet eros suspendisse', 70, 27, 5, 98);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-07 11:05:02.000', 'tincidunt eget tempus', 116, 9, 17, 63);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-29 09:50:58.000', 'ante vel ipsum', 98, 18, 16, 86);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-27 21:16:26.000', 'convallis nunc', 8, 12, 8, 68);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-02 03:11:43.000', 'nunc commodo placerat', 86, 5, 19, 91);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-15 17:42:48.000', null, null, null, null, 38);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-05 06:35:19.000', 'aenean lectus pellentesque', 27, 23, 2, 19);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-27 21:16:26.000', 'id', 2, 16, 9, 64);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-28 09:08:43.000', 'elit sodales scelerisque', 82, 14, null, 10);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'pellentesque ultrices mattis', 21, 13, 18, 75);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-02 02:36:24.000', 'congue', 43, 26, 7, 95);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-03 23:58:35.000', null, null, null, 3, 49);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'quisque', 15, 25, 5, 100);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-05 06:35:19.000', null, null, null, null, 29);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-10-16 03:25:15.000', 'iaculis diam erat', 11, 19, 7, 61);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-29 09:50:58.000', 'diam cras pellentesque', 62, 30, 18, 90);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-26 12:46:01.000', 'odio', 37, 19, 19, 48);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-03 23:41:39.000', null, null, null, 4, 100);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-02 03:11:43.000', 'nec euismod', 8, 8, 20, 89);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-07 16:39:20.000', 'aliquam augue quam', 43, 5, 12, 63);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 00:55:53.000', 'at', 89, 19, 12, 78);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-22 16:54:48.000', 'nonummy maecenas tincidunt', 100, 23, null, 88);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-26 14:54:30.000', 'orci', 29, 14, 2, 82);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-28 09:08:43.000', 'diam id ornare', 64, 21, null, 88);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-27 21:16:26.000', 'odio curabitur', 19, 16, 5, 35);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-09 06:35:56.000', 'gravida sem', 66, 11, null, 70);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-01 13:23:15.000', 'cubilia', 33, 6, 4, 100);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 18:02:13.000', null, null, null, 4, 53);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-02 02:36:24.000', 'tincidunt eu felis', 64, 9, null, 20);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 18:02:13.000', 'sapien varius', 57, 19, null, 65);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-20 03:38:14.000', 'luctus', 85, 2, null, 1);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-24 14:25:42.000', 'donec diam neque', 6, 9, 19, 8);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-27 21:16:26.000', 'praesent', 71, 10, null, 30);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-12-08 03:19:07.000', 'et', 117, 26, null, 86);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'vel', 28, 14, null, 60);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-10 14:00:19.000', 'justo maecenas', 117, 8, null, 90);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'libero', 64, 15, null, 84);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 00:55:53.000', 'nulla tellus in', 120, 16, 5, 29);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-27 12:31:00.000', 'eu', 45, 22, 16, 48);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 18:02:13.000', 'neque', 119, 16, 5, 67);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-17 20:25:25.000', 'sed magna', 50, 30, 13, 98);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-03-09 17:22:56.000', 'nam', 11, 13, 20, 30);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-11-27 02:08:51.000', 'curabitur in libero', 114, 14, 14, 75);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-28 09:08:43.000', 'nisl', 5, 1, 1, 49);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-07 16:39:20.000', 'cras mi', 112, 22, 19, 65);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-20 11:40:52.000', 'diam erat', 2, 25, 7, 37);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-20 03:38:14.000', 'ultrices posuere', 58, 17, 3, 99);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-18 19:54:52.000', 'neque', 21, 27, null, 10);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-07 16:39:20.000', 'pulvinar', 47, 8, 11, 42);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-07-15 17:42:48.000', 'integer', 103, 11, 15, 66);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-18 05:20:51.000', 'tortor id nulla', 29, 2, 18, 14);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-26 12:46:01.000', 'vivamus', 49, 21, null, 62);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-20 03:38:14.000', 'vel', 111, 2, null, 45);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-09-23 13:44:50.000', 'ante', 94, 16, null, 38);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-08-03 23:58:35.000', 'posuere nonummy', 48, 24, 20, 75);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-02-20 03:38:14.000', 'fusce', 22, 23, 12, 91);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2020-01-26 12:46:01.000', 'parturient montes nascetur', 44, 27, 16, 9);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-02 03:11:43.000', 'posuere', 48, 7, 12, 60);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-05-02 03:11:43.000', 'pede', 120, 6, null, 1);
INSERT INTO ATENDIMENTO (Data, Local, Tempo_despendido, PC_id, Sessao_id, Utente_id) VALUES ('2019-06-10 14:00:19.000', 'venenatis non', 71, 21, null, 36);

INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Arch', null);
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Fedora', '21');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Kubuntu', '18.04');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('CentOS', '8');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Xubuntu', '18.04.3');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Gentoo', null);
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Windows', '10');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('PopOS', null);
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Windows', '8.1');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Ubuntu', '19.10');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('MXLinux', null);
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Tails', null);
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Debian', '9');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Windows', '7');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Ubuntu', '20.04');
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Antergos', null);
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('Manjaro', null);
INSERT INTO SISTEMA_OPERATIVO (Nome, Versao) VALUES ('RedHat', null);

INSERT INTO MEMBRO(ID,Email,Num_telemovel,Tipo,Estado,Data_entrada) VALUES(11,'lorem.luctus.ut@ipsum.org','956219108',3,0,'2020-11-05'),(12,'Donec@sempererat.net','999728165',2,0,'2020-01-19'),(13,'consequat.auctor@vulputate.net','941545282',0,1,'2020-10-08'),(14,'erat@nibhsit.ca','991535593',1,0,'2020-09-17'),(15,'Praesent@egetmetusIn.edu','973718216',0,1,'2020-12-19'),(16,'erat.in.consectetuer@habitant.edu','953960779',1,1,'2021-04-02'),(17,'vulputate@adlitoratorquent.ca','962140384',1,1,'2020-03-12'),(18,'mattis.Cras@nondapibusrutrum.ca','956838951',4,0,'2020-10-10'),(19,'et.nunc@congueInscelerisque.co.uk','953028010',0,0,'2019-09-14'),(20,'vulputate.lacus@nuncnullavulputate.edu','918309178',0,0,'2019-09-25');
INSERT INTO MEMBRO(ID,Email,Num_telemovel,Tipo,Estado,Data_entrada) VALUES(21,'laoreet.lectus@scelerisquelorem.com','950872934',3,1,'2021-03-28'),(22,'magna.Duis@senectuset.com','949484537',3,1,'2019-10-16'),(23,'Aliquam.fringilla@Sedmalesuada.co.uk','971060393',4,1,'2021-04-23'),(24,'a.ultricies@penatibusetmagnis.edu','974569191',3,1,'2021-02-16'),(25,'egestas.Fusce@duiaugueeu.co.uk','931215233',3,1,'2021-05-02'),(26,'feugiat.nec.diam@velitQuisquevarius.edu','907842362',3,0,'2021-02-02'),(27,'purus.accumsan.interdum@Donec.com','931330767',2,1,'2019-10-22'),(28,'libero.Morbi.accumsan@liberoProin.org','980726034',2,1,'2021-02-07'),(29,'et@Donecfelisorci.com','995773340',2,0,'2019-12-07'),(30,'faucibus@mauris.com','976272461',3,1,'2019-08-13');

INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('et', 'posuere metus vitae ipsum', 'etiam vel augue', 4, 'consequat metus sapien', 23);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('integer', 'augue quam sollicitudin vitae consectetuer eget rutrum', 'risus auctor sed tristique', 1, 'eros viverra eget', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('natoque penatibus', 'morbi quis tortor id nulla ultrices aliquet maecenas', 'rutrum at', 4, 'pretium nisl', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('quis lectus', 'convallis duis consequat', 'nunc rhoncus dui vel', 0, 'sagittis', 28);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('ut nulla sed', 'quam a odio in', 'sagittis dui vel', 0, 'massa tempor convallis', 13);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('nunc', 'vel accumsan', 'lacinia', 3, 'arcu adipiscing', 23);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('dictumst', null, 'massa tempor', 1, 'nec sem', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('ullamcorper augue', 'eget vulputate ut ultrices vel augue vestibulum ante ipsum primis', 'venenatis lacinia aenean sit amet', 0, 'quam nec dui', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('lacinia erat', 'vel', 'mauris laoreet ut rhoncus', 2, 'a', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('blandit lacinia erat', null, 'pellentesque volutpat dui', 3, 'in ante', 29);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('tristique tortor eu', 'lectus in quam fringilla rhoncus mauris enim leo', 'duis ac nibh fusce lacus', 2, 'at', 14);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('elementum ligula', 'habitasse platea dictumst morbi vestibulum velit id', 'nisl venenatis lacinia aenean sit', 1, 'felis sed', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('rhoncus aliquam', 'interdum mauris', 'nullam orci pede venenatis', 2, null, null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('ac tellus', 'nunc proin at turpis a', 'amet', 4, 'suscipit ligula in', 16);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('dolor quis', 'quisque id justo sit amet', 'diam vitae quam suspendisse', 4, 'sollicitudin vitae', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('convallis nunc', 'pede morbi porttitor lorem id ligula suspendisse', 'ipsum primis in faucibus orci', 2, null, null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('nec nisi', 'fermentum justo nec condimentum neque sapien placerat', 'turpis eget elit sodales', 0, 'orci nullam molestie', 17);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('habitasse platea', 'donec quis orci eget orci vehicula', 'diam erat fermentum justo nec', 3, 'vel', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('dolor quis odio', 'at lorem integer tincidunt', 'elementum in hac habitasse', 2, 'maecenas tincidunt', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('ultricies eu nibh', 'eget rutrum at', 'lobortis est', 1, null, null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('posuere', 'eros viverra', 'lacinia eget', 3, null, null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('primis in faucibus', 'quam', 'id', 1, 'posuere', 18);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('pellentesque eget nunc', 'neque aenean auctor gravida sem praesent', 'quis', 1, 'justo aliquam', 27);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('quis odio', 'montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis', 'dolor', 4, null, 12);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('vel accumsan tellus', 'dolor sit amet consectetuer adipiscing elit proin risus praesent lectus', 'interdum venenatis', 0, 'tellus in', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('sapien cum', 'tellus nisi eu orci mauris lacinia', 'sit amet', 4, 'volutpat quam', 24);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('aliquam', 'phasellus id sapien in sapien iaculis congue vivamus metus', 'fusce posuere felis sed lacus', 2, 'montes', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('nisi at', null, 'quis augue luctus tincidunt nulla', 2, 'faucibus orci luctus', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('nibh', null, 'tortor', 4, 'id lobortis', 15);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('enim', 'viverra', 'nibh ligula nec sem', 2, 'felis eu', 11);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('orci luctus et', 'primis in faucibus orci', 'proin eu mi', 2, 'ipsum praesent', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('dui vel', null, 'eu magna', 2, 'varius nulla', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('lectus', 'justo pellentesque viverra pede ac diam cras pellentesque volutpat dui', 'cras in purus eu magna', 2, 'nec dui luctus', 14);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('in', 'tempus sit amet', 'mattis odio donec vitae', 4, 'nibh ligula', 21);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('cursus id', 'magnis', 'ut erat', 4, 'integer pede justo', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('arcu', 'eros viverra eget congue eget semper rutrum', 'condimentum id luctus', 2, 'id luctus nec', 16);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('vestibulum', 'ipsum', 'adipiscing molestie hendrerit at vulputate', 4, 'varius', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('integer ac neque', 'in libero ut', 'in lacus curabitur at ipsum', 1, 'at feugiat', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('nulla quisque', 'a suscipit', 'enim leo rhoncus sed', 3, 'quam nec', 16);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('eu', 'congue elementum in hac habitasse platea dictumst morbi', 'ullamcorper purus sit amet nulla', 4, 'luctus', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('aliquet', 'mauris enim leo rhoncus sed vestibulum sit amet cursus id', 'non', 4, 'ornare', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('natoque', 'sapien urna pretium nisl ut volutpat sapien arcu sed augue', 'felis fusce posuere felis sed', 2, 'turpis a pede', 21);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('amet justo morbi', 'id massa id nisl venenatis lacinia aenean sit', 'aenean sit amet justo morbi', 4, 'quis odio', 11);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('vel lectus in', 'ullamcorper augue a suscipit nulla', 'varius nulla', 3, null, null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('ac', 'nec sem duis aliquam convallis', 'quam sollicitudin vitae consectetuer eget', 1, 'erat eros', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('pellentesque ultrices', 'sed vel enim sit', 'venenatis turpis enim', 4, 'augue', 20);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('ligula', 'ligula pellentesque ultrices phasellus', 'in imperdiet', 3, 'blandit lacinia', null);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('fermentum donec ut', 'erat nulla', 'quis turpis', 1, 'dolor morbi', 19);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('ipsum', 'ut massa volutpat convallis morbi odio odio', 'bibendum morbi', 0, 'leo', 13);
INSERT INTO EQUIPAMENTO (Nome, Descricao, Localizacao, Estado, Dador, Membro_id) VALUES ('nulla', 'lacus morbi sem mauris laoreet ut rhoncus aliquet', 'dictumst', 0, 'hac habitasse', 28);

INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (34, null, 32, 3, null, 1);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (27, 'Sandisk', 8, 3, 'at ipsum ac', null);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (20, 'Sandisk', 32, 2, 'sapien urna', null);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (31, null, 32, 2, null, 11);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (47, null, 32, 2, null, 8);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (7, 'Kingston', 16, 3, null, 18);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (14, 'Sandisk', 8, 3, 'purus phasellus in felis donec semper', null);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (15, 'Kingston', 8, 2, 'lectus', null);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (1, 'Sandisk', 64, 2, null, 5);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (49, 'Sandisk', 64, 2, null, 15);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (40, 'Sandisk', 4, 2, null, 1);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (48, 'Kingston', 32, 3, 'montes nascetur ridiculus mus', null);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (50, 'Kingston', 16, 3, 'luctus nec molestie sed justo pellentesque viverra pede', null);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (44, null, 256, 2, null, 6);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (24, 'Kingston', 8, 3, 'risus', null);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (41, 'Kingston', 8, 2, null, 17);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (39, 'Sandisk', 64, 3, 'libero convallis eget eleifend luctus', null);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (3, 'Sandisk', 256, 3, null, 12);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (4, 'Sandisk', 256, 3, null, 15);
INSERT INTO FLASH_DRIVE (ID, Fabricante, Capacidade, Velocidade, Conteudo, SO_id) VALUES (8, 'Sandisk', 64, 3, null, 1);

INSERT INTO PARTICIPACAO(Membro_id,Sessao_id) VALUES(13,13),(14,1),(23,7),(29,5),(24,7),(30,4),(20,10),(23,4),(14,18),(24,8);
INSERT INTO PARTICIPACAO(Membro_id,Sessao_id) VALUES(13,5),(18,16),(13,9),(20,19),(28,20),(25,19),(12,20),(19,16),(21,5),(26,9);
INSERT INTO PARTICIPACAO(Membro_id,Sessao_id) VALUES(15,7),(14,16),(28,14),(15,12),(13,20),(13,4),(23,9),(19,17),(29,11),(30,12);
INSERT INTO PARTICIPACAO(Membro_id,Sessao_id) VALUES(27,13),(18,12),(12,2),(19,18),(13,18),(21,9),(23,12),(17,16),(23,5),(27,12);
INSERT INTO PARTICIPACAO(Membro_id,Sessao_id) VALUES(12,7),(28,11),(22,14),(16,9),(15,17),(17,18),(29,9),(22,13),(25,17),(22,10);
INSERT INTO PARTICIPACAO(Membro_id,Sessao_id) VALUES(12,17),(13,3),(17,13),(17,4),(12,10),(11,20),(18,9),(25,4),(17,9),(25,13);

INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (134, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (182, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (144, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (83, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (142, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (16, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (132, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (98, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (39, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (106, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (55, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (39, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (140, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (166, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (182, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (181, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (40, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (14, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (180, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (72, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (73, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (14, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (32, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (33, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (100, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (5, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (110, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (14, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (154, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (155, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (105, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (153, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (171, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (35, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (8, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (166, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (170, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (143, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (37, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (45, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (188, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (17, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (186, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (164, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (16, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (179, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (65, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (36, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (128, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (51, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (62, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (126, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (6, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (61, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (29, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (101, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (178, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (26, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (81, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (104, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (112, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (93, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (167, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (69, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (127, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (148, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (172, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (173, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (20, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (182, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (116, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (114, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (38, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (190, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (196, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (174, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (132, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (193, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (158, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (186, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (151, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (4, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (113, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (60, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (47, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (139, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (141, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (129, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (76, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (90, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (46, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (78, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (150, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (68, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (180, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (170, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (198, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (159, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (118, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (23, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (34, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (134, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (169, 16);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (119, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (142, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (43, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (186, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (112, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (88, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (80, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (8, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (140, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (115, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (149, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (185, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (55, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (74, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (77, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (192, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (84, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (37, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (85, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (170, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (22, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (123, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (173, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (161, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (86, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (38, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (140, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (193, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (175, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (89, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (175, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (102, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (91, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (63, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (158, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (23, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (152, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (156, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (157, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (91, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (13, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (68, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (138, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (200, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (30, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (58, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (192, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (56, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (131, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (3, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (72, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (163, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (2, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (176, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (161, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (67, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (114, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (99, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (99, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (54, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (32, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (159, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (25, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (171, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (111, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (76, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (49, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (195, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (52, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (53, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (137, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (191, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (189, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (71, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (134, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (40, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (40, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (25, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (135, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (109, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (188, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (185, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (32, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (3, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (63, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (111, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (12, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (147, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (32, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (153, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (178, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (43, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (94, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (72, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (118, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (197, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (197, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (174, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (162, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (197, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (166, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (35, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (13, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (10, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (76, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (132, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (120, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (119, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (103, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (188, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (178, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (43, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (145, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (80, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (143, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (38, 16);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (113, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (132, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (92, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (138, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (117, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (114, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (111, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (177, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (160, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (146, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (143, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (15, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (57, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (12, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (159, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (55, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (194, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (68, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (184, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (64, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (183, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (139, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (140, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (149, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (89, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (183, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (7, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (63, 16);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (81, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (121, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (121, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (96, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (167, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (143, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (192, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (55, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (194, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (63, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (101, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (28, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (134, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (181, 27);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (97, 14);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (82, 19);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (12, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (15, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (88, 29);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (29, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (51, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (55, 11);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (182, 28);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (96, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (171, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (131, 21);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (9, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (7, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (11, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (136, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (81, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (139, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (38, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (144, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (168, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (146, 30);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (165, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (175, 25);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (27, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (19, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (104, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (130, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (66, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (59, 15);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (86, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (186, 12);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (187, 13);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (175, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (87, 17);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (107, 24);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (190, 26);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (90, 23);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (41, 18);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (70, 16);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (98, 20);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (20, 22);
INSERT INTO PRESTACAO (Atendimento_id, Membro_id) VALUES (21, 28);

INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Tin', 'goodreads.com', 'Phalacrocorax albiventer');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Voltsillam', 'youtu.be', 'Pseudalopex gymnocercus');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Hatity', 'seesaa.net', 'Lasiorhinus latifrons');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Quo Lux', 'plala.or.jp', 'Semnopithecus entellus');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Zontrax', 'webnode.com', 'Podargus strigoides');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Tampflex', 'abc.net.au', 'Notechis semmiannulatus');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Keylex', 'goo.ne.jp', 'Tapirus terrestris');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Rank', 'spotify.com', 'Bison bison');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Span', 'fastcompany.com', 'Felis silvestris lybica');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Pannier', 'comsenz.com', 'Sula dactylatra');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Duobam', 'slashdot.org', 'Macropus agilis');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Opela', 'goo.gl', 'Scolopax minor');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Fintone', 'rediff.com', 'Neophron percnopterus');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Stronghold', 'dell.com', 'Chlidonias leucopterus');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Matsoft', 'gravatar.com', 'Pteropus rufus');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Holdlamis', 'nymag.com', 'Tachybaptus ruficollis');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Regrant', 'networkadvertising.org', 'Thamnolaea cinnmomeiventris');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Job', 'bigcartel.com', 'Semnopithecus entellus');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('It', 'shutterfly.com', 'Madoqua kirkii');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Latlux', '1688.com', 'Spermophilus lateralis');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Lotlux', 'reference.com', 'Ammospermophilus nelsoni');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Mat Lam Tam', 'weibo.com', 'Varanus salvator');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Trippledex', 'qq.com', 'Cacatua tenuirostris');
INSERT INTO PLATAFORMA (Nome, Link, Descricao) VALUES ('Solarbreeze', 'chron.com', 'Trichosurus vulpecula');

INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Holdlamis', 24, 'Cassandra', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Span', 18, 'Sonya', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tampflex', 20, 'Malchy', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Duobam', 27, 'Gale', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Lotlux', 29, 'Annis', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Stronghold', 20, 'Nancie', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Holdlamis', 27, 'Brody', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Holdlamis', 20, 'Tabbatha', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('It', 18, 'Galvan', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Lotlux', 27, 'Barbra', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Trippledex', 12, 'Christoforo', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Rank', 22, 'Nomi', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Solarbreeze', 11, 'Sinclair', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Job', 23, 'Pam', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Job', 24, 'Arabela', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('It', 26, 'Modesty', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tampflex', 17, 'Kipper', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Duobam', 11, 'Babara', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Span', 19, 'Bronny', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Rank', 12, 'Nathan', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Solarbreeze', 28, 'Byram', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Regrant', 22, 'Rossy', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('It', 29, 'Mirelle', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Job', 20, 'Annetta', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Quo Lux', 26, 'Lilian', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Quo Lux', 19, 'Wyn', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Holdlamis', 29, 'Tam', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Duobam', 23, 'Lothaire', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Duobam', 16, 'Brier', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Zontrax', 16, 'Grady', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Job', 12, 'Benedick', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Trippledex', 28, 'Reynard', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Hatity', 27, 'Onofredo', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tin', 15, 'Broddy', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Regrant', 21, 'Oren', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tampflex', 27, 'Hillary', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Zontrax', 13, 'Nelson', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Voltsillam', 20, 'Margy', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tampflex', 11, 'Seward', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('It', 21, 'Karrie', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Opela', 19, 'Hirsch', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Matsoft', 27, 'Omero', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Keylex', 23, 'Sena', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Keylex', 17, 'Silvana', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Zontrax', 21, 'Jessy', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Fintone', 29, 'Patin', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Quo Lux', 20, 'Cortie', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Quo Lux', 28, 'Amy', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Matsoft', 24, 'Hercules', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Opela', 15, 'Lynde', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Holdlamis', 21, 'Emlynn', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Voltsillam', 24, 'Yvonne', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Pannier', 16, 'Cathrin', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Job', 13, 'Silvana', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Fintone', 11, 'Hill', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Pannier', 13, 'Salli', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tampflex', 28, 'Shepherd', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Rank', 27, 'Simonne', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Trippledex', 21, 'Josephina', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Lotlux', 17, 'Zonda', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tin', 14, 'Aurore', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Holdlamis', 28, 'Marwin', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Job', 22, 'Eleanor', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tampflex', 26, 'Carlen', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Duobam', 13, 'Ninnette', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Stronghold', 28, 'Brooke', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Holdlamis', 18, 'Bernadine', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Fintone', 19, 'Kayle', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Lotlux', 14, 'Alina', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Mat Lam Tam', 16, 'Tandie', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Regrant', 16, 'Charissa', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Keylex', 11, 'Gennifer', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Holdlamis', 22, 'Stevana', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Tampflex', 25, 'Ashton', 'Moderador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Latlux', 12, 'Genna', 'Membro');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Zontrax', 12, 'Rainer', 'Administrador');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Hatity', 25, 'Martino', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Fintone', 15, 'Toddy', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Span', 11, 'Yoshi', 'Owner');
INSERT INTO ACESSO (Plataforma_nome, Membro_id, Username, Tipo) VALUES ('Duobam', 25, 'Armin', 'Moderador');

INSERT INTO TOPICO(Nome) VALUES ('Placa Gr�fica'),('Placa de Redes'), ('Codecs de multimedia'), ('Drives Desatualizadas'), ('Bloqueios no Arranque'), ('Microfones Externos');

INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Vipe', 'Catfish, blue');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('DabZ', 'Swamp deer');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Teklist', 'Lion, south american sea');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Talane', 'Southern lapwing');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Dabshots', 'Mouse, four-striped grass');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Wikizz', 'Eagle, bald');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('LiveZ', 'Brush-tailed phascogale');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('BlogXS', 'Ovenbird');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Chatterpoint', 'Tiger cat');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Rhybox', 'Buffalo, asian water');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Jetwire', 'Eastern box turtle');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('InnoZ', 'Rhea, greater');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Dabtype', 'Gecko, tokay');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Skippad', 'Eagle, golden');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Vitz', 'Vulture, egyptian');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Rhyloo', 'White-throated toucan');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Jabberbean', 'Capuchin, weeper');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Ooba', 'American alligator');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Fatz', 'Bateleur eagle');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Gigabox', 'Great skua');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Divavu', 'Long-billed corella');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Rhynyx', 'Goose, canada');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Flashspan', 'Kiskadee, great');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Topiclounge', 'Blue shark');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Mybuzz', 'Rose-ringed parakeet');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Eazzy', 'Alpaca');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Gabtype', 'Oryx, beisa');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Mycat', 'Deer, roe');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Kanoodle', 'Mexican beaded lizard');
INSERT INTO COMPONENTE (Fabricante, Modelo) VALUES ('Rhyzio', 'Common raccoon');

INSERT INTO PROBLEMA(Descricao, Componente_id, SO_id) VALUES('Bloqueio do computador quando o utente faz o log-in na tela inicial', NULL, 10),('Bloqueio logo apos o grub, sob a forma de uma tela preta', NULL, 1), ('O Wifi n�o funciona', 21, 2), ('Quando liga os headphones, o computador n�o d� som pelos headphones nem ativa o micro', 23, 6);

INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 57, 2, 'pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 25, 1, 'nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 110, 0, 'eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 196, 2, 'ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 153, 1, 'ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 181, 2, 'tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 92, 1, 'quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 113, 2, 'platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 106, 2, 'lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 14, 2, 'dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 33, 2, 'nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 61, 2, 'ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 67, 2, 'lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 64, 2, 'praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 138, 2, 'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 112, 2, 'ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 12, 0, 'eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 37, 1, 'non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (3, 195, 1, 'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 94, 0, 'praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 176, 2, 'nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (3, 106, 0, 'mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 78, 0, 'sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 141, 2, 'feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 29, 0, 'ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 163, 1, 'lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 61, 0, 'imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 162, 0, 'praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (3, 176, 1, 'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 2, 2, 'turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 27, 0, 'morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (3, 15, 0, 'nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 129, 0, 'dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (2, 43, 2, 'nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (1, 9, 0, 'phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 171, 2, 'erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 178, 2, 'libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus');
INSERT INTO TENTATIVA (Problema_id, Atendimento_id, Estado, Procedimento) VALUES (4, 156, 2, 'nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet');

INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (5, 3);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (2, 1);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (1, 4);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (4, 3);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (5, 1);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (3, 3);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (2, 3);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (2, 4);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (3, 1);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (1, 1);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (5, 2);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (1, 2);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (4, 2);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (3, 2);
INSERT INTO TOPICO_PROBLEMA (Topico_id, Problema_id) VALUES (3, 4);


