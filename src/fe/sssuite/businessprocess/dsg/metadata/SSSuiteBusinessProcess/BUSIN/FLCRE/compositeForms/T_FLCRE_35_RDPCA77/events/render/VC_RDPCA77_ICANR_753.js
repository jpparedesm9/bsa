//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ApprovedApplication
    task.render = function (entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
        var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
        var viewState = renderEventArgs.commons.api.viewState;

        task.showButtons(renderEventArgs);

        //********Parametros
        //********Modo
        //Modo Consulta
        if (parentParameters.Task.urlParams.Modo == FLCRE.CONSTANTS.Mode.Query) {}
        //********Etapas
        //Aprobacion
        if (parentParameters.Task.urlParams.Etapa == FLCRE.CONSTANTS.Stage.Aprobacion) {}

        //********Tramite
        //Refinanciamiento, Reestructuracion, Renovacion
        if (parentParameters.Task.urlParams.Tramite == FLCRE.CONSTANTS.RequestName.Refinancing || parentParameters.Task.urlParams.Tramite == FLCRE.CONSTANTS.RequestName.Renovation || parentParameters.Task.urlParams.Tramite == FLCRE.CONSTANTS.RequestName.Reestructuration) {

        }
    };