package com.cobiscorp.ecobis.cloud.service.integration;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.busin.enums.ColumnCatalog;
import com.cobiscorp.ecobis.busin.enums.ParameterType;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.busin.model.InputParameterDto;
import com.cobiscorp.ecobis.business.commons.platform.utils.Constants;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.CatalogSyncResponse;

public class CatalogIntegrationService extends RestServiceBase {
	private static final ILogger LOGGER = LogFactory.getLogger(CatalogIntegrationService.class);

	public CatalogIntegrationService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public List<CatalogDto> getTermByFrecuency(String frecuency) throws Exception {

		LOGGER.logDebug("Star getTermByFrecuency");
		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		try {
			String spName = "cob_credito..sp_obtener_catalogo";

			HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
			hmColumnsResponse.put(ColumnCatalog.CODE, 1);
			hmColumnsResponse.put(ColumnCatalog.NAME, 2);

			List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
			inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "21743", ParameterType.INT_4));
			inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_S, ParameterType.VARCHAR));
			inputParameterDtoList.add(new InputParameterDto(Constants.TIPO, "T", ParameterType.VARCHAR));
			inputParameterDtoList.add(new InputParameterDto(Constants.MODO, "0", ParameterType.INT_2));
			inputParameterDtoList.add(new InputParameterDto(Constants.FRECUENCY, frecuency, ParameterType.VARCHAR));

			ServiceResponse serviceResponse = this.execute(this.getIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
					new Object[] { spName, inputParameterDtoList, hmColumnsResponse });
			if (serviceResponse == null) {
				LOGGER.logError("Se obtiene respuesta vacia del sp. cob_credito..sp_obtener_catalogo");
				throw new Exception(com.cobiscorp.ecobis.cloud.service.util.Constants.ERR_FRECUENCY_CATALOG);
			} else {
				if (serviceResponse.isResult()) {
					catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
				} else {
					LOGGER.logError("Error al obtener plazos por frecuencia de Pago>>" + serviceResponse.getMessages());
					throw new Exception(serviceResponse.getMessages() == null ? com.cobiscorp.ecobis.cloud.service.util.Constants.ERR_FRECUENCY_CATALOG
							: (serviceResponse.getMessages().get(0) == null ? com.cobiscorp.ecobis.cloud.service.util.Constants.ERR_FRECUENCY_CATALOG
									: serviceResponse.getMessages().get(0).getMessage()));
				}
			}
		} finally {
			LOGGER.logDebug("Finish getTermByFrecuency");
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getPaymentFrequency() throws Exception {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();
		String spName = "cob_cartera..sp_tdividendo";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_1, 3);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(this.getIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			LOGGER.logError("Error al obtener plazos por frecuencia de Pago>>" + serviceResponse.getMessages());
			throw new Exception(serviceResponse.getMessages() == null ? com.cobiscorp.ecobis.cloud.service.util.Constants.ERR_FRECUENCY_CATALOG
					: (serviceResponse.getMessages().get(0) == null ? com.cobiscorp.ecobis.cloud.service.util.Constants.ERR_FRECUENCY_CATALOG
							: serviceResponse.getMessages().get(0).getMessage()));
		}
	}

	public CatalogSyncResponse[] getSynchronizedCatalog() {
		LOGGER.logDebug("Inicio de Servicio getSynchronizedCatalog");
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		ServiceResponse serviceResponse = executeNormal("MobileManagement.SyncManagement.SearchSyncCatalogData", serviceRequestApplicationTO);
		if (serviceResponse.isResult() && serviceResponse.getData() != null) {
			cobiscorp.ecobis.commons.dto.ServiceResponseTO dataResponse = (cobiscorp.ecobis.commons.dto.ServiceResponseTO) serviceResponse.getData();
			return (CatalogSyncResponse[]) (dataResponse.getData().get("returnCatalogSyncResponse"));
		}
		return null;

	}
}
