//Entity: Group
//Group.addressMember (CheckBox) View: GroupForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_8723IIAMUFLQPPL_567725 = function(  entities, changedEventArgs ) {
	changedEventArgs.commons.execServer = false;
	if(changedEventArgs.commons.api.parentVc==undefined){
		if(entities.Group.addressMember==true){
			changedEventArgs.commons.api.viewState.disable('VA_9330BRACKQSJMLZ_312725');
			changedEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLLT_362725'); 
			/*  if(entities.Group.code){
				changedEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPEWRVJ_935520', false);
            }*/
        } else{
			changedEventArgs.commons.api.viewState.enable('VA_9330BRACKQSJMLZ_312725');
			changedEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLLT_362725'); 
			entities.Group.meetingAddress=null;
		}
	}  
};