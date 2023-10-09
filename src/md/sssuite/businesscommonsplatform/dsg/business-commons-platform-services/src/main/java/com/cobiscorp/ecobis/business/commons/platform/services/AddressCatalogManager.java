package com.cobiscorp.ecobis.business.commons.platform.services;

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
import com.cobiscorp.ecobis.business.commons.platform.utils.Constants;
import com.cobiscorp.ecobis.business.commons.platform.utils.ServiceId;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

//TODO: Definir el paquete donde se colocaria para que pueda ser usado por BussinessProcess
/**
 * Servicios para consulta de pais provincia ciudad y parroquia
 * 
 * @author Clearminds
 * 
 */
public class AddressCatalogManager extends BaseEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(AddressCatalogManager.class);

	public AddressCatalogManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	/***
	 * Obtiene todos los paises
	 * 
	 * @param arg1
	 * @param options
	 * @return
	 */
	public List<CatalogDto> getCountries(ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cobis..sp_pais";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "1553", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_H, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.TIPO, Constants.TIPO_A, ParameterType.VARCHAR));
		// @i_modo 2 trae todos los resultados
		inputParameterDtoList.add(new InputParameterDto(Constants.MODO, "2", ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getProvinces(String countryCode, String departmentCode, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cob_pac..sp_provincia_busin";
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "1550", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_H, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.TIPO, Constants.TIPO_A, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.MODO, Constants.CERO, ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto(Constants.PAIS, countryCode, ParameterType.INT_2));
		if (departmentCode != null) {
			inputParameterDtoList.add(new InputParameterDto("@i_departamento", departmentCode, ParameterType.VARCHAR));
		}
		inputParameterDtoList.add(new InputParameterDto(Constants.ROWCOUNT, Constants.CERO, ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	/***
	 * Obtiene las parroquias de una ciudad
	 * 
	 * @param cityCode Id de la ciudad de la cual se obtienen las parroquias
	 * @param arg1
	 * @param options
	 * @return
	 */
	public List<CatalogDto> getParishes(String cityCode, String postalCode, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cob_pac..sp_parroquia_busin";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "1559", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_H, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.TIPO_H, Constants.TIPO_A, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.MODO, Constants.CERO, ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto(Constants.CIUDAD, cityCode, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.ROWCOUNT, Constants.CERO, ParameterType.INT_4));
		if (postalCode != null) {
			inputParameterDtoList.add(new InputParameterDto(Constants.POSTAL, postalCode, ParameterType.INT_4));
		}

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	/***
	 * Obtiene las ciudades correspondientes a una provincia
	 * 
	 * @param provinceCode Id de la provincia de la cual obtiene las ciudades
	 * @param arg1
	 * @param options
	 * @return
	 */
	public List<CatalogDto> getCities(String provinceCode, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cob_pac..sp_ciudad_busin";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "1562", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_H, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.TIPO, "S", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.MODO, Constants.CERO, ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto(Constants.ROWCOUNT, Constants.CERO, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.PROVINCIA, provinceCode, ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getPhysicalAddressTypes(ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cob_pac..sp_address_type_busin";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "599", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_H, ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getDepartments(String countryCode, ICommonEventArgs arg1, BehaviorOption options) {
		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();
		String spName = "cob_pac..sp_depart_pais_busin";
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "15395", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_H, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.TIPO, Constants.TIPO_A, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.MODO, Constants.CERO, ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto(Constants.ROWCOUNT, Constants.CERO, ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto(Constants.PAIS, countryCode, ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getNeigborhoods(String provinceCode, String cityCode, ICommonEventArgs arg1, BehaviorOption options) {
		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();
		String spName = "cob_pac..sp_barrio_busin";
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "15309", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_H, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.TIPO_H, Constants.TIPO_B, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.MODO, Constants.CERO, ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto(Constants.DISTRITO, provinceCode, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.CANTON, cityCode, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.ROWCOUNT, Constants.CERO, ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), LOGGER, ServiceId.GETCATALOG_BY_STOREDPROCEDURE,
				new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getBusinessByCode(Integer code, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		String spName = "cob_pac..sp_business_code_busin";

		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto(Constants.TRN, "599", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto(Constants.OPERACION, Constants.OPERACION_H, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto(Constants.ENTE, code.toString(), ParameterType.INT_4));

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
