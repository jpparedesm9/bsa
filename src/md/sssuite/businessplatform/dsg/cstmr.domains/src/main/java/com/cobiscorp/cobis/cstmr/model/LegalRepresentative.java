package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LegalRepresentative {

	public static final String EN_LEGALRETT_503 = "EN_LEGALRETT_503";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LegalRepresentative";
	
	
	public static final Property<Date> EFFECTIVEDATE = new Property<Date>("effectiveDate", Date.class, false);
	
	public static final Property<Boolean> UNDEFINEDEFFECTIVEDATE = new Property<Boolean>("undefinedEffectiveDate", Boolean.class, false);
	
	public static final Property<Integer> LEGALREPRESENTATIVECODE = new Property<Integer>("legalRepresentativeCode", Integer.class, false);
	
	public static final Property<String> NOTARYOFFICE = new Property<String>("notaryOffice", String.class, false);
	
	public static final Property<String> LEGALREPRESENTATIVEDESCRIPTION = new Property<String>("legalRepresentativeDescription", String.class, false);
	
	public static final Property<String> NOTARY = new Property<String>("notary", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
