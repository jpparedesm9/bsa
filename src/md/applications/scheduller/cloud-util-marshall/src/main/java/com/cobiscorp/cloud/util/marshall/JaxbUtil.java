package com.cobiscorp.cloud.util.marshall;

import java.io.File;
import java.io.StringWriter;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.JAXBIntrospector;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.stream.StreamSource;
import org.apache.log4j.Logger;

public class JaxbUtil<T> {

	private static final Logger logger = Logger.getLogger(JaxbUtil.class);

	/***
	 * Convierte un objeto jaxb a xml, partiendo que el archivo se debe crear a
	 * partir de un xsd (JAXBElement)
	 * 
	 * @param obj
	 *            Objecto jaxb
	 * @param root
	 *            Objecto JAXBElement
	 * @param file
	 *            File donde se crea el archivo xml
	 * @return
	 * @throws JAXBException
	 */
	public File marshall(Object obj, JAXBElement<?> root, File file)
			throws JAXBException {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia marshall :" + obj + " root: " + root
					+ " file: " + file);
		}
		JAXBContext jaxbContext = JAXBContext.newInstance(obj.getClass());
		Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
		jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);

		StringWriter stringWriter = new StringWriter();
		jaxbMarshaller.marshal(root, stringWriter);
		logger.info(stringWriter.toString());

		jaxbMarshaller.marshal(root, file);

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza marshall : ");
		}
		return file;
	}

	/**
	 * Permite convertir un archivo xml a un objecto jaxb
	 * 
	 * @param obj
	 *            Objeto jaxb que se quiere obtener
	 * @param file
	 *            archivo xml
	 * @return
	 * @throws JAXBException
	 * @throws ClassNotFoundException
	 */
	public Object unmarshall(Object obj, File file) throws JAXBException {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia unmarshall: " + obj + " file: " + file);
		}
		JAXBContext jaxbContext = JAXBContext.newInstance(obj.getClass());
		Unmarshaller jaxbMarshaller = jaxbContext.createUnmarshaller();

		Object schemaObject = JAXBIntrospector.getValue(jaxbMarshaller
				.unmarshal(new StreamSource(file), obj.getClass()));

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza unmarshall: " + schemaObject);
		}
		return schemaObject;
	}

	/**
	 * @param file
	 * @param object
	 * @return
	 * @throws JAXBException
	 */
	public T deserialization(File file, T object) throws JAXBException {
		JAXBContext context = JAXBContext.newInstance(new Class[] { object
				.getClass() });
		Unmarshaller u = context.createUnmarshaller();

		return (T) u.unmarshal(file);
	}
}
