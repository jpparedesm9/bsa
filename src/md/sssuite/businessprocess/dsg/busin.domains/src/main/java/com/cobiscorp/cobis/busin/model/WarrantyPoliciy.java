package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class WarrantyPoliciy {

	public static final String EN_WRANTYPIY629 = "EN_WRANTYPIY629";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "WarrantyPoliciy";
	
	
	public static final Property<String> NUMBERPOLICY = new Property<String>("numberPolicy", String.class, false);
	
	public static final Property<String> INSURANCE = new Property<String>("insurance", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("type", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<Date> EFFECTIVEDATE = new Property<Date>("effectiveDate", Date.class, false);
	
	public static final Property<Date> EFFECTIVEDATEEND = new Property<Date>("effectiveDateEnd", Date.class, false);
	
	public static final Property<Date> ENDORSEMENTDATE = new Property<Date>("endorsementDate", Date.class, false);
	
	public static final Property<Date> ENDORSEMENTDATEEND = new Property<Date>("endorsementDateEnd", Date.class, false);
	
	public static final Property<String> COIN = new Property<String>("coin", String.class, false);
	
	public static final Property<BigDecimal> POLICYVALUE = new Property<BigDecimal>("policyValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ENDORSEMENTVALUE = new Property<BigDecimal>("endorsementValue", BigDecimal.class, false);
	
	public static final Property<String> STATE = new Property<String>("state", String.class, false);
	
	public static final Property<Integer> CUSTODY = new Property<Integer>("custody", Integer.class, false);
	
	public static final Property<Integer> BRANCHOFFICE = new Property<Integer>("branchOffice", Integer.class, false);
	
	public static final Property<String> CUSTODYTYPE = new Property<String>("custodyType", String.class, false);
	
	public static final Property<String> EXTERNALCODE = new Property<String>("externalCode", String.class, false);
	
	public static final Property<String> ISNEW = new Property<String>("isNew", String.class, false);
	
	public static final Property<String> INSURANCEDESCRIPTION = new Property<String>("insuranceDescription", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
