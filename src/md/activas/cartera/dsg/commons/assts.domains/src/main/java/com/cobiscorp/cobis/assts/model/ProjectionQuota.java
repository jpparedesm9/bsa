package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ProjectionQuota {

	public static final String EN_PROJECTTI_953 = "EN_PROJECTTI_953";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ProjectionQuota";
	
	
	public static final Property<Date> PROJECTIONDATE = new Property<Date>("projectionDate", Date.class, false);
	
	public static final Property<Integer> PROJECTIONDAYS = new Property<Integer>("projectionDays", Integer.class, false);
	
	public static final Property<BigDecimal> CURRENTAMOUNTDUE = new Property<BigDecimal>("currentAmountDue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNTOVERDUE = new Property<BigDecimal>("amountOverdue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> PREPAYMENTAMOUNT = new Property<BigDecimal>("prepaymentAmount", BigDecimal.class, false);
	
	public static final Property<String> TYPECALCULATION = new Property<String>("typeCalculation", String.class, false);
	
	public static final Property<Integer> EXPIRATIONDAYS = new Property<Integer>("expirationDays", Integer.class, false);
	
	public static final Property<Date> DATEPROCESS = new Property<Date>("dateProcess", Date.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
