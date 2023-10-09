package com.cobiscorp.mobile.services.impl.utils;

import java.io.IOException;
import java.io.StringReader;

import javax.servlet.ServletException;
import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.xml.sax.SAXException;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.services.impl.RegistrationServiceImpl;

/**
 * Custom error handler while validating xml against xsd
 */

public class ValidateXmlXsd {
	private static ILogger LOGGER = LogFactory.getLogger(RegistrationServiceImpl.class);
	private static final String className = "[ValidateXmlXsd]";

	public static boolean validate(String xmlString) throws ServletException, IOException {

		String result = "";
		boolean resultado = true;
		try {
			SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
			Schema schema = factory.newSchema(ValidateXmlXsd.class.getResource("/webpayxml.xsd"));
			Validator validator = schema.newValidator();
			validator.setErrorHandler(new XsdErrorHandler());
			validator.validate(new StreamSource(new StringReader(xmlString)));
			result = "Validación exitosa. Ve al Paso 2: Cifrando la cadena";
		} catch (IOException e) {
			// handle exception while reading source}
			resultado = false;
		} catch (SAXException e) {
			result = "La cadena no cumple con el esquema \n" + e.getMessage();
			resultado = false;
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(className + result);
		}
		return resultado;
	}
}
