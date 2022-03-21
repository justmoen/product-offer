CREATE TABLE [dbo].[LU_Country] (
    [LU_CountryId]            TINYINT         IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]                    VARCHAR (50)    NULL,
    [ISOCode]                 CHAR (2)        NULL,
    [CountryCode]             VARCHAR (50)    NULL,
    [IsTaxInclusive]          BIT             NULL,
    [IsActive]                BIT             NULL,
    [CreatedDateTime]         DATETIME2 (7)   CONSTRAINT [DF_LU_Country_CreatedDateTime] DEFAULT (sysdatetime()) NULL,
    [UpdatedDateTime]         DATETIME2 (7)   CONSTRAINT [DF_LU_Country_UpdatedDateTime] DEFAULT (sysdatetime()) NULL,
    CONSTRAINT [PK_LU_Country] PRIMARY KEY CLUSTERED ([LU_CountryId] ASC) WITH (FILLFACTOR = 80)
    );
