package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class SearchCriteriaPrintingDocuments {

	public static final String EN_EIERNNCME834 = "EN_EIERNNCME834";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SearchCriteriaPrintingDocuments";
	
	
	public static final Property<String> CLAIMANTID = new Property<String>("claimantId", String.class, false);
	
	public static final Property<String> CITY = new Property<String>("City", String.class, false);
	
	public static final Property<String> CODEPROCESS = new Property<String>("codeProcess", String.class, false);
	
	public static final Property<String> TYPEPROCESS = new Property<String>("typeProcess", String.class, false);
	
	public static final Property<Integer> IDAPPLICATION = new Property<Integer>("IdApplication", Integer.class, false);
	
	public static final Property<String> FLOWTYPE = new Property<String>("FlowType", String.class, false);
	
	public static final Property<String> CUSTOMERID = new Property<String>("CustomerId", String.class, false);
	
	public static final Property<String> TYPECUSTOMER = new Property<String>("typeCustomer", String.class, false);
	
	public static final Property<String> ALTERNATECODE = new Property<String>("alternateCode", String.class, false);
	
	public static final Property<Boolean> GROUP = new Property<Boolean>("group", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
