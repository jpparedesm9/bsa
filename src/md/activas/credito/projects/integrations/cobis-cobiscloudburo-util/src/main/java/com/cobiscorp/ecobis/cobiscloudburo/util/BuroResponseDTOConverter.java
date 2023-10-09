package com.cobiscorp.ecobis.cobiscloudburo.util;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Respuesta;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

/**
 * Created by pclavijo on 13/07/2017.
 */
public class BuroResponseDTOConverter {
    private static ILogger logger = LogFactory.getLogger(BuroRequestXMLConverter.class);
    private static final String className = "[BuroResponseDTOConverter]";

    public static Respuesta buildDTO(String xmlResponse) throws JAXBException, UnsupportedEncodingException {
//        SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
//        Schema schema = sf.newSchema(new File("RespuestaCC.xsd"));

        JAXBContext jaxbContext = JAXBContext.newInstance(Respuesta.class);

        Unmarshaller unmarshaller = jaxbContext.createUnmarshaller();
//        unmarshaller.setSchema(schema);
//        unmarshaller.setEventHandler(new MyValidationEventHandler());
        InputStream inputStream = new ByteArrayInputStream(xmlResponse.getBytes("UTF-8"));
        Respuesta respuesta = (Respuesta) unmarshaller.unmarshal(inputStream);

        if (logger.isTraceEnabled()) {
            logger.logTrace("respuestaBC: " + respuesta.toString());
        }
        return respuesta;
    }
}
