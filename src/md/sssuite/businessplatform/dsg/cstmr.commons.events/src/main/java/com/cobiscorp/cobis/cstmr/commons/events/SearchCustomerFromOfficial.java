package com.cobiscorp.cobis.cstmr.commons.events;

import java.math.BigDecimal;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficialRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.CustomerTransferRequest;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.TransferManager;

public class SearchCustomerFromOfficial extends BaseEvent implements IExecuteQuery {
	private static final ILogger LOGGER = LogFactory.getLogger(SearchCustomerFromOfficial.class);

	public SearchCustomerFromOfficial(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		LOGGER.logDebug("Ingreso executeQuery SearchCustomerFromOfficial ");

		DataEntityList lista = new DataEntityList();
		DataEntity item = new DataEntity();

		if (arg1.getParameters() != null && arg1.getParameters().getCustomParameters() != null) {
			LOGGER.logDebug("arg1 ejecucion: " + (arg1.getParameters().getCustomParameters()));
			int ejecucion = (arg1.getParameters().getCustomParameters().get("ejecucion") == null ? 1
					: Integer.parseInt(arg1.getParameters().getCustomParameters().get("ejecucion").toString()));

			if (ejecucion == 0) {
				return lista.getDataList();
			}
		}

		int idNotif = (arg0.getData().get("customerId") == null ? 0 : Integer.parseInt(arg0.getData().get("customerId").toString()));

		int officeId = Integer.parseInt((String) arg0.getData().get("officeId"));
		String official = arg0.getData().get("officialId").toString();
		char isGroup = arg0.getData().get("isGroup").toString().charAt(0);
		String marketType = arg0.getData().get("marketType") != null ? arg0.getData().get("marketType").toString() : null;
		TransferManager transferManager = new TransferManager(this.getServiceIntegration());

		CustomerRequest customerRequest = new CustomerRequest();
		customerRequest.setIsGroup(isGroup);
		customerRequest.setLastResult(idNotif);
		customerRequest.setCollective(marketType);
		OfficialRequest officialRequest = new OfficialRequest();
		officialRequest.setLogin(official);
		officialRequest.setOffice(officeId);

		try {
			// Seteo del código del Grupo
			LOGGER.logDebug("data: " + arg0.getData().toString());
			for (CustomerResponse customerResponse : transferManager.searchCustomerByOfficial(customerRequest, officialRequest, arg1)) {
				item = new DataEntity();
				item.set(CustomerTransferRequest.CUSTOMERID, customerResponse.getCustomerId());
				item.set(CustomerTransferRequest.CUSTOMERNAME, customerResponse.getCustomerFullName());
				item.set(CustomerTransferRequest.CUSTOMERSTATUS, customerResponse.getStatus());
				item.set(CustomerTransferRequest.REGISTRATIONDATE, customerResponse.getEmissionDateId());
				item.set(CustomerTransferRequest.LASTUPDATEDATE, customerResponse.getLastUpdateDate());
				item.set(CustomerTransferRequest.CICLES, customerResponse.getCicleNumberEn());
				item.set(CustomerTransferRequest.WEEKSDELAY, customerResponse.getDescriptionProfessions());
				item.set(CustomerTransferRequest.CREDITAMOUNT, customerResponse.getMonthlyTrxAmount());
				item.set(CustomerTransferRequest.ISCHECKED, false);
				lista.add(item);
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_CUSTOMERBYOFICIAL, e, arg1, LOGGER);
		}
		return lista.getDataList();
	}
}
