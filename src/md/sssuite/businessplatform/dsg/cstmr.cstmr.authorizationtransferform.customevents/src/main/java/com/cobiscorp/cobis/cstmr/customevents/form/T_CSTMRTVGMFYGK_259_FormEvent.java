/*
 * Archivo: T_CSTMRTVGMFYGK_259_FormEvent.java
 * Fecha: 25/07/2018 9:48:25
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

package com.cobiscorp.cobis.cstmr.customevents.form;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.cstmr.customevents.events.AuthoriceTransfer;
import com.cobiscorp.cobis.cstmr.customevents.events.RefuseTransfer;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_CSTMRTVGMFYGK_259_FormEvent - AuthorizationTransferForm
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "CSTMR"), @Property(name = "task.submodule", value = "CSTMR"),
		@Property(name = "task.id", value = "T_CSTMRTVGMFYGK_259"), @Property(name = "task.version", value = "1.0.0") })
public class T_CSTMRTVGMFYGK_259_FormEvent extends FormEventBuilder {

	//private static final ILogger LOGGER = LogFactory.getLogger(T_CSTMRTVGMFYGK_259_FormEvent.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	public void configure() {
		this.addOnCloseModalEvent("VC_AUTHORIZOS_306259", new RefuseTransfer(this.serviceIntegration));
		this.addExecuteCommandEvent("CM_TCSTMRTV_C7T", new AuthoriceTransfer(this.serviceIntegration));
		//this.addExecuteCommandEvent("CM_TCSTMRTV_R2T", new RefuseTransfer(this.serviceIntegration));
	}

}