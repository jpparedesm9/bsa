package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class GuaranteeSearchCriteria {

	public static final String EN_RSRCHERIA652 = "EN_RSRCHERIA652";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GuaranteeSearchCriteria";
	
	
	public static final Property<String> AMOUNT = new Property<String>("amount", String.class, false);
	
	public static final Property<String> ADMISSIBILITY = new Property<String>("admissibility", String.class, false);
	
	public static final Property<Integer> WARRANTYMONEY = new Property<Integer>("warrantyMoney", Integer.class, false);
	
	public static final Property<String> SHARED = new Property<String>("shared", String.class, false);
	
	public static final Property<String> CHARACTER = new Property<String>("character", String.class, false);
	
	public static final Property<String> STATUSGUARANTEE = new Property<String>("StatusGuarantee", String.class, false);
	
	public static final Property<Integer> CORRELATIVEEND = new Property<Integer>("CorrelativeEnd", Integer.class, false);
	
	public static final Property<String> CUSTOMER = new Property<String>("Customer", String.class, false);
	
	public static final Property<Date> STARTDATEADMISSION = new Property<Date>("StartDateAdmission", Date.class, false);
	
	public static final Property<Date> ENDDATEADMISSION = new Property<Date>("EndDateAdmission", Date.class, false);
	
	public static final Property<String> EXTERNALCODE = new Property<String>("ExternalCode", String.class, false);
	
	public static final Property<String> OFFICER = new Property<String>("Officer", String.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("Office", String.class, false);
	
	public static final Property<Integer> CORRELATIVESTART = new Property<Integer>("CorrelativeStart", Integer.class, false);
	
	public static final Property<String> GUARANTEETYPE = new Property<String>("GuaranteeType", String.class, false);
	
	public static final Property<String> EXTERNALCODENEXT = new Property<String>("ExternalCodeNext", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
