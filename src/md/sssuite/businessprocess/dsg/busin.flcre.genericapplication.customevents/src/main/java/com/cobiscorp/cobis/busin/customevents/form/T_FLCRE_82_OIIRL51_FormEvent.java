/*
 * Archivo: T_FLCRE_82_OIIRL51_FormEvent.java
 * Fecha: 12/03/2015 04:52:20 PM
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

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_FLCRE_82_OIIRL51_FormEvent - SolicitudCreditoSimpleG
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "BUSIN"), @Property(name = "task.submodule", value = "FLCRE"), @Property(name = "task.id", value = "T_FLCRE_82_OIIRL51"),
		@Property(name = "task.version", value = "1.0.0") })
public class T_FLCRE_82_OIIRL51_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static final ILogger logger = LogFactory.getLogger(T_FLCRE_82_OIIRL51_FormEvent.class);

	@Override
	public void configure() {
		logger.logInfo("entra a la from event NMP");
		addInitDataEvent("VC_OIIRL51_CNLTO_343", new InitDataOriginalApplication(serviceIntegration));
		addExecuteCommandEvent("CM_OIIRL51SVE80", new ExecuteCommandCM_OIIRL51SVE80(serviceIntegration));
		addExecuteCommandEvent("CM_OIIRL51TND41", new ExecuteCommandCM_OIIRL51TND41(serviceIntegration));
		addExecuteCommandEvent("CM_OIIRL51INT80", new ExecuteCommandCM_OIIRL51INT80(serviceIntegration));
		// addExecuteCommandEvent("CM_OIIRL51INT80", new
		// SynchronizationMovil(serviceIntegration));
		addExecuteCommandEvent("CM_OIIRL51CAD91", new ExecuteCommandCM_OIIRL51CAD91(serviceIntegration));
		// addExecuteCommandEvent("VA_VABUTTONFUIXKXW_718576", new
		// ExecuteCommandQueryInfoCustomer(serviceIntegration));
		addExecuteCommandEvent("VA_VABUTTONFUIXKXW_718576", new ExecuteQueryBureauAval(serviceIntegration));
		addExecuteCommandEvent("CM_TFLCRE_8_TCR", new SynchronizationMovil(serviceIntegration));
		addExecuteCommandEvent("CM_TFLCRE_8__II", new QueryBureau(serviceIntegration));
		addExecuteCommandEvent("CM_TFLCRE_8_IO1", new SaveLCR(serviceIntegration));
		addExecuteCommandEvent("CM_TFLCRE_8_925", new ExecuteCommandCM_TFLCRE_8_925(serviceIntegration));
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}