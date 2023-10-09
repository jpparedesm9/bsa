//"TaskId": "T_ASSTSDOHFZMES_451"
//"TaskId": "T_LOANSEARCHSWA_959"
var queryString = {};
var isGroup = 'N';
task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters,
            groupCode = args.commons.api.vc.dialogParameters.CodeReceive,
            groupName = args.commons.api.vc.dialogParameters.name,
            isGroup = 'S';
        args.model.LoanSearchFilter.numIdentification = groupCode;
    };