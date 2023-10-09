//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RefinanceLoansFilter
    task.initData.VC_REFINANCSL_902781 = function (entities, initDataEventArgs){
        var viewState = initDataEventArgs.commons.api.viewState;
        viewState.hide("VA_OPERATIONPZCOUQ_327515");
        
        initDataEventArgs.commons.execServer = false;
        entities.RefinanceLoanFilter.totalRefinance = 0;
        entities.RefinanceLoanFilter.newLoanTerm = 0;
        entities.RefinanceLoanFilter.periodicity = 'MES(ES)';
        entities.RefinanceLoanFilter.newLoanCurrency = 'MX';
        entities.RefinanceLoanFilter.overDue = 'N/A';
        entities.RefinanceLoanFilter.capitalBalance = 0;
        entities.RefinanceLoanFilter.interestBalance = "";
        entities.RefinanceLoanFilter.arrearsBalance = 0;
        entities.RefinanceLoanFilter.otherBalance = 0;
        entities.RefinanceLoanFilter.aditionalBalance = 0;
        
        
    };