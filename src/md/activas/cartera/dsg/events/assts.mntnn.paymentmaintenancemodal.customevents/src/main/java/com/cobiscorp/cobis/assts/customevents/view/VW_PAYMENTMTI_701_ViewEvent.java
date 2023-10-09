/*
 * Archivo: VW_PAYMENTMTI_701_ViewEvent.java
 * Fecha: Jan 13, 2017 1:43:58 PM
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

package com.cobiscorp.cobis.assts.customevents.view;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.customevents.events.CanalLoadCatalogEvent;
import com.cobiscorp.cobis.assts.customevents.events.CategoryProductsLoadCatalogEvent;
import com.cobiscorp.cobis.assts.customevents.events.PaymentReverseLoadCatalogEvent;
import com.cobiscorp.cobis.assts.customevents.events.ProducCobisLoadCatalogEvents;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_PAYMENTMTI_701_ViewEvent - View of PaymentMaintenanceModal 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_PAYMENTMTI_701"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_PAYMENTMTI_701_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_PAYMENTMTI_701_ViewEvent.class);
			
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
		logger.logInfo(">>>>>> Eventos personalizables");
        this.addLoadCatalog ("VA_CATEGORYPGXZQCK_157701", new CategoryProductsLoadCatalogEvent (serviceIntegration));
      
        this.addLoadCatalog ("VA_PAYMENTMETHODSD_816701", new PaymentReverseLoadCatalogEvent (serviceIntegration));
       
        this.addLoadCatalog ("VA_BANKSERVICESDQR_160701", (com.cobiscorp.designer.api.customization.ILoadCatalog)null /*implementar clase*/);
        this.addLoadCatalog ("VA_PCOBISNSCZVLGJB_151701",new ProducCobisLoadCatalogEvents (serviceIntegration));
        this.addLoadCatalog ("VA_CANALAHHGQQRYXT_909701", new CanalLoadCatalogEvent (serviceIntegration));
	}
		
}