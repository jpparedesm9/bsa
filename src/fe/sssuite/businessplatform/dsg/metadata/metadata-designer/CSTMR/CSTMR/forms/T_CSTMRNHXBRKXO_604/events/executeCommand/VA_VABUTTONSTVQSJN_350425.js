//Entity: SpousePerson
//SpousePerson. (Button) View: CustomerSpouseForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONSTVQSJN_350425 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
    if (screenMode == 'Q') {

        var controls = ['VA_TEXTINPUTBOXTLP_404425','VA_TEXTINPUTBOXXTU_738425','VA_TEXTINPUTBOXJTN_514425',
                        'VA_TEXTINPUTBOXPLP_556425','VA_TEXTINPUTBOXMPZ_379425','VA_DATEFIELDMSIZCP_990425',
                        'VA_VABUTTONOARJENM_541425','VA_VABUTTONOARJENM_541425'];
        LATFO.UTILS.disableFields(executeCommandEventArgs, controls, true);
            
    }
};