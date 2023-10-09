/*
 * Archivo: T_ASSTSOSPSJXWE_883_FormEvent.java
 * Fecha: 16/07/2018 16:05:17
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

import com.cobiscorp.cobis.assts.customevents.events.ChangeAccount;
import com.cobiscorp.cobis.assts.customevents.events.InitialCharge;
import com.cobiscorp.cobis.assts.customevents.events.PaymentLoan;
import com.cobiscorp.cobis.assts.customevents.events.RetryDispersion;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_ASSTSOSPSJXWE_883_FormEvent - RegularizeDispersionsRejectedForm
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "ASSTS"), @Property(name = "task.submodule", value = "TRNSC"),
		@Property(name = "task.id", value = "T_ASSTSOSPSJXWE_883"), @Property(name = "task.version", value = "1.0.0") })
public class T_ASSTSOSPSJXWE_883_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger LOGGER = LogFactory.getLogger(T_ASSTSOSPSJXWE_883_FormEvent.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Reference(bind = "setCobisParameter", unbind = "unsetCobisParameter", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	protected ICobisParameter cobisParameter;

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

	public void setCobisParameter(ICobisParameter aCobisParameter) {
		LOGGER.logDebug("Antes de Setear");
		LOGGER.logDebug("aCobisParameter: " + aCobisParameter);
		this.cobisParameter = aCobisParameter;
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void unsetCobisParameter(ICobisParameter aCobisParameter) {
		this.cobisParameter = null;
	}

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
		LOGGER.logDebug("Ingresa customevents");
		this.addInitDataEvent("VC_REGULARIOE_732883", new InitialCharge(this.serviceIntegration, this.cobisParameter));
		this.addExecuteCommandEvent("CM_TASSTSOS_EAN", new RetryDispersion(this.serviceIntegration));
		this.addExecuteCommandEvent("CM_TASSTSOS_SJO", new ChangeAccount(this.serviceIntegration, this.cobisParameter));
		this.addExecuteCommandEvent("CM_TASSTSOS_ASN", new PaymentLoan(this.serviceIntegration));
	}

}