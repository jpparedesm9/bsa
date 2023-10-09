package com.cobiscorp.cobis.asscr.customevents.form.events;

import java.util.Map;

import com.cobiscorp.cobis.asscr.model.Amount;
import com.cobiscorp.cobis.asscr.model.CallCenterQuestion;
import com.cobiscorp.cobis.asscr.model.LoginCallCenter;
import com.cobiscorp.cobis.asscr.model.QuestionValidation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.constants.Outputs;
import com.cobiscorp.ecobis.callcenter.commons.services.AutorizeDispositionManager;
import com.cobiscorp.ecobis.callcenter.commons.services.CallCenterQuestionsManager;

import cobiscorp.ecobis.bussinescallcenter.dto.AutorizedDispositionRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class AutorizeDisposition extends BaseEvent implements IExecuteCommand {
	
	private static final ILogger logger = LogFactory.getLogger(AutorizeDisposition.class);
	
	public AutorizeDisposition(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {
		// TODO Auto-generated method stub
		try
		{
		logger.logDebug("executeDataEvent AutorizeDisposition Call Center");
	
		DataEntity amount = arg0.getEntity(Amount.ENTITY_NAME);
		logger.logDebug("amount operation -->"+amount.get(Amount.OPERATION));
		logger.logDebug("amount monto     -->"+amount.get(Amount.AMOUNTAPPROVED));
		AutorizedDispositionRequest auDisRequest =new AutorizedDispositionRequest();
		auDisRequest.setOperation(amount.get(Amount.OPERATION));
		auDisRequest.setMonto(amount.get(Amount.AMOUNTAPPROVED).doubleValue());
		
		Map<String, Object> otputs=null;
		AutorizeDispositionManager autorizeDispositionManager=new AutorizeDispositionManager(getServiceIntegration());
		otputs=autorizeDispositionManager.AutorizationDispositionMsm(auDisRequest, arg1);
        logger.logDebug("otputs-->"+otputs);	
		
		if(otputs.get("@o_msg").toString()!=null)
		{	
			String msmDesembolsar=null;
			msmDesembolsar=otputs.get("@o_msg").toString();
			logger.logDebug("msm validation-->"+msmDesembolsar);		
				logger.logDebug("msm validation ingresa-->"+msmDesembolsar);
				amount.set(Amount.MSMDESEMBOLSAR, msmDesembolsar);
				
		}
		}catch(Exception e) {
			logger.logDebug("Error" +e);
			}

		
	}

}
