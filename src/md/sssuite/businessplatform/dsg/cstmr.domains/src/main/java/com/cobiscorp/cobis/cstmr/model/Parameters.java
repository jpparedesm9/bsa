package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Parameters {

	public static final String EN_PARAMETER_311 = "EN_PARAMETER_311";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Parameters";
	
	
	public static final Property<Integer> MINIMUMAGE = new Property<Integer>("minimumAge", Integer.class, false);
	
	public static final Property<String> SCREENMODE = new Property<String>("screenMode", String.class, false);
	
	public static final Property<Date> IDEXPIRATION = new Property<Date>("idExpiration", Date.class, false);
	
	public static final Property<Boolean> REFRESGRID = new Property<Boolean>("refresGrid", Boolean.class, false);
	
	public static final Property<Boolean> ALLOWUPDATENAMES = new Property<Boolean>("allowUpdateNames", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
