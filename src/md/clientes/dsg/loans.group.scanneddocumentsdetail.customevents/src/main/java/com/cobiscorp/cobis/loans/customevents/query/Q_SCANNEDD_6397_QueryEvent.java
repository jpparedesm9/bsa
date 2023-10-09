/*
 * Archivo: Q_SCANNEDD_6397_QueryEvent.java
 * Fecha: Jul 5, 2017 8:13:44 PM
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.cobis.loans.customevents.query;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.loans.customevents.events.SearchDocuments;
import com.cobiscorp.cobis.loans.customevents.events.SearchDocumentsInd;
import com.cobiscorp.designer.api.builder.QueryEventBuilder;

/**
 * Personalizacion de Eventos del Query
 * 
 * Q_SCANNEDD_6397_QueryEvent - ScannedDocumentsDetQuery 
 *
 * @autor designer
 */
@Component
@Service({QueryEventBuilder.class})
@Properties(value={
		@Property(name = "query.id", value = "Q_SCANNEDD_6397"),
		@Property(name = "query.version", value = "1.0.0")
})
public class Q_SCANNEDD_6397_QueryEvent extends QueryEventBuilder {

	/**
	 * Instancia de Logger
	 */
	//private static final ILogger LOGGER = LogFactory.getLogger(Q_SCANNEDD_6397_QueryEvent.class);
	
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;
	
	
	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
	
	@Override
	//TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
        this.addQueryEvent ("Q_SCANNEDD_6397", new SearchDocuments(serviceIntegration));
        this.addQueryEvent ("Q_SCANNEEC_4137", new SearchDocumentsInd(serviceIntegration));
	}
		
}