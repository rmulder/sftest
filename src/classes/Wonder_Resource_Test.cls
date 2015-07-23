@isTest
public class Wonder_Resource_Test{

    static TestMethod void testInsert() {
    
        String image = 'Hello';
        String description = 'Description';
        
        Id newWonder = Wonder_Resource.insertWonder(image,description);
        
        System.assert(newWonder != null);
        Wonder__c t = [Select Id, Name, Description__c, Primary_Image__c From Wonder__c Where Id = :newWonder];
        System.assert(t != null);
        System.assert(t.Primary_Image__c != null);
        Attachment a = [Select Id From Attachment Where Id = :t.Primary_Image__c];
        System.assert(a != null);
        
    }
    
    static TestMethod void testInsertDescriptionTooLong() {
    
        String image = 'Hello';
        String description = '1234567890123456789012345678901234567890';
        
        Id newWonder = Wonder_Resource.insertWonder(image,description);
        
        System.assert(newWonder != null);
        Wonder__c t = [Select Id, Name, Description__c, Primary_Image__c From Wonder__c Where Id = :newWonder];
        System.assert(t != null);
		System.assertEquals(t.Description__c, '123456789012345678901234567890');
    }    
    
    static TestMethod void testInsertNothing() {
    
        String image = null;
        String description = null;
        
        Id newWonder = Wonder_Resource.insertWonder(image,description);
        
        System.assert(newWonder == null);
    }        
}