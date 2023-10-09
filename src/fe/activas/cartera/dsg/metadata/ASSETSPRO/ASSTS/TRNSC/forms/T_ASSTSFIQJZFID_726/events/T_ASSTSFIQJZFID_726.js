//"TaskId": "T_ASSTSFIQJZFID_726"
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = resp.CodeReceive;
    var CustomerName = resp.name;
    args.model.Loan.clientName = customerCode + " - " + CustomerName;
    args.model.Loan.clientID = customerCode;
    
    //Limpiar cajas de texto antes de buscar
    
    
};