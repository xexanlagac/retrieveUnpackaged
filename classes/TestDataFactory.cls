/************************************************************
	Author: Reymark Arlos
	Date Created: 04/20/2020
	Description: TestDataFactory
	<Author>			<Date>			<Description>

************************************************************/
@isTest
public class TestDataFactory
{
	public static Account createTestAccount(String accName)
    {
        Account accRec = new Account();
        accRec.Name = accName;
        
        return accRec;
    }
    
    public static List<Account> createTestAccounts(Integer accNum)
    {
        List<Account> accLst = new List<Account>();
        for(Integer ctr = 1; ctr <= accNum; ctr++)
        {
            Account accRec = new Account();
            accRec.Name = 'Account0' + ctr;
            accLst.add(accRec);
        }
        
        return accLst;
    }
    
    public static Contact createTestContact(String lastName, String firstName, string accId)
    {
        Contact contRec = new Contact();
        contRec.LastName = lastName;
        contRec.FirstName = firstName;
        contRec.AccountId = accId;
        
        return contRec;
    }
    
    public static List<Contact> createTestContacts(List<Account> accLst)
    {
        List<Contact> contLst = new List<Contact>();
        
        for(Account accRec : accLst)
        {
            integer ctr = 1;
            
            Contact contRec = new Contact();
            contRec.AccountId = accRec.Id;
            contRec.LastName = 'Contact0' + ctr;
            contRec.FirstName = 'Test';
            contLst.add(contRec);
            ctr++;
		}
        
        return contLst;
    }
}