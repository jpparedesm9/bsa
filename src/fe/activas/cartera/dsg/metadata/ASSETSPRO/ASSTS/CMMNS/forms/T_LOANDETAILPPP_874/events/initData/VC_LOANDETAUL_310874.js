//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanDetailPopupForm
    task.initData.VC_LOANDETAUL_310874 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var customParams = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
		entities.Loan = customParams.Loan;
		$("#VA_VASIMPLELABELLL_441816").parent().parent().parent().find(".control-label").remove();//Delete title label
		entities.Loan.startDate = kendo.toString(entities.Loan.startDate, "d");
		entities.Loan.endDate = kendo.toString(entities.Loan.endDate, "d");
		entities.Loan.feeEndDate = kendo.toString(entities.Loan.feeEndDate, "d")
    };