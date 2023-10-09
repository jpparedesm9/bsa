/*
 * Archivo: T_PAYMENTSMANII_157_FormEvent.java
 * Fecha: Dec 5, 2016 2:18:56 PM
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




import com.cobiscorp.cobis.assts.customevents.events.ExecuteCommandPaymentMain;
import com.cobiscorp.cobis.assts.customevents.events.InitPaymentManager;
import com.cobiscorp.cobis.assts.customevents.events.PaymentCloseModalEvent;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.FormEventBuilder;


/**
 * Personalizacion de Eventos del Formulario
 * 
 * T_PAYMENTSMANII_157_FormEvent - PaymentsMain 
 *
 * @autor designer
 */
@Component
@Service({ FormEventBuilder.class })
@Properties({ @Property(name = "task.module", value = "ASSTS"),
             @Property(name = "task.submodule", value = "TRNSC"),
             @Property(name = "task.id", value = "T_PAYMENTSMANII_157"),
             @Property(name = "task.version", value = "1.0.0") })
public class T_PAYMENTSMANII_157_FormEvent extends FormEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(T_PAYMENTSMANII_157_FormEvent.class);
	
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
		this.addInitDataEvent("VC_PAYMENTSAN_916157", new InitPaymentManager(serviceIntegration));
        this.addExecuteCommandEvent("CM_PAYMENTS_T3A", new ExecuteCommandPaymentMain(serviceIntegration));
        this.addOnCloseModalEvent("VC_PAYMENTSAN_916157", new PaymentCloseModalEvent(serviceIntegration));
        this.addExecuteCommandEvent("CM_TPAYMENT_Y_2", new ExecuteCommandPaymentMain(serviceIntegration));
	}

		
}