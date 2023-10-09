package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Collateral {

	public static final String EN_COLATERAL763 = "EN_COLATERAL763";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Collateral";
	
	
	public static final Property<String> COLLATERALCODE = new Property<String>("collateralCode", String.class, false);
	
	public static final Property<String> COLLATERALTYPE = new Property<String>("collateralType", String.class, false);
	
	public static final Property<String> COLLATERALDESCRIPTION = new Property<String>("collateralDescription", String.class, false);
	
	public static final Property<BigDecimal> PRODUCTVALUE = new Property<BigDecimal>("productValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> RESIDUALNET = new Property<BigDecimal>("residualNet", BigDecimal.class, false);
	
	public static final Property<Date> DATELASTAPPRAISAL = new Property<Date>("dateLastAppraisal", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
