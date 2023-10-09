/*
 * Archivo: T_ASSTSRBSDDMKT_144_FormEvent.java
 * Fecha: Jan 25, 2019 2:04:51 PM
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

package com.cobiscorp.cobis.assts.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.assts.customevents.events.AutBlocking;
import com.cobiscorp.cobis.assts.customevents.events.LCRBlockInitData;
import com.cobiscorp.cobis.assts.customevents.events.LCRCancelExecuteCommand;
import com.cobiscorp.cobis.assts.customevents.events.LCRExecuteCommand;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_ASSTSRBSDDMKT_144_FormEvent - CreditBlockComposite 
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "ASSTS"),
             @Property(name = "task.submodule", value = "MNTNN"),
             @Property(name = "task.id", value = "T_ASSTSRBSDDMKT_144"),
             @Property(name = "task.version", value = "1.0.0") })
public class T_ASSTSRBSDDMKT_144_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_ASSTSRBSDDMKT_144_FormEvent.class);
	
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
		this.addInitDataEvent("VC_CREDITBLOC_747144", new LCRBlockInitData(serviceIntegration)/*implementar clase*/);
		this.addExecuteCommandEvent("CM_TASSTSRB_N1N",new LCRExecuteCommand(serviceIntegration));
		this.addExecuteCommandEvent("CM_TASSTSRB_SSS",new LCRCancelExecuteCommand(serviceIntegration));
		this.addExecuteCommandEvent("CM_TASSTSRB_NMS",new AutBlocking(serviceIntegration));
	}
		
}