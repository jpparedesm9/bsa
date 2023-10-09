/*
 * Archivo: VW_SHCTRATNIW77_ViewEvent.java
 * Fecha: May 19, 2015 9:52:15 AM
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

package com.cobiscorp.cobis.busin.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.customevents.events.ExecuteCommandSearchApplications;
import com.cobiscorp.cobis.busin.customevents.events.LoadCatalogTypeFlow;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_SHCTRATNIW77_ViewEvent - SearchCriteriaApplicationView 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_SHCTRATNIW77"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_SHCTRATNIW77_ViewEvent extends ViewEventBuilder {
	
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;	
	
	
	
	/**
	 * Instancia de Logger
	 */
	private static final ILogger LOGGER = LogFactory.getLogger(VW_SHCTRATNIW77_ViewEvent.class);
			
	@Override
	//TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
		LOGGER.logInfo(">>>>>> Eventos personalizables");
		addLoadCatalog("VA_SHCTRATNIW7705_LTYE544", new LoadCatalogTypeFlow(serviceIntegration));
		addExecuteCommandEvent("VA_SHCTRATNIW7705_0000829", new ExecuteCommandSearchApplications(serviceIntegration));
	}
	
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {		
		this.serviceIntegration = null;
	}
		
}