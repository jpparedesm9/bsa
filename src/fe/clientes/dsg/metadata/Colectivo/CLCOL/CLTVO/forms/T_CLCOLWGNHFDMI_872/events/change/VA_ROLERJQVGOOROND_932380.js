//Entity: CollectiveRole
    //CollectiveRole.role (ComboBox) View: CollectiveAdvisorsRoles
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ROLERJQVGOOROND_932380 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    activate = true;
    entities.CollectiveRole.roleDescription =  changedEventArgs.commons.api.viewState.selectedText('VA_ROLERJQVGOOROND_932380', changedEventArgs.newValue);
    entities.CollectiveRole.official = null;
    entities.CollectiveRole.collective = null;
    entities.CollectiveRole.collectiveDescription = null;
    changedEventArgs.commons.api.viewState.refreshData('VA_OFFICIALYYQHLMI_968380');    
    };