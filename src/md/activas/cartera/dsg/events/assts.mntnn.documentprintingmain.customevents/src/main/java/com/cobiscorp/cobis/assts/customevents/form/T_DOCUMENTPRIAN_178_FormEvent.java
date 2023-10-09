/*
 * Archivo: T_DOCUMENTPRIAN_178_FormEvent.java
 * Fecha: Dec 28, 2016 3:16:10 PM
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

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.assts.customevents.events.DocumentsPrintingIni;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_DOCUMENTPRIAN_178_FormEvent - DocumentPrintingMain 
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "ASSTS"),
             @Property(name = "task.submodule", value = "MNTNN"),
             @Property(name = "task.id", value = "T_DOCUMENTPRIAN_178"),
             @Property(name = "task.version", value = "1.0.0") })
public class T_DOCUMENTPRIAN_178_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_DOCUMENTPRIAN_178_FormEvent.class);
	
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
		logger.logInfo("-->T_DOCUMENTPRIAN_178_FormEvent >>> configure");
		this.addInitDataEvent("VC_DOCUMENTIG_406178", new DocumentsPrintingIni(serviceIntegration));//(com.cobiscorp.designer.api.customization.IInitDataEvent)null /*implementar clase*/)		
		this.addInitDataEvent("VC_DOCUMENTPP_352678", new DocumentsPrintingIni(serviceIntegration));
        this.addExecuteCommandEvent("CM_DOCUMENT_CRT", (com.cobiscorp.designer.api.customization.IExecuteCommand)null /*implementar clase*/);
	}
		
}