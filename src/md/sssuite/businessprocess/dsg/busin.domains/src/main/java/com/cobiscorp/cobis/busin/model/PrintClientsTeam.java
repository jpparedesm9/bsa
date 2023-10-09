package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PrintClientsTeam {

	public static final String EN_PRINTCLES_523 = "EN_PRINTCLES_523";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PrintClientsTeam";
	
	
	public static final Property<Integer> OPERATION = new Property<Integer>("operation", Integer.class, false);
	
	public static final Property<String> IDBANK = new Property<String>("idBank", String.class, false);
	
	public static final Property<Integer> IDCLIENT = new Property<Integer>("idclient", Integer.class, false);
	
	public static final Property<String> DATESTART = new Property<String>("dateStart", String.class, false);
	
	public static final Property<String> DATEEND = new Property<String>("dateEnd", String.class, false);
	
	public static final Property<Double> AMOUNT = new Property<Double>("amount", Double.class, false);
	
	public static final Property<String> STATUSCLIENT = new Property<String>("statusClient", String.class, false);
	
	public static final Property<String> DATEREPORT = new Property<String>("dateReport", String.class, false);
	
	public static final Property<Integer> IDPROCESS = new Property<Integer>("idProcess", Integer.class, false);
	
	public static final Property<Integer> IDTEAM = new Property<Integer>("idTeam", Integer.class, false);
	
	public static final Property<Double> AMOUNTPAID = new Property<Double>("amountPaid", Double.class, false);
	
	public static final Property<Double> AMOUNTRETURNED = new Property<Double>("amountReturned", Double.class, false);
	
	public static final Property<String> FORMPAID = new Property<String>("formPaid", String.class, false);
	
	public static final Property<String> TYPESECURE = new Property<String>("typeSecure", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
