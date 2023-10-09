//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanSearchGroupForm
    task.initData.VC_LOANSEARUG_773451 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.viewState.hide('VA_AVANCESEARCHJRS_939549');         
    };