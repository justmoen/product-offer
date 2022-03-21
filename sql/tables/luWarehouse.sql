CREATE TABLE [dbo].[LU_Warehouse] (
    [LU_WarehouseId]                       TINYINT       IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LU_CountryId]                         TINYINT       NULL,
    [Name]                                 VARCHAR (50)  NULL,
    [Code]                                 CHAR (7)      NULL,
    [IsActive]                             BIT           CONSTRAINT [DF_LU_Warehouse_IsActive] DEFAULT ((1)) NULL,
    [CreatedDateTime]                      DATETIME2 (0) CONSTRAINT [DF_LU_Warehouse_CreatedDateTime] DEFAULT (sysdatetime()) NULL,
    [UpdatedDateTime]                      DATETIME2 (0) CONSTRAINT [DF_LU_Warehouse_UpdatedDateTime] DEFAULT (sysdatetime()) NULL,
    CONSTRAINT [PK_LU_Warehouse] PRIMARY KEY CLUSTERED ([LU_WarehouseId] ASC) WITH (FILLFACTOR = 97),
    CONSTRAINT [FK_LU_Warehouse_LU_Country] FOREIGN KEY ([LU_CountryId]) REFERENCES [dbo].[LU_Country] ([LU_CountryId])
    );

GO
CREATE NONCLUSTERED INDEX [IX_LU_Warehouse_LU_CountryId]
    ON [dbo].[LU_Warehouse]([LU_CountryId] ASC) WITH (FILLFACTOR = 80);

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LU_Warehouse_Code]
    ON [dbo].[LU_Warehouse]([Code] ASC) WITH (FILLFACTOR = 80);