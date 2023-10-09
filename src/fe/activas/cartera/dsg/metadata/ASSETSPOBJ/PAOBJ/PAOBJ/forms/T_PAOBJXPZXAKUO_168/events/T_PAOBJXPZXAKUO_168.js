//"TaskId": "T_PAOBJXPZXAKUO_168"
var queryString = {};
var isGroup = 'N';
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = args.commons.api.vc.dialogParameters.CodeReceive;
    var CustomerName = args.commons.api.vc.dialogParameters.name;
    var identification = args.commons.api.vc.dialogParameters.documentId;    
    var customerType = args.commons.api.vc.dialogParameters.customerType;

    var title = '';

    switch (customerType) {
    case 'P':
        title = 'PAOBJ.LBL_PAOBJ_CDIGOCLEI_32810';
        isGroup = 'N';
        break;
    case 'C':
        title = 'PAOBJ.LBL_PAOBJ_CDIGOCLEI_32810';
        isGroup = 'N';
        break;
    case 'S':
        title = 'PAOBJ.LBL_PAOBJ_CDIGOGROU_63314';
        isGroup = 'S';
        break;
    case 'G':
        title = 'PAOBJ.LBL_PAOBJ_CDIGOGROU_63314';
        isGroup = 'S';
        break;
    }
    args.model.DatosBusquedaPagoObjetado.criterioBusqueda = customerCode;
    args.model.DatosBusquedaPagoObjetado.esGrupo = isGroup;
    args.commons.api.viewState.label("VA_1WFWHEAZGTYHGIU_390505",title);
};

task.gridRowCommand.VA_CHECKBOXSAGRGOQ_593505 = function (rowData, gridRowCommandEventArgs) {
    var viewState = gridRowCommandEventArgs.commons.api.viewState;
    var anterior = true;
    gridRowCommandEventArgs.commons.execServer = false;
    gridRowCommandEventArgs.stopPropagation = true;
    anterior = gridRowCommandEventArgs.rowData.seleccionar;
    if (anterior == false) {
        gridRowCommandEventArgs.rowData.seleccionar = true;
    } else {
        gridRowCommandEventArgs.rowData.seleccionar = false;
    }
};