package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class TransferRequest {

	public static final String EN_TRANSFEEU_439 = "EN_TRANSFEEU_439";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "TransferRequest";
	
	
	public static final Property<String> OFFICIALORIGINID = new Property<String>("officialOriginId", String.class, false);
	
	public static final Property<String> DESCRIPTIONCAUSE = new Property<String>("descriptionCause", String.class, false);
	
	public static final Property<Integer> IDCAUSE = new Property<Integer>("idCause", Integer.class, false);
	
	public static final Property<String> ISALL = new Property<String>("isAll", String.class, false);
	
	public static final Property<Character> ISGROUP = new Property<Character>("isGroup", Character.class, false);
	
	public static final Property<Integer> OFFICEORIGINID = new Property<Integer>("officeOriginId", Integer.class, false);
	
	public static final Property<Integer> OFFICEDESTINATIONID = new Property<Integer>("officeDestinationId", Integer.class, false);
	
	public static final Property<String> OFFICIALDESTINATIONID = new Property<String>("officialDestinationId", String.class, false);
	
	public static final Property<String> MARKETTYPE = new Property<String>("marketType", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
