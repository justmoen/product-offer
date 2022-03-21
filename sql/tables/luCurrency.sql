CREATE TABLE [dbo].[LU_Currency] (
    [LU_CurrencyId]   TINYINT       IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]            NVARCHAR(25)  NULL,
    [Code]            CHAR (3)      NULL,
    [CreatedDateTime] DATETIME2 (0) NULL,
    [UpdatedDateTime] DATETIME2 (0) NULL,
    CONSTRAINT [PK_LU_Currency] PRIMARY KEY CLUSTERED ([LU_CurrencyId] ASC) WITH (FILLFACTOR = 97)
    );