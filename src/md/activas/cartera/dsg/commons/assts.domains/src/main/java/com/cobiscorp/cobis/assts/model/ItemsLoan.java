package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ItemsLoan {

	public static final String EN_ITEMSLONA_118 = "EN_ITEMSLONA_118";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ItemsLoan";
	
	
	public static final Property<String> CONCEPT = new Property<String>("concept", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<Character> ITEMTYPE = new Property<Character>("itemType", Character.class, false);
	
	public static final Property<Character> PAYMENTMETHOD = new Property<Character>("paymentMethod", Character.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final Property<Integer> PRIORITY = new Property<Integer>("priority", Integer.class, false);
	
	public static final Property<Character> LATEPAYMENT = new Property<Character>("latePayment", Character.class, false);
	
	public static final Property<Character> CAUSE = new Property<Character>("cause", Character.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("reference", String.class, false);
	
	public static final Property<Character> SIGN = new Property<Character>("sign", Character.class, false);
	
	public static final Property<BigDecimal> POINTSVALUE = new Property<BigDecimal>("pointsValue", BigDecimal.class, false);
	
	public static final Property<Character> POINTSTYPE = new Property<Character>("pointsType", Character.class, false);
	
	public static final Property<BigDecimal> VALUETOTALRATE = new Property<BigDecimal>("valueTotalRate", BigDecimal.class, false);
	
	public static final Property<BigDecimal> NEGOTIATEDRATE = new Property<BigDecimal>("negotiatedRate", BigDecimal.class, false);
	
	public static final Property<BigDecimal> ANNUALEFECRATE = new Property<BigDecimal>("annualEfecRate", BigDecimal.class, false);
	
	public static final Property<Character> REAJUSTMENSIGN = new Property<Character>("reajustmenSign", Character.class, false);
	
	public static final Property<BigDecimal> REAJUSTMENTVALUEPOINTS = new Property<BigDecimal>("reajustmentValuePoints", BigDecimal.class, false);
	
	public static final Property<String> REAJUSTMENTREFERENCE = new Property<String>("reajustmentReference", String.class, false);
	
	public static final Property<BigDecimal> GAIN = new Property<BigDecimal>("gain", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BASECALCULATION = new Property<BigDecimal>("baseCalculation", BigDecimal.class, false);
	
	public static final Property<BigDecimal> CHARGEFORRINGING = new Property<BigDecimal>("chargeForRinging", BigDecimal.class, false);
	
	public static final Property<String> WARRANTYTYPE = new Property<String>("warrantyType", String.class, false);
	
	public static final Property<String> WARRANTYNUMBER = new Property<String>("warrantyNumber", String.class, false);
	
	public static final Property<Character> COVERAGEPERCENTAGE = new Property<Character>("coveragePercentage", Character.class, false);
	
	public static final Property<Character> WARRANTYVALUE = new Property<Character>("warrantyValue", Character.class, false);
	
	public static final Property<String> DIVIDENDTYPE = new Property<String>("dividendType", String.class, false);
	
	public static final Property<Integer> INTERESTPERIOD = new Property<Integer>("interestPeriod", Integer.class, false);
	
	public static final Property<String> TABLEOTHERRATE = new Property<String>("tableOtherRate", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
