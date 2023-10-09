package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo;

/**
 * Created by portiz on 10/04/2019.
 */
public class QueryAltair extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryAltair.class);
	
	public QueryAltair(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	@Override
	public void executeCommand(DynamicRequest dynamicRequest, IExecuteCommandEventArgs iExecuteCommandEventArgs) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeCommand in QueryBureau");
		}
		
		try {
			
			DataEntity naturalPerson = dynamicRequest.getEntity(NaturalPerson.ENTITY_NAME);
			
			if (naturalPerson != null && naturalPerson.get(NaturalPerson.PERSONSECUENTIAL) != null) {
				
				ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();
				
				ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
				validationProspectRequest.setCustomerId(naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));
				validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);
				
				ServiceResponse serviceResponse = this.execute(LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateSantanderWithoutValidation", new Object[] { validationProspectServiceRequest });
				
				if (serviceResponse.isResult()) {
					OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse.getData();
					
					CustomerCoreInfo santanderExecutionResponse = orchestrationClientValidationResponse.getCustomerCoreInfo();
					LOGGER.logDebug("santanderExecutionResponse" + santanderExecutionResponse);
					
					if (santanderExecutionResponse != null) {
						naturalPerson.set(NaturalPerson.ACCOUNTINDIVIDUAL, santanderExecutionResponse.getCustomerAccountId());
						SessionManager.getSession().put("PERSON_SECUENTIAL", naturalPerson.get(NaturalPerson.PERSONSECUENTIAL));
						SessionManager.getSession().put("PRODUC_LIST", santanderExecutionResponse.getProductList());
						//naturalPerson.set(NaturalPerson.SANTANDERCODE, santanderExecutionResponse.getCustomerStdCode());
						//person.set(Person.SANTANDERCODE, santanderExecutionResponse.getCustomerStdCode());
						if (santanderExecutionResponse.getCustomerStdCode() == null || santanderExecutionResponse.getCustomerAccountId() == null) {
							LOGGER.logDebug("No tiene cuenta en Santander");
							iExecuteCommandEventArgs.getMessageManager().showErrorMsg("No tiene cuenta en Santander");
						}
					} else {
						iExecuteCommandEventArgs.setSuccess(false);
						LOGGER.logDebug("Error al consultar datos de Santander");
						iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Error al consultar datos de Santander");
					}
				} else {
					iExecuteCommandEventArgs.getMessageManager().showErrorMsg(serviceResponse.getMessages().get(0).getMessage());
				}
			} else {
				iExecuteCommandEventArgs.setSuccess(false);
				iExecuteCommandEventArgs.getMessageManager().showErrorMsg("CLIENTE NO EXISTE");
			}
		} catch (BusinessException be) {
			iExecuteCommandEventArgs.setSuccess(false);
			LOGGER.logError("BusinessException: ", be);
			iExecuteCommandEventArgs.getMessageManager().showErrorMsg(be.getMessage());
		} catch (Exception e) {
			iExecuteCommandEventArgs.setSuccess(false);
			LOGGER.logError("Exception: ", e);
			iExecuteCommandEventArgs.getMessageManager().showErrorMsg(e.getMessage());
		}

	}

}
