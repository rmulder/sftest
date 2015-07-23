public with sharing class soql_offset_example {
 
   private integer offset=0;  //keeps track of the offset
   private integer list_size=10; //sets the page size or number of rows
   public integer RecordsListSize; //used to show user the total size of the list
 
   public soql_offset_example() {
   RecordsListSize = [select count() from Contact]; //set the total size in the constructor
   }
 
   public Contact[] getNumbers() {
      try {
         Contact[] numbers = [select id, name
                                from Contact
                                order by name
                                limit :list_size
                                offset :offset];
 
         return numbers;
      } catch (QueryException e) {
         ApexPages.addMessages(e);   
         return null;
      }
   }
 
   public PageReference Beginning() { //user clicked beginning
      offset = 0;
      return null;
   }
 
   public PageReference Previous() { //user clicked previous button
      offset -= list_size;
      return null;
   }
 
   public PageReference Next() { //user clicked next button
      offset += list_size;
      return null;
   }
 
   public PageReference End() { //user clicked end
      offset = RecordsListSize - math.mod(RecordsListSize, list_size);
      return null;
   }
 
   public Boolean getDisablePrevious() {
      //this will disable the previous and beginning buttons
      if (offset>0) return false; else return true;
   }
 
   public Boolean getDisableNext() { //this will disable the next and end buttons
      if (offset + list_size < RecordsListSize) return false; else return true;
   }
 
   public Integer getTotal_size() {
      return RecordsListSize;
   }
 
   public Integer getPageNumber() {
      return offset/list_size + 1;
   }
 
   public Integer getTotalPages() {
      if (math.mod(RecordsListSize, list_size) > 0) {
         return RecordsListSize/list_size + 1;
      } else {
         return (RecordsListSize/list_size);
      }
   }
}