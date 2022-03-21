CREATE PROCEDURE [dbo].[spGetProductOfferLookupList]
    @CurrentDateTime DATETIME = NULL,
    @LuOrderType INT = NULL,
    @LuCurrency INT = NULL,
    @IsVisible BIT = NULL,
    @IsSearchable BIT = NULL,
    @PriceLimit INT = NULL,
    @Product NVARCHAR(MAX) = NULL,
    @Skus NVARCHAR(MAX) = NULL,
    @isOnlyAvailableInInventory BIT = NULL,
    @LuCountry INT = NULL,
    @LuCulture INT = NULL,
    @LuWarehouse INT = NULL,
	@UserCulture INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET @CurrentDateTime=ISNULL(@CurrentDateTime,GETDATE())

    IF OBJECT_ID('tempdb..#TempSKU') IS NOT NULL
        DROP TABLE #TempSKU
    IF OBJECT_ID('tempdb..#TempPI') IS NOT NULL
        DROP TABLE #TempPI

    DECLARE @TempProductOffer TABLE (
        [KittingNumber] [varchar](12),
        [OfferPrice] DECIMAL(18,2),
        [IsVisibleInUI] [bit],
        [StartDateTime] [datetime2](7),
        [EndDateTime] [datetime2](7),
        [ProductOfferId] [int],
        [LU_CountryId] [tinyint],
        [LU_CurrencyId] [tinyint],
        [LU_CultureId] [smallint],
        [LU_WarehouseId] [tinyint],
        [LU_OrderTypeId] [tinyint],
        [IsArchived] [bit],
        [ProductId] [int],
        [IsSearchable] [bit],
        [CreatedDateTime] [datetime2](7),
        [UpdatedDateTime] [datetime2](7),
        [IsAvailable] [bit],
        [RetailUnitPrice] DECIMAL(18,2),
        [SKU] [varchar](50),
        [ProductName] [varchar] (500)
    )

    SELECT VALUE as SKU INTO #TempSKU FROM dbo.Split(@Skus, ',')
    CREATE CLUSTERED INDEX [IX_TempSKU_SKU]
        ON #TempSKU(SKU ASC)

    SELECT VALUE as ProdId INTO #TempPI FROM dbo.Split(@Product, ',')
    CREATE CLUSTERED INDEX [IX_TempPI_ProdId]
        ON #TempPI(ProdId ASC)

    INSERT INTO @TempProductOffer
    SELECT
        po.KittingNumber,
        po.OfferPrice,
        po.QualifyingVolume,
        po.CommissionableVolume,
        po.IsVisibleInUI,
        po.StartDateTime,
        po.EndDateTime,
        po.ProductOfferId,
        po.LU_CountryId,
        po.LU_CurrencyId,
        po.LU_CultureId,
        po.LU_WarehouseId,
        po.LU_OrderTypeId,
        po.IsArchived,
        po.ProductId,
        po.IsSearchable,
        po.CreatedDateTime,
        po.UpdatedDateTime,
        pi.IsAvailable,
        ISNULL(pp.RetailUnitPrice,0),
        p.SKU,
        p.ProductSwatchImageFileId,
        COALESCE(pkp.Name,n.Name,p.Name)
    FROM [ProductOffer] po WITH (NOLOCK)
        LEFT OUTER JOIN #TempPI ri WITH (NOLOCK) ON po.ProductId = ri.ProdId
        INNER JOIN Product p WITH (NOLOCK) ON po.ProductId = p.ProductId
        LEFT OUTER JOIN #TempSKU ti WITH (NOLOCK) ON p.SKU = ti.SKU
        INNER JOIN ProductInventory pi WITH (NOLOCK) ON p.SKU = pi.SKU
            AND COALESCE(pi.KittingNumber, '') = COALESCE(po.KittingNumber, '')
        LEFT OUTER JOIN ProductPrice pp WITH (NOLOCK) ON p.ProductId = pp.ProductId
            AND @LuCurrency = pp.LU_CurrencyId
            AND COALESCE(pp.KittingNumber, '') = COALESCE(po.KittingNumber, '')
        LEFT OUTER JOIN LU_Warehouse lw WITH (NOLOCK) ON pi.LU_WarehouseId = lw.LU_WarehouseId
        LEFT OUTER JOIN ProductProperty n WITH (NOLOCK) ON n.ProductId = po.ProductId
            AND n.LU_CultureId = @UserCulture
        LEFT OUTER JOIN ProductKitProperty pkp WITH (NOLOCK) ON pkp.LU_CultureId = @UserCulture
            AND pkp.KittingNumber = po.KittingNumber AND pkp.ProductId = po.ProductId
    WHERE (po.LU_OrderTypeId = @LuOrderType)
        AND (po.LU_CurrencyId = @LuCurrency)
        AND (po.IsArchived = 0)
        AND (po.StartDateTime <= @CurrentDateTime)
        AND (
            po.EndDateTime > @CurrentDateTime
            OR po.EndDateTime IS NULL
        )
        AND (
            @IsVisible IS NULL
            OR po.IsVisibleInUI = @IsVisible
            OR p.CommodityClass IS NOT NULL
        )
        AND (
            @IsSearchable IS NULL
            OR po.IsSearchable = @IsSearchable
        )
        AND (
            @PriceLimit IS NULL
            OR po.Price <= @PriceLimit
        )
        AND (
            @isOnlyAvailableInInventory IS NULL
            OR (
                @isOnlyAvailableInInventory = 1
                AND pi.IsAvailable = 1
            )
        )
        AND (
            @LuCountry IS NULL
            OR po.LU_CountryId = @LuCountry
        )
        AND (
            @LuCulture IS NULL
            OR po.LU_CultureId = @LuCulture
        )
        AND (
            (
                @LuWarehouse IS NULL
                OR pi.LU_WarehouseId = @LuWarehouse
            )
            AND lw.IsActive = 1
        )
        AND
            (
                @Skus IS NULL
                OR (
                    @Skus IS NOT NULL
                    AND ti.SKU IS NOT NULL
                )
            )
        AND (
                @Product IS NULL
                OR (
                    @Product IS NOT NULL
                    AND ri.ProdId IS NOT NULL
                )
            )
        AND (
            @LuWarehouse IS NULL
            OR (
                @LuWarehouse IS NOT NULL
                AND (
                    po.Lu_WarehouseId IS NULL
                    OR po.LU_WarehouseId = @LuWarehouse
                )
            )
        )

    IF (@isOnlyAvailableInInventory = 0 AND @LuWarehouse IS NOT NULL)
        SELECT * FROM  @TempProductOffer
    ELSE
        SELECT DISTINCT * FROM  @TempProductOffer WHERE IsAvailable = 1

    DROP TABLE #TempPI
    DROP TABLE #TempSKU
END