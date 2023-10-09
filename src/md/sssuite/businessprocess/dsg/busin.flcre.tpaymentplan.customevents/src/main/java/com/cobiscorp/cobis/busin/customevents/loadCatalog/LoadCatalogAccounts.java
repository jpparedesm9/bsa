package com.cobiscorp.cobis.busin.customevents.loadCatalog;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import cobiscorp.ecobis.account.dto.AccountResponse;
import cobiscorp.ecobis.businessprocess.customers.dto.Customer;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadCatalogAccounts extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadCatalogAccounts.class);

	public LoadCatalogAccounts(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List executeDataEvent(DynamicRequest entities,
			ILoadCatalogDataEventArgs args) {
	
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("start:>:>LoadCatalogAccounts:>:>executeDataEvent:>:>");
		}
		
		List<ItemDTO> listItemDTO = new ArrayList<ItemDTO>();
		
		try {

			DataEntity paymentPlanHeader = entities
					.getEntity(PaymentPlanHeader.ENTITY_NAME);
			String wayToPay = paymentPlanHeader.get(PaymentPlanHeader.WAYTOPAY);
			Integer customerCode = paymentPlanHeader
					.get(PaymentPlanHeader.CUSTOMERCODE);

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

			Customer customer = new Customer();
			customer.setCustomerId(customerCode);
			//customer.setCurrency(null);
			//customer.setProductVar(wayToPay);
			serviceRequestTO.getData().put(RequestName.INCUSTOMER, customer);

			LOGGER.logDebug(":>wayToPay:>:>" + wayToPay);
			LOGGER.logDebug(":>customerCode:>:>" + customerCode);
			if (wayToPay != null && customerCode != null) {

				ServiceResponse serviceResponse = execute(
						getServiceIntegration(), LOGGER,
						ServiceId.SERVICESEARCHACCOUNTBYCURRENCY,
						serviceRequestTO);
				if (serviceResponse.isResult()) {
					ServiceResponseTO serviceAccountResponseTO = new ServiceResponseTO();
					serviceAccountResponseTO = (ServiceResponseTO) serviceResponse
							.getData();
					AccountResponse[] returnAccountResponse = (AccountResponse[]) serviceAccountResponseTO
							.getValue(ReturnName.RETURNACCOUNTRESPONSE);

					DataEntityList itemsEntity = new DataEntityList();
					for (AccountResponse accountResponse : returnAccountResponse) {
						ItemDTO item = new ItemDTO();
						LOGGER.logDebug("catalogDto.getCode()"
								+ accountResponse.getAccount());
						item.setCode(accountResponse.getAccount());
						LOGGER.logDebug("catalogDto.getName()"
								+ accountResponse.getAccount() + "-"
								+ accountResponse.getAccountDescription());
						item.setValue(accountResponse.getAccount() + "-"
								+ accountResponse.getAccountDescription());
						item.setAttributes(Arrays.asList(accountResponse
								.getAccountDescription()));
						listItemDTO.add(item);
					}
				}
			}

		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CATALOG_ACCOUNTS, ex, args, LOGGER);
		} finally {
			LOGGER.logDebug("finish:>:>LoadCatalogAccounts:>:>executeDataEvent:>:>");
		}
		return listItemDTO;
	}
}
