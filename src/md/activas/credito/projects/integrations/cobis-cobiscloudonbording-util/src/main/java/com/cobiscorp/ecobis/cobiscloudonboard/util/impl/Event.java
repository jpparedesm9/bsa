package com.cobiscorp.ecobis.cobiscloudonboard.util.impl;
import org.codehaus.jackson.map.ObjectMapper;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class Event {
	
	private Event() {
		
	}
	
	private static final ILogger LOGGER = LogFactory.getLogger(Event.class);
	
	public static String objectToJson(Object obj){
    	ObjectMapper mapper = new ObjectMapper();
    	try {
			return mapper.writeValueAsString(obj); 
		} catch (Exception e) {
			LOGGER.logError("Error al obtener trama JSON de respuesta:",e);
			return null;
		}
    }

}
