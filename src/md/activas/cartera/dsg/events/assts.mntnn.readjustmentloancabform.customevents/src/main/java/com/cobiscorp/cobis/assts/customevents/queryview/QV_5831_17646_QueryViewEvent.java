/*
 * Archivo: QV_5831_17646_QueryViewEvent.java
 * Fecha: Oct 25, 2016 10:21:23 AM
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

package com.cobiscorp.cobis.assts.customevents.queryview;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.designer.api.builder.QueryViewEventBuilder;

/**
 * Personalizacion de Eventos del Query
 * 
 * QV_5831_17646_QueryViewEvent - ReadjustmentLoanCabForm
 * 
 * @autor designer
 */
@Component
@Service({ QueryViewEventBuilder.class })
@Properties({ @Property(name = "queryView.id", value = "QV_5831_17646") })
public class QV_5831_17646_QueryViewEvent extends QueryViewEventBuilder {

	@Override
	public void configure() {

	}

}