// (Button) 
    task.executeCommand.CM_PAYMENTS_NNS = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //Open Modal
        var nav = executeCommandEventArgs.commons.api.navigation;
        nav.label = cobis.translate('ASSTS.LBL_ASSTS_PRIORIDAA_58251'); //Priodidades
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_PRIORITIESENY_489',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_PRIORITIOM_989489'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'md',
            callFromGrid: false
        };
        var priorities2 = angular.copy(entities.Priorities);
        nav.customDialogParameters = {
            bankNum: entities.Loan.loanBankID,
            priorities: priorities2
        }; 
        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
        
    };