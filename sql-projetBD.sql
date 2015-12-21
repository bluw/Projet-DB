CREATE TABLE [dbo].[Sector] (
    [codeSector]   NVARCHAR(10)  NOT NULL,
    [denomination] NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([codeSector] ASC)
);

INSERT INTO [dbo].[Sector] ([codeSector], [denomination]) VALUES (N'ENS', N'Enseignement');

CREATE TABLE [dbo].[Company] (
    [idCompany]               INT           NOT NULL,
    [denomination]            NVARCHAR (50) NOT NULL,
    [adressNum]               INT           NOT NULL,
    [adressStreet]            NVARCHAR (50) NOT NULL,
    [adressPostCode]          INT           NOT NULL,
    [adressLocality]          NVARCHAR (50) NOT NULL,
    [telNum]                  NVARCHAR (12) NOT NULL,
    [nbSubmittedWorkerDeb]    INT           NOT NULL,
    [nbNonSubmittedWorkerDeb] INT           NOT NULL,
    [FK_Sector]               NVARCHAR(10)  NOT NULL,
    PRIMARY KEY CLUSTERED ([idCompany] ASC),
    CONSTRAINT [FK_Company_Sector] FOREIGN KEY ([FK_Sector]) REFERENCES [dbo].[Sector] ([codeSector])
);

INSERT INTO [dbo].[Company] ([idCompany], [denomination], [adressNum], [adressStreet], [adressPostCode], [adressLocality], [telNum], [nbSubmittedWorkerDeb], [nbNonSubmittedWorkerDeb], [FK_Sector]) VALUES (1, N'Henallux', 19, N'Rue Joseph Calozet', 5000, N'Namur', N'081 46 86 10', 12, 24, N'ENS');


CREATE TABLE [dbo].[Worker] (
    [idWorker]       INT           NOT NULL,
    [Name]           NVARCHAR (50) NOT NULL,
    [adressNum]      INT           NOT NULL,
    [adressStreet]   NVARCHAR (50) NOT NULL,
    [adressPostCode] INT           NOT NULL,
    [adressLocality] NVARCHAR (50) NOT NULL,
    [folderNum]      INT           NULL,
    PRIMARY KEY CLUSTERED ([idWorker] ASC)
);

INSERT INTO [dbo].[Worker] ([idWorker], [Name], [adressNum], [adressStreet], [adressPostCode], [adressLocality], [folderNum]) VALUES (1, N'Cedric', 1, N'rue des chemins', 5032, N'Gembloux', 1);


CREATE TABLE [dbo].[Profession] (
    [codeProf] NVARCHAR(10)       NOT NULL,
    PRIMARY KEY CLUSTERED ([codeProf] ASC)
);

INSERT INTO [dbo].[Profession] ([codeProf]) VALUES (N'CLEANER')
INSERT INTO [dbo].[Profession] ([codeProf]) VALUES (N'ETU')
INSERT INTO [dbo].[Profession] ([codeProf]) VALUES (N'SECRETARY')
INSERT INTO [dbo].[Profession] ([codeProf]) VALUES (N'TEACHER')
INSERT INTO [dbo].[Profession] ([codeProf]) VALUES (N'TECH')



CREATE TABLE [dbo].[SubmittedJob] (
    [idJob]         INT  NOT NULL,
    [startDate]     DATE NOT NULL,
    [endDate]       DATE NULL,
    [FK_Company]    INT  NOT NULL,
    [FK_Worker]     INT  NOT NULL,
    [FK_Profession] NVARCHAR(10)  NOT NULL,
    PRIMARY KEY CLUSTERED ([idJob] ASC),
    CONSTRAINT [FK_SubmittedJob_Company] FOREIGN KEY ([FK_Company]) REFERENCES [dbo].[Company] ([idCompany]),
    CONSTRAINT [FK_SubmittedJob_Worker] FOREIGN KEY ([FK_Worker]) REFERENCES [dbo].[Worker] ([idWorker]),
    CONSTRAINT [FK_SubmittedJob_Profession] FOREIGN KEY ([FK_Profession]) REFERENCES [dbo].[Profession] ([codeProf])
);

INSERT INTO [dbo].[SubmittedJob] ([idJob], [startDate], [endDate], [FK_Company], [FK_Worker], [FK_Profession]) VALUES (1, N'2016-01-02', NULL, 1, 1, N'ETU')
INSERT INTO [dbo].[SubmittedJob] ([idJob], [startDate], [endDate], [FK_Company], [FK_Worker], [FK_Profession]) VALUES (2, N'1998-04-21', N'2059-08-03', 1, 1, N'TECH')
INSERT INTO [dbo].[SubmittedJob] ([idJob], [startDate], [endDate], [FK_Company], [FK_Worker], [FK_Profession]) VALUES (3, N'2003-06-12', NULL, 1, 1, N'CLEANER')
INSERT INTO [dbo].[SubmittedJob] ([idJob], [startDate], [endDate], [FK_Company], [FK_Worker], [FK_Profession]) VALUES (4, N'2013-08-23', NULL, 1, 1, N'TEACHER')
INSERT INTO [dbo].[SubmittedJob] ([idJob], [startDate], [endDate], [FK_Company], [FK_Worker], [FK_Profession]) VALUES (5, N'2007-05-19', NULL, 1, 1, N'SECRETARY')


CREATE TABLE [dbo].[Risk] (
    [codeRisk] NVARCHAR(10)  NOT NULL,
    PRIMARY KEY CLUSTERED ([codeRisk] ASC)
);

INSERT INTO [dbo].[Risk] ([codeRisk]) VALUES (N'R-BURNOUT')
INSERT INTO [dbo].[Risk] ([codeRisk]) VALUES (N'R-CANCER')
INSERT INTO [dbo].[Risk] ([codeRisk]) VALUES (N'R-CRASH')
INSERT INTO [dbo].[Risk] ([codeRisk]) VALUES (N'R-DEMENTIA')
INSERT INTO [dbo].[Risk] ([codeRisk]) VALUES (N'R-ELECTRO')
INSERT INTO [dbo].[Risk] ([codeRisk]) VALUES (N'R-FRACTURE')
INSERT INTO [dbo].[Risk] ([codeRisk]) VALUES (N'R-HEART')


CREATE TABLE [dbo].[TypeExam] (
    [codeExam]      NVARCHAR(10)    NOT NULL,
    [periodicity]   NVARCHAR (50)   NOT NULL,
    [numCompteProd] INT             NOT NULL,
    [price]         NUMERIC (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([codeExam] ASC)
);

INSERT INTO [dbo].[TypeExam] ([codeExam], [periodicity], [numCompteProd], [price]) VALUES (N'MOTORSKIL', N'2/y', 8837382, CAST(150.39 AS Decimal(10, 2)))
INSERT INTO [dbo].[TypeExam] ([codeExam], [periodicity], [numCompteProd], [price]) VALUES (N'PHYSICAL', N'2/y', 2132334, CAST(89.99 AS Decimal(10, 2)))
INSERT INTO [dbo].[TypeExam] ([codeExam], [periodicity], [numCompteProd], [price]) VALUES (N'PSYCHO', N'1/y', 7222833, CAST(403.50 AS Decimal(10, 2)))
INSERT INTO [dbo].[TypeExam] ([codeExam], [periodicity], [numCompteProd], [price]) VALUES (N'RADIO', N'1/y', 7881231, CAST(530.59 AS Decimal(10, 2)))
INSERT INTO [dbo].[TypeExam] ([codeExam], [periodicity], [numCompteProd], [price]) VALUES (N'SAMPLE', N'1/y', 3994828, CAST(110.39 AS Decimal(10, 2)))
INSERT INTO [dbo].[TypeExam] ([codeExam], [periodicity], [numCompteProd], [price]) VALUES (N'SCAN', N'1/2y', 7883242, CAST(680.49 AS Decimal(10, 2)))


CREATE TABLE [dbo].[Link] (
    [idLink]      INT NOT NULL,
    [FK_Risk]     NVARCHAR(10) NOT NULL,
    [FK_TypeExam] NVARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([idLink] ASC),
    CONSTRAINT [FK_Link_Risk] FOREIGN KEY ([FK_Risk]) REFERENCES [dbo].[Risk] ([codeRisk]),
    CONSTRAINT [FK_Link_TypeExam] FOREIGN KEY ([FK_TypeExam]) REFERENCES [dbo].[TypeExam] ([codeExam])
);
INSERT INTO [dbo].[Link] ([idLink], [FK_Risk], [FK_TypeExam]) VALUES (1, N'R-ELECTRO', N'SCAN')
INSERT INTO [dbo].[Link] ([idLink], [FK_Risk], [FK_TypeExam]) VALUES (2, N'R-FRACTURE', N'RADIO')


CREATE TABLE [dbo].[Exposition] (
    [idExposition]    INT IDENTITY(1,1) NOT NULL,
    [FK_SubmittedJob] INT NOT NULL,
    [FK_Risk]         NVARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([idExposition] ASC),
    CONSTRAINT [FK_Exposition_SubmittedJob] FOREIGN KEY ([FK_SubmittedJob]) REFERENCES [dbo].[SubmittedJob] ([idJob]),
    CONSTRAINT [FK_Exposition_Risk] FOREIGN KEY ([FK_Risk]) REFERENCES [dbo].[Risk] ([codeRisk])
);

CREATE TABLE [dbo].[Submission] (
    [idSubmission]    INT IDENTITY(1,1) NOT NULL,
    [FK_SubmittedJob] INT NOT NULL,
    [FK_TypeExam]     NVARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([idSubmission] ASC),
    CONSTRAINT [FK_Submission_SubmittedJob] FOREIGN KEY ([FK_SubmittedJob]) REFERENCES [dbo].[SubmittedJob] ([idJob]),
    CONSTRAINT [FK_Submission_TypeExam] FOREIGN KEY ([FK_TypeExam]) REFERENCES [dbo].[TypeExam] ([codeExam])
);

CREATE TABLE [dbo].[Language] (
    [codeLanguage] NVARCHAR (2)  NOT NULL,
    [denomination] NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([codeLanguage] ASC)
);

INSERT INTO [dbo].[Language] ([codeLanguage], [denomination]) VALUES (N'FR', N'Francais');
INSERT INTO [dbo].[Language] ([codeLanguage], [denomination]) VALUES (N'EN', N'English');


CREATE TABLE [dbo].[TranslationProfession] (
    [idTranslation] INT           NOT NULL,
    [translation]   NVARCHAR (50) NOT NULL,
    [FK_Language]   NVARCHAR (2)  NOT NULL,
    [FK_Profession] NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([idTranslation] ASC),
    CONSTRAINT [FK_TranslationP_Language] FOREIGN KEY ([FK_Language]) REFERENCES [dbo].[Language] ([codeLanguage]),
    CONSTRAINT [FK_TranslationP_Profession] FOREIGN KEY ([FK_Profession]) REFERENCES [dbo].[Profession] ([codeProf])
);

INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (1, N'Student', N'EN', N'ETU')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (2, N'Etudiant', N'FR', N'ETU')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (3, N'Technician', N'EN', N'TECH')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (4, N'Technicien', N'FR', N'TECH')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (5, N'Cleaner', N'EN', N'CLEANER')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (6, N'Netoyeur', N'FR', N'CLEANER')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (7, N'Teacher', N'EN', N'TEACHER')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (8, N'Professeur', N'FR', N'TEACHER')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (9, N'Secretary', N'EN', N'SECRETARY')
INSERT INTO [dbo].[TranslationProfession] ([idTranslation], [translation], [FK_Language], [FK_Profession]) VALUES (10, N'Secretaire', N'FR', N'SECRETARY')


CREATE TABLE [dbo].[TranslationRisk] (
    [idTranslation] INT           NOT NULL,
    [translation]   NVARCHAR (50) NOT NULL,
    [FK_Language]   NVARCHAR (2)  NOT NULL,
    [FK_Risk]       NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([idTranslation] ASC),
    CONSTRAINT [FK_TranslationR_Language] FOREIGN KEY ([FK_Language]) REFERENCES [dbo].[Language] ([codeLanguage]),
    CONSTRAINT [FK_TranslationR_Risk] FOREIGN KEY ([FK_Risk]) REFERENCES [dbo].[Risk] ([codeRisk])
);

INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (1, N'Electrocution', N'EN', N'R-ELECTRO')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (2, N'Electrocution', N'FR', N'R-ELECTRO')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (3, N'Fracture', N'EN', N'R-FRACTURE')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (4, N'Fracture', N'FR', N'R-FRACTURE')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (5, N'Dementia', N'EN', N'R-DEMENTIA')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (6, N'Démence', N'FR', N'R-DEMENTIA')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (7, N'Burn-out', N'EN', N'R-BURNOUT')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (8, N'Crise de nerf', N'FR', N'R-BURNOUT')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (9, N'Car crash', N'EN', N'R-CRASH')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (10, N'Accident de voiture', N'FR', N'R-CRASH')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (11, N'Cancer', N'EN', N'R-CANCER')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (12, N'Cancer', N'FR', N'R-CANCER')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (13, N'Heart attack', N'EN', N'R-HEART')
INSERT INTO [dbo].[TranslationRisk] ([idTranslation], [translation], [FK_Language], [FK_Risk]) VALUES (14, N'Crise cardiaque', N'FR', N'R-HEART')


CREATE TABLE [dbo].[TranslationExam] (
    [idTranslation] INT           NOT NULL,
    [translation]   NVARCHAR (50) NOT NULL,
    [FK_Language]   NVARCHAR (2)  NOT NULL,
    [FK_TypeExam]   NVARCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([idTranslation] ASC),
    CONSTRAINT [FK_TranslationE_Language] FOREIGN KEY ([FK_Language]) REFERENCES [dbo].[Language] ([codeLanguage]),
    CONSTRAINT [FK_TranslationE_TypeExam] FOREIGN KEY ([FK_TypeExam]) REFERENCES [dbo].[TypeExam] ([codeExam])
);

INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (1, N'Radiography', N'EN', N'RADIO')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (2, N'Radiographie', N'FR', N'RADIO')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (3, N'Scanner', N'EN', N'SCAN')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (4, N'Echographe', N'FR', N'SCAN')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (5, N'Psychological test', N'EN', N'PSYCHO')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (6, N'Test psychologique', N'FR', N'PSYCHO')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (7, N'Traction test', N'EN', N'MOTORSKIL')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (8, N'Test de motricité', N'FR', N'MOTORSKIL')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (9, N'Fitness test', N'EN', N'PHYSICAL')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (10, N'Test physique', N'FR', N'PHYSICAL')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (11, N'Body fluid analysis', N'EN', N'SAMPLE')
INSERT INTO [dbo].[TranslationExam] ([idTranslation], [translation], [FK_Language], [FK_TypeExam]) VALUES (12, N'Analyse des fluides', N'FR', N'SAMPLE')

