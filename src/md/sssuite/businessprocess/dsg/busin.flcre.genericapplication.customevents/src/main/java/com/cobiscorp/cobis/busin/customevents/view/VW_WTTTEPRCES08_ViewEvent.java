/*
 * Archivo: VW_WTTTEPRCES08_ViewEvent.java
 * Fecha: 14/06/2016 03:58:09 PM
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

package com.cobiscorp.cobis.busin.customevents.view;

import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Service;


import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.DynamicResponse;
import com.cobiscorp.designer.api.builder.ViewEventBuilder;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

/**
 * Personalizacion de Eventos del Formulario
 * 
 * VW_WTTTEPRCES08_ViewEvent - VW_tittleProcess 
 *
 * @autor designer
 */
@Component
@Service({ViewEventBuilder.class})
@Properties(value={
		@Property(name = "view.id", value = "VW_WTTTEPRCES08"),
		@Property(name = "view.version", value = "1.0.0")
})
public class VW_WTTTEPRCES08_ViewEvent extends ViewEventBuilder {
	/**
	 * Instancia de Logger
	 */
	private static final ILogger logger = LogFactory.getLogger(VW_WTTTEPRCES08_ViewEvent.class);
			
	@Override
	//TODO Se deben agregar los eventos a administrar
	public void configure() {
		// TODO Auto-generated method stub
		logger.logInfo(">>>>>> Eventos personalizables");
	}
		
}