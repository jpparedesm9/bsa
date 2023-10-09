package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.Context;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.ParameterManager;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
//import cobiscorp.ecobis.customerdatamanagement.dto.ParameterRezsponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

public class InitDataProspect extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataProspect.class);

	public InitDataProspect(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeDataEvent in InitDataProspect");
		}
		ParameterResponse edadMax;
		ParameterResponse edadMin;
		ParameterResponse padre;
		ParameterResponse hijo;
		ParameterResponse conyugue;
		ParameterResponse unionLibre;
		ParameterResponse casado;
		ParameterResponse paisMx;

		ParameterResponse dirResidencia;
		ParameterResponse dirNegocio;
		ParameterResponse RENAPO;
		
		ParameterResponse paramColectivo; 			//Req. 161141
		ParameterResponse paramNivelColectivo;		//Req. 161141
		
		ParameterResponse paramActRENAPOQueryByCurp; //Req. 		

		ParameterManager parameterManagement = new ParameterManager(getServiceIntegration());

		DataEntity parameters = entities.getEntity("Parameters");

		Date dateTmp = null;
		SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");

		DataEntity contextEntity = new DataEntity();
		try {

			edadMax = parameterManagement.getParameter(4, "EMAX", "CLI", args);
			LOGGER.logDebug("edad maxima " + edadMax.getParameterValue());

			edadMin = parameterManagement.getParameter(4, "MDE", "ADM", args);
			padre = parameterManagement.getParameter(4, "PAD", "CLI", args);
			hijo = parameterManagement.getParameter(4, "HIJ", "CLI", args);
			conyugue = parameterManagement.getParameter(4, "CONY", "CLI", args);
			unionLibre = parameterManagement.getParameter(4, "UNL", "CLI", args);
			casado = parameterManagement.getParameter(4, "CDA", "CLI", args);
			paisMx = parameterManagement.getParameter(4, "CP", "ADM", args);

			dirResidencia = parameterManagement.getParameter(4, "TDRE", "CLI", args);
			dirNegocio = parameterManagement.getParameter(4, "TDNE", "CLI", args);
			RENAPO = parameterManagement.getParameter(4, "RENAPO", "CLI", args);
			
			paramColectivo = parameterManagement.getParameter(4, "CDDFCL", "CLI", args);
			paramNivelColectivo = parameterManagement.getParameter(4, "CDDFNC", "CLI", args);
			
			paramActRENAPOQueryByCurp = parameterManagement.getParameter(4, "ACRXCR", "CLI", args);

			if (edadMax != null) {
				contextEntity.set(Context.MAXIMUMAGE, Integer.parseInt(edadMax.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - EMAX");
				contextEntity.set(Context.MAXIMUMAGE, 0);
			}
			if (edadMin != null) {
				contextEntity.set(Context.MINIMUMAGE, Integer.parseInt(edadMin.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro -MDE ");
				contextEntity.set(Context.MINIMUMAGE, 0);
			}
			if (padre != null) {
				contextEntity.set(Context.PARENTS, Integer.parseInt(padre.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - 211");
				contextEntity.set(Context.PARENTS, 0);
			}
			if (hijo != null) {
				contextEntity.set(Context.SON, Integer.parseInt(hijo.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - 210");
				contextEntity.set(Context.SON, 0);
			}
			if (conyugue != null) {
				contextEntity.set(Context.COUPLE, conyugue.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - 209");
				contextEntity.set(Context.COUPLE, "0");
			}
			if (unionLibre != null) {
				contextEntity.set(Context.FREEUNION, unionLibre.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - UNL");
				contextEntity.set(Context.FREEUNION, "0");
			}
			if (casado != null) {
				contextEntity.set(Context.MARRIED, casado.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - CDA");
				contextEntity.set(Context.MARRIED, "0");
			}
			if (paisMx != null) {
				contextEntity.set(Context.FLAG1, Integer.parseInt(paisMx.getParameterValue()));
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - CP");
				contextEntity.set(Context.FLAG1, 0);
			}

			if (dirResidencia != null) {
				contextEntity.set(Context.FLAG2, dirResidencia.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - TDRE");
				contextEntity.set(Context.FLAG2, "0");
			}
			if (dirNegocio != null) {
				contextEntity.set(Context.FLAG3, dirNegocio.getParameterValue());
			} else {
				LOGGER.logError("----->>>No hay informacion para el parametro - TDNE");
				contextEntity.set(Context.FLAG3, "0");
			}

			if (RENAPO == null) {
				LOGGER.logError("----->>>No hay informacion para el parametro - RENAPO");
				contextEntity.set(Context.RENAPO, "N");
			} else {
				contextEntity.set(Context.RENAPO, RENAPO.getParameterValue());
			}
			
			if( paramColectivo != null) {
				contextEntity.set(Context.COLLECTIVE, paramColectivo.getParameterValue());
			}else {
				LOGGER.logError("----->>>No hay informacion para el parametro - Colectivo - CDDFCL");
				contextEntity.set(Context.COLLECTIVE, "I");
			}
			if( paramNivelColectivo != null) {
				contextEntity.set(Context.COLLECTIVELEVEL, paramNivelColectivo.getParameterValue());
			}else {
				LOGGER.logError("----->>>No hay informacion para el parametro - nivel Colectivo - CDDFNC");
				contextEntity.set(Context.COLLECTIVELEVEL, "O");
			}
			
			if( paramActRENAPOQueryByCurp != null) {
				contextEntity.set(Context.RENAPOBYCURP, paramActRENAPOQueryByCurp.getParameterValue());
			}else {
				LOGGER.logError("----->>>No hay informacion para el parametro - consulta por curp - ACRXCR");
				contextEntity.set(Context.RENAPOBYCURP, Parameter.INACTIVE);
			}			
			
			entities.setEntity(Context.ENTITY_NAME, contextEntity);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.INIT_DATA_CUSTOMER, e, args, LOGGER);
		}

	}

}
