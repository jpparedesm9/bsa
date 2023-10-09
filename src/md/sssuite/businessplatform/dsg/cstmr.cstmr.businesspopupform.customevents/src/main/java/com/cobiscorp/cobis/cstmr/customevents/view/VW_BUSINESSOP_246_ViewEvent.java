/*
 * Archivo: VW_BUSINESSOP_246_ViewEvent.java
 * Fecha: 04/05/2017 15:42:38
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
import com.cobiscorp.cobis.cstmr.commons.events.GetEntrepreneur;
import com.cobiscorp.cobis.cstmr.commons.loadCatalog.LoadCatalogActivity;
import com.cobiscorp.cobis.cstmr.customevents.events.CreateBusiness;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogCities;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogCountries;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogParishes;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogProvinces;
import com.cobiscorp.cobis.cstmr.customevents.events.SearchAddressHome;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_BUSINESSOP_246_ViewEvent - View of BusinessPopupForm 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_BUSINESSOP_246"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_BUSINESSOP_246_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger LOGGER = LogFactory.getLogger(VW_BUSINESSOP_246_ViewEvent.class);
			
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
		LOGGER.logInfo(">>>>>> Eventos personalizables View Popup");
		this.addLoadCatalog("VA_COUNTRYIIWTTPSU_839246", new LoadCatalogCountries(serviceIntegration));
		this.addLoadCatalog("VA_STATEILWSIRFUNE_256246", new LoadCatalogProvinces(serviceIntegration));
		this.addLoadCatalog("VA_MUNICIPALITYALV_646246", new LoadCatalogCities(serviceIntegration));
		this.addLoadCatalog("VA_COLONYYSQOLWTXJ_927246", new LoadCatalogParishes(serviceIntegration));
		this.addLoadCatalog("VA_ECONOMICACTIITI_682246", new LoadCatalogActivity(serviceIntegration));
		
        this.addExecuteCommandEvent ("VA_VABUTTONYULNPZK_374246", new CreateBusiness(serviceIntegration));
        this.addChangedEvent ("VA_TYPELOCALUWBLBM_820246", new SearchAddressHome(serviceIntegration) );
        this.addChangedEvent ("VA_DATEBUSINESSBNU_397246", new GetEntrepreneur(serviceIntegration) );
	}
		
}