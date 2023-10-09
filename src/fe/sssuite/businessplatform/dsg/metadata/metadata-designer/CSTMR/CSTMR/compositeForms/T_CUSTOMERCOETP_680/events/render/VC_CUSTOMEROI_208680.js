//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: CustomerComposite
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    //var client = renderEventArgs.commons.api.parentVc;
    //var api = renderEventArgs.commons.api;

    //    try {
    //        var client = renderEventArgs.commons.api.parentVc;
    //        var api = renderEventArgs.commons.api;
    //        if (api.vc.model.DemographicData.hasDisability !== undefined && api.vc.model.DemographicData.hasDisability == "N") {
    //            api.viewState.disable('VA_3231VVMQGIEFXXK_586794');
    //        }
    //        if (api.vc.model.NaturalPerson.expirationDate !== undefined && api.vc.model.NaturalPerson.expirationDate === null) {
    //            api.vc.model.NaturalPerson.indefinite = true;
    //            api.viewState.disable('VA_EXPIRATIONDAEET_157213');
    //        }
    //        if (client.customDialogParameters.Task.urlParams.MODE !== undefined && client.customDialogParameters.Task.urlParams.MODE == "Q") {
    //            task.hideModeQuery(renderEventArgs);
    //            entities.Entity1.screenMode = "Q";
    //        }
    //    }
    //    catch (err) {
    //        //CSTMR.Utils.managerException(err);
    //    }


};