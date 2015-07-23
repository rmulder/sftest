@restResource(urlMapping='/wonder/detail/*')
global class WonderDetail_Helper{
	
	@HttpGet
        global static WonderDetail getDetail() {
            RestRequest req = RestContext.request;
            String wonderId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
            Wonder__c wonder = [Select Id, Name, Description__c, Active__c, Primary_Image__c,
                                CreatedDate, OwnerId, Owner.Name, CreatedById, 
                                CreatedBy.Name, CreatedBy.SmallPhotoUrl 
                                From Wonder__c where Id = :wonderId];
			
            List<ConnectApi.FeedItem> feed = ConnectApi.ChatterFeeds.getFeedItemsFromFeed(null, ConnectApi.FeedType.Record, wonder.id).items;
            
			WonderDetail ret = new WonderDetail();
			
            ret.wonder = wonder;
            ret.feed = feed;

			return ret;            
        }
    
    @HttpPost
        global static Boolean postComment(String comment) {
            RestRequest req = RestContext.request;
            String wonderId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
            
            ConnectApi.ChatterFeeds.postFeedItem(null,ConnectApi.FeedType.Record,wonderId,comment);
            
            return True;
            
            
        }

        global class WonderDetail {
         	
            public Wonder__c wonder { get; set; }
            public List<ConnectApi.FeedItem> feed { get; set; }
            
        }
}