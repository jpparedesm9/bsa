package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ExtendsQuota {

	public static final String EN_EXTENDSUT_567 = "EN_EXTENDSUT_567";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ExtendsQuota";
	
	
	public static final Property<Date> EXTENDSDATE = new Property<Date>("extendsDate", Date.class, false);
	
	public static final Property<Date> MAXIMUMDATEEXTENDED = new Property<Date>("maximumDateExtended", Date.class, false);
	
	public static final Property<Integer> NUMBERQUOTA = new Property<Integer>("numberQuota", Integer.class, false);
	
	public static final Property<Date> EXPIRATIONDATE = new Property<Date>("expirationDate", Date.class, false);
	
	public static final Property<Date> PROCESSDATE = new Property<Date>("processDate", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
