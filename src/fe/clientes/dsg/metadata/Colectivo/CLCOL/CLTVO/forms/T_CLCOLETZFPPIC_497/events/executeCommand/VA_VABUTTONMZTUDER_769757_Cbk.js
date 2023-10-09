//Start signature to Callback event to VA_VABUTTONMZTUDER_769757
task.executeCommandCallback.VA_VABUTTONMZTUDER_769757 = function(entities, executeCommandCallbackEventArgs) {
//here your code
     if (executeCommandCallbackEventArgs.success) {
         if(entities.CollectiveAdvisorFile.ejecution<=2){
             executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONMZTUDER_769757', 'VA_VABUTTONMZTUDER_769757', null, false, false, 'G_LOADEXTVDO_653757', false);
             
         }
         
         if(entities.CollectiveAdvisor.data().length>0)
             {
                 executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONXICAMDT_820757');
             }
        //Mostrar exportar
        CLCOL.hideOrShowDSGGridButtonByClass('cb-btn-export','show');
        
        executeCommandCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394', 'CEQV_201QV_3718_27394_509');
     }
};