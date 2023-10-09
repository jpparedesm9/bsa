package com.cobiscorp.cobis.cstmr.commons.events;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.CatalogManagement;
import com.cobiscorp.cobis.cstmr.model.Business;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;

public class GetEntrepreneur extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(GetEntrepreneur.class);

	public GetEntrepreneur(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		try {
			LOGGER.logDebug("Start executeCommand in GetEntrepreneur");
			
			DataEntity business = entities.getEntity(Business.ENTITY_NAME);
			Date dateBusiness = business.get(Business.DATEBUSINESS);
			
			Calendar fecha = Calendar.getInstance();
			Date fechaProceso = null;
			SimpleDateFormat formatDate = new SimpleDateFormat("MM/dd/yyyy");
			
			if (ServerParamUtil.getProcessDate() != null) {
				fechaProceso = formatDate.parse(ServerParamUtil.getProcessDate());
			}
			
			CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDto = catalogManagement.getParameter(4, "NDEP", "MIS", args, new BehaviorOption(false, false));
			int parametro = Integer.parseInt(parameterDto.getParameterValue());
			
			
			Calendar fechaProcesoCal=Calendar.getInstance();
			fechaProcesoCal.setTime(fechaProceso);
			fechaProcesoCal.add(Calendar.MONTH, -parametro);
			
			LOGGER.logDebug("Fecha sin formato: " + ServerParamUtil.getProcessDate());
			LOGGER.logDebug("Fecha de Proceso: " + fechaProceso);
			LOGGER.logDebug("Fecha de Negocio: " + dateBusiness);
			LOGGER.logDebug("Fecha de ProcesoRestado: " + fechaProcesoCal.getTime());
			
			DataEntity businessEntity = new DataEntity();
			
			businessEntity = business;
			
			if(dateBusiness.getTime() >= fechaProcesoCal.getTime().getTime()){
				businessEntity.set(Business.AREENTREPRENEUR, true);
			} else {
				businessEntity.set(Business.AREENTREPRENEUR, false);
			}
			
			entities.setEntity(Business.ENTITY_NAME, businessEntity);
			
		} catch (BusinessException e) {
			LOGGER.logDebug("Error al obtener Emprendedor" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al obtener Emprendedor"+e.getMessage());
		} catch (Exception e) {
			LOGGER.logDebug("Error al obtener Emprendedor" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al obtener Emprendedor");
		} finally {
			LOGGER.logDebug("Finish executeCommand in SearchBusiness");			
		}
	}

}
