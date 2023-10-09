package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class InfocredEntity {

	public static final String EN_INFOCDTIT893 = "EN_INFOCDTIT893";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "InfocredEntity";
	
	
	public static final Property<String> DOCUMENTTYPE = new Property<String>("DocumentType", String.class, false);
	
	public static final Property<String> FULLNAME = new Property<String>("FullName", String.class, false);
	
	public static final Property<Character> SOURCE = new Property<Character>("Source", Character.class, false);
	
	public static final Property<Character> ROLE = new Property<Character>("Role", Character.class, false);
	
	public static final Property<Integer> REQUESTIDLOANID = new Property<Integer>("RequestIdLoanId", Integer.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
