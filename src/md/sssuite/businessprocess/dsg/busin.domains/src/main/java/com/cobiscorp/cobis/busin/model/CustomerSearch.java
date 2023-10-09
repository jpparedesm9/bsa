package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CustomerSearch {

	public static final String EN_CTMERSEAR765 = "EN_CTMERSEAR765";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CustomerSearch";
	
	
	public static final Property<String> IDENTIFICATIONTYPE = new Property<String>("identificationType", String.class, false);
	
	public static final Property<String> WARRANTYTYPE = new Property<String>("warrantyType", String.class, false);
	
	public static final Property<String> IDENTIFICATION = new Property<String>("identification", String.class, false);
	
	public static final Property<String> FLAGCRITERIA = new Property<String>("FlagCriteria", String.class, false);
	
	public static final Property<String> CUSTOMER = new Property<String>("Customer", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final Property<String> TYPEOBJECT = new Property<String>("TypeObject", String.class, false);
	
	public static final Property<Integer> OFFICERID = new Property<Integer>("OfficerId", Integer.class, false);
	
	public static final Property<Character> FLAGEXIT = new Property<Character>("Flagexit", Character.class, false);
	
	public static final Property<String> OFFICER = new Property<String>("Officer", String.class, false);
	
	public static final Property<Boolean> PRINCIPAL = new Property<Boolean>("Principal", Boolean.class, false);
	
	public static final Property<String> EXPROMISSION = new Property<String>("Expromission", String.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("Sector", String.class, false);
	
	public static final Property<String> TYPEOPERATION = new Property<String>("TypeOperation", String.class, false);
	
	public static final Property<String> TYPEPROCESS = new Property<String>("TypeProcess", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
