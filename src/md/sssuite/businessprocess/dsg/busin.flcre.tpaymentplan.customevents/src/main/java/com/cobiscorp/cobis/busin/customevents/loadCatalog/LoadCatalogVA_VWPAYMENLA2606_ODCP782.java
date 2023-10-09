package com.cobiscorp.cobis.busin.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ProductResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogVA_VWPAYMENLA2606_ODCP782 extends BaseEvent implements
		ILoadCatalog {

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadCatalogVA_VWPAYMENLA2606_ODCP782.class);

	public LoadCatalogVA_VWPAYMENLA2606_ODCP782(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List executeDataEvent(DynamicRequest arg0,
			ILoadCatalogDataEventArgs arg1) {

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso LoadCatalogVA_VWPAYMENLA2606_ODCP782");

		ApplicationRequest applicationRequest = new ApplicationRequest();
		DataEntity paymentPlanHeader = arg0
				.getEntity(PaymentPlanHeader.ENTITY_NAME);

		applicationRequest.setIdrequested(paymentPlanHeader
				.get(PaymentPlanHeader.IDREQUESTED));

		ServiceRequestTO serviceRequestItemsTO = new ServiceRequestTO();
		serviceRequestItemsTO.getData().put("inApplicationRequest",
				applicationRequest);
		ServiceResponse serviceResponse = execute(
				getServiceIntegration(),
				LOGGER,
				"Businessprocess.Creditmanagement.ProductListQuery.searchProductbyConditions",
				serviceRequestItemsTO);
		List<ItemDTO> productList = new ArrayList<ItemDTO>();
		try{
			if (serviceResponse.isResult()) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("RESULTADO EXITOSO SEARCHPRODUCTBYCONTITIONS");

				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse
						.getData();
				ProductResponse[] listProductResponse = (ProductResponse[]) serviceItemsResponseTO
						.getValue("returnProductResponse");

				for (ProductResponse iteratorProduct : listProductResponse) {
					LOGGER.logDebug("Entro For products");
					ItemDTO itemDTO = new ItemDTO();
					itemDTO.setCode(iteratorProduct.getProductId());
					itemDTO.setValue(iteratorProduct.getProductDesc());
					productList.add(itemDTO);
				}

			} else {
				List<Message> errorMessage = serviceResponse.getMessages();
				for (Message message : errorMessage) {
					arg1.getMessageManager()
							.showErrorMsg(
									message.getMessage() + " - ["
											+ message.getCode() + "]");
				}
			}
			return productList;
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CATALOG_TERMS, e, arg1, LOGGER);
		}
		return productList;
	}

}
