CREATE TABLE [dbo].[ProductPrice] (
    [ProductPriceId]       INT               IDENTITY (1, 1) NOT NULL,
    [LU_CurrencyId]        TINYINT           NOT NULL,
    [ProductId]            INT               NOT NULL,
    [KittingNumber]        VARCHAR(12)       NULL,
    [RetailUnitPrice]      DECIMAL(18,2)     NULL,
    CONSTRAINT [PK_ProductPrice] PRIMARY KEY CLUSTERED ([ProductPriceId] ASC),
    CONSTRAINT [FK_ProductPrice_LU_Currency] FOREIGN KEY ([LU_CurrencyId]) REFERENCES [dbo].[LU_Currency] ([LU_CurrencyId]),
    CONSTRAINT [FK_ProductPrice_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Product] ([ProductId])
    );