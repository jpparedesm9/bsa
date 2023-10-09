package com.cobiscorp.cobis.clcol.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CollectiveAdvisor {

	public static final String EN_COLLECTOV_485 = "EN_COLLECTOV_485";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CollectiveAdvisor";
	
	
	public static final Property<String> COLLECTIVE = new Property<String>("collective", String.class, false);
	
	public static final Property<String> CUSTOMERID = new Property<String>("customerId", String.class, false);
	
	public static final Property<String> OBSERVATIONS = new Property("observations", String.class, false);
	
	public static final Property<String> CUSTOMERCELL = new Property<String>("customerCell", String.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<String> EXTERNALADVISOR = new Property<String>("externalAdvisor", String.class, false);
	
	public static final Property<Integer> IDSECUENCIAL = new Property("idSecuencial", Integer.class, false);
	
	public static final Property<String> CUSTOMERADDRESS = new Property<String>("customerAddress", String.class, false);
	
	public static final Property<String> CUSTOMERMAIL = new Property<String>("customerMail", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
