package com.cobiscorp.cobis.busin.flcre.commons.utiles;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import com.cobiscorp.cobis.busin.flcre.commons.constants.SesionConstants;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.dto.ItemDTO;

public class SessionController {

	//private static final String COBIS_SESSION = "cobis-session";
	private static final ILogger logger = LogFactory
			.getLogger(SessionController.class);
	
	@SuppressWarnings("unchecked")
	
	private static String obtenerIdentificacionBase(String data){
		return data;
	}
	
		
	/**
	 * Permite guardar un objeto cliente en sesión
	 * 
	 * @param identificacion
	 *            (obligatorio)
	 * @param operacion
	 *            (obligatorio)
	 */
	public static void guardarObjetoSesion(String identificacion, Object operacion) {		
		if (!Validate.Strings.isNotNullOrEmpty(identificacion)) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("GUARDAR TRAMITE: NULL O VACIO");					
			}
		} else {
			if (operacion == null) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("GUARDAR TRAMITE: OBJETO VACIO O NULL");					
				}
			} else {
				Map<String, Object> session = SessionManager.getSession();
				if (logger.isDebugEnabled()) {
					logger.logDebug("Session en la que se guardo la operacion: "
							+ SessionManager.getSessionId());
				}
				String clave = obtenerIdentificacionBase(SesionConstants.TRAMITE_SESSION + identificacion);
				session.put(clave, operacion);
			}
		}
	}
	
	
	/**
	 * Recupera un objeto cliente de sesión
	 * 
	 * @param identificacion
	 *            (obligatorio)
	 * @return DataEntity
	 */
	public static DataEntity obtenerObjetoSesion(String identificacion) {
		DataEntity dataEntity = null;
		
		if (!Validate.Strings.isNotNullOrEmpty(identificacion)) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("OBTENER TRAMITE: NULL O VACIO"+identificacion);					
			}
		} else {
			String clave = obtenerIdentificacionBase(SesionConstants.TRAMITE_SESSION + identificacion);
			Map<String, Object> session = SessionManager.getSession();			
			if(!Validate.Strings.isNotNullOrEmpty(session.get(clave))){
				if (logger.isDebugEnabled()) {
					logger.logDebug("Session recuperada: "+ ((DataEntity) session.get(clave)).getData());
				}
				dataEntity = (DataEntity) session.get(clave);
			}else{
				if (logger.isDebugEnabled()) {
					logger.logDebug("Session no encontrada");
				}
			}
		}
		return dataEntity;
	}	
	
	/**
	 * Recupera un objeto cliente de sesión
	 * 
	 * @param identificacion
	 *            (obligatorio)
	 * @return DataEntity
	 */
	public static DataEntityList obtenerObjetoListaSesion(String identificacion) {
		DataEntityList dataEntity = null;
		
		if (!Validate.Strings.isNotNullOrEmpty(identificacion)) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("ObtenerObjetoListaSesion: NULL O VACIO"+identificacion);					
			}
		} else {
			String clave = obtenerIdentificacionBase(SesionConstants.TRAMITE_SESSION + identificacion);
			Map<String, Object> session = SessionManager.getSession();			
			if(!Validate.Strings.isNotNullOrEmpty(session.get(clave))){
				if (logger.isDebugEnabled()) {
					logger.logDebug("Session recuperada: "+ ((DataEntityList) session.get(clave)).getDataList());
				}
				dataEntity = (DataEntityList) session.get(clave);
			}else{
				if (logger.isDebugEnabled()) {
					logger.logDebug("Session no encontrada");
				}
			}
		}
		return dataEntity;
	}	
}
