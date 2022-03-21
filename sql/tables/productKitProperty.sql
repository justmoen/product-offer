CREATE TABLE [dbo].[ProductKitProperty] (
    [ProductKitPropertyId] INT           IDENTITY (1, 1) NOT NULL,
    [ProductId]            INT           NOT NULL,
    [LU_CultureId]         SMALLINT      NOT NULL,
    [KittingNumber]        VARCHAR(12)   NOT NULL,
    [Name]                 NVARCHAR(255)  NOT NULL,
    [CreatedDateTime]      DATETIME2 (7) NOT NULL,
    [UpdatedDateTime]      DATETIME2 (7) NULL,
    CONSTRAINT [PK_ProductKitPropertyId] PRIMARY KEY CLUSTERED ([ProductKitPropertyId] ASC),
    CONSTRAINT [FK_ProductKitProperty_LU_Culture] FOREIGN KEY ([LU_CultureId]) REFERENCES [dbo].[LU_Culture] ([LU_CultureId]),
    CONSTRAINT [FK_ProductKitProperty_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId])
    );