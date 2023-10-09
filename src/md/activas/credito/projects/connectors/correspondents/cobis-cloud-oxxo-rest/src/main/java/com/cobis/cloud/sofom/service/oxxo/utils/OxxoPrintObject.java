package com.cobis.cloud.sofom.service.oxxo.utils;

import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import com.cobiscorp.cobis.commons.log.ILogger;

public class OxxoPrintObject {
	public OxxoPrintObject() {
	}

	public static String transformObject(Object objeto, ILogger LOGGER, String mensaje) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start transformObject");
		}
		StreamResult xmlOutput = new StreamResult(new StringWriter());
		try {
			Source xmlInput = new StreamSource(new StringReader(marshalObject(objeto, LOGGER, mensaje)));
			Transformer transformer = TransformerFactory.newInstance().newTransformer();
			transformer.transform(xmlInput, xmlOutput);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(mensaje + xmlOutput.getWriter().toString());
			}

		} catch (TransformerConfigurationException e) {
			LOGGER.logError("Error al transformar la trama: " + e);
		} catch (TransformerFactoryConfigurationError e) {
			LOGGER.logError("Error al transformar la trama: " + e);
		} catch (TransformerException e) {
			LOGGER.logError("Error al transformar la trama: " + e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish transformObject");
			}
		}
		return xmlOutput.getWriter() == null ? "" : xmlOutput.getWriter().toString();

	}

	public static String marshalObject(Object objeto, ILogger LOGGER, String mensaje) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start marshallObject");
		}
		StringWriter sw = new StringWriter();
		try {

			JAXBContext context = JAXBContext.newInstance(objeto.getClass());
			Marshaller m = context.createMarshaller();
			m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
			m.marshal(objeto, sw);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(mensaje + sw.toString());
			}
		} catch (JAXBException e) {
			LOGGER.logError("Error al parsear la trama " + e);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish marshallObject");
			}
		}
		return sw.toString();
	}

}
