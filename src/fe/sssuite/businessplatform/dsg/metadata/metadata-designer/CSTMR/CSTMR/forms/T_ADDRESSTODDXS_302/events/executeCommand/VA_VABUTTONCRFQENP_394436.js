//Entity: PhysicalAddress
//PhysicalAddress. (Button) View: AddressPopupForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONCRFQENP_394436 = function (entities, executeCommandEventArgs) {

    if (entities.PhysicalAddress.directionNumberInternal === null) {
        entities.PhysicalAddress.directionNumberInternal = -1;
    }
    if (entities.PhysicalAddress.latitude === null ){
        entities.PhysicalAddress.latitude =0;
        
    }
    if (entities.PhysicalAddress.longitude === null ){
        entities.PhysicalAddress.longitude =0;
        
    }
    if(angular.isDefined(entities.PhysicalAddress) && angular.isDefined(entities.PhysicalAddress.street) && entities.PhysicalAddress.street!==null){
        entities.PhysicalAddress.street = entities.PhysicalAddress.street.trim();
    }
    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.serverParameters.PhysicalAddress = true;

};