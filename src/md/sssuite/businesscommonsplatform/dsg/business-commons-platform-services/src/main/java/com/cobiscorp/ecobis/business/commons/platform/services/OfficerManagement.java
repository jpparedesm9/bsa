package com.cobiscorp.ecobis.business.commons.platform.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.enums.ColumnCatalog;
import com.cobiscorp.ecobis.busin.enums.ParameterType;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.busin.model.InputParameterDto;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.MessageManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;
import com.cobiscorp.ecobis.business.commons.platform.utils.Constants;
import com.cobiscorp.ecobis.business.commons.platform.utils.RequestName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ReturnName;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

public class OfficerManagement extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(OfficerManagement.class);

	public OfficerManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public OfficerResponse getOfficerByLogin(String login, ICommonEventArgs arg1) throws BusinessException {
		OfficerRequest officerRequest = new OfficerRequest();
		officerRequest.setLogin(login);
		officerRequest.setType(Constants.STRING_L);

		OfficerResponse[] officerResponses = searchOfficer(officerRequest, arg1);
		if (officerResponses != null && officerResponses.length > 0) {
			return officerResponses[0];
		}
		return null;
	}

	public OfficerResponse[] searchOfficer(OfficerRequest officerRequest, ICommonEventArgs arg1) throws BusinessException {

		CallServices callServices = new CallServices(getServiceIntegration());
		return (OfficerResponse[]) callServices.callServiceWithReturnArray(RequestName.INOFFICERREQUEST, officerRequest, ServiceId.SEARCHOFFICER, ReturnName.RETURNOFFICERRESPONSE,
				arg1);

	}

	// Obtener oficiales
	public List<CatalogDto> getExecutive(ICommonEventArgs arg1, BehaviorOption options) {

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_oficiales";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7063", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_oficial", "0", ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE, new Object[] { spName, inputParameterDtoList,
				hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
}
