package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class WarrantyLocation {

	public static final String EN_WARRLOCTN270 = "EN_WARRLOCTN270";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "WarrantyLocation";
	
	
	public static final Property<String> ADDRESSDESCRIPTION = new Property<String>("addressDescription", String.class, false);
	
	public static final Property<String> ACCOUNTINGOFFICE = new Property<String>("accountingOffice", String.class, false);
	
	public static final Property<String> DOCUMENTLOCATION = new Property<String>("documentLocation", String.class, false);
	
	public static final Property<String> DOCUMENTCITY = new Property<String>("documentCity", String.class, false);
	
	public static final Property<String> LICENSENUMBER = new Property<String>("licenseNumber", String.class, false);
	
	public static final Property<String> WARRANTYCITY = new Property<String>("warrantyCity", String.class, false);
	
	public static final Property<Date> LICENSEDATEEXPIRATION = new Property<Date>("licenseDateExpiration", Date.class, false);
	
	public static final Property<String> ADDRESS = new Property<String>("address", String.class, false);
	
	public static final Property<Integer> CITY = new Property<Integer>("city", Integer.class, false);
	
	public static final Property<String> PARISH = new Property<String>("parish", String.class, false);
	
	public static final Property<String> PHONE = new Property<String>("phone", String.class, false);
	
	public static final Property<String> REPOSITORY = new Property<String>("repository", String.class, false);
	
	public static final Property<Integer> PROVINCE = new Property<Integer>("province", Integer.class, false);
	
	public static final Property<Integer> STOREKEEPER = new Property<Integer>("storeKeeper", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
