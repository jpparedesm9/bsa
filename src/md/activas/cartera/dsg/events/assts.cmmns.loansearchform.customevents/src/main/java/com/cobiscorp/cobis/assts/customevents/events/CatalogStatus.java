package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.LoanSearchStatusRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanSearchStatusResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.LoanSearchFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class CatalogStatus extends BaseEvent implements ILoadCatalog {
	private static final ILogger logger = LogFactory.getLogger(CatalogStatus.class);

	public CatalogStatus(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs args) {

		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso executeDataEvent");
		}

		ServiceRequestTO request = new ServiceRequestTO();
		List<ItemDTO> lista = new ArrayList<ItemDTO>();

		DataEntity loanSearchFilter = entities.getEntity(LoanSearchFilter.ENTITY_NAME);
		LoanSearchStatusRequest loanSearchStatusRequest = new LoanSearchStatusRequest();
		loanSearchStatusRequest.setOperation("W");
		loanSearchStatusRequest.setCategory(loanSearchFilter.get(LoanSearchFilter.CATEGORY));

		request.addValue("inLoanSearchStatusRequest", loanSearchStatusRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), logger, "Loan.LoanMaintenance.LoanSearchStatus", request);

		if (response != null && response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();

			LoanSearchStatusResponse[] clResponse = (LoanSearchStatusResponse[]) resultado.getValue("returnLoanSearchStatusResponse");

			if (clResponse != null) {
				for (LoanSearchStatusResponse r : clResponse) {
					if (logger.isDebugEnabled()) {
						logger.logDebug("INGRESA MAPEO");
					}
					ItemDTO item = new ItemDTO();
					item.setCode(r.getCode());
					item.setValue(r.getDescStatus());

					lista.add(item);
				}
			}
		} else {
			if (logger.isDebugEnabled()) {
				logger.logDebug("INCORRECTO");
			}
		}

		args.setSuccess(true);

		return lista;
	}

}
