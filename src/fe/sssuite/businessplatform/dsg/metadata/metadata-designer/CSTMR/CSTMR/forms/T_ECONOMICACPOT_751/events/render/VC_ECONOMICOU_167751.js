//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: EconomicActivityPopupForm
task.render = function (entities, renderEventArgs){
    renderEventArgs.commons.execServer = false;

    var api = renderEventArgs.commons.api;

    if (api.parentVc.model.Entity1.screenMode == 'Q') {
        api.viewState.disable('VA_SECUENTIALWARUP_426887');
        api.viewState.disable('VA_ECONOMICSECTORO_655887');
        api.viewState.disable('VA_SUBSECTORFKJIRP_876887');
        api.viewState.disable('VA_ECONOMICACTIYTT_504887');
        api.viewState.disable('VA_DESCRIPTIONGSVS_438887');
        api.viewState.disable('VA_PRINCIPALJAQWIU_928887');
        api.viewState.disable('VA_STARTDATEACTIYI_966887');
        api.viewState.disable('VA_ANTIQUITYAOXEZY_723887');
        api.viewState.disable('VA_NUMBEREMPLOYEEE_936887');
        api.viewState.disable('VA_AUTHORIZEDRYTPO_449887');
        api.viewState.disable('VA_AFFILIATEEORSHU_858887');
        api.viewState.disable('VA_PLACEAFFILIAOTT_272887');
        api.viewState.disable('VA_ENVIRONMENTRONU_551887');
        api.viewState.disable('VA_PROPERTYTYPEDLF_626887');
        api.viewState.disable('CM_TECONOMI_RSP');
    }

};