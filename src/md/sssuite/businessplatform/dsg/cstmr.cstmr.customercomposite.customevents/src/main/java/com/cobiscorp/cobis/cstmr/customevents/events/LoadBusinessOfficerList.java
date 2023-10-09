package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficialRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.OfficialResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.ILoadCatalog;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.dto.ItemDTO;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadBusinessOfficerList extends BaseEvent implements ILoadCatalog {

	private static final ILogger LOGGER = LogFactory.getLogger(LoadBusinessOfficerList.class);

	public LoadBusinessOfficerList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, ILoadCatalogDataEventArgs eventArgs) {
		List<ItemDTO> lista = new ArrayList<ItemDTO>();
		try{		
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response;

		OfficialRequest officialRequest = new OfficialRequest();
		officialRequest.setFlag('S');
		officialRequest.setType('A');
		officialRequest.setLevel('0');
		officialRequest.setChief(32001);
		request.addValue("inOfficialRequest", officialRequest);

		response = this.execute(LOGGER, Parameter.SEARCH_OFFICIALS, request);

		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				OfficialResponse[] officerList = (OfficialResponse[]) resultado.getValue("returnOfficialResponse");
				for (OfficialResponse item : officerList) {
					ItemDTO itemDTO = new ItemDTO();
					itemDTO.setCode(String.valueOf(item.getOfficial()).trim());
					itemDTO.setValue(item.getName());
					lista.add(itemDTO);
				}
			}
		} else {
			// String mensaje =
			// GeneralFunction.getMessageError(response.getMessages(), null);
			String mensaje = "Error al cargar los oficiales";
			eventArgs.getMessageManager().showErrorMsg(mensaje);
		}
		return lista;
		}
		catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.LOADCATALOG_BUSSINESS_OFFICER, e, eventArgs, LOGGER);
		}
		return lista;
	}

}
