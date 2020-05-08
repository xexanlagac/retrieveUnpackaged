/************************************************************
    Author: Reymark Arlos
    Date Created: 04/20/2020
    Description: Trigger Handler for Account
    <Author>            <Date>          <Description>

************************************************************/

public class AccountTriggerHandler
{
    /************************************************************
    Author: Reymark Arlos
    Date Created: 04/20/2020
    Description: Check Match billing address then copy billing post code to shipping postal code
    <Author>            <Date>          <Description>

    ************************************************************/
    public void copyBillingPostalCodeToShippingPostalCode(List<Account> newAccLst, Map<Id, Account> oldAccMap)
    {
        for(Account accRec : newAccLst)
        {
            if(!oldAccMap.isEmpty())
            {
                if(accRec.Match_Billing_Address__c != oldAccMap.get(accRec.Id).Match_Billing_Address__c)
                {
                    if(accRec.BillingPostalCode != '' && accRec.Match_Billing_Address__c)
                    {
                        accRec.ShippingStreet = accRec.BillingStreet;
                        accRec.ShippingCity = accRec.BillingCity;
                        accRec.ShippingState = accRec.BillingState;
                        accRec.ShippingCountry = accRec.BillingCountry;
                        accRec.ShippingPostalCode = accRec.BillingPostalCode;
                        system.debug('test');
                        system.debug('test');
                    }
                }
            }
            else
            {
                if(accRec.BillingPostalCode != '' && accRec.Match_Billing_Address__c)
                {
                    accRec.ShippingStreet = accRec.BillingStreet;
                    accRec.ShippingCity = accRec.BillingCity;
                    accRec.ShippingState = accRec.BillingState;
                    accRec.ShippingCountry = accRec.BillingCountry;
                    accRec.ShippingPostalCode = accRec.BillingPostalCode;
                }
            }
        }
    }
    
    /************************************************************
    Author: Reymark Arlos
    Date Created: 04/20/2020
    Description: Check billing country then update the address and verify phone and fax values
    <Author>            <Date>          <Description>

    ************************************************************/
    public void checkBillingCountry(List<Account> newAccLst)
    {
        for(Account accRec : newAccLst)
        {
            if(!string.isBlank(accRec.BillingCountry))
            {
                if(accRec.BillingCountry.EqualsIgnoreCase('US') || accRec.BillingCountry.EqualsIgnoreCase('USA') ||
                    accRec.BillingCountry.EqualsIgnoreCase('CA'))
                {
                    if(String.isBlank(accRec.ShippingStreet) && String.isBlank(accRec.ShippingCity)
                       && String.isBlank(accRec.ShippingState) && String.isBlank(accRec.ShippingPostalCode)
                       && String.isBlank(accRec.ShippingCountry))
                    {
                        accRec.ShippingStreet = accRec.BillingStreet;
                        accRec.ShippingCity = accRec.BillingCity;
                        accRec.ShippingState = accRec.BillingState;
                        accRec.ShippingPostalCode = accRec.BillingPostalCode;
                        accRec.ShippingCountry = accRec.BillingCountry;
                    }
                }
                else if(accRec.BillingCountry.EqualsIgnoreCase('PH'))
                {
                    if(!string.isBlank(accRec.Phone))
                    {
                        if(!string.valueOf(accRec.Phone).startsWith('+63'))
                        {
                            accRec.AddError('Philippine telephone numbers must be prefixed with the Country Code: +63.');
                        }
                    }
                    
                    if(!string.isBlank(accRec.Fax))
                    {
                        if(!string.valueOf(accRec.Fax).startsWith('+63'))
                        {
                            accRec.AddError('Philippine telephone numbers must be prefixed with the Country Code: +63.');
                        }
                    }
                }
            }
        }
    }
    
    /************************************************************
    Author: Reymark Arlos
    Date Created: 04/20/2020
    Description: Copy Account Billing Address to Contact Mailing Address
    <Author>            <Date>          <Description>

    ************************************************************/
    public void copyAccBillingAddToContMailingAdd(Map<Id, Account> newAccMap, Map<Id, Account> oldAccMap)
    {
        Set<Id> accIds = new Set<Id>();
        
        for(Account accRec : newAccMap.values())
        {
            if(accRec.BillingStreet != oldAccMap.get(accRec.Id).BillingStreet ||
               accRec.BillingCity != oldAccMap.get(accRec.Id).BillingCity ||
               accRec.BillingState != oldAccMap.get(accRec.Id).BillingState ||
               accRec.BillingPostalCode != oldAccMap.get(accRec.Id).BillingPostalCode ||
               accRec.BillingCountry != oldAccMap.get(accRec.Id).BillingCountry)
            {
                accIds.add(accRec.Id);
            }
        }
        
        if(!accIds.isEmpty())
        {
            List<Contact> contLst = [SELECT Id, Name, AccountId, MailingStreet, MailingCity, MailingState,
                                     MailingPostalCode, MailingCountry 
                                        FROM Contact 
                                        WHERE AccountId IN: accIds];
            
            for(Contact contRec : contLst)
            {
                contRec.MailingStreet = newAccMap.get(contRec.AccountId).BillingStreet;
                contRec.MailingCity = newAccMap.get(contRec.AccountId).BillingCity;
                contRec.MailingState = newAccMap.get(contRec.AccountId).BillingState;
                contRec.MailingPostalCode = newAccMap.get(contRec.AccountId).BillingPostalCode;
                contRec.MailingCountry = newAccMap.get(contRec.AccountId).BillingCountry;
            }
            
            update contLst;
        }
    }
}