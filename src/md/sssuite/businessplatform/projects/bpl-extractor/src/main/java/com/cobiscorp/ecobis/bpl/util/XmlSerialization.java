package com.cobiscorp.ecobis.bpl.util;

import java.io.File;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;


public class XmlSerialization <T>{
	
	
	@SuppressWarnings("unchecked")
	public T deserialization(String path, T object) throws JAXBException
	{
		JAXBContext context = JAXBContext.newInstance(object.getClass());
		Unmarshaller u = context.createUnmarshaller();
		return (T) u.unmarshal(new File(path));
	}

	
	public void serialization(String path, T object) throws JAXBException
	{
		JAXBContext context = JAXBContext.newInstance(object.getClass());
		Marshaller m = context.createMarshaller();       
		m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
		m.marshal(object, new File(path));
	}
}
