/*
 * Archivo: T_LOANSCDNOQLVK_282_FormEvent.java
 * Fecha: May 8, 2018 5:24:51 PM
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

package com.cobiscorp.cobis.loans.customevents.form;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.events.InitDataEvent;
import com.cobiscorp.cobis.loans.customevents.events.OnCloseModalEvent;
import com.cobiscorp.designer.api.builder.FormEventBuilder;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;
//import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Personalizacion de Eventos del Formulario
 * <p>
 * T_LOANSCDNOQLVK_282_FormEvent - MemberRiskLevelForm
 *
 * @autor designer
 */
@Component
@Service({FormEventBuilder.class})
@Properties({@Property(name = "task.module", value = "LOANS"),
        @Property(name = "task.submodule", value = "GROUP"),
        @Property(name = "task.id", value = "T_LOANSCDNOQLVK_282"),
        @Property(name = "task.version", value = "1.0.0")})
public class T_LOANSCDNOQLVK_282_FormEvent extends FormEventBuilder {
    /**
     * Instancia de Logger
     */
    private static final ILogger logger = LogFactory.getLogger(T_LOANSCDNOQLVK_282_FormEvent.class);

    @Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
    private ICTSServiceIntegration serviceIntegration;


    /**
     * Method that set the instance of ICTSServiceIntegration
     *
     * @param serviceIntegration Instance of ICTSServiceIntegration
     */
    public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.serviceIntegration = serviceIntegration;
    }

    /**
     * Method that unset the instance of ICTSServiceIntegration
     *
     * @param serviceIntegration Instance of ICTSServiceIntegration
     */
    public void unsetServiceIntegration(
            ICTSServiceIntegration serviceIntegration) {
        this.serviceIntegration = null;
    }

    @Override
    //TODO Se deben agregar los eventos a administrar
    public void configure() {
        this.addOnCloseModalEvent("VC_MEMBERRILV_790282", (com.cobiscorp.designer.api.customization.IOnCloseModalEvent) new OnCloseModalEvent(this.serviceIntegration) /*implementar clase*/);
        this.addInitDataEvent("VC_MEMBERRILV_790282", (com.cobiscorp.designer.api.customization.IInitDataEvent) new InitDataEvent(this.serviceIntegration) /*implementar clase*/);
    }

}