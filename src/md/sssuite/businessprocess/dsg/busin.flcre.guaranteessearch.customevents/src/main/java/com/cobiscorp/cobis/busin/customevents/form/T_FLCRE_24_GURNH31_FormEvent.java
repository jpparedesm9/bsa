/*
 * Archivo: T_FLCRE_24_GURNH31_FormEvent.java
 * Fecha: Dec 28, 2016 7:31:18 PM
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

package com.cobiscorp.cobis.busin.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.custonevents.events.ExecuteCommandCM_GURNH31OOS11;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_FLCRE_24_GURNH31_FormEvent - GuaranteesSearch 
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "BUSIN"),
             @Property(name = "task.submodule", value = "FLCRE"),
             @Property(name = "task.id", value = "T_FLCRE_24_GURNH31"),
             @Property(name = "task.version", value = "1.0.0") })
public class T_FLCRE_24_GURNH31_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_FLCRE_24_GURNH31_FormEvent.class);
	
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
        this.addExecuteCommandEvent("CM_GURNH31OOS11", new ExecuteCommandCM_GURNH31OOS11(serviceIntegration));
	}
		
}