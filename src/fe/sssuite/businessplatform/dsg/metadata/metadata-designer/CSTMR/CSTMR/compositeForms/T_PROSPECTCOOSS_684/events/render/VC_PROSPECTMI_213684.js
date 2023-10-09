//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: ProspectComposite
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    renderEventArgs.commons.api.viewState.disable('G_ADDRESSRXH_631566', true);
    renderEventArgs.commons.api.viewState.disable('G_ADDRESSLJO_139566', true);
    renderEventArgs.commons.api.viewState.hide('CM_TPROSPEC_T8S', true);
    renderEventArgs.commons.api.viewState.hide('CM_TPROSPEC_STR', true);

    if (entities.Context.renapoByCurp == 'S') {
        renderEventArgs.commons.api.viewState.show('CM_TPROSPEC_MR6', true);
        renderEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MT4', true);
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXNJK_823739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXWXT_116739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXVEC_991739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXBXR_146739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXFGQ_850739');
        renderEventArgs.commons.api.viewState.disable('VA_DATEFIELDKWUZZN_303739');
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXGXM_696739');
        renderEventArgs.commons.api.viewState.disable('VA_COUNTYOFBIRTHHH_490739');
    } else {
        renderEventArgs.commons.api.viewState.hide('CM_TPROSPEC_MR6', true);
        renderEventArgs.commons.api.viewState.show('CM_TPROSPEC_MT4', true);
        renderEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXNJK_823739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXWXT_116739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXVEC_991739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXBXR_146739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXFGQ_850739');
        renderEventArgs.commons.api.viewState.enable('VA_DATEFIELDKWUZZN_303739');
        renderEventArgs.commons.api.viewState.enable('VA_TEXTINPUTBOXGXM_696739');
        renderEventArgs.commons.api.viewState.enable('VA_COUNTYOFBIRTHHH_490739');
    }
};