
/**
 * Archivo: SynchronizeService.java
 * Fecha..:
 * Autor..: Team Evac
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//include imports with key: SynchronizeService.imports

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.Action;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.Request;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.SynchronizeData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.GetDataSynchronizeRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.GetEntitiesDataRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.GetEntitiesDataResponse;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.services.UpdateDataSynchronizeRequest;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.AgendaSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CollectiveDocumentAndQuestionnaireSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CreditGroupApplicationSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CreditIndividualApplicationSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.CustomerSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.GroupSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.SolidarityPaymentSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.VerificationGroupSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.VerificationSynchronizationData;
import com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto.synchronization.VerificationSynchronizationDataLcr;
import com.cobiscorp.ecobis.cobiscloudsynchronization.util.XmlConverter;

public class SynchronizeServiceSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.bsl.ISynchronizeService {
	private static ILogger logger = LogFactory.getLogger(SynchronizeServiceSERVImpl.class);

	// include body with key: SynchronizeService.body

	public CustomerSynchronizationData getCustomerToSynchronize(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getCustomerToSynchronize]";

		CustomerSynchronizationData customer = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		logger.logDebug("resultado xml cliente...." + xml);
		if (xml != null) {
			try {
				customer = (CustomerSynchronizationData) XmlConverter.xmlToDto(xml, CustomerSynchronizationData.class);
				logger.logDebug("getBankCode...." + customer.getCustomer().getCustomer().getBankCode());
				logger.logDebug("getBankAccount...." + customer.getCustomer().getCustomer().getBankAccount());
				logger.logDebug("getGender()...." + customer.getCustomer().getCustomer().getGender());

				if (logger.isDebugEnabled()) {
					logger.logDebug(wInfo + "CustomerSynchronizationData DTO-->" + customer);
				}
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type Customer");
			}
		}

		return customer;

	}

	public SolidarityPaymentSynchronizationData getSolidarityPaymentToSynchronize(Integer id) {

		String wInfo = "[SynchronizeServiceSERVImpl][getSolidarityPaymentToSynchronize]";

		SolidarityPaymentSynchronizationData solidarityPayment = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				solidarityPayment = (SolidarityPaymentSynchronizationData) XmlConverter.xmlToDto(xml, SolidarityPaymentSynchronizationData.class);
				if (logger.isDebugEnabled()) {
					logger.logDebug(wInfo + "CustomerSynchronizationData DTO-->" + solidarityPayment);
				}
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type SolidarityPayment");
			}
		}

		return solidarityPayment;
	}

	public List<SynchronizeData> getDataToSynchronize(GetDataSynchronizeRequest request) {

		String wInfo = "[SynchronizeServiceSERVImpl][getDataToSychronize]";
		List<SynchronizeData> synchronizeDataList = new ArrayList<SynchronizeData>();
		if (request == null || request.getUser() == null) {
			return null;
		}
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();

		parameterMap.put("operation", "Q");
		parameterMap.put("user", request.getUser());
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpSpControlTableUtil.executeSpControlTable(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (logger.isErrorEnabled()) {
				logger.logError(wInfo + "Error getting data from sp_tabla_control");
			}
		}
		List<?> listResults = (List<?>) spRequest.getInfo().get("aResultSpControlTable");
		if (listResults != null && !listResults.isEmpty()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "listResults --> " + listResults.toString());
			}
			List<?> controlTableDetailResult = (List<?>) listResults.get(0);

			for (Object object : controlTableDetailResult) {
				Map<?, ?> mapParams = (Map<?, ?>) object;
				SynchronizeData synchronizeData = new SynchronizeData();
				synchronizeData.setIdSync((Integer) mapParams.get("tc_id_sync"));
				synchronizeData.setEntity((String) mapParams.get("tc_entidad"));
				synchronizeData.setUser((String) mapParams.get("tc_usuario"));
				if (mapParams.get("tc_id_entidad") != null) {
					synchronizeData.setEntityId((Integer.parseInt(((String) mapParams.get("tc_id_entidad")).trim())));
				}
				Date date = (Date) mapParams.get("tc_fecha");
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				String formattedDate = formatter.format(date);
				synchronizeData.setDate(formattedDate);
				synchronizeData.setRegistersNumber((Integer) mapParams.get("tc_nro_registros"));
				synchronizeData.setState((String) mapParams.get("tc_estado"));
				synchronizeDataList.add(synchronizeData);
			}
		}
		return synchronizeDataList;
	}

	public CreditGroupApplicationSynchronizationData getCreditGroupApplicationSynchronizationData(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getCreditGroupApplicationSynchronizationData]";

		CreditGroupApplicationSynchronizationData creditGroup = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				creditGroup = (CreditGroupApplicationSynchronizationData) XmlConverter.xmlToDto(xml, CreditGroupApplicationSynchronizationData.class);
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type CreditGroupApplication");
			}
		}
		return creditGroup;
	}

	@Override
	public CreditIndividualApplicationSynchronizationData getCreditIndividualApplicationSynchronizationData(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getCreditIndividualApplicationSynchronizationData]";

		CreditIndividualApplicationSynchronizationData creditIndividual = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				creditIndividual = (CreditIndividualApplicationSynchronizationData) XmlConverter.xmlToDto(xml, CreditIndividualApplicationSynchronizationData.class);
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type CreditIndividualApplication");
			}
		}
		return creditIndividual;
	}

	@Override
	public VerificationSynchronizationData getVerificationSynchronizationData(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getVerificationSynchronizationData]";

		VerificationSynchronizationData verificationSynchronizationData = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				verificationSynchronizationData = (VerificationSynchronizationData) XmlConverter.xmlToDto(xml, VerificationSynchronizationData.class);
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type IndividualVerification");
			}
		}
		return verificationSynchronizationData;
	}

	@Override
	public VerificationGroupSynchronizationData getVerificationGroupSynchronizationData(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getVerificationGroupSynchronizationData]";

		VerificationGroupSynchronizationData verificationGroupSynchronizationData = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				verificationGroupSynchronizationData = (VerificationGroupSynchronizationData) XmlConverter.xmlToDto(xml, VerificationGroupSynchronizationData.class);
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type GroupVerification");
			}
		}
		return verificationGroupSynchronizationData;
	}

	public VerificationSynchronizationDataLcr getVerificationSynchronizationDataLcr(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getVerificationSynchronizationDataLcr]";
		logger.logDebug("Inicia metodo VerificationSynchronizationDataLcr " + wInfo);
		VerificationSynchronizationDataLcr verificationSynchronizationDataLcr = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				verificationSynchronizationDataLcr = (VerificationSynchronizationDataLcr) XmlConverter.xmlToDto(xml, VerificationSynchronizationDataLcr.class);
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type verificationSynchronizationDataLcr");
			}
		}
		return verificationSynchronizationDataLcr;
	}

	@Override
	public CollectiveDocumentAndQuestionnaireSynchronizationData getCollectiveSynchronizationData(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getCollectiveDocumentSynchronizationData]";
		logger.logDebug("Inicia metodo CollectiveDocumentSynchronizationData " + wInfo);
		CollectiveDocumentAndQuestionnaireSynchronizationData collectiveSynchronizationData = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				collectiveSynchronizationData = (CollectiveDocumentAndQuestionnaireSynchronizationData) XmlConverter.xmlToDto(xml,
						CollectiveDocumentAndQuestionnaireSynchronizationData.class);
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type collectiveDocumentSynchronizationData");
			}
		}
		return collectiveSynchronizationData;
	}

	@Override
	public AgendaSynchronizationData getAgendaSynchronizationData(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getAgendaSynchronizationData]";

		AgendaSynchronizationData agenda = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				agenda = (AgendaSynchronizationData) XmlConverter.xmlToDto(xml, AgendaSynchronizationData.class);
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type Agenda");
			}
		}
		return agenda;
	}

	public GroupSynchronizationData getGroupToSynchronize(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getGroupToSynchronize]";

		GroupSynchronizationData group = null;
		if (id == null) {
			return null;
		}
		String xml = getXmlControlTableDetail(id);
		if (xml != null) {
			try {
				group = (GroupSynchronizationData) XmlConverter.xmlToDto(xml, GroupSynchronizationData.class);
			} catch (Exception e) {
				SynchronizationUtil.logException(logger, e);
				throw new BusinessException(2109104, "The entity you are trying to download is not a entity of type Group");
			}
		}

		return group;
	}

	public Integer updateDataToSynchronize(UpdateDataSynchronizeRequest request) {
		String wInfo = "[SynchronizeServiceSERVImpl][updateDataToSynchronize]";

		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();

		parameterMap.put("operation", "U");
		parameterMap.put("idSync", request.getIdSync());
		parameterMap.put("state", request.getStatus());
		if ("S".equals(request.getStatus())) {
			Date date = new Date();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			String datestring = dateFormat.format(date);
			parameterMap.put("syncDate", datestring);
		}
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpSpControlTableUtil.executeSpControlTable(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		logger.logError("estatus code 11111" + statusCode);
		if (statusCode != 0) {
			if (logger.isErrorEnabled()) {
				logger.logError(wInfo + "Error updating data from sp_tabla_control");
			}
			return -1;
		}
		return 0;

	}

	public String getXmlControlTableDetail(Integer id) {
		String wInfo = "[SynchronizeServiceSERVImpl][getXmlControlTableDatil]";
		String xml = null;
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();

		parameterMap.put("operation", "Q");
		parameterMap.put("id", id);
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpSpControlTableDetailUtil.executeSpControlTableDetail(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (logger.isErrorEnabled()) {
				logger.logError(wInfo + "Error getting data from si_sincronizar_app_movil");
			}
		}
		List<?> listResults = (List<?>) spRequest.getInfo().get("aResultSpControlTableDetail");

		if (listResults != null && !listResults.isEmpty()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "listResults --> " + listResults.toString());
			}
			List<?> controlTableDetailResult = (List<?>) listResults.get(0);
			if (!controlTableDetailResult.isEmpty()) {
				Map<?, ?> mapParams = (Map<?, ?>) controlTableDetailResult.get(0);
				xml = (String) mapParams.get("sa_dato_xml");
			}
		}
		return xml;

	}

	public List<Object> getEntitiesData(GetEntitiesDataRequest request) {
		String wInfo = "[SynchronizeServiceSERVImpl][getEntitiesData]";
		List<Object> entitiesDtos = new ArrayList<Object>();
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Map<String, Object> requestMap = new HashMap<String, Object>();
		if (request == null || request.getEntity() == null || request.getIdSync() == null) {
			return null;
		}
		parameterMap.put("operation", "S");
		parameterMap.put("idSync", request.getIdSync());
		parameterMap.put("page", request.getPage());
		parameterMap.put("perPage", request.getPerPage());
		Request spRequest = new Request();
		requestMap.put("aParameter", parameterMap);
		spRequest.setInfo(requestMap);
		SpSpControlTableDetailUtil.executeSpControlTableDetail(spRequest, getSpOrchestrator());
		Integer statusCode = (Integer) spRequest.getInfo().get("statusCode");
		if (statusCode != 0) {
			if (logger.isErrorEnabled()) {
				logger.logError(wInfo + "Error getting data from si_sincronizar_app_movil");
			}
		}
		List<Integer> rowsId = new ArrayList<Integer>();
		List<Action> actionList = new ArrayList<Action>();
		List<?> listResults = (List<?>) spRequest.getInfo().get("aResultSpControlTableDetail");
		if (listResults != null && !listResults.isEmpty()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "listResults --> " + listResults.toString());
			}
			List<?> controlTableDetailResult = (List<?>) listResults.get(0);
			for (Object object : controlTableDetailResult) {
				Map<?, ?> mapParams = (Map<?, ?>) object;
				rowsId.add((Integer) mapParams.get("sa_id"));
				Action action = new Action();
				action.setActionType((String) mapParams.get("sa_accion"));
				action.setDescription((String) mapParams.get("sa_observacion"));
				actionList.add(action);
				if (logger.isDebugEnabled()) {
					logger.logDebug(wInfo + "mapParams Por Entidad --> " + mapParams);
					logger.logDebug(wInfo + "action --> " + action);
					logger.logDebug(wInfo + "actionList --> " + actionList);

				}
			}
		}
		if (logger.isDebugEnabled()) {
			logger.logDebug(wInfo + "actionList beforeSetting response --> " + actionList);

		}
		Integer index = 0;
		for (Integer idRow : rowsId) {
			GetEntitiesDataResponse entitiesDataResponse = new GetEntitiesDataResponse();
			if (logger.isDebugEnabled()) {
				logger.logDebug(wInfo + "index --> " + actionList.get(index));
				logger.logDebug(wInfo + "action to be set --> " + actionList.get(index));
				logger.logDebug(wInfo + "entity --> " + request.getEntity());
				logger.logDebug(wInfo + "idRow --> " + idRow);
			}

			entitiesDataResponse.setAction(actionList.get(index));
			if ("cliente".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getCustomerToSynchronize(idRow));
			}
			if ("grupo".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getGroupToSynchronize(idRow));
			}
			if ("pagoSolidario".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getSolidarityPaymentToSynchronize(idRow));
			}
			if ("creditoGrupal".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getCreditGroupApplicationSynchronizationData(idRow));
			}
			if ("creditoIndividual".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getCreditIndividualApplicationSynchronizationData(idRow));
			}
			if ("agenda".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getAgendaSynchronizationData(idRow));
			}
			if ("verificacion".equals(request.getEntity()) || "verificacionColectivo".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getVerificationSynchronizationData(idRow));
			}

			if ("verificacionGrupal".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getVerificationGroupSynchronizationData(idRow));
			}
			if ("verificationDocumentLcr".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getVerificationSynchronizationDataLcr(idRow));
			}
			if ("collectiveSynchronizationData".equals(request.getEntity())) {
				entitiesDataResponse.setEntity(this.getCollectiveSynchronizationData(idRow));
			}

			entitiesDtos.add(entitiesDataResponse);
			index++;
		}

		return entitiesDtos;

	}

}
