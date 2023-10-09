package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CategoryReadjustment {

	public static final String EN_CATGOREAE716 = "EN_CATGOREAE716";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CategoryReadjustment";
	
	
	public static final Property<String> CONCEPT = new Property<String>("Concept", String.class, false);
	
	public static final Property<String> CONCEPTDESCRIPTION = new Property<String>("ConceptDescription", String.class, false);
	
	public static final Property<String> CONCEPTTYPE = new Property<String>("ConceptType", String.class, false);
	
	public static final Property<String> CONCEPTTYPEDESCRIPTION = new Property<String>("ConceptTypeDescription", String.class, false);
	
	public static final Property<String> AMOUNTTOAPPLY = new Property<String>("AmountToApply", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("Reference", String.class, false);
	
	public static final Property<String> REFERENCEDESCRIPTION = new Property<String>("ReferenceDescription", String.class, false);
	
	public static final Property<Double> REFERENCEAMOUNT = new Property<Double>("ReferenceAmount", Double.class, false);
	
	public static final Property<String> SIGN = new Property<String>("Sign", String.class, false);
	
	public static final Property<Double> SPREAD = new Property<Double>("Spread", Double.class, false);
	
	public static final Property<Double> VALUE = new Property<Double>("Value", Double.class, false);
	
	public static final Property<Double> MINIMUM = new Property<Double>("Minimum", Double.class, false);
	
	public static final Property<Double> MAXIMUN = new Property<Double>("Maximun", Double.class, false);
	
	public static final Property<Double> MAXRATE = new Property<Double>("MaxRate", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
