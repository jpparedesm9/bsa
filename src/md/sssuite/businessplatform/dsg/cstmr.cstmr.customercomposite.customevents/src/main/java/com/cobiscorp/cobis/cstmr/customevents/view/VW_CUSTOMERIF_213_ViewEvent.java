/*
 * Archivo: VW_CUSTOMERIF_213_ViewEvent.java
 * Fecha: Feb 1, 2017 5:21:44 PM
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
import com.cobiscorp.cobis.cstmr.commons.loadCatalog.LoadCatalogExecutiveCustomer;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadCountryofBirth;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadDocumentTypeCatalog;
import com.cobiscorp.cobis.cstmr.customevents.events.LoadNationalityList;
import com.cobiscorp.cobis.cstmr.customevents.events.ReadCustomerExecuteCommandEvent;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_CUSTOMERIF_213_ViewEvent - View of CustomerGeneralInfForm 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_CUSTOMERIF_213"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_CUSTOMERIF_213_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_CUSTOMERIF_213_ViewEvent.class);
			
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
		logger.logInfo(">>>>>> Eventos personalizables");
        this.addLoadCatalog ("VA_DOCUMENTTYPEAQM_964213", new LoadDocumentTypeCatalog(serviceIntegration));
        this.addLoadCatalog ("VA_NATIONALITYCEDE_860213", new LoadNationalityList(serviceIntegration, Parameter.TYPESEUDOCATALOG.COUNTRY));
        this.addLoadCatalog ("VA_OFFICERCODEBNMM_892213", new LoadCatalogExecutiveCustomer(serviceIntegration));
        this.addLoadCatalog ("VA_COUNTYOFBIRTHHH_881213", new LoadCountryofBirth(serviceIntegration));
        this.addExecuteCommandEvent ("VA_VABUTTONQGYEKJY_245213", new ReadCustomerExecuteCommandEvent(serviceIntegration));
	}
		
}