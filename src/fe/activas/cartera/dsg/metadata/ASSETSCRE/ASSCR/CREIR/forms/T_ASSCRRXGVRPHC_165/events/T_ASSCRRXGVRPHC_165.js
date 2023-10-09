//"TaskId": "T_ASSCRRXGVRPHC_165"


task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = resp.CodeReceive;
    var CustomerName = resp.name;
   // args.model.LoginCallCenter.idClient = customerCode + " - " + CustomerName;
     args.model.LoginCallCenter.idCliente= customerCode;
    
    
};
