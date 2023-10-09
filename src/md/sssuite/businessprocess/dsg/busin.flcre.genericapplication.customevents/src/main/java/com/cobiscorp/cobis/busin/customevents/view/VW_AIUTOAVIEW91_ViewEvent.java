/*
 * Archivo: VW_AIUTOAVIEW91_ViewEvent.java
 * Fecha: Dec 28, 2016 2:19:49 PM
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

import java.util.List;
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
import com.cobiscorp.cobis.busin.view.customevents.events.LoadCatalogCity;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogExecutive;
import com.cobiscorp.cobis.busin.view.customevents.loadCatalog.LoadCatalogLocation;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.customization.*;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.designer.api.customization.arguments.ILoadCatalogDataEventArgs;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_AIUTOAVIEW91_ViewEvent - alicutoaView 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_AIUTOAVIEW91"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_AIUTOAVIEW91_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_AIUTOAVIEW91_ViewEvent.class);
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;			
	//@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	//private ICTSServiceIntegration serviceIntegration;
	
	
	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	/*public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}*/

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	/*public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}*/	
	
	@Override
	//TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
		logger.logInfo(">>>>>> Eventos personalizables");
        
        
        
        this.addLoadCatalog ("VA_ORIAHEADER8608_TTCD057", (com.cobiscorp.designer.api.customization.ILoadCatalog)null /*implementar clase*/);
        this.addLoadCatalog ("VA_ORIAHEADER8608_CCAA829", (com.cobiscorp.designer.api.customization.ILoadCatalog)null /*implementar clase*/);
        
        this.addLoadCatalog ("VA_ORIAHEADER8608_TAOR020", (com.cobiscorp.designer.api.customization.ILoadCatalog)null /*implementar clase*/);
        this.addLoadCatalog ("VA_ORIAHEADER8608_TCTC534", (com.cobiscorp.designer.api.customization.ILoadCatalog)null /*implementar clase*/);
        
      //Location
      addLoadCatalog("VA_UBICACIONCNXOET_652R86", new LoadCatalogLocation(serviceIntegration)); //ok falta borrar las clases
      //Executive
      addLoadCatalog("VA_EJECUTIVOZUEHTQ_752W91", new LoadCatalogExecutive(serviceIntegration));
	}
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {		
		this.serviceIntegration = null;
	}
		
}