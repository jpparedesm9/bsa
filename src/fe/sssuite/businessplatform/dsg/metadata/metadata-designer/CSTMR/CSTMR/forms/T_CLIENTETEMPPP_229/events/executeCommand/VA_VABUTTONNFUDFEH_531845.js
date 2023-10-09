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