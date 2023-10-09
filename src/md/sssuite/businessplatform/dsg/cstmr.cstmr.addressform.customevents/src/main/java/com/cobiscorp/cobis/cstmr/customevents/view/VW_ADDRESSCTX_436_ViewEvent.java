/*
 * Archivo: VW_ADDRESSCTX_436_ViewEvent.java
 * Fecha: 26-ene-2017 17:28:24
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
import com.cobiscorp.cobis.cstmr.customevents.events.CargarEstadosMunicipios;
import com.cobiscorp.cobis.cstmr.customevents.events.CreateAddress;
import com.cobiscorp.cobis.cstmr.customevents.events.FindZipPostal;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogBusinessNames;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogCities;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogCountries;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogDepartments;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogNeigborhoods;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogParishes;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogPhysicalAddressTypes;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCatalogProvinces;
import com.cobiscorp.cobis.cstmr.customevents.events.UpdateState;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_ADDRESSCTX_436_ViewEvent - View of AddressForm 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_ADDRESSCTX_436"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_ADDRESSCTX_436_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger LOGGER = LogFactory.getLogger(VW_ADDRESSCTX_436_ViewEvent.class);
			
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
		// TODO Auto-generated method stub
		LOGGER.logInfo(">>> Eventos personalizables VW_ADDRESSCTX_436_ViewEvent");
		addLoadCatalog("VA_TEXTINPUTBOXOJR_474436", new LoadCatalogCountries(serviceIntegration));
		addLoadCatalog("VA_TEXTINPUTBOXTCU_205436", new LoadCatalogProvinces(serviceIntegration));
		addLoadCatalog("VA_TEXTINPUTBOXQVZ_987436", new LoadCatalogCities(serviceIntegration));
		addLoadCatalog("VA_TEXTINPUTBOXPPK_701436", new LoadCatalogParishes(serviceIntegration));
		addLoadCatalog("VA_TEXTINPUTBOXHGW_672436", new LoadCatalogPhysicalAddressTypes(serviceIntegration));
		addLoadCatalog("VA_DEPARTMENTEYBYZ_692436", new LoadCatalogDepartments(serviceIntegration));
		addLoadCatalog("VA_TEXTINPUTBOXSGN_115436", new LoadCatalogNeigborhoods(serviceIntegration));
		addExecuteCommandEvent("VA_VABUTTONCRFQENP_394436",new CreateAddress(serviceIntegration));
		this.addChangedEvent("VA_POSTALCODERCKFJ_389436", new  CargarEstadosMunicipios(serviceIntegration));
		this.addChangedEvent("VA_TEXTINPUTBOXPPK_701436", new  FindZipPostal(serviceIntegration));
		addLoadCatalog("VA_BUSINESSCODEWRI_405436", new LoadCatalogBusinessNames(serviceIntegration));
		this.addExecuteCommandEvent ("CM_TADDRESS_5TD", new UpdateState(serviceIntegration));
		
	}
		
}