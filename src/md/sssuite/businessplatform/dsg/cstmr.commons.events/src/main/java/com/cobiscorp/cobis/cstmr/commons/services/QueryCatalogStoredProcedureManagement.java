package com.cobiscorp.cobis.cstmr.commons.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class QueryCatalogStoredProcedureManagement extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryCatalogStoredProcedureManagement.class);

	public QueryCatalogStoredProcedureManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<CatalogDto> getActivityFilter(String filter, String codigo, ICommonEventArgs arg1, BehaviorOption options) {

		LOGGER.logDebug("Sets del sp a traer la informacion----------------------->");
		String spName = "cobis..sp_actividad_economica";

		LOGGER.logDebug("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		LOGGER.logDebug("Sets de los parametros de entrada------------------------>");
		LOGGER.logDebug("El codigo en el servicio es: " + codigo);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "2436", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "C", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_filtro", filter, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_codigo", codigo, ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public List<CatalogDto> getExecutiveFilter(String filter, String oficial, ICommonEventArgs arg1, BehaviorOption options) {

		LOGGER.logDebug("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_oficiales";

		LOGGER.logDebug("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		LOGGER.logDebug("Sets de los parametros de entrada------------------------>");
		LOGGER.logDebug("El codigo en el servicio es: " + oficial);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7063", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "C", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_oficial", oficial, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_filtro", filter, ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public List<CatalogDto> getCatalogQuery(String filter, String type, String mode, ICommonEventArgs arg1, BehaviorOption options) {

		LOGGER.logDebug("getRole------------------------>");
		String spName = "cob_credito..sp_obtener_catalogo";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "21744", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "Q", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_filtro", filter, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", type, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", mode, ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

}