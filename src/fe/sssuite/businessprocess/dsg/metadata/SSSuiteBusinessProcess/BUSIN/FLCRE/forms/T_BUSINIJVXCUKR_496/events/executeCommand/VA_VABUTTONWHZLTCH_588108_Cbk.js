//Entity: QuestionsPartThree
    //QuestionsPartThree. (Button) View: DataVerificationQuestions
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONWHZLTCH_588108 = function(  entities, executeCommandEventArgs ) {
		executeCommandEventArgs.commons.execServer = false;
		executeCommandEventArgs.commons.api.vc.rowData.answer = entities.QuestionsPartThree.result;        
    };