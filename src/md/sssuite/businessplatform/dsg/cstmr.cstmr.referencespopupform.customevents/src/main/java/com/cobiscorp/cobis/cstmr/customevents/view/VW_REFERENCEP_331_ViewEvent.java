/*
 * Archivo: VW_REFERENCEP_331_ViewEvent.java
 * Fecha: 15/05/2017 16:42:55
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
import com.cobiscorp.cobis.cstmr.customevents.events.CreateReferences;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogCities;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogCountries;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogNeigborhoods;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogParishes;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogProvinces;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_REFERENCEP_331_ViewEvent - View of ReferencesPopupForm 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_REFERENCEP_331"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_REFERENCEP_331_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger LOGGER = LogFactory.getLogger(VW_REFERENCEP_331_ViewEvent.class);
			
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
	public void configure() {
		LOGGER.logInfo(">>>>>> Eventos personalizables View Popup");
		this.addLoadCatalog("VA_COUNTRYHJLSZJFZ_494331", new LoadCatalogCountries(serviceIntegration));
		this.addLoadCatalog("VA_STATEYTBMHORZDS_966331", new LoadCatalogProvinces(serviceIntegration));
		this.addLoadCatalog("VA_MUNICIPALITYFPX_127331", new LoadCatalogCities(serviceIntegration));
		this.addLoadCatalog("VA_COLONYZBIXFSRUI_331331", new LoadCatalogParishes(serviceIntegration));
		this.addLoadCatalog("VA_NEIGHBORHOODDTI_129331", new LoadCatalogNeigborhoods(serviceIntegration));
		
        this.addExecuteCommandEvent ("VA_VABUTTONLYUTEBY_858331", new CreateReferences(serviceIntegration));
	}
		
}