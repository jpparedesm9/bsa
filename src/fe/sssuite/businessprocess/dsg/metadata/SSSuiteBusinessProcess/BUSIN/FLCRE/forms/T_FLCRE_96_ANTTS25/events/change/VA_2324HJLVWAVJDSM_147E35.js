//Entity: ParameterPrint
    //ParameterPrint.companyName (ComboBox) View: parameterPrintTask
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_2324HJLVWAVJDSM_147E35 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.serverParameters.OriginalHeader = true;
        changedEventArgs.commons.serverParameters.ParameterPrint = true;
        changedEventArgs.commons.execServer = true;
    };