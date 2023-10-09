//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: LoadCollectivePerson
task.initData.VC_LOADCOLLEV_719333 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    initDataEventArgs.commons.api.viewState.disable('VA_VABUTTONUKAXPIV_480908');
    initDataEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_216908');
    initDataEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_690908');
    $("#VA_VASIMPLELABELLL_989908").text(0);
    $("#VA_VASIMPLELABELLL_366908").text(0);
    $("#VA_VASIMPLELABELLL_901908").text(0);    
};