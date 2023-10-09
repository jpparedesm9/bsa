//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: ProspectComposite
task.initData.VC_PROSPECTMI_213684 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = true;
    initDataEventArgs.commons.api.viewState.disable('G_GENERALEAO_954739');
    initDataEventArgs.commons.api.viewState.disable('VC_OHGJMSCFAL_971769');
    initDataEventArgs.commons.api.viewState.disable('VC_RIZJHPLTPZ_320966');
    initDataEventArgs.commons.api.viewState.hide('G_ADDRESSLJO_139566');
    initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXJOG_550739');//estado civil
    //task.showHideSpouceInformation(entities, initDataEventArgs);
};