//Entity: Member
//Member. (Button) View: MemberPopPupForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONXYNUHPG_895132 = function (entities, executeCommandEventArgs) {
    var catalogs = executeCommandEventArgs.commons.api.vc.catalogs;
    individualAccount = executeCommandEventArgs.commons.api.vc.parentVc.model.Group.hasIndividualAccount; //comentadao
    //executeCommandEventArgs.commons.constants.mode 

	if(entities.Member.membershipDate === null || entities.Member.membershipDate === undefined){
		executeCommandEventArgs.commons.messageHandler.showMessagesError("LOANS.LBL_LOANS_LAFECHAEL_59329");
        executeCommandEventArgs.commons.execServer = false;
	}else{
        if (executeCommandEventArgs.commons.constants.mode.Insert === mode) {
            entities.Member.operation = 'I';
        }
        else if (executeCommandEventArgs.commons.constants.mode.Update === mode) {
            entities.Member.operation = 'U';
        }
        else if (executeCommandEventArgs.commons.constants.mode.Delete === mode) {
            entities.Member.operation = 'D';
        }
        entities.Member.groupId = groupId;
        entities.Member.role = task.findValueInCatalog(entities.Member.roleId, catalogs.VA_TEXTINPUTBOXHYH_612132.data());
        entities.Member.state = task.findValueInCatalog(entities.Member.stateId, catalogs.VA_TEXTINPUTBOXAIN_291132.data());
        // entities.Member.qualification=task.findValueInCatalog(entities.Member.qualificationId, catalogs.VA_TEXTINPUTBOXKTO_991132.data());
        entities.Member.qualification = entities.Member.qualificationId;
        if (typeOrigin === LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
            entities.Member.creditCode = executeCommandEventArgs.commons.api.vc.parentVc.model.Credit.creditCode;
        }
        executeCommandEventArgs.commons.serverParameters.Member = true;
        executeCommandEventArgs.commons.execServer = true;	
	}
};