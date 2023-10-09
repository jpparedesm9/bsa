var screenCall;
//"TaskId": "T_PAYMENTSMANII_157"
task.getQuotation = function(quotationList, currencyTypeSearch) {
        var currencyType = 0;
        var quotationValue = 1;
        
        for (var i = 0; i < quotationList._data.length - 1; i++) {
            currencyType = quotationList._data[i].currencyType;
            if (currencyTypeSearch == currencyType) {
                quotationValue = quotationList._data[i].value;
                break;
            }
        }
        return quotationValue;
    };

task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
        var CustomerName=  args.commons.api.vc.dialogParameters.name;
        var identification= args.commons.api.vc.dialogParameters.documentId;
        args.model.Payment.customer = customerCode +"-"+ CustomerName;
        args.model.Payment.customerID = customerCode;
    };