package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ExceptionClient {

	public static final String EN_ECPTCLINT504 = "EN_ECPTCLINT504";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ExceptionClient";
	
	
	public static final Property<Integer> TRAMITE = new Property<Integer>("tramite", Integer.class, false);
	
	public static final Property<String> NUM_BANCO = new Property<String>("num_banco", String.class, false);
	
	public static final Property<String> OPERACION = new Property<String>("operacion", String.class, false);
	
	public static final Property<String> REGLA = new Property<String>("regla", String.class, false);
	
	public static final Property<String> NOMBREREGLA = new Property<String>("nombreRegla", String.class, false);
	
	public static final Property<Date> FECHAAUTORIZACION = new Property<Date>("fechaAutorizacion", Date.class, false);
	
	public static final Property<String> AUTORIZANTE = new Property<String>("autorizante", String.class, false);
	
	public static final Property<String> NOMBRE = new Property<String>("nombre", String.class, false);
	
	public static final Property<Integer> AUTORIZADA = new Property<Integer>("autorizada", Integer.class, false);
	
	public static final Property<String> OBSERVACION = new Property<String>("observacion", String.class, false);
	
	public static final Property<Integer> CLIENETID = new Property<Integer>("clienetId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
