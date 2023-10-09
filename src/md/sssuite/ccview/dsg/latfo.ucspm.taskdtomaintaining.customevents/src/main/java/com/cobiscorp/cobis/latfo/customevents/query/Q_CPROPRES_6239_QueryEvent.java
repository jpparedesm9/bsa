/*
 * Archivo: Q_CPROPRES_6239_QueryEvent.java
 * Fecha: 29/09/2015 09:37:14 AM
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

package com.cobiscorp.cobis.latfo.customevents.query;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.designer.api.builder.QueryEventBuilder;

/**
 * Personalizacion de Eventos del Query
 * 
 * Q_CPROPRES_6239_QueryEvent - Detalle de Propiedades
 * 
 * @autor designer
 */
@Component
@Service({ QueryEventBuilder.class })
@Properties(value = { @Property(name = "query.id", value = "Q_CPROPRES_6239"),
		@Property(name = "query.version", value = "1.0.0") })
public class Q_CPROPRES_6239_QueryEvent extends QueryEventBuilder {

	@Override
	// TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
	}

}