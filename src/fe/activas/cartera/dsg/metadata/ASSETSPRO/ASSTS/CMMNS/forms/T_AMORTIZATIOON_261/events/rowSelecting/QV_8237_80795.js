//gridRowSelecting QueryView: QV_8237_80795
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_8237_80795 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        //Open Modal
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
        nav.label = gridRowSelectingEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_DESGLOSCO_45546');
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'MNTNN',
            taskId: 'T_AMORTIZATIDTE_881',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_AMORTIZATE_895881'
        };
        nav.queryParameters = {
            mode: 2
        };
        nav.modalProperties = {
            size: 'lg',
            callFromGrid: false
        };        
        nav.customDialogParameters = {
            dividend: gridRowSelectingEventArgs.rowData.share,
            loanBankID: entities.Loan.loanBankID
        };        
        nav.openModalWindow('QV_8237_80795', gridRowSelectingEventArgs.rowData);
        
    };