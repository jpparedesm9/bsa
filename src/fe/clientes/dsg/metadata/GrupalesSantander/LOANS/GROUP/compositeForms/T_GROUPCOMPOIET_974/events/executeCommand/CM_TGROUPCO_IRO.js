// (Button) 
task.executeCommand.CM_TGROUPCO_IRO = function (entities, executeCommandEventArgs) {    
    entities.Group.nextVisitDate = '';    
    if (type == 'Consulta') {
        if (entities.Group.code != null && entities.Group.code != undefined && entities.Group.code != "") {
            entities.Group.operation = 'U';
            entities.Credit.customerId= entities.Group.code;
        }
    }
    else if (type == 'Ingreso') {
        if(entities.Group.code == null)
        {
        entities.Group.operation = 'I';
        }
        else
        {
            entities.Group.operation = 'U'
        }
    }
    executeCommandEventArgs.commons.serverParameters.Group = true;
    executeCommandEventArgs.commons.serverParameters.Member = true;
    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.api.viewState.show('CM_TGROUPCO_O3P', true);
};