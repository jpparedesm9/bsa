/*
 * Archivo: VW_LOANHEADRN_612_ViewEvent.java
 * Fecha: Nov 18, 2016 11:01:37 AM
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
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_LOANHEADRN_612_ViewEvent - View of LoanHeaderInfoForm 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_LOANHEADRN_612"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_LOANHEADRN_612_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_LOANHEADRN_612_ViewEvent.class);
			
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
        this.addChangedEvent ("VA_TEXTINPUTBOXPHC_672612", (com.cobiscorp.designer.api.customization.IChangedEvent)null /*implementar clase*/);
        
	}
		
}