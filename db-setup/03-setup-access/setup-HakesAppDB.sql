-- Create the database users
USE HakesAppDB;
GO
CREATE USER HakesAppDBWriter FOR LOGIN HakesAppDBWriter;
CREATE USER HakesAppDBReadOnly FOR LOGIN HakesAppDBReadOnly;
GO

-- Grant access to users
ALTER ROLE db_datawriter ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_datareader ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_datareader ADD MEMBER HakesAppDBReadOnly;
GO

-- Grant EXECUTE permissions
GRANT EXECUTE ON dbo.sp_RecalculateAuctionItem TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.sp_SearchAuctionItems TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.sp_SearchSalesListItems TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.sp_UpdateOrderHeader TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_AuctionCategoryWithItems TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_AuctionItemAggData TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_AuctionItemData TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_AuctionItemLatestBids TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_CheckIfAuctionItemIsWatchedByCustomer TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_CountRunningAuctions TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_CreateNewSliderGroup TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_CreateOrdersForAuction TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_DeleteCustomerWatchedItem TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_GetAllBidStatusBidsForAuction TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_GetAllWatchedItemsForAuction TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_GetCustomerBidHistoryByAuction TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_GetSMSCustomersForAuction TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_SearchAuctionItemList TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_SetSliderImageToInactive TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_TestUpdateOrderHeaderTaxAmount TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_UpdateCustomerDetail TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_UpdateHomepageSliderGroup TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_UpdateSliderImage TO HakesAppDBWriter;
GRANT EXECUTE ON dbo.usp_UploadSliderImage TO HakesAppDBWriter;
