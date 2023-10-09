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
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.businessprocess.orchestrator.wf.route.ICommitRejectionCreditTramite;

@Component(name = "CommitRejectionCreditTramite", immediate = false)
@Service({ com.cobiscorp.ecobis.businessprocess.orchestrator.wf.route.ICommitRejectionCreditTramite.class })
@Properties({ @Property(name = "service.description", value = "commitRejectionCreditTramite"),
		@Property(name = "service.vendor", value = "COBISCORP"), @Property(name = "service.version", value = "1.0.0"),
		@Property(name = "service.identifier", value = "commitRejectionCreditTramite") })
public class CommitRejectionCreditTramite implements ICommitRejectionCreditTramite {

	private static final ILogger LOGGER = LogFactory.getLogger(CommitRejectionCreditTramite.class);

	private static final String ORCHESTRATOR_NAME = "cob_procesador..commitRejectionCreditTramite";

	@Reference(bind = "setSpOchestrator", unbind = "unsetSpOchestrator", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ISPOrchestrator spOrchestrator;

	@Override
	public boolean commitRejectionCreditTramite(String processInstanceIdentifier, String field1, String field2, Integer field3, String field4)
			throws CTSServiceException, CTSInfrastructureException {

		if (LOGGER.isDebugEnabled()) {
			StringBuffer sb = new StringBuffer();
			sb.append("Process Instance Identifier: " + processInstanceIdentifier);
			sb.append("\tfield 1: " + field1);
			sb.append("\tfield 2: " + field2);
			sb.append("\tfield 3: " + field3);
			sb.append("\tfield 4: " + field4);
			LOGGER.logDebug(sb.toString());
		}

		IProcedureRequest procedureRequest = new ProcedureRequestAS();
		procedureRequest.setSpName(ORCHESTRATOR_NAME);
		//procedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLINT4, field2);
		procedureRequest.addInputParam("@i_tramite", ICTSTypes.SQLINT4, field3.toString());
		//procedureRequest.addInputParam("@i_observaciones", ICTSTypes.SQLVARCHAR, field4);
		procedureRequest.addInputParam("@i_observaciones", ICTSTypes.SQLVARCHAR, field2);
		procedureRequest.addFieldInHeader(ICOBISTS.HEADER_TRN, ICOBISTS.HEADER_NUMBER_TYPE, "0");

		IProcedureResponse procedureResponse = spOrchestrator.executeSP(procedureRequest);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("ProcedureResponse from commitRejectionCreditTramite "
					+ CommonCharacter.convertKParameter(procedureResponse.getProcedureResponseAsString()));
		}
		if (procedureResponse.hasError()) {
			@SuppressWarnings("unchecked")
			Collection<IMessageBlock> messages = procedureResponse.getMessages();
			for (IMessageBlock m : messages) {
				LOGGER.logError("Message number: " + m.getMessageNumber() + " Message text" + m.getMessageText());
			}
			throw new BusinessException(90000, "Error during the execution of " + ORCHESTRATOR_NAME, "Plesea review the orchestration");

		} else {
			return true;
		}
	}

	protected void setSpOchestrator(ISPOrchestrator ispOrchestrator) {
		LOGGER.logDebug("NMA setSpOchestrator");
		this.spOrchestrator = ispOrchestrator;
	}

	protected void unsetSpOchestrator(ISPOrchestrator ispOrchestrator) {
		if (spOrchestrator == ispOrchestrator) {
			spOrchestrator = null;
		}
	}

}
