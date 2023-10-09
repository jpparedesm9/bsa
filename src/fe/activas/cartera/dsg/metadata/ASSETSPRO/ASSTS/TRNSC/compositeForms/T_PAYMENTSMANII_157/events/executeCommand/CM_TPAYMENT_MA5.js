// (Button) 
    task.executeCommand.CM_TPAYMENT_MA5 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //Open Modal
        var nav = executeCommandEventArgs.commons.api.navigation;

        nav.label = cobis.translate('ASSTS.LBL_ASSTS_CONDONASE_22340'); //Condonaciones
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_CONDONATIOSNN_532',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_CONDONATON_778532'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'lg',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            bankNum: entities.Loan.loanBankID,
            condonationDetail2: entities.CondonationDetail 
        };  

        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };