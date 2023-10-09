/*
 * Archivo: Q_TRANSAIN_3698_QueryEvent.java
 * Fecha: Oct 21, 2016 6:52:05 PM
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
 * Q_TRANSAIN_3698_QueryEvent - TransactionLoanQuery 
 *
 * @autor designer
 */
@Component
@Service({QueryEventBuilder.class})
@Properties(value={
		@Property(name = "query.id", value = "Q_TRANSAIN_3698"),
		@Property(name = "query.version", value = "1.0.0")
})
public class Q_TRANSAIN_3698_QueryEvent extends QueryEventBuilder {
	
	@Override
	//TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
	}
		
}