public class AccountTriggerHandler {
    // Before Insert
    public static void handleBeforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            acc.Active__c = false;
        }
    }
    
    // Before Update
    public static void handleBeforeUpdate(List<Account> Acct) {
        Integer Hr = 0;
        Integer Admin = 0;
        for(Account acc : Acct){
            if(acc.Active__c){
                for(Team_Members__c tm : [SELECT AccountId__c,Member_Type__c  FROM Team_Members__c WHERE (AccountId__c =: acc.Id AND Member_Type__c IN ('HR', 'Admin'))]){
                    if(tm.Member_Type__c == 'HR'){
                        Hr = Hr + 1;
                    }else if(tm.Member_Type__c == 'Admin'){
                        Admin = Admin  + 1;
                    }
                }
            }
        }
        if(Hr != 0 && Admin != 0) {
            System.debug('Updated Succesfully');
        }else {
            System.Debug('Custom Error');
        }
          }
    
    //After Insert
    public static void handleAfterInsert(List<Account> newAccounts) {
        List<Team_Members__c> teamMembersToInsert = new List<Team_Members__c>();
        
        for (Account acc : newAccounts) {
            //if (acc.Active__c) {
                teamMembersToInsert.add(new Team_Members__c(
                    AccountId__c = acc.Id,
                    Name = 'Team Member 1',
                    Member_Type__c = '',
                    Contact_Info__c = ''
                ));
                teamMembersToInsert.add(new Team_Members__c(
                    AccountId__c = acc.Id,
                    Name = 'Team Member 2',
                    Member_Type__c = '',
                    Contact_Info__c = ''
                ));
           // }
        }
        
        if (!teamMembersToInsert.isEmpty()) {
            insert teamMembersToInsert;
        }
    }
}