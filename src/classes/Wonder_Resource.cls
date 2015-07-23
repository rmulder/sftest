@RestResource(urlMapping='/wonderHelper')
global class Wonder_Resource{
    @HttpPost
    global static Id insertWonder(String image, String description) {

        if (image == null || description == null) {
            return null;
        }
        
        if (description.length() > 30) {
            description = description.substring(0,30);
        }
        
        
        Wonder__c newWaste = new Wonder__c();
        newWaste.Description__c = description;
        newWaste.Active__c = True;
        insert newWaste;
        
		Attachment a = new Attachment();
        a.parentId = newWaste.id;
        a.body = EncodingUtil.base64Decode(image);
        a.name = 'WonderImage.jpg';
        a.contentType = 'image/jpg';
        insert a;
        
        
        newWaste.Primary_Image__c = a.id;
        update newWaste;
        
        return newWaste.id;
    }
}