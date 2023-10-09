package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ExecutiveBonusHeaderRisk {

	public static final String EN_HEADERRSK971 = "EN_HEADERRSK971";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ExecutiveBonusHeaderRisk";
	
	
	public static final Property<Date> STARTDATE = new Property<Date>("startDate", Date.class, false);
	
	public static final Property<Date> ENDDATE = new Property<Date>("endDate", Date.class, false);
	
	public static final Property<String> LOGIN = new Property<String>("login", String.class, false);
	
	public static final Property<Date> REGISTRATIONDATE = new Property<Date>("registrationDate", Date.class, false);
	
	public static final Property<Integer> RISKID = new Property<Integer>("riskId", Integer.class, false);
	
	public static final Property<Date> PROCESSDATE = new Property<Date>("processDate", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
