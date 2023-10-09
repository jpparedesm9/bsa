package com.cobiscorp.ecobis.cobiscloudsynchronization.util;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import java.io.StringReader;
import java.io.StringWriter;

/**
 * Created by farid on 7/17/2017.
 */
public class XmlConverter {

    public static String dtoToXml(Object dto) throws JAXBException {
        JAXBContext jaxbContext = JAXBContext.newInstance(dto.getClass());
        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
        jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        StringWriter sw = new StringWriter();
        jaxbMarshaller.marshal(dto, sw);
        String xmlString = sw.toString();
        return xmlString;
    }

    public static Object xmlToDto(String xmlString, Class neededClass) throws JAXBException, ClassNotFoundException {
        JAXBContext jaxbContext = JAXBContext.newInstance(neededClass);
        Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
        StringReader reader = new StringReader(xmlString);
        return jaxbUnmarshaller.unmarshal(reader);
    }


}
