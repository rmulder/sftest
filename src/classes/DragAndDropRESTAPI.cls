@RestResource(urlMapping='/DragAndDrop/v1/*')
global with sharing class DragAndDropRESTAPI
{
    @HttpPost
    global static String attachDoc(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        res.addHeader('Access-Control-Allow-Origin', 'https://rmulder-developer-edition.na15.force.com');
        res.addHeader('Content-Type', 'application/json');
        
        String fName = req.params.get('FileName'); 
        String parId = req.params.get('parId');  
        Blob postContent = req.requestBody; 
          
        Attachment a = new Attachment (ParentId = parId,
                                       Body = postContent, 
                                       Name = fName);
         
        insert a;
        return a.Id;
   }
}