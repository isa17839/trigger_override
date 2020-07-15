global with sharing class AccountsOverride extends Framework.Domain {

    public AccountsOverride(List<Account> sObjectList) {
        super(sObjectList);
    }

    global class Constructor implements Framework.Domain.DomainConstructor {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new AccountsOverride(sObjectList);
        }
    }
    
    public override void beforeUpdate(Map<Id,SObject> oldMap) {
        for (Account acc: (Account[]) records) {
            acc.NumberOfEmployees++;
        }
    }
    
}