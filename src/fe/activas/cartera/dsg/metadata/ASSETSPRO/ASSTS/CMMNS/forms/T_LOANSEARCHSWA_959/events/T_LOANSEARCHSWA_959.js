//"TaskId": "T_LOANSEARCHSWA_959"
var queryString = {};
var isGroup = 'N';
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = args.commons.api.vc.dialogParameters.CodeReceive;
    var CustomerName = args.commons.api.vc.dialogParameters.name;
    var identification = args.commons.api.vc.dialogParameters.documentId;    
    var customerType = args.commons.api.vc.dialogParameters.customerType;

    var title = '';
    if (args.model.LoanInstancia.idOptionMenu == 14) {
        args.model.LoanSearchFilter.group = 'S';
    }

    switch (customerType) {
    case 'P':
        title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
        isGroup = 'N';
        break;
    case 'C':
        title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
        isGroup = 'N';
        break;
    case 'S':
        title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
        isGroup = 'S';
        break;
    case 'G':
        title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
        isGroup = 'S';
        break;
    }
    args.model.LoanSearchFilter.numIdentification = customerCode;
    args.commons.api.viewState.label("VA_CODCLIENTCIXLEY_866508",title);
};