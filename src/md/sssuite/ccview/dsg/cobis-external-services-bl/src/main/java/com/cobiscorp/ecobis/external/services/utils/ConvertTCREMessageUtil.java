package com.cobiscorp.ecobis.external.services.utils;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.xml.sax.Attributes;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.DefaultHandler;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.external.services.bl.impl.CreditCardManagerImpl;

public class ConvertTCREMessageUtil extends DefaultHandler {
	
	private String tag = "";
	private Map<String, Object> mapPrueba = new HashMap<String, Object>();
	private List<Map<String, Object>> listaMapas = new ArrayList<Map<String, Object>>();
	private String codigoRespuesta = "";
	private String mensajeRespuesta = "";

	public ConvertTCREMessageUtil() throws SAXException {
		
	}

	public void read(String dataXML) throws IOException, SAXException {
		
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {

		if (qName.equalsIgnoreCase("DatosTarjeta")) {
			this.mapPrueba = new HashMap<String, Object>();
			listaMapas.add(mapPrueba);
		}

		this.tag = localName;
	}

	@Override
	public void characters(char ch[], int start, int length) throws SAXException {

		if (String.valueOf(ch, start, length).trim().length() > 0) {
			if (this.tag.trim().equalsIgnoreCase("CodigoRespuesta")) {
				codigoRespuesta = String.valueOf(ch, start, length).trim();
			} else if (this.tag.trim().equalsIgnoreCase("MensajeRespuesta")) {
				mensajeRespuesta = String.valueOf(ch, start, length).trim();
			} else {
				this.mapPrueba.put(this.tag.trim(), String.valueOf(ch, start, length).trim());
			}
		}
	}

	public Map<String, Object> getMapPrueba() {
		return mapPrueba;
	}

	public List<Map<String, Object>> getListaMapas() {

		return listaMapas;
	}

	public String getCodigoRespuesta() {
		return codigoRespuesta;
	}

	public String getMensajeRespuesta() {
		return mensajeRespuesta;
	}

}
