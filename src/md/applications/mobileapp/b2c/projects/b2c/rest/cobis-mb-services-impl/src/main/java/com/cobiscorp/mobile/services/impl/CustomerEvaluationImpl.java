package com.cobiscorp.mobile.services.impl;

import java.security.Key;
import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.crypt.ICobisCrypt;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.response.CustomerEvaluationResponse;
import com.cobiscorp.mobile.service.interfaces.ICustomerEvaluation;
import com.cobiscorp.mobile.services.impl.utils.ManagerException;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ ICustomerEvaluation.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class CustomerEvaluationImpl extends ServiceBase implements ICustomerEvaluation {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisCrypt", unbind = "unsetCobisCrypt", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICobisCrypt cobisCrypt;

	private static final String ID_APPLICATION = "bancaMovil";

	/** Class name. */
	private static final String CLASS_NAME = " [ MB ---> CustomerEvaluationImpl] ";

	/** Logger. */
	private ILogger LOGGER = LogFactory.getLogger(CustomerEvaluationImpl.class);

	private Map<String, Key> privateKeysMap;

	private ISPOrchestrator spOrchestrator;

	public void setPrivateKeysMap(Map<String, Key> privateKeysMap) {
		this.privateKeysMap = privateKeysMap;
	}

	// implementacion servicios
	@Override
	public CustomerEvaluationResponse customerEvaluationImpl(com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest customerRequest, String cobisSessionId)
			throws MobileServiceException {

		CustomerEvaluationResponse customerEvaluationResponse = new CustomerEvaluationResponse();
		boolean evaluationOKB = false;
		MessageTO messageTO = new MessageTO();

		String wInfo = "[CustomerEvaluationImpl][customerEvaluationImpl] ";
		try {

			LOGGER.logDebug(wInfo + "Datos customerRequest: " + customerRequest);

			com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = null;
			serviceResponse = this.execute1(cobisSessionId, serviceIntegration, LOGGER, "OrchestrationClientValidationServiceSERVImpl.customerEvaluation", new Object[] { customerRequest });

			LOGGER.logDebug(wInfo + "Datos serviceResponse: " + serviceResponse.getData());

			if (serviceResponse.isResult()) {

				OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse.getData();

				LOGGER.logDebug(wInfo + "Datos orchestrationClientValidationResponse: " + orchestrationClientValidationResponse);
				if (orchestrationClientValidationResponse.getEvaluation() == null) {
					LOGGER.logDebug(wInfo + "Error al ejecutar la Evaluación del Cliente11");
					messageTO.setCode("1988");
					messageTO.setMessage("Error al ejecutar la Evaluación del Cliente");
					ManagerException.manageResponseError(LOGGER, messageTO);
				}

				String evaluationOK = orchestrationClientValidationResponse.getEvaluation();

				if (evaluationOK.equals("SI")) {
					evaluationOKB = true;
				}

				customerEvaluationResponse.setCustomerId(customerRequest.getInValidationProspectRequest().getCustomerId());
				customerEvaluationResponse.setEvaluation(evaluationOKB);
				customerEvaluationResponse.setAmountApproved(orchestrationClientValidationResponse.getAmountApproved());
				customerEvaluationResponse.setQualification(orchestrationClientValidationResponse.getQualification());

				LOGGER.logDebug(wInfo + "Datos Salida customerEvaluationResponse: " + customerEvaluationResponse);
			}

		} catch (Exception e) {
			LOGGER.logError(wInfo + "Error al ejecutar el metodo: " + customerEvaluationResponse);
			throw new MobileServiceException(e);
		}

		return customerEvaluationResponse;
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void setCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public void unsetCobisCrypt(ICobisCrypt cobisCrypt) {
		this.cobisCrypt = cobisCrypt;
	}

	public Map<String, Key> getPrivateKeysMap() {
		return this.privateKeysMap;
	}

	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

}
