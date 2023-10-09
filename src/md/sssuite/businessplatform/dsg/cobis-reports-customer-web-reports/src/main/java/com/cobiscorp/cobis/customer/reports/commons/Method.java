package com.cobiscorp.cobis.customer.reports.commons;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class Method {
	private static final ILogger logger = LogFactory.getLogger(Method.class);
	private Map<String, Object> prmMain;

	@SuppressWarnings("unchecked")
	public void error(ServiceResponseTO serviceResponseTO) {
		if (logger.isDebugEnabled()) {
			if (serviceResponseTO.getMessages() != null) {
				List<MessageTO> errorMessages = new ArrayList<MessageTO>();
				errorMessages = serviceResponseTO.getMessages();
				for (MessageTO message : errorMessages) {
					logger.logDebug("Mensaje  -  Codigo: " + message.getCode() + ", Detalle:" + message.getMessage());
				}
			}
			logger.logDebug(" *****--****** FALL SERVICE " + serviceResponseTO);
		}
	}
	public void mapValuesToParams(String pName, Object value, Object defaultValue) {
		try {
			if (value != null) {
				this.getPrmMain().put(pName, value);
			} else {
				this.getPrmMain().put(pName, defaultValue);
			}
		} catch (Exception ex) {
			logger.logError("REPORTE  ERROR EN EL MAPEO DE DATOS PARA: " + pName, ex);
		}
	}

	public Map<String, Object> getPrmMain() {
		return prmMain;
	}

	public void setPrmMain(Map<String, Object> prmMain) {
		this.prmMain = prmMain;
	}

	public void mapOneValueToParams(String[] pNameList, Object value, Object defaultValue) {
		Object finalValue = (value != null) ? value : defaultValue;
		try {
			for (String pName : pNameList) {
				this.getPrmMain().put(pName, finalValue);
			}
		} catch (Exception ex) {
			logger.logError("REPORTE  ERROR EN EL MAPEO DE DATOS PARA: " + pNameList, ex);
		}
	}
}