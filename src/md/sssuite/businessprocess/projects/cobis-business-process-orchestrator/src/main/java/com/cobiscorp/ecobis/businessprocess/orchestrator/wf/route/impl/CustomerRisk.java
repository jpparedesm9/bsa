package com.cobiscorp.ecobis.businessprocess.orchestrator.wf.route.impl;

import java.util.Collection;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.commons.utils.CommonCharacter;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSInfrastructureException;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSServiceException;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.businessprocess.orchestrator.wf.route.ICustomerRisk;

@Component(name = "CustomerRisk", immediate = false)
@Service({ com.cobiscorp.ecobis.businessprocess.orchestrator.wf.route.ICustomerRisk.class })
@Properties({ @Property(name = "service.description", value = "CustomerRisk"), @Property(name = "service.vendor", value = "COBISCORP"),
		@Property(name = "service.version", value = "1.0.0"), @Property(name = "service.identifier", value = "CustomerRisk") })
public class CustomerRisk implements ICustomerRisk {

	private static final ILogger LOGGER = LogFactory.getLogger(CustomerRisk.class);

	private static final String ORCHESTRATOR_NAME = "cob_procesador..riskOrchestration";

	@Reference(bind = "setSpOchestrator", unbind = "unsetSpOchestrator", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ISPOrchestrator spOrchestrator;
	
	@Override
	public boolean evaluateCustomerRisk(String processInstanceIdentifier, String field1, String field2, Integer field3, String field4) throws CTSServiceException, CTSInfrastructureException {
		if (LOGGER.isDebugEnabled()) {
			StringBuffer sb = new StringBuffer();
			sb.append("Process Instance Identifier: " + processInstanceIdentifier);
			sb.append("\tfield 1: " + field1);
			sb.append("\tfield 2: " + field2);
			sb.append("\tfield 3: " + field3);
			sb.append("\tfield 4: " + field4);
			LOGGER.logDebug(sb.toString());

		}
		
		//Recupero el usuario del contexto
		Context context = ContextManager.getContext();
		String user = context.getSession().getUser();
		if(LOGGER.isDebugEnabled()){
			LOGGER.logDebug("User --> " + user);
		}
		

		IProcedureRequest procedureRequest = new ProcedureRequestAS();
		procedureRequest.setSpName(ORCHESTRATOR_NAME);
		procedureRequest.addInputParam("@i_id_inst_proc",ICTSTypes.SQLINT1, processInstanceIdentifier);
		procedureRequest.addInputParam("@i_user", ICTSTypes.SQLVARCHAR, user);
		procedureRequest.addFieldInHeader(ICOBISTS.HEADER_TRN,ICOBISTS.HEADER_NUMBER_TYPE , "0");

		IProcedureResponse procedureResponse = spOrchestrator.executeSP(procedureRequest);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("ProcedureResponse from risk Orchestration " + CommonCharacter.convertKParameter(procedureResponse.getProcedureResponseAsString()));
		    }
		if(procedureResponse.hasError()){
			@SuppressWarnings("unchecked")
			Collection<IMessageBlock> messages = procedureResponse.getMessages();
			for (IMessageBlock m : messages) {
				LOGGER.logError("Message number: " + m.getMessageNumber() + " Message text" + m.getMessageText());
			}
			throw new BusinessException(90001, "Error during the execution of " + ORCHESTRATOR_NAME, "Plesea review the orchestration");
			
			
		}else{
			return true;
		}
		
	}

	protected void setSpOchestrator(ISPOrchestrator ispOrchestrator){
		this.spOrchestrator = ispOrchestrator;
	}

	protected void unsetSpOchestrator(ISPOrchestrator ispOrchestrator){
		if(spOrchestrator == ispOrchestrator){
			spOrchestrator = null;
		}
	}
}
