/*
 * Archivo: T_FLCRE_12_TPYEP21_FormEvent.java
 * Fecha: Dec 14, 2016 6:16:43 PM
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

import com.cobiscorp.cobis.busin.customevents.events.InitDataPaymentPlan;
import com.cobiscorp.cobis.busin.customevents.executeCommand.ExecuteCommandCM_TPYEP21MTE89;
import com.cobiscorp.cobis.busin.customevents.executeCommand.ExecuteCommandSaveSessionPaymenPlan;
import com.cobiscorp.cobis.busin.customevents.executeCommand.ExecuteCommandVA_VWPAYMENLA2621_0000855;
import com.cobiscorp.designer.api.builder.FormEventBuilder;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_FLCRE_12_TPYEP21_FormEvent - TPaymentPlan 
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "BUSIN"),
             @Property(name = "task.submodule", value = "FLCRE"),
             @Property(name = "task.id", value = "T_FLCRE_12_TPYEP21"),
             @Property(name = "task.version", value = "1.0.0") })
public class T_FLCRE_12_TPYEP21_FormEvent extends FormEventBuilder {
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	@Override
	public void configure() {
		addInitDataEvent("VC_TPYEP21_FAETL_814", new InitDataPaymentPlan(serviceIntegration));		
		addExecuteCommandEvent("CM_TPYEP21MTE89", new ExecuteCommandCM_TPYEP21MTE89(serviceIntegration));
		addExecuteCommandEvent("VA_VWPAYMENLA2621_0000855", new ExecuteCommandVA_VWPAYMENLA2621_0000855(serviceIntegration));
		addExecuteCommandEvent("VA_VWPAYMENLA2621_0000251", new ExecuteCommandSaveSessionPaymenPlan(serviceIntegration));
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
		
}