package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ReadjustmentDetalilsLoan {

	public static final String EN_REAJUSTEE_221 = "EN_REAJUSTEE_221";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ReadjustmentDetalilsLoan";
	
	
	public static final Property<String> CONCEPTO = new Property<String>("concepto", String.class, false);
	
	public static final Property<String> REFERENCIAL = new Property<String>("referencial", String.class, false);
	
	public static final Property<String> SIGNO = new Property<String>("signo", String.class, false);
	
	public static final Property<Double> FACTOR = new Property<Double>("factor", Double.class, false);
	
	public static final Property<Double> PORCENTAJE = new Property<Double>("porcentaje", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
