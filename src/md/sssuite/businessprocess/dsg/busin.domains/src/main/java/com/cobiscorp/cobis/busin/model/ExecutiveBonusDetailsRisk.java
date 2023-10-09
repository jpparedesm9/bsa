package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ExecutiveBonusDetailsRisk {

	public static final String EN_EEBONUETI653 = "EN_EEBONUETI653";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ExecutiveBonusDetailsRisk";
	
	
	public static final Property<Integer> AGENCYID = new Property<Integer>("agencyId", Integer.class, false);
	
	public static final Property<String> AGENCYNAME = new Property<String>("agencyName", String.class, false);
	
	public static final Property<Double> ADDITIONALRISKPERCENTAGE = new Property<Double>("AdditionalRiskPercentage", Double.class, false);
	
	public static final Property<Double> GESTIONRISKPERCENTAGE = new Property<Double>("GestionRiskPercentage", Double.class, false);
	
	public static final Property<String> OFFICERNAME = new Property<String>("OfficerName", String.class, false);
	
	public static final Property<String> POSITIONDESCRIPTION = new Property<String>("PositionDescription", String.class, false);
	
	public static final Property<Integer> OFFICEID = new Property<Integer>("OfficeId", Integer.class, false);
	
	public static final Property<String> RATEDESCRIPTION = new Property<String>("RateDescription", String.class, false);
	
	public static final Property<BigDecimal> TOTALAMOUNT = new Property<BigDecimal>("TotalAmount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALBONUS = new Property<BigDecimal>("TotalBonus", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALBONUSPREVIOUS = new Property<BigDecimal>("TotalBonusPrevious", BigDecimal.class, false);
	
	public static final Property<Double> OPERATIONALRISKPERCENTAGE = new Property<Double>("OperationalRiskPercentage", Double.class, false);
	
	public static final Property<String> REGIONAL = new Property<String>("Regional", String.class, false);
	
	public static final Property<String> REGIONALID = new Property<String>("RegionalID", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
