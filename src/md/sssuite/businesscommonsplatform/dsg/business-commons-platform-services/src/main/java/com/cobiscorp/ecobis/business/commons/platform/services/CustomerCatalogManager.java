package com.cobiscorp.ecobis.business.commons.platform.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.enums.ColumnCatalog;
import com.cobiscorp.ecobis.busin.enums.ParameterType;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.busin.model.InputParameterDto;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.MessageManagement;
import com.cobiscorp.ecobis.business.commons.platform.utils.Constants;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

public class CustomerCatalogManager extends BaseEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(AddressCatalogManager.class);

	public CustomerCatalogManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	public List<CatalogDto> getCountriesOfBirth(ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cobis..sp_consulta_estados";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_S, ParameterType.VARCHAR));


		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE, new Object[] { spName, inputParameterDtoList,
				hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}
}
