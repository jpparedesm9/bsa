//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: GeneralBusinessData
task.initData.VC_GENERALBSI_401479 = function (entities, initDataEventArgs) {
  initDataEventArgs.commons.execServer = false;
  var customDialogParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
  //Instancia de proceso
    entities.Customer.processInstance = (angular.isDefined(customDialogParameters) && customDialogParameters!==null && customDialogParameters.Task!==null) ? customDialogParameters.Task.processInstanceIdentifier : null;
    
    if(entities.Customer.processInstance!==null){
        initDataEventArgs.commons.execServer = true;
    }else{
        console.log("Error al obtener la instancia de proceso");
    }
    
    //openFindCustomer(initDataEventArgs);
    //entities.Customer.customerId = 5;

};