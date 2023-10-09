//Start signature to Callback event to VA_VABUTTONUWUXNHE_853769
task.executeCommandCallback.VA_VABUTTONUWUXNHE_853769 = function(entities, executeCommandCallbackEventArgs) {
//here your code
if(entities.Amount.msmDesembolsar!='--')
        {
            var msnDesm=entities.Amount.msmDesembolsar;
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError(msnDesm+'', true);
            //executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess(msnDesm, '', 20000, false);
        }
    else
        {
         executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSCR.MSG_ASSCR_LATRANSLO_93204', '', 6000, false);   
        }
    
if(executeCommandCallbackEventArgs.success==true)
    {
       clienteId=0;
       entities.LoginCallCenter.idCodRegister='';
       entities.Amount.amountApproved='';
       executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONUWUXNHE_853769');
       executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONTOSIJNF_422769');
       executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_9614ZTSONZLMVRK_410769');
       executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_82692');
            	
    }
        
    

};