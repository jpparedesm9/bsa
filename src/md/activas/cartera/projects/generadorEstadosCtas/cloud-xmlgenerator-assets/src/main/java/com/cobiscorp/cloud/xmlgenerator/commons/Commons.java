package com.cobiscorp.cloud.xmlgenerator.commons;

import java.io.File;
import java.io.FileWriter;
import java.io.Writer;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.stream.XMLEventFactory;
import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLEventWriter;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.events.XMLEvent;
import javax.xml.transform.stream.StreamSource;

import org.apache.log4j.Logger;

import com.cobiscorp.cloud.configuration.ConfigManager;

public class Commons {

	private static final Logger logger = Logger.getLogger(Commons.class);
	private static Commons commons;

	private static final String DATE_FORMATER = "yyyy-MM-dd";

	private Commons() {

	}

	public static Commons getInstance() {
		if (commons == null) {
			commons = new Commons();
		}
		return commons;
	}

	public static XMLGregorianCalendar dateToXml(Date date) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia dateToXml : " + date);
		}

		XMLGregorianCalendar xmlDate = null;
		if (date != null) {
			DateFormat dateFormat = new SimpleDateFormat(DATE_FORMATER);
			String strDate = dateFormat.format(date);
			try {
				xmlDate = DatatypeFactory.newInstance()
						.newXMLGregorianCalendar(strDate);
				return xmlDate;
			} catch (DatatypeConfigurationException e) {
				if (logger.isDebugEnabled()) {
					logger.debug("Error de conversion de fechas : " + e);
				}
			}
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza dateToXml");
		}
		return xmlDate;

	}

	public static XMLGregorianCalendar stringToXml(String strDate) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia stringToXml : " + strDate);
		}

		XMLGregorianCalendar xmlDate = null;
		if (strDate != null) {
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			try {
				Date date = dateFormat.parse(strDate);
				return dateToXml(date);
			} catch (ParseException e1) {
				if (logger.isDebugEnabled()) {
					logger.debug("Error de conversion de fechas" + e1);
				}
			}
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza stringToXml");
		}
		return xmlDate;

	}

	public static Date stringToDate(String strDate) {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia stringToDate : " + strDate);
		}
		Date date = null;
		if (strDate != null) {
			DateFormat dateFormat = new SimpleDateFormat(DATE_FORMATER);
			try {
				return dateFormat.parse(strDate);
			} catch (ParseException e1) {
				if (logger.isDebugEnabled()) {
					logger.debug("Error de conversion de fechas" + e1);
				}
			}
		}
		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza stringToDate");
		}
		return date;

	}

	public static String[] getPaths() {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia getPath : ");
		}
		String[] paths = new String[2];

		String directoryRoot = ConfigManager.getInstance().getXmlPath();
		SimpleDateFormat sdfDate = new SimpleDateFormat(DATE_FORMATER);
		String strDate = sdfDate.format(new Date());

		File fileRoot = new File(directoryRoot + "/" + strDate);
		if (!fileRoot.exists()) {
			fileRoot.mkdirs();
		}
		String pathRoot = fileRoot.getAbsolutePath();

		File fileTmp = new File(pathRoot + "/tmp");
		if (!fileTmp.exists()) {
			fileTmp.mkdirs();
		}
		String pathTmp = fileTmp.getAbsolutePath();

		paths[0] = pathRoot;
		paths[1] = pathTmp;

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza getPath rootPath: " + pathRoot
					+ " tmpPath: " + pathTmp);
		}
		return paths;
	}
	
	public static void concatXml(String pathRoot, String nameConcatXml,
			String rootTag) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia concatXml path root: " + pathRoot + " name: "
					+ nameConcatXml + " rootTag" + rootTag);
		}

		File dir = new File(pathRoot + "/tmp");
		File[] rootFiles = dir.listFiles();

		File concatXml = new File(pathRoot, nameConcatXml + ".xml");

		Writer outputWriter = null;
		XMLEventWriter xmlEventWriter = null;
		try {
			outputWriter = new FileWriter(concatXml);
			xmlEventWriter = XMLOutputFactory.newFactory()
					.createXMLEventWriter(outputWriter);

			addXml(rootTag,rootFiles,xmlEventWriter);
			
		} finally {
			if (xmlEventWriter != null) {
				xmlEventWriter.close();
			}
			if (outputWriter != null) {
				outputWriter.close();
			}
			// borro directorio temporal
			for (File file : rootFiles) {
				if (file.exists()) {
					file.delete();
				}
			}
			if (dir.exists()) {
				dir.delete();
			}

			if (logger.isDebugEnabled()) {
				logger.debug("Finaliza concatXml");
			}

		}
	}

	public static void addXml(String rootTag, File[] rootFiles,
			XMLEventWriter xmlEventWriter) throws Exception {
		if (logger.isDebugEnabled()) {
			logger.debug("Inicia addXml rootTag:" + rootTag + " rootFiles "
					+ rootFiles + " xmlEventWriter " + xmlEventWriter);
		}

		XMLEventFactory xmlEventFactory = XMLEventFactory.newFactory();

		xmlEventWriter.add(xmlEventFactory.createStartDocument());
		xmlEventWriter.add(xmlEventFactory
				.createStartElement("", null, rootTag));

		XMLInputFactory xmlInFactory = XMLInputFactory.newFactory();
		for (File rootFile : rootFiles) {
			XMLEventReader xmlEventReader = xmlInFactory
					.createXMLEventReader(new StreamSource(rootFile));
			XMLEvent event = xmlEventReader.nextEvent();
			// Skip ahead in the input to the opening document element
			while (event.getEventType() != XMLEvent.START_ELEMENT) {
				if (xmlEventReader.hasNext()) {
					event = xmlEventReader.nextEvent();
				}
			}
			do {
				xmlEventWriter.add(event);
				event = xmlEventReader.nextEvent();
			} while (event.getEventType() != XMLEvent.END_DOCUMENT);
			xmlEventReader.close();
		}
		xmlEventWriter.add(xmlEventFactory.createEndElement("", null, rootTag));
		xmlEventWriter.add(xmlEventFactory.createEndDocument());

		if (logger.isDebugEnabled()) {
			logger.debug("Finaliza addXml");
		}

	}
}
