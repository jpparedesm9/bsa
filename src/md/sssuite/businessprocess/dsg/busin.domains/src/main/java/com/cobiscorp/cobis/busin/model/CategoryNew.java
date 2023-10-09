package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CategoryNew {

	public static final String EN_ATEGRYNEW531 = "EN_ATEGRYNEW531";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CategoryNew";
	
	
	public static final Property<String> CONCEPT = new Property<String>("Concept", String.class, false);
	
	public static final Property<String> METHODOFPAYMENT = new Property<String>("MethodOfPayment", String.class, false);
	
	public static final Property<Double> PERCENTAGE = new Property<Double>("Percentage", Double.class, false);
	
	public static final Property<Character> CONCEPTTYPE = new Property<Character>("ConceptType", Character.class, false);
	
	public static final Property<String> SIGN = new Property<String>("Sign", String.class, false);
	
	public static final Property<Double> FACTOR = new Property<Double>("Factor", Double.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("Reference", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
