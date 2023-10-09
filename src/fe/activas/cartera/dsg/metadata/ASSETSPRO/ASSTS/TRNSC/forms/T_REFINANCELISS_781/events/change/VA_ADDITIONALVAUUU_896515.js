//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.additionalValue (TextInputBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ADDITIONALVAUUU_896515 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
            entities.RefinanceLoanFilter.capitalBalance = 0;
        entities.RefinanceLoanFilter.interestBalance = "";        
        entities.RefinanceLoanFilter.otherBalance = 0;
        entities.RefinanceLoanFilter.aditionalBalance = 0;
        var additionalValue = entities.RefinanceLoanFilter.additionalValue;
        var totalRefinance  = 0;
        
        for (var i = 0; i < entities.RefinanceLoans._data.length; i++) {
            entities.RefinanceLoanFilter.capitalBalance = entities.RefinanceLoanFilter.capitalBalance + entities.RefinanceLoans._data[i].capitalBalance
            totalRefinance = totalRefinance + entities.RefinanceLoans._data[i].capitalBalance;            
            entities.RefinanceLoanFilter.otherBalance = entities.RefinanceLoanFilter.otherBalance + entities.RefinanceLoans._data[i].interestBalance;
            totalRefinance = totalRefinance + entities.RefinanceLoans._data[i].interestBalance;
            entities.RefinanceLoanFilter.otherBalance = entities.RefinanceLoanFilter.otherBalance + entities.RefinanceLoans._data[i].defaultBalance
            totalRefinance = totalRefinance + entities.RefinanceLoans._data[i].defaultBalance;
            entities.RefinanceLoanFilter.otherBalance = entities.RefinanceLoanFilter.otherBalance + entities.RefinanceLoans._data[i].otherConceptsBalance
            totalRefinance = totalRefinance + entities.RefinanceLoans._data[i].otherConceptsBalance;
            
        }
        totalRefinance  = totalRefinance + additionalValue;
        totalRefinance = kendo.toString(totalRefinance, "n2"); 
        additionalValue = kendo.toString(additionalValue, "n2"); 
        entities.RefinanceLoanFilter.aditionalBalance = additionalValue;
        entities.RefinanceLoanFilter.totalRefinance = totalRefinance
        
    };