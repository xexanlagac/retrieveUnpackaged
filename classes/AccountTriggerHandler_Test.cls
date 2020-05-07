/************************************************************
	Author: Reymark Arlos
	Date Created: 04/20/2020
	Description: Test Class for AccountTriggerHandler
	<Author>			<Date>			<Description>

************************************************************/
@isTest
public class AccountTriggerHandler_Test
{
    @isTest
    static void testCopyBillingPostalCodeToShippingPostalCodeRec()
    {
        Account accRec = TestDataFactory.createTestAccount('AccountName');
        accRec.BillingStreet = 'Street';
        accRec.BillingCity = 'City';
        accRec.BillingState = 'State';
        accRec.BillingCountry = 'Country';
        accRec.BillingPostalCode = '1234';
        accRec.Match_Billing_Address__c = true;
        
        test.startTest();
        insert accRec;
        test.stopTest();
        
        Account checkAcc = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, 
                            BillingCountry, BillingPostalCode, ShippingStreet, ShippingCity, 
                            ShippingState, ShippingCountry, ShippingPostalCode
                            	FROM Account
                           		WHERE Id =: accRec.Id];
        
        Boolean confirm = false;
        
        if(checkAcc.BillingStreet == checkAcc.ShippingStreet &&
          	checkAcc.BillingCity == checkAcc.ShippingCity &&
          	checkAcc.BillingState == checkAcc.ShippingState &&
          	checkAcc.BillingCountry == checkAcc.ShippingCountry &&
          	checkAcc.BillingPostalCode == checkAcc.ShippingPostalCode)
        {
            confirm = true;
        }
        
        system.assert(confirm, 'Shipping Address not same as Billing Address');
        
    }
    
    @isTest
    static void testLoadMutipleAccountRecords()
    {
        List<sObject> newAccLoadData = Test.loadData(Account.sObjectType, 'TestAccounts');

        test.startTest();
        
        List<Account> updateAcc = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, 
                            BillingCountry, BillingPostalCode, ShippingStreet, ShippingCity, 
                            ShippingState, ShippingCountry, ShippingPostalCode
                            	FROM Account];
        
        system.debug(updateAcc);
        for(Account accRec : updateAcc)
        {
             system.debug('Account: ' + accRec);
        }
        
        for(integer ctr = 0; ctr < 5; ctr++)
        {
            updateAcc[ctr].Match_Billing_Address__c = true;
        }
        
        update updateAcc;
        
        test.stopTest();
        
        Boolean confirm = false;
        
        List<Account> accLst = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, 
                            BillingCountry, BillingPostalCode, ShippingStreet, ShippingCity, 
                            ShippingState, ShippingCountry, ShippingPostalCode
                            	FROM Account
                           		WHERE Match_Billing_Address__c = true];
        
        for(Account checkAcc : accLst)
        {
            if(checkAcc.BillingStreet == checkAcc.ShippingStreet &&
                checkAcc.BillingCity == checkAcc.ShippingCity &&
                checkAcc.BillingState == checkAcc.ShippingState &&
                checkAcc.BillingCountry == checkAcc.ShippingCountry &&
                checkAcc.BillingPostalCode == checkAcc.ShippingPostalCode)
            {
                confirm = true;
            }
            else
            {
                confirm = false;
            }
        }
        
        
        system.assert(confirm, 'Shipping Address not same as Billing Address');
    }
    
    @isTest
    static void testCheckBillingCountryPhone()
    {
        Account accRec = TestDataFactory.createTestAccount('AccountName');
        accRec.BillingStreet = 'Street';
        accRec.BillingCity = 'City';
        accRec.BillingState = 'State';
        accRec.BillingCountry = 'PH';
        accRec.BillingPostalCode = '1234';
        accRec.Phone = '1234';
        
        Boolean confirm = false;
        String message;
        
        test.startTest();
        try{
            insert accRec;
        }
        catch(Exception e)
        {
            Message = e.getMessage();
        }
        test.stopTest();
        
        if(Message.containsAny('Philippine telephone numbers must be prefixed with the Country Code: +63.'))
        {
            confirm = true;
        }
        
        system.assert(confirm);
    }
    
    @isTest
    static void testCheckBillingCountryFax()
    {
        Account accRec = TestDataFactory.createTestAccount('AccountName');
        accRec.BillingStreet = 'Street';
        accRec.BillingCity = 'City';
        accRec.BillingState = 'State';
        accRec.BillingCountry = 'PH';
        accRec.BillingPostalCode = '1234';
        accRec.Fax = '+639278183358';
        
        Boolean confirm = false;
        String message;
        
        test.startTest();
        insert accRec;
        try{  
        }
        catch(Exception e)
        {
            Message = e.getMessage();
        }
        test.stopTest();
        
        if(Message.containsAny('Philippine telephone numbers must be prefixed with the Country Code: +63.'))
        {
            confirm = true;
        }
        
        system.assert(confirm);
    }
    
    @isTest
    static void checkCopyAccBillingAddToContMailingAdd()
    {

        List<Account> newAccLst = TestDataFactory.createTestAccounts(20);
        Integer ctr = 0;
        for(Account accRec : newAccLst)
        {
            accRec.BillingStreet = 'Street0' + ctr;
            accRec.BillingCity = 'City0' + ctr;
            accRec.BillingState = 'State0' + ctr;
            accRec.BillingCountry = 'PH0' + ctr;
            accRec.BillingPostalCode = '12340' + ctr;
            ctr++;
        }
        insert newAccLst;
        
        List<Contact> newContLst = TestDataFactory.createTestContacts(newAccLst);
        insert newContLst;
        
        Map<Id, Account> accMap = new Map<Id,Account>(newAccLst);
        
        test.startTest();
        List<Account> updateAccLst = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, 
                                        BillingCountry, BillingPostalCode, ShippingStreet, ShippingCity, 
                                        ShippingState, ShippingCountry, ShippingPostalCode
                                            FROM Account
                                            WHERE Id IN: accMap.keySet()];
        for(Account accRec : updateAccLst)
        {
            accRec.BillingStreet = accRec.BillingStreet + ' update';
            accRec.BillingCity = accRec.BillingCity + ' update';
            accRec.BillingState = accRec.BillingState + ' update';
            accRec.BillingCountry = accRec.BillingCountry + ' update';
            accRec.BillingPostalCode = accRec.BillingPostalCode + ' update';
        }
        update updateAccLst;
        test.stopTest();
        
        Boolean confirm = false;
        
        List<Contact> contLst = [SELECT Id, Name, AccountId, MailingStreet, MailingCity, MailingState,
                                     MailingPostalCode, MailingCountry 
                                     	FROM Contact 
                                     	WHERE AccountId IN: accMap.keySet()];
            
        for(Contact contRec : contLst)
        {
            if(contRec.MailingStreet.containsAny('update') && contRec.MailingCity.containsAny('update') &&
            	contRec.MailingState.containsAny('update') && contRec.MailingPostalCode.containsAny('update') &&
              	contRec.MailingCountry.containsAny('update'))
            {
                confirm = true;
            }
            else
            {
                confirm = false;
            }
        }
        
        system.assert(confirm);
    }
}