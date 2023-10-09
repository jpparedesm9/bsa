//Entity: RefinanceLoanFilter
    //RefinanceLoanFilter.currencyTypeAux (ComboBox) View: RefinanceLoansFilter
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_CURRENCYTYPEUXU_869515 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var catalogData = changeEventArgs.commons.api.vc.catalogs.VA_CURRENCYTYPEUXU_869515._data;
        var currencySymbol = '';
        for (var i = 0; i <= catalogData.length - 1; i++) {
            if (catalogData[i].code == entities.RefinanceLoanFilter.currencyTypeAux) {
                currencySymbol = catalogData[i].value;
                break;
            }
        }
        entities.RefinanceLoanFilter.newLoanCurrency = currencySymbol;
        entities.RefinanceLoanFilter.payMethodCurrency = currencySymbol;
    };