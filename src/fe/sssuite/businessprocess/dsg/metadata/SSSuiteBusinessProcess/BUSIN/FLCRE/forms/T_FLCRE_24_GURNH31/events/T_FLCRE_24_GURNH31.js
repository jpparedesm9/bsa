//"TaskId": "T_FLCRE_24_GURNH31"
var guareanteeDialogParameters;

 task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
        var CustomerName=  args.commons.api.vc.dialogParameters.name;
        var identification= args.commons.api.vc.dialogParameters.documentId;
        args.model.GuaranteeSearchCriteria.Customer = customerCode +"-"+ CustomerName;
    };

