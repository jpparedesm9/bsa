package com.cobiscorp.mobile.services.impl;

import java.security.Key;
import java.util.ArrayList;
import java.util.List;
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
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.request.CustomerRequest;
import com.cobiscorp.mobile.response.AltairResponse;
import com.cobiscorp.mobile.service.interfaces.IQueryAltair;
import com.cobiscorp.mobile.services.impl.utils.ManagerException;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Component
@Service({ IQueryAltair.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class QueryAltairImpl extends ServiceBase implements IQueryAltair {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisCrypt", unbind = "unsetCobisCrypt", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICobisCrypt cobisCrypt;

	private static final String ID_APPLICATION = "bancaMovil";

	/** Class name. */
	private static final String CLASS_NAME = " [ MB ---> QueryAltairImpl] ";

	/** Logger. */
	private ILogger logger = LogFactory.getLogger(QueryAltairImpl.class);

	private Map<String, Key> privateKeysMap;

	private ISPOrchestrator spOrchestrator;

	public void setPrivateKeysMap(Map<String, Key> privateKeysMap) {
		this.privateKeysMap = privateKeysMap;
	}

	@Override
	public AltairResponse queryAltairImp(CustomerRequest altairRequest, String sessionId) throws MobileServiceException {

		try {

			logger.logDebug(">>>>>>>>>>>metodo queryAltairImp ");

			ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();
			AltairResponse altairResponse = new AltairResponse();
			List<String> account = new ArrayList();
			MessageTO messageTO = new MessageTO();

			ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
			if (altairRequest.getCustomerId() != null && altairRequest.getCustomerId() > 0) {
				validationProspectRequest.setCustomerId(altairRequest.getCustomerId());
				validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);

				logger.logDebug(">>>>>>>>>>>metodo queryAltairImp -- llamar al servicio");

				ServiceResponse serviceResponse = this.execute1(sessionId, serviceIntegration, logger, "OrchestrationClientValidationServiceSERVImpl.validateSantanderWithoutValidation",
						new Object[] { validationProspectServiceRequest });
				if (serviceResponse.isResult()) {
					OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse.getData();

					CustomerCoreInfo santanderExecutionResponse = orchestrationClientValidationResponse.getCustomerCoreInfo();
					logger.logDebug("santanderExecutionResponse" + santanderExecutionResponse);

					if (santanderExecutionResponse != null) {

						for (int i = 0; i < santanderExecutionResponse.getProductList().size(); i++) {
							account.add(santanderExecutionResponse.getProductList().get(i).getContractNumber());

						}

						if (santanderExecutionResponse.getCustomerStdCode() == null || santanderExecutionResponse.getCustomerAccountId() == null) {
							logger.logDebug("No tiene cuenta en Santander");
							messageTO.setCode("1988");
							messageTO.setMessage("No tiene cuenta en Santander");
							ManagerException.manageResponseError(logger, messageTO);
						}
						if (logger.isDebugEnabled()) {
							logger.logDebug("cuenta Santander : " + santanderExecutionResponse.getCustomerStdCode());
						}
						altairResponse.setBuc(santanderExecutionResponse.getCustomerStdCode());

					} else {
						logger.logDebug("Error al consultar datos de Santander");
						messageTO.setCode("1988");
						messageTO.setMessage("Error al consultar datos de Santander");
						ManagerException.manageResponseError(logger, messageTO);

					}

				} else {
					if (logger.isDebugEnabled()) {
						logger.logDebug("Error in execution Altair imp: >> " + altairRequest.getCustomerId());
					}
					logger.logDebug("Error al consultar datos de Santander");
					messageTO.setCode("1988");
					messageTO.setMessage("Error al ejecutar Servicio de Altair");
					ManagerException.manageResponseError(logger, messageTO);
				}

				altairResponse.setCustomerId(altairRequest.getCustomerId());
				altairResponse.setAccount(account);
			} else {
				logger.logDebug("Cliente no existe");
				messageTO.setCode("1988");
				messageTO.setMessage("Cliente no existe");
				ManagerException.manageResponseError(logger, messageTO);

			}
			return altairResponse;
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
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
