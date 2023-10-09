package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PostalCodeTmp {

	public static final String EN_POSTALCEE_915 = "EN_POSTALCEE_915";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PostalCodeTmp";
	
	
	public static final Property<Integer> CITYCODE = new Property<Integer>("cityCode", Integer.class, false);
	
	public static final Property<Integer> PARISHCODE = new Property<Integer>("parishCode", Integer.class, false);
	
	public static final Property<Integer> PROVINCECODE = new Property<Integer>("provinceCode", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
