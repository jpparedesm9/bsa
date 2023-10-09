//"TaskId": "T_ASSCRMFWPCNKI_783"
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = resp.CodeReceive;
    var CustomerName = resp.name;
    var isGroup = resp.isGroup;
    args.model.PrefilledRequest.clientId = customerCode;
    args.model.PrefilledRequest.clientIdStr = customerCode;
    args.model.PrefilledRequest.isGroup = isGroup;
};
