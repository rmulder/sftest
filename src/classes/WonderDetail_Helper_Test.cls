@isTest
public class WonderDetail_Helper_Test{

    static testmethod void testHelperDetail() {
        String image = 'Hello';
        String description = 'Description';
        Id newWonder = Wonder_Resource.insertWonder(image,description);

        ConnectApi.FeedItemPage testPage = new ConnectApi.FeedItemPage();
        List<ConnectApi.FeedItem> testItemList = new List<ConnectApi.FeedItem>();
        testItemList.add(new ConnectApi.FeedItem());
        testItemList.add(new ConnectApi.FeedItem());
        testPage.items = testItemList;        
		ConnectApi.ChatterFeeds.setTestGetFeedItemsFromFeed(null, ConnectApi.FeedType.Record, newWonder, testPage);

		System.RestContext.request = new RestRequest();
        RestContext.request.requestURI = '/wonder/detail/'+newWonder;
        
        WonderDetail_Helper.WonderDetail detail = WonderDetail_Helper.getDetail();
        System.assert(detail != null);
        System.assert(detail.wonder.Id == newWonder);
        System.assert(detail.feed != null);
    }
    
    @IsTest(SeeAllData=true)
    static void testHelperDetail_Insert() {    
        String image = 'Hello';
        String description = 'Description';
        Id newWonder = Wonder_Resource.insertWonder(image,description);

		System.RestContext.request = new RestRequest();
        RestContext.request.requestURI = '/wonder/detail/'+newWonder;
        
        Boolean ret = WonderDetail_Helper.postComment('new comment');
        System.assert(ret);

    }
}