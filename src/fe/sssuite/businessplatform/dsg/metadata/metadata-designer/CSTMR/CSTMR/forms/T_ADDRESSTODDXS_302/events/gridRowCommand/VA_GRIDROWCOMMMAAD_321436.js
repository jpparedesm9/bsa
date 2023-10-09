//Entity: Phone
//Phone. (Button) View: AddressPopupForm

task.gridRowCommand.VA_GRIDROWCOMMMAAD_321436 = function(  entities, gridRowCommandEventArgs ) {
    gridRowCommandEventArgs.commons.execServer = false;
    
    var args = gridRowCommandEventArgs;
    
    if(args.rowData.isChecked == 'S'){
        //grid.addCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);
        args.commons.messageHandler.showMessagesInformation('CSTMR.MSG_CSTMR_ELNMEROEE_39880');
    } else {

        var nav = args.commons.api.navigation;
        nav.label = args.commons.api.viewState.translate('CSTMR.LBL_CSTMR_CDIGODEIC_62610');
        nav.address = {
            moduleId: 'CSTMR',
            subModuleId: 'CSTMR',
            taskId: 'T_CSTMRGAPGAKXO_726',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_CODEVERICU_522726'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'sm',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            cstmrCode: entities.PhysicalAddress.personSecuential,
            phoneNumber: args.rowData.phoneNumber,
            valType: 'SMS',
            addressId: entities.PhysicalAddress.addressId
        };
        nav.openModalWindow(args.commons.controlId, args.rowData);
    }
};