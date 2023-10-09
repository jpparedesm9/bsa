//Entity: ConciliationManualSearchFilter
    //ConciliationManualSearchFilter.customCode (TextInputButton) View: ConciliationManualSearchForm
    task.customValidate.VA_CUSTOMCODEETRCB_211547 = function(  entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;

        var customCode = entities.ConciliationManualSearchFilter.customCode;
        if (customCode < 0 || customCode > 2147483647) {
            customValidateEventArgs.errorMessage = 'ASSTS.MSG_ASSTS_VALORESDA_30202';
            customValidateEventArgs.isValid = false;
        }else{
            customValidateEventArgs.isValid = true;
        }
    };