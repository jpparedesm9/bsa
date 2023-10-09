/**
 * Archivo: ParserRepository.java
 * Fecha: 28/08/2013
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
package com.cobiscorp.ecobis.external.services.utils;

import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

/**
 * saves and instance peer thread of saxparser, in order
 * to improve performance
 * @author fabad
 *
 */
public class ParserTCRERepository {
		
	private static ThreadLocal<XMLReader> threadLocalSAXParser = new ThreadLocal<XMLReader>();

	public static XMLReader getInstance() throws SAXException {
		/**
		 * FABAD: it is important to save in thread local in order 
		 * to improve performance, create a new instance is very expensive
		 */
		XMLReader wXmlReader = threadLocalSAXParser.get(); 
		if(wXmlReader == null){
			//System.out.println("creating parser in class " +ParserACHRepository.class.getName() + " for thread:" + Thread.currentThread().getName());
			wXmlReader =  XMLReaderFactory.createXMLReader();
			threadLocalSAXParser.set(wXmlReader);
		}
		return wXmlReader;
		
	}

}
