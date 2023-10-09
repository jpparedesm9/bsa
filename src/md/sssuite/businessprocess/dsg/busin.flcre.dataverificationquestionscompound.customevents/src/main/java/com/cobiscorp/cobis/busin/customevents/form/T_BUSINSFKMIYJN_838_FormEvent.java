/*
 * Archivo: T_BUSINSFKMIYJN_838_FormEvent.java
 * Fecha: Jun 21, 2017 10:08:52 AM
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

import com.cobiscorp.cobis.busin.customevents.events.InitDataVerificationQuestionCompound;
import com.cobiscorp.cobis.busin.customevents.events.Save_CM_TBUSINSF_3N8;
import com.cobiscorp.cobis.busin.customevents.events.Synchronize_CM_TBUSINSF_SSU;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_BUSINSFKMIYJN_838_FormEvent - DataVerificationQuestionsCompound
 * 
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "BUSIN"), @Property(name = "task.submodule", value = "FLCRE"), @Property(name = "task.id", value = "T_BUSINSFKMIYJN_838"), @Property(name = "task.version", value = "1.0.0") })
public class T_BUSINSFKMIYJN_838_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_BUSINSFKMIYJN_838_FormEvent.class);

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
	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
		logger.logDebug("--------Empezo metodo InitData - DataVerificationQuestionCompound");
		this.addInitDataEvent("VC_DATAVERITO_790838", new InitDataVerificationQuestionCompound(serviceIntegration));
		this.addExecuteCommandEvent("CM_TBUSINSF_3N8", new Save_CM_TBUSINSF_3N8(serviceIntegration));
	    this.addExecuteCommandEvent("CM_TBUSINSF_SSU", new Synchronize_CM_TBUSINSF_SSU(serviceIntegration));

	}

}