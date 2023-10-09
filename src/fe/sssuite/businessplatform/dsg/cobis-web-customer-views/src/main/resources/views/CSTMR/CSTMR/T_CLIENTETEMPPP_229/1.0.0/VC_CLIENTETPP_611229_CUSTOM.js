/* variables locales de T_CLIENTETEMPPP_229*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.clientetemp;
    

    //"TaskId": "T_CLIENTETEMPPP_229"


    //Entity: Entity1
    //Entity1. (Button) View: ClienteTemp
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONNFUDFEH_531845 = function(  entities, executeCommandEventArgs ) {
        try {
        executeCommandEventArgs.commons.execServer = false;
        var moduleId = "", subModuleId = "",
            taskId = "", vcId = "", 
            label = "",
            parameters = {
                loanInstancia : entities.Entity1
          };        
        
          moduleId = "CSTMR";
          subModuleId = "CSTMR";
          taskId = "T_CUSTOMERCOETP_680";
          vcId = "VC_CUSTOMEROI_208680";
          label = "CONSULTA DE CLIENTES";
         
		 executeCommandEventArgs.commons.api.vc.customDialogParameters={Task:{urlParams:{MODE:"Q"}}};
		 
         if (entities.Entity1.errorValidation != true){
            var apiNav = executeCommandEventArgs.commons.api.navigation;            
               apiNav.label = label;
               apiNav.address = {
                  moduleId: moduleId,
                  subModuleId: subModuleId,
                  taskId: taskId,
                  taskVersion: "1.0.0",
                  viewContainerId: vcId
              };
              apiNav.customDialogParameters = {parameters : parameters,Task:{urlParams:{MODE:"Q"}} };            
              apiNav.navigate(executeCommandEventArgs.commons.controlId);
         }
         
        
        //executeCommandEventArgs.commons.serverParameters.Entity1 = true;
      } catch (err) {
            CSTMR.Utils.managerException(err);
      }
        
    };

//Entity: Entity1
    //Entity1. (Button) View: ClienteTemp
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONWXVCRTB_198845 = function(  entities, executeCommandEventArgs ) {
      try {
        executeCommandEventArgs.commons.execServer = false;
        var moduleId = "", subModuleId = "",
            taskId = "", vcId = "", 
            label = "",
            parameters = {
                loanInstancia : entities.Entity1
          };        
        
          moduleId = "CSTMR";
          subModuleId = "CSTMR";
          taskId = "T_CUSTOMERCOETP_680";
          vcId = "VC_CUSTOMEROI_208680";
          label = "CONSULTA DE CLIENTES";
           
         if (entities.Entity1.errorValidation != true){
            var apiNav = executeCommandEventArgs.commons.api.navigation;            
               apiNav.label = label;
               apiNav.address = {
                  moduleId: moduleId,
                  subModuleId: subModuleId,
                  taskId: taskId,
                  taskVersion: "1.0.0",
                  viewContainerId: vcId
              };
              apiNav.customDialogParameters = { 
                     parameters : parameters };            
              apiNav.navigate(executeCommandEventArgs.commons.controlId);
         }
        //executeCommandEventArgs.commons.serverParameters.Entity1 = true;
      } catch (err) {
            CSTMR.Utils.managerException(err);
      }
    };



}));