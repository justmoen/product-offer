CREATE TABLE [dbo].[ProductProperty] (
    [ProductPropertyId]   INT             IDENTITY (1, 1) NOT NULL,
    [ProductId]           INT             NULL,
    [SKU]                 VARCHAR (50)    NULL,
    [LU_CultureId]        SMALLINT        NULL,
    [Name]                NVARCHAR (215)  NULL,
    [Description]         NVARCHAR (100)  NULL,
    [CreatedBy]           INT             NULL,
    [CreatedDateTime]     DATETIME2 (7)   CONSTRAINT [DF_ProductProperty_CreatedDateTime] DEFAULT (sysdatetime()) NULL,
    [UpdatedBy]           INT             NULL,
    [UpdatedDateTime]     DATETIME2 (7)   CONSTRAINT [DF_ProductProperty_UpdatedDateTime] DEFAULT (sysdatetime()) NULL,
    CONSTRAINT [PK_ProductProperty] PRIMARY KEY CLUSTERED ([ProductPropertyId] ASC) WITH (FILLFACTOR = 97),
    CONSTRAINT [FK_ProductProperty_LU_Culture] FOREIGN KEY ([LU_CultureId]) REFERENCES [dbo].[LU_Culture] ([LU_CultureId]),
    CONSTRAINT [FK_ProductProperty_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId])
    );

GO
CREATE NONCLUSTERED INDEX [IX_ProductProperty_Product]
    ON [dbo].[ProductProperty]([ProductId] ASC) WITH (FILLFACTOR = 97);

GO
CREATE NONCLUSTERED INDEX [IX_ProductProperty_LU_Culture]
    ON [dbo].[ProductProperty]([LU_CultureId] ASC) WITH (FILLFACTOR = 97);
