/*
 * Archivo: QV_5241_65721_QueryViewEvent.java
 * Fecha: Nov 13, 2017 2:40:57 PM
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

package com.cobiscorp.cobis.mbile.customevents.queryview;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.builder.QueryViewEventBuilder;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

/**
 * Personalizacion de Eventos del Query
 * <p>
 * QV_5241_65721_QueryViewEvent - TerminalManagementForm
 *
 * @autor designer
 */
@Component
@Service({QueryViewEventBuilder.class})
@Properties({@Property(name = "queryView.id", value = "QV_5241_65721")})

public class QV_5241_65721_QueryViewEvent extends QueryViewEventBuilder {
    /**
     * Instancia de Logger
     */
    private static final ILogger logger = LogFactory.getLogger(QV_5241_65721_QueryViewEvent.class);

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
        // TODO Auto-generated method stub
        this.addGridRowDeleting("QV_5241_65721", (com.cobiscorp.designer.api.customization.IGridRowDeleting) new DeletingTerminal(serviceIntegration) /*implementar clase*/);
        this.addGridRowInserting("QV_5241_65721", (com.cobiscorp.designer.api.customization.IGridRowInserting) new InsertingTerminal(serviceIntegration) /*implementar clase*/);
        this.addGridRowUpdating("QV_5241_65721", (com.cobiscorp.designer.api.customization.IGridRowUpdating) new UpdatingTerminal(serviceIntegration) /*implementar clase*/);
    }
}