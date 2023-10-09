//Entity: CollectiveAdvisorFile
    //CollectiveAdvisorFile. (Button) View: LoadExternalAdvisor
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONQOPUGSB_200757 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
        if(entities.CollectiveAdvisorFile.nameFile!=="")
            {
              executeCommandEventArgs.commons.api.vc.removeFile('VA_1BNOXXDXEIKXBOP_815757')
            }
        executeCommandEventArgs.commons.api.viewState.disable('VA_VABUTTONXICAMDT_820757');
        executeCommandEventArgs.commons.api.grid.refresh('QV_3718_27394');
        entities.CollectiveAdvisorFile.ejecution=1;
         
        CLCOL.fileLoadingPercent(0,"VA_VASIMPLELABELLL_164757");
        executeCommandEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_604757');
        executeCommandEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_164757');

        CLCOL.hideOrShowDSGGridButtonByClass('cb-btn-export','hide');
        executeCommandEventArgs.commons.api.grid.showToolBarButton('QV_3718_27394', 'CEQV_201QV_3718_27394_509');
    };