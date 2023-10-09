package com.cobiscorp.cobis.assts.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.ItemResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.RefinanceLoanFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;

public class OperationTypeCatalog extends BaseEvent implements ILoadCatalog {

	private static final ILogger logger = LogFactory.getLogger(OperationTypeCatalog.class);
	
	public OperationTypeCatalog(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities,ILoadCatalogDataEventArgs args) {
		List<ItemDTO> lista = new ArrayList<ItemDTO>();

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		ServiceResponse response;
		
		DataEntity refinancingLoanFilter = entities.getEntity(RefinanceLoanFilter.ENTITY_NAME);
		
		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setOperation('R');
		if (refinancingLoanFilter.get(RefinanceLoanFilter.CURRENCYTYPEAUX) == null) {
			loanRequest.setCurrency(0);
		} else {
			loanRequest.setCurrency(refinancingLoanFilter.get(RefinanceLoanFilter.CURRENCYTYPEAUX));
		}	

		serviceRequest.addValue("inLoanRequest", loanRequest);

		response = this.execute(logger, Parameter.REFINANCE_OPERATION_TYPES, serviceRequest);

		if (response.isResult()) {	
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				ItemResponse[] itemResponseList = (ItemResponse[]) resultado.getValue("returnItemResponse");
				for (ItemResponse item : itemResponseList) {
					ItemDTO itemOperationType = new ItemDTO();
					itemOperationType.setCode(item.getProduct());
					itemOperationType.setValue(item.getDescription());
					lista.add(itemOperationType);
				}
			}
		}
		else {
			String mensaje = GeneralFunction.getMessageError(response.getMessages(), null);
			args.getMessageManager().showErrorMsg(mensaje);
		}
		return lista;
	}

}
