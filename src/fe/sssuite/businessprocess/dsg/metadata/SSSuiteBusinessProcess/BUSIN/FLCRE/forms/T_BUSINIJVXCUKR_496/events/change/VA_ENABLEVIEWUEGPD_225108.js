//Entity: QuestionsPartThree
    //QuestionsPartThree.enableView (TextInputBox) View: DataVerificationQuestions
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ENABLEVIEWUEGPD_225108 = function(  entities, changedEventArgs ) {
		changedEventArgs.commons.execServer = false;
		var viewState = changedEventArgs.commons.api.viewState;
		var grid = changedEventArgs.commons.api.grid;
		grid.disabledColumn('QV_5932_10558','answer');
		grid.disabledColumn('QV_7780_54457','answer');
		var ctrs = ['VC_DATAVERION_567496']
		BUSIN.API.disable(viewState, ctrs);        
    };