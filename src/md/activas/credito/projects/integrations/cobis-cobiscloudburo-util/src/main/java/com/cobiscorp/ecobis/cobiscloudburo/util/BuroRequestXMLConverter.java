package com.cobiscorp.ecobis.cobiscloudburo.util;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroRequest;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Consulta;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Domicilio;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Domicilios;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Encabezado;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Nombre;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Persona;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Personas;
import org.xml.sax.SAXException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import java.io.StringWriter;

/**
 * Created by pclavijo on 11/07/2017.
 */
public class BuroRequestXMLConverter {
    private static ILogger logger = LogFactory.getLogger(BuroRequestXMLConverter.class);
    private static final String className = "[BuroRequestXMLConverter]";

    public static String buildXML(BuroRequest buroRequest) throws JAXBException, SAXException {
        Encabezado encabezado = BuroRequestDTOConverter.convertHeader(buroRequest.getHeader());
        Nombre nombre = BuroRequestDTOConverter.convertName(buroRequest.getName());
        Domicilio domicilio = BuroRequestDTOConverter.convertResidence(buroRequest.getResidence());

        Domicilios domicilios = new Domicilios();
        domicilios.setDomicilio(domicilio);
        Persona persona = new Persona();
        persona.setEncabezado(encabezado);
        persona.setNombre(nombre);
        persona.setDomicilios(domicilios);
        Personas personas = new Personas();
        personas.setPersona(persona);
        Consulta consulta = new Consulta();
        consulta.setPersonas(personas);

//        SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
//        Schema schema = sf.newSchema(new File("ConsultaBC.xsd"));

        JAXBContext jaxbContext = JAXBContext.newInstance(Consulta.class);
        Marshaller marshaller = jaxbContext.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_NO_NAMESPACE_SCHEMA_LOCATION, "ConsultaBC.xsd");
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
//        marshaller.setSchema(schema);
//        marshaller.setEventHandler(new XMLValidationEventHandler());
        StringWriter sw = new StringWriter();
        marshaller.marshal(consulta, sw);

        String xmlRequest = sw.toString();
        if (logger.isTraceEnabled()) {
            logger.logTrace("xmlRequest: " + xmlRequest);
        }
        return xmlRequest;
    }
}
