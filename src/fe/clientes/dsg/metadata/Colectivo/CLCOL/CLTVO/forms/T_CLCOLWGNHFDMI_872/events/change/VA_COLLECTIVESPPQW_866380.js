//Entity: CollectiveRole
    //CollectiveRole.collective (ComboBox) View: CollectiveAdvisorsRoles
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_COLLECTIVESPPQW_866380 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    entities.CollectiveRole.collectiveDescription =  changedEventArgs.commons.api.viewState.selectedText('VA_COLLECTIVESPPQW_866380', changedEventArgs.newValue);
        
    };