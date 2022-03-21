CREATE TABLE [dbo].[LU_Culture] (
    [LU_CultureId]        SMALLINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LU_CountryId]        TINYINT       NULL,
    [LU_LanguageId]       TINYINT       NULL,
    [Locale]              VARCHAR (5)   NULL,
    [IsDefaultForCountry] BIT           NULL,
    [IsActive]            BIT           NULL,
    [CreatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_LU_Culture_CreatedDateTime] DEFAULT (sysdatetime()) NULL,
    [UpdatedDateTime]     DATETIME2 (7) CONSTRAINT [DF_LU_Culture_UpdatedDateTime] DEFAULT (sysdatetime()) NULL,
    CONSTRAINT [PK_LU_Culture] PRIMARY KEY CLUSTERED ([LU_CultureId] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK_LU_Culture_LU_Country] FOREIGN KEY ([LU_CountryId]) REFERENCES [dbo].[LU_Country] ([LU_CountryId]),
    CONSTRAINT [FK_LU_Culture_LU_Language] FOREIGN KEY ([LU_LanguageId]) REFERENCES [dbo].[LU_Language] ([LU_LanguageId])
    );