//Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar de un label de un input control.
    task.executeLabelCommand.VA_TUTORIDJFWNDWTD_976168 = function(  entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;
    };

/*task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var customerCode= args.commons.api.vc.dialogParameters.CodeReceive;
        var CustomerName= args.commons.api.vc.dialogParameters.name;
        var identification= args.commons.api.vc.dialogParameters.documentId;
        args.model.EconomicInformation.tutorName = CustomerName;
        args.model.EconomicInformation.tutorId = customerCode;
    };
*/
//Entity: EconomicInformation
    //EconomicInformation.tutorId (TextInputButton) View: EconomicInfForm
    
task.textInputButtonEvent.VA_TUTORIDJFWNDWTD_976168 = function( textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label =cobis.translate('CSTMR.LBL_CSTMR_BSQUEDADE_82600');
        nav.customAddress = {id: "findCustomer", url:"customer/templates/find-customers-tpl.html"};
        nav.modalProperties = {size: 'lg'};
        nav.scripts = [{module: cobis.modules.CUSTOMER, files: ["/customer/services/find-customers-srv.js","/customer/controllers/find-customers-ctrl.js"]}];
        nav.customDialogParameters = {};
};