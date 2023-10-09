//"TaskId": "T_PAYMENTMODEEE_368"

task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode = resp.CodeReceive;
        var CustomerName = resp.name;
        //var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
        //var CustomerName=  args.commons.api.vc.dialogParameters.name;
        //var identification= args.commons.api.vc.dialogParameters.documentId;
        args.model.PaymentForm.clientFullName = customerCode +" - "+ CustomerName;
        args.model.PaymentForm.clientId = customerCode;
    };