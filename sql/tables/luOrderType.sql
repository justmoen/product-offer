CREATE TABLE [dbo].[LU_OrderType] (
    [LU_OrderTypeId] TINYINT       IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]           VARCHAR (100) NULL,
    [Code]           VARCHAR (25)  NULL,
    [Description]    VARCHAR (255) NULL,
    CONSTRAINT [PK_LU_OrderType] PRIMARY KEY CLUSTERED ([LU_OrderTypeId] ASC) WITH (FILLFACTOR = 97),
    CONSTRAINT [UQ_LU_OrderType_Code] UNIQUE NONCLUSTERED ([Code] ASC) WITH (FILLFACTOR = 97)
    );
