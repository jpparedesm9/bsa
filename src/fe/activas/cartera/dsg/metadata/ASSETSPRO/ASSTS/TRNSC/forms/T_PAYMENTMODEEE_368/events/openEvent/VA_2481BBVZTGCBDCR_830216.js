//Entity: PaymentForm
    //PaymentForm.accountNumber (TextInputButton) View: PaymentModeForm
    
    task.textInputButtonEvent.VA_2481BBVZTGCBDCR_830216 = function(textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
        //if(textInputButtonEventArgs.model.PaymentForm.payFormCategory != ""){
        //Open Modal
           var nav = textInputButtonEventArgs.commons.api.navigation;
           nav.label = cobis.translate('ASSTS.LBL_ASSTS_CUENTASAT_41675'); //Cuentas 
           nav.address = {
               moduleId: 'ASSTS',
               subModuleId: 'TRNSC',
               taskId: 'T_BANKACCOUNTOA_777',
               taskVersion: '1.0.0',
               viewContainerId: 'VC_BANKACCOMU_224777'
           };
           nav.queryParameters = {
               mode: 1
           };
           nav.modalProperties = {
               size: 'md',
               callFromGrid: false
           };
           nav.customDialogParameters = {
               customerID: textInputButtonEventArgs.model.PaymentForm.clientId,
               payFormId:  textInputButtonEventArgs.model.PaymentForm.payFormId,            
               desOpeType: textInputButtonEventArgs.model.Loan.desOperationType,
               currencyId: textInputButtonEventArgs.model.PaymentForm.currencyId
           };
         //}
    };