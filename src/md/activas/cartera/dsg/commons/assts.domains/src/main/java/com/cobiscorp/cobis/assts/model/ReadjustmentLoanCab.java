package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ReadjustmentLoanCab {

	public static final String EN_REAJUSTBB_191 = "EN_REAJUSTBB_191";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ReadjustmentLoanCab";
	
	
	public static final Property<Date> DATE = new Property<Date>("date", Date.class, false);
	
	public static final Property<String> MANTCUOTA = new Property<String>("mantCuota", String.class, false);
	
	public static final Property<Integer> SECUENCIAL = new Property<Integer>("secuencial", Integer.class, false);
	
	public static final Property<String> DESAGIO = new Property<String>("desagio", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
