CREATE TABLE [dbo].[LU_Language] (
    [LU_LanguageId]       TINYINT       IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]                VARCHAR (50)  NULL,
    [Code]                CHAR (2)      NULL,
    [CreatedDateTime]     DATETIME2 (0) NULL,
    [UpdatedDateTime]     DATETIME2 (0) NULL,
    CONSTRAINT [PK_LU_Language] PRIMARY KEY CLUSTERED ([LU_LanguageId] ASC) WITH (FILLFACTOR = 80)
    );
