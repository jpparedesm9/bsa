/*
 * Archivo: T_FLCRE_68_ITCII49_FormEvent.java
 * Fecha: Mar 18, 2015 12:04:06 PM
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

//import busin.flcre.officialactivityallocation.customevent.events.InitDataOfficial;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.customevents.events.ExecuteCommandPrint;
import com.cobiscorp.cobis.busin.customevents.events.InitDataPrinting;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_FLCRE_68_ITCII49_FormEvent - PrintingActivity 
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "BUSIN"),
             @Property(name = "task.submodule", value = "FLCRE"),
             @Property(name = "task.id", value = "T_FLCRE_68_ITCII49"),
             @Property(name = "task.version", value = "1.0.0") })
public class T_FLCRE_68_ITCII49_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;
	
	private static final ILogger logger = LogFactory.getLogger(T_FLCRE_68_ITCII49_FormEvent.class);
	
	@Override
	//TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
		addInitDataEvent("VC_ITCII49_TNYFM_899", new InitDataPrinting(serviceIntegration));
	    addExecuteCommandEvent( "CM_ITCII49ITT66", new ExecuteCommandPrint(serviceIntegration));	
	}
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(
			ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
		
}