package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

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

public class QueryStoredProcedureManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(QueryStoredProcedureManagement.class);

	public QueryStoredProcedureManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<CatalogDto> getSegmentListByPortfolioType(String portfoliotype, ICommonEventArgs arg1, BehaviorOption options) {

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_tcca_segcred";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7856", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo_car", portfoliotype, ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public List<CatalogDto> getFinancialDestinyBySegment(String segment, ICommonEventArgs arg1, BehaviorOption options) {

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_seg_destino_bce";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7451", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_segmento", segment, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public List<CatalogDto> getPaymentFrequency(ICommonEventArgs arg1, BehaviorOption options) {

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_tdividendo";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_1, 3);
		// hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_2, 4);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		// inputParameterDtoList.add(new InputParameterDto("@t_trn", "7107",
		// ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public List<CatalogDto> getActivityDestinationBySegmentAndDestination(String segment, String destination, ICommonEventArgs arg1, BehaviorOption options) {

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_pac..sp_tcca_destino_busin";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_1, 3);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_2, 4);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "73934", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "X", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_segmento", segment, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_destino_bce", destination, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public List<CatalogDto> getDataParish(String cityCode, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_pac..sp_parroquia_busin";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "1559", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo_h", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto("@i_ciudad", cityCode, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_rowcount", "0", ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getCity(String provinceId, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_pac..sp_ciudad_busin";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "1562", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "S", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));
		inputParameterDtoList.add(new InputParameterDto("@i_rowcount", "0", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_provincia", provinceId, ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getStoreKeeper(ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_custodia..sp_almacenera";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "19016", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getProvince(ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cobis..sp_provincia";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "1550", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getPaymentWays(String producto, Integer moneda, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_qr_producto";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7076", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "4", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_linea_cre", producto, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_moneda", String.valueOf(moneda), ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}
	
	public List<CatalogDto> getPaymentWaysGroup(String producto, Integer moneda, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_qr_producto";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7076", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "G", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "1", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_linea_cre", producto, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_moneda", String.valueOf(moneda), ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getAccounts(ICommonEventArgs arg1, BehaviorOption options, String producto, Integer cliente) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_cuenta_cobis";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7003", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_producto", producto, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_cliente", String.valueOf(cliente), ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "1", ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		logger.logDebug("serviceResponse getAccounts: " + serviceResponse.getData() + ",isResult:" + serviceResponse.isResult());
		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getOtherDestinationBySegment(String segment, String otherDestination, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_pac..sp_destino_scon_sviv_busin";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_1, 3);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "73933", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "Q", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_segmento", segment, ParameterType.VARCHAR));
		if (otherDestination != null) {
			inputParameterDtoList.add(new InputParameterDto("@i_destino", otherDestination, ParameterType.VARCHAR));
		}

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getOtherDestinationByTramite(String tramite, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_inf_tasas_bce";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);// ad_secuencial
		hmColumnsResponse.put(ColumnCatalog.NAME, 3);// ad_tramite
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_1, 7);// ad_dest_hipot
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_2, 8);// desc_finan_hip
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_3, 9);// desc_finan_con
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_4, 10);// ad_dest_consumo

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7450", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "S", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tramite", tramite, ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public void saveExceptionToApprobal(ICommonEventArgs arg1, BehaviorOption options, String idRule, String idRuleVersion, String idInstProceso, String idAsigActividad,
			String code, String value) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_pac..sp_exception_rule_busin";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@i_mode", "WFL", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_id_inst_proceso", idInstProceso, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_code_rule", idRule, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_code_version", idRuleVersion, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_code_asig_act", idAsigActividad, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_return_value", value, ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_return_code", code, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "I", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "P", ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (!serviceResponse.isResult()) {
			MessageManagement.show(serviceResponse, arg1, options);
		}
	}

	public void deleteExceptionToApprobal(ICommonEventArgs arg1, BehaviorOption options, String idRule, String idRuleVersion, String idInstProceso, String idAsigActividad) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_pac..sp_exception_rule_busin";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@i_mode", "WFL", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_id_inst_proceso", idInstProceso, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_code_rule", idRule, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_code_version", idRuleVersion, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_code_asig_act", idAsigActividad, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "D", ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (!serviceResponse.isResult()) {
			MessageManagement.show(serviceResponse, arg1, options);
		}
	}

	public List<CatalogDto> getLocation(ICommonEventArgs arg1, BehaviorOption options) {

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cobis..sp_ciudad";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "1562", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public List<CatalogDto> getEntities(ICommonEventArgs arg1, BehaviorOption options) {

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_custodia..sp_entidad";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "19901", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
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

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public List<CatalogDto> getExecutiveByOffice(String oficina, ICommonEventArgs arg1, BehaviorOption options) {

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
		inputParameterDtoList.add(new InputParameterDto("@i_oficina", oficina, ParameterType.VARCHAR));
		logger.logDebug("oficina----------------------->"+oficina);
		

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public List<CatalogDto> getExecutiveFilter(String filter, String oficial, ICommonEventArgs arg1, BehaviorOption options) {

		logger.logDebug("Sets del sp a traer la informacion----------------------->");
		String spName = "cob_cartera..sp_oficiales";

		logger.logDebug("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);

		logger.logDebug("Sets de los parametros de entrada------------------------>");
		logger.logDebug("El codigo en el servicio es: " + oficial);
		
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "7063", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "C", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_oficial", oficial, ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_filtro", filter, ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			List<CatalogDto> catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
			return catalogDtoList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public List<CatalogDto> getLocationByOffice(String office, ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cobis..sp_oficinaciudad";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_1, 3);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "1140", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "C", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_oficina", office, ParameterType.VARCHAR));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getOffices( ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cobis..sp_oficina";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_1, 3);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "1574", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "H", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_tipo", "A", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_opcion", "C", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_filial", "1", ParameterType.INT_4));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}

	public List<CatalogDto> getNemonic(ICommonEventArgs arg1, BehaviorOption options) {

		List<CatalogDto> catalogDtoList = new ArrayList<CatalogDto>();

		System.out.println("Sets del sp a traer la informacion----------------------->");
		String spName = "cobis..sp_moneda";

		System.out.println("Sets de las columnas de respuesta------------------------>");
		HashMap<ColumnCatalog, Integer> hmColumnsResponse = new HashMap<ColumnCatalog, Integer>();
		hmColumnsResponse.put(ColumnCatalog.CODE, 1);
		hmColumnsResponse.put(ColumnCatalog.NAME, 2);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_1, 3);
		hmColumnsResponse.put(ColumnCatalog.DESCRIPTION_2, 4);

		System.out.println("Sets de los parametros de entrada------------------------>");
		List<InputParameterDto> inputParameterDtoList = new ArrayList<InputParameterDto>();
		inputParameterDtoList.add(new InputParameterDto("@t_trn", "1554", ParameterType.INT_4));
		inputParameterDtoList.add(new InputParameterDto("@i_operacion", "Q", ParameterType.VARCHAR));
		inputParameterDtoList.add(new InputParameterDto("@i_modo", "0", ParameterType.INT_2));

		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.SERVICE_NAME, new Object[] { spName, inputParameterDtoList, hmColumnsResponse });

		if (serviceResponse.isResult()) {
			catalogDtoList = (List<CatalogDto>) serviceResponse.getData();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return catalogDtoList;
	}
}