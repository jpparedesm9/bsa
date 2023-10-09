package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ComplementaryRequestData {

	public static final String EN_COMPLEMRR_873 = "EN_COMPLEMRR_873";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ComplementaryRequestData";
	
	
	public static final Property<String> BUREAUBACKGROUND = new Property<String>("bureauBackground", String.class, false);
	
	public static final Property<String> RECRUITMENTCHANNEL = new Property<String>("recruitmentChannel", String.class, false);
	
	public static final Property<String> LANDLINEONE = new Property<String>("landlineOne", String.class, false);
	
	public static final Property<String> ELECTRONICSIGNATURE = new Property<String>("electronicSignature", String.class, false);
	
	public static final Property<String> PROFESSIONALACTIVITY = new Property<String>("professionalActivity", String.class, false);
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("customerCode", Integer.class, false);
	
	public static final Property<String> LANDLINETWO = new Property<String>("landlineTwo", String.class, false);
	
	public static final Property<String> PERSONNAMEMESSAGES = new Property<String>("personNameMessages", String.class, false);
	
	public static final Property<String> IFENUMBER = new Property<String>("ifeNumber", String.class, false);
	
	public static final Property<String> COUNTRY = new Property<String>("country", String.class, false);
	
	public static final Property<String> PASSPORTNUMBER = new Property<String>("passportNumber", String.class, false);
	
	public static final Property<String> PHONEERRANDS = new Property<String>("phoneErrands", String.class, false);
	
	public static final Property<String> ISCRYPTOUSED = new Property<String>("isCryptoUsed", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
