/*
 * Archivo: VW_COLLECTIVR_380_ViewEvent.java
 * Fecha: Dec 3, 2019 3:44:51 PM
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

package com.cobiscorp.cobis.clcol.customevents.view;

import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;


import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.DynamicResponse;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
import com.cobiscorp.cobis.clcol.customevents.events.ExecuteCommandInsertAdvisorRole;
import com.cobiscorp.cobis.clcol.customevents.events.LoadCatalogCollective;
import com.cobiscorp.cobis.clcol.customevents.events.LoadCatalogOfficial;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.*;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_COLLECTIVR_380_ViewEvent - View of CollectiveAdvisorsRoles 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_COLLECTIVR_380"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_COLLECTIVR_380_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_COLLECTIVR_380_ViewEvent.class);
			
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
		logger.logInfo(">>>>>> Eventos personalizables");
        this.addLoadCatalog ("VA_OFFICIALYYQHLMI_968380", new LoadCatalogOfficial(serviceIntegration));
        this.addLoadCatalog ("VA_COLLECTIVESPPQW_866380", new LoadCatalogCollective(serviceIntegration));
        this.addExecuteCommandEvent ("VA_VABUTTONUCULYAE_906380", new ExecuteCommandInsertAdvisorRole(serviceIntegration));
	}
		
}