package com.cobiscorp.cobis.busin.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ConditionsVarRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ConditionsVarResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogRebateRequest extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadCatalogRebateRequest.class);

	public LoadCatalogRebateRequest(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public List executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {
		// TODO Auto-generated method stub
		// Consultar los valores de la variable CRM-CARGO de la regla REBAJA DE
		// TASA nemonic RT
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start executeDataEvent in LoadCatalogRebateRequest");
		
		List<ItemDTO> listItemDTO;
		ItemDTO item;
		ServiceRequestTO serviceRequestTO;
		ConditionsVarRequest conditionVarRequest;
		ServiceResponse serviceResponse;
		ServiceResponseTO serviceResponseTO;
		ConditionsVarResponse[] conditionsVarReponseService;

		try {
			// ******************llenando el catalogo de cargos***************//
			serviceRequestTO = new ServiceRequestTO();
			serviceResponse = new ServiceResponse();
			conditionVarRequest = new ConditionsVarRequest();
			listItemDTO = new ArrayList<ItemDTO>();
			conditionVarRequest.setRuleAcronym("RT");
			conditionVarRequest.setVarAcronym("CRGS");
			serviceRequestTO.getData().put("inConditionsVarRequest",
					conditionVarRequest);
			serviceResponse = execute(
					getServiceIntegration(),
					LOGGER,
					"Businessprocess.Creditmanagement.LoanQuery.GetConditionsVariableLoan",
					serviceRequestTO);

			if (serviceResponse.isResult()) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("Service execute Sucessfull");
				serviceResponseTO = (ServiceResponseTO) serviceResponse
						.getData();
				conditionsVarReponseService = (ConditionsVarResponse[]) serviceResponseTO
						.getValue("returnConditionsVarResponse");
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("List with lenght "
							+ conditionsVarReponseService.length);
				for (ConditionsVarResponse cvr : conditionsVarReponseService) {
					item = new ItemDTO();
					item.setCode(cvr.getCode());
					item.setValue(cvr.getName());
					listItemDTO.add(item);
				}

			} else {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("Retrieving empty list");
				listItemDTO = new ArrayList<ItemDTO>();
			}
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("End executeDataEvent in LoadCatalogRebateRequest");
			return listItemDTO;

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CATALOG_REBATE, e, arg1, LOGGER);
			return new ArrayList<ItemDTO>();
		}

	}

}
