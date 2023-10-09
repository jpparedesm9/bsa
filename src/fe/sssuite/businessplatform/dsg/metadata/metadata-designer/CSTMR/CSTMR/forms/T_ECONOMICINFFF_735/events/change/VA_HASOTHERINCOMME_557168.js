//Entity: EconomicInformation
//EconomicInformation.hasOtherIncome (CheckBox) View: EconomicInfForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_HASOTHERINCOMME_557168 = function (entities, changedEventArgs) {


    if (entities.EconomicInformation.hasOtherIncome) {
        if (!angular.isDefined(changedEventArgs.commons.api.vc.parentVc)) {
            changedEventArgs.commons.api.viewState.enable('VA_OTHERINCOMESEEE_418168');
            changedEventArgs.commons.api.viewState.enable('VA_SALESPRFYEHZSYT_162168');
        }
    } else {
        changedEventArgs.commons.api.viewState.disable('VA_OTHERINCOMESEEE_418168');
        changedEventArgs.commons.api.viewState.disable('VA_SALESPRFYEHZSYT_162168');
        entities.EconomicInformation.otherIncomeSource = null;
        entities.EconomicInformation.sales = null;
    }
    
    if (screenMode == 'Q'){
         changedEventArgs.commons.api.viewState.disable('VA_OTHERINCOMESEEE_418168');
         changedEventArgs.commons.api.viewState.disable('VA_SALESPRFYEHZSYT_162168');
    }

    changedEventArgs.commons.execServer = false;

};