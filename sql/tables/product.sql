CREATE TABLE [dbo].[Product] (
    [ProductId]                       INT               NOT NULL IDENTITY (1, 1),
    [SKU]                             VARCHAR(50)       NULL,
    [IsKit]                           BIT               NULL,
    [IsShippable]                     BIT               NULL,
    [IsConsumable]                    BIT               NULL,
    [IsCommissionable]                BIT               NULL,
    [IsDiscountable]                  BIT               NULL,
    [IsTaxable]                       BIT               NULL,
    [IsTaxInclusive]                  BIT               NULL,
    [IsBackOrderAllowed]              BIT               NULL,
    [IsSellable]                      BIT               NULL,
    [IsStockItem]                     BIT               NULL,
    [IsActive]                        BIT               NULL,
    [CreatedBy]                       INT               NULL,
    [CreatedDateTime]                 DATETIME2(7)      NULL CONSTRAINT [DF_Product_CreatedDateTime] DEFAULT (SYSDATETIME()),
    [UpdatedBy]                       INT               NULL,
    [UpdatedDateTime]                 DATETIME2(7)      NULL CONSTRAINT [DF_Product_UpdatedDateTime] DEFAULT (SYSDATETIME()),
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductId] ASC) WITH (FILLFACTOR = 80)
    )

GO
CREATE NONCLUSTERED INDEX [IX_Product_SKU]
    ON [dbo].[Product]([SKU] ASC);