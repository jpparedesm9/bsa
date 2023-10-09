//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: warrantiesCreation
task.render = function (entities, renderEventArgs) {
    var api = renderEventArgs.commons.api;
    var viewState = api.viewState;
    var params = renderEventArgs.commons.api.navigation.getCustomDialogParameters();
    var typeOfGuarantee = "";
    viewState.readOnly('VA_ARANSCATIO0709_IDER508', true); //plazo fijo
    BUSIN.API.addStyle('cb-group-flex', viewState, ['GR_ARANSCATIO07_15']);

    if (params != undefined && params.typeGuaranteeData != undefined) {
        typeOfGuarantee = params.typeGuaranteeData.typeOfGuarantee;
    } else {
        //SRO
        if (renderEventArgs.commons.api.parentVc != undefined && renderEventArgs.commons.api.parentVc.customDialogParameters != undefined) {
            typeOfGuarantee = renderEventArgs.commons.api.parentVc.customDialogParameters.currentRow.Type;
            params.typeGuaranteeData = renderEventArgs.commons.api.parentVc.customDialogParameters.currentRow;
        }
    }

    if ('PERSONAL' == typeOfGuarantee) { //GARGPE
        //viñeta de datos adicionales
        viewState.disable('VC_RRCAI67_GUSME_893', true);
    }

};