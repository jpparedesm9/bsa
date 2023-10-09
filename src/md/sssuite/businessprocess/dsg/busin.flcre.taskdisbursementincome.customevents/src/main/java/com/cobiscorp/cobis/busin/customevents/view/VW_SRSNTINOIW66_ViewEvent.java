/*
 * Archivo: VW_SRSNTINOIW66_ViewEvent.java
 * Fecha: 16-abr-2017 21:19:34
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

import com.cobiscorp.cobis.busin.customevents.events.ChangeCurrencyDisbursement;
import com.cobiscorp.cobis.busin.customevents.events.ChangeDisbursementValue;
import com.cobiscorp.cobis.busin.customevents.events.LoadCatalogCurrencyByProduct;
import com.cobiscorp.cobis.busin.customevents.events.LoadGroupMembers;
import com.cobiscorp.cobis.busin.customevents.events.LoadGroupMembersCheck;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_SRSNTINOIW66_ViewEvent - DisbursementIncomeView 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_SRSNTINOIW66"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_SRSNTINOIW66_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_SRSNTINOIW66_ViewEvent.class);
			
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
		addChangedEvent("VA_SRSNTINOIW6604_RNCY790",new ChangeCurrencyDisbursement(serviceIntegration));//currency
		addChangedEvent("VA_SRSNTINOIW6604_IBTU111",new ChangeDisbursementValue(serviceIntegration));
		addLoadCatalog("VA_SRSNTINOIW6604_RNCY790", new LoadCatalogCurrencyByProduct(serviceIntegration));
		addExecuteCommandEvent("VA_VABUTTONIWKBMNP_334W66", new LoadGroupMembers(serviceIntegration));
		addExecuteCommandEvent ("VA_VABUTTONRBZVRHL_639W66",new LoadGroupMembersCheck(serviceIntegration));


	}
		
}