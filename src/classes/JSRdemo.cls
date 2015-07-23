@RestResource(urlMapping='/RestAPI/v1/jsrdemo')
global with sharing class JSRdemo {

   @RemoteAction
    public static List<Contact> getContacts(integer limitNum) {
        return [select Id, createdDate, Name from Contact order by createdDate desc limit : limitNum];
    }

   @RemoteAction
    public static String createContact(string FirstName, string LastName) {
       Contact c = new Contact(FirstName=FirstName,LastName=LastName);
       insert c;
       return c.Id;
    }

   @RemoteAction
    public static String doGetText() {
        return 'Hey, we got a response!';
    }

    @RemoteAction
    public static String getJSON() {
        JSONGenerator generator = JSON.createGenerator(true);
        generator.writeStartObject();
        String testJSON = '{"conditions":[{"select_field":"About_Account__c.Funding_Type_CHK__c","select_value":"!"},{"select_field":"About_Account__c.Funding_Type_CHK__c","select_value":"Add External Accounts","required":true}]}';
        generator.writeObjectField('expressionProperties', testJSON);
        generator.writeEndObject();
        return generator.getAsString();
    }
/*
    @HttpPost
    global static String attachDoc(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;

        String fName = req.params.get('FileName');
        String parId = req.params.get('parId');
        Blob postContent = req.requestBody; 

        Attachment a = new Attachment (ParentId = parId,
                                       Body = postContent,
                                       Name = fName);

        insert a;
        return a.Id;
   }
   */

    @HttpPost
    global static String ImportContact() {
        RestRequest req = RestContext.request;
        System.debug('req is---------------------- ' +req);
        RestResponse resp = RestContext.response;
        
        
        Contact impContact = new Contact();
        impContact.FirstName = req.params.get('firstname');
        impContact.LastName = req.params.get('lastname');
        impContact.FirstName = req.params.get('email');
        impContact.Phone = req.params.get('phone');
        
        //Check for a matching Contact
        try {
            upsert impContact;
        } Catch (DMLException e){
            resp.statusCode = 400;
            return 'Error loading Contact into Salesforce- ' + e.getMessage(); 
        }
        
        /*Blob pic = req.requestBody;
        if (pic.size() > 0){
            
        }*/
        
        resp.statusCode = 201;
        return 'Contact created';
        
    }
}