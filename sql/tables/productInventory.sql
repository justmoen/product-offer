CREATE TABLE [dbo].[ProductInventory] (
    [ProductInventoryId]      INT           IDENTITY (1, 1) NOT NULL,
    [SKU]                     VARCHAR (50)  NULL,
    [KittingNumber]           VARCHAR (12)  NULL,
    [LU_WarehouseId]          TINYINT       NULL,
    [Qty]                     INT           NULL,
    [IsAvailable]             BIT           CONSTRAINT [DF_ProductInventory_IsAvailable] DEFAULT ((0)) NOT NULL,
    [CreatedBy]               INT           NULL,
    [CreatedDateTime]         DATETIME2 (7) CONSTRAINT [DF_ProductInventory_CreatedDateTime] DEFAULT (sysdatetime()) NULL,
    [UpdatedBy]               INT           NULL,
    [UpdatedDateTime]         DATETIME2 (7) CONSTRAINT [DF_ProductInventory_UpdatedDateTime] DEFAULT (sysdatetime()) NULL,
    CONSTRAINT [PK_ProductInventory] PRIMARY KEY CLUSTERED ([ProductInventoryId] ASC) WITH (FILLFACTOR = 97),
    CONSTRAINT [FK_ProductInventory_LU_Warehouse] FOREIGN KEY ([LU_WarehouseId]) REFERENCES [dbo].[LU_Warehouse] ([LU_WarehouseId])
    );

GO
CREATE NONCLUSTERED INDEX [IX_ProductInventory_SKU_KittingNumber]
    ON [dbo].[ProductInventory]([SKU] ASC, [KittingNumber] ASC);

GO
CREATE NONCLUSTERED INDEX [IX_ProductInventory_LU_WarehouseId]
    ON [dbo].[ProductInventory]([LU_WarehouseId] ASC) WITH (FILLFACTOR = 80);