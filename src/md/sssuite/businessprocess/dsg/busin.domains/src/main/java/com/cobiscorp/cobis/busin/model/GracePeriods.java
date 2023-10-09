package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class GracePeriods {

	public static final String EN_RACEPEROS137 = "EN_RACEPEROS137";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GracePeriods";
	
	
	public static final Property<Integer> GRACEPERIODSCAPITAL = new Property<Integer>("GracePeriodsCapital", Integer.class, false);
	
	public static final Property<Integer> GRACEPERIODSINTEREST = new Property<Integer>("GracePeriodsInterest", Integer.class, false);
	
	public static final Property<Character> SHAPERECOVERYGRACIA = new Property<Character>("ShapeRecoveryGracia", Character.class, false);
	
	public static final Property<Integer> GRACEDAYSOFMORA = new Property<Integer>("GraceDaysofMora", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
