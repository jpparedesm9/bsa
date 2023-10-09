//Entity: Member
    //Member. (Button) View: MemberForm
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAA_212848 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = false;
    
//Open Modal
var nav = gridRowCommandEventArgs.commons.api.navigation;

nav.label = 'Relaciones';
nav.address = {
    moduleId: 'CSTMR',
    subModuleId: 'CSTMR',
    taskId: 'T_RELATIONAJNQY_494',
    taskVersion: '1.0.0',
    viewContainerId: 'VC_RELATIONQE_861494'
};
nav.queryParameters = {
    mode: 1
};
nav.modalProperties = {
    size: 'lg',
    callFromGrid: false
};
nav.customDialogParameters = {
    modeRelation:'ModeRelation',
   codigoCli:gridRowCommandEventArgs.rowData.customerId
}

//Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
//nav.openModalWindow(args.commons.controlId, null);
//Si la llamada es desde un evento de un control perteneciente a una grilla de la página
nav.openModalWindow('QV_7978_25243', gridRowCommandEventArgs.modelRow);

    
        
    };