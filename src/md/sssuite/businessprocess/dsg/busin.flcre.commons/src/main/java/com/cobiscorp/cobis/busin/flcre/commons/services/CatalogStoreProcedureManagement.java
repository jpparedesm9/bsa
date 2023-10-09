package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.enums.ColumnCatalog;
import com.cobiscorp.ecobis.busin.enums.ParameterType;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.busin.model.InputParameterDto;

public class CatalogStoreProcedureManagement extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(CatalogStoreProcedureManagement.class);

	public CatalogStoreProcedureManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<CatalogDto> getTerm(String frecuency, ICommonEventArgs arg1, BehaviorOption options) {
		LOGGER.logDebug("Ingreso a  getTerm nuevo");
		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cob_credito..sp_obtener_catalogo";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.TRN, "21743", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.OPERACION, Mnemonic.OPERACION_S, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.TIPO, "T", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.MODO, "0", ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto("@i_frecuencia", frecuency, ParameterType.CHAR));		

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getCatalogQuery(String operation, String mode, String type, String filter, String product, String idRequested, ICommonEventArgs arg1, BehaviorOption options) {

		LOGGER.logDebug("Ingreso CatalogStoreProcedureManagement-->getCatalogQuery------------------------>");
		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cob_credito..sp_obtener_catalogo";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.TRN, "21744", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.OPERACION, operation, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.MODO, mode, ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.TIPO, type, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.FILTRO, filter, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.PRODUCTO, product, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Mnemonic.IDREQUESTED, idRequested, ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}
}
