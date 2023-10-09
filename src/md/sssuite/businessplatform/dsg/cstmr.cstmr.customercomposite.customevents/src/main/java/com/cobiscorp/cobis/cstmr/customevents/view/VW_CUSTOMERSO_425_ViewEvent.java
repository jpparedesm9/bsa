/*
 * Archivo: VW_CUSTOMERSO_425_ViewEvent.java
 * Fecha: 12/09/2017 9:05:08
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

package com.cobiscorp.cobis.cstmr.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.SearchSpouse;
import com.cobiscorp.cobis.cstmr.customevents.events.CreateSpouse;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCountryofBirth;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadNaturalCatalogDocumenType;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_CUSTOMERSO_425_ViewEvent - View of CustomerSpouseForm 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_CUSTOMERSO_425"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_CUSTOMERSO_425_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger LOGGER = LogFactory.getLogger(VW_CUSTOMERSO_425_ViewEvent.class);
			
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
		LOGGER.logInfo(">>>>>> Eventos personalizables SpouseForm");
		this.addLoadCatalog ("VA_TEXTINPUTBOXMPZ_379425", new LoadNaturalCatalogDocumenType(serviceIntegration));
        this.addLoadCatalog ("VA_TEXTINPUTBOXKWI_295425", new LoadCountryofBirth(serviceIntegration));
        this.addExecuteCommandEvent ("VA_VABUTTONOARJENM_541425", new CreateSpouse(serviceIntegration));
        this.addExecuteCommandEvent ("VA_VABUTTONSTVQSJN_350425", new SearchSpouse(serviceIntegration));
	}
		
}