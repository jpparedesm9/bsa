/*
 * Archivo: Q_REAJUSTE_2618_QueryEvent.java
 * Fecha: Oct 25, 2016 10:20:50 AM
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

package com.cobiscorp.cobis.assts.customevents.query;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.designer.api.builder.QueryEventBuilder;

/**
 * Personalizacion de Eventos del Query
 * 
 * Q_REAJUSTE_2618_QueryEvent - ReadjustmentDetalilsLoanQuery_2618
 * 
 * @autor designer
 */
@Component
@Service({ QueryEventBuilder.class })
@Properties(value = { @Property(name = "query.id", value = "Q_REAJUSTE_2618"),
		@Property(name = "query.version", value = "1.0.0") })
public class Q_REAJUSTE_2618_QueryEvent extends QueryEventBuilder {

	@Override
	public void configure() {
	}

}