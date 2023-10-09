package com.cobiscorp.cobis.bssns.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Customer {

	public static final String EN_CUSTOMERR_368 = "EN_CUSTOMERR_368";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Customer";
	
	
	public static final Property<String> CUSTOMERSECONDNAME = new Property<String>("customerSecondName", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("customerId", Integer.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final Property<Integer> OFFICIAL = new Property<Integer>("official", Integer.class, false);
	
	public static final Property<String> GENDER = new Property<String>("gender", String.class, false);
	
	public static final Property<String> CUSTOMERLASTNAME = new Property<String>("customerLastName", String.class, false);
	
	public static final Property<String> IDENTIFICATIONTYPE = new Property<String>("identificationType", String.class, false);
	
	public static final Property<Integer> NATIONALITYCOUNTRY = new Property<Integer>("nationalityCountry", Integer.class, false);
	
	public static final Property<String> SANTANDERCODE = new Property<String>("santanderCode", String.class, false);
	
	public static final Property<String> CUSTOMERIDENTIFICATION = new Property<String>("customerIdentification", String.class, false);
	
	public static final Property<String> OFFICIALDESCRIPTION = new Property<String>("officialDescription", String.class, false);
	
	public static final Property<String> PROCESSINSTANCE = new Property<String>("processInstance", String.class, false);
	
	public static final Property<String> CUSTOMERMARITALSTATUS = new Property<String>("customerMaritalStatus", String.class, false);
	
	public static final Property<String> CUSTOMERFULLNAME = new Property<String>("customerFullName", String.class, false);
	
	public static final Property<String> CUSTOMERSECONDLASTNAME = new Property<String>("customerSecondLastName", String.class, false);
	
	public static final Property<String> NATIONALITYDESCRIPTION = new Property<String>("nationalityDescription", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
