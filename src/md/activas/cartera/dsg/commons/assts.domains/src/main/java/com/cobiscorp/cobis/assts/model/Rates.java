package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Rates {

	public static final String EN_RATESTIRW_494 = "EN_RATESTIRW_494";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Rates";
	
	
	public static final Property<String> REFERENCEVALUE = new Property<String>("referenceValue", String.class, false);
	
	public static final Property<BigDecimal> VALUE = new Property<BigDecimal>("value", BigDecimal.class, false);
	
	public static final Property<String> PORTFOLIOCLASS = new Property<String>("portfolioClass", String.class, false);
	
	public static final Property<String> TYPEPOINTS = new Property<String>("typePoints", String.class, false);
	
	public static final Property<Integer> NUMBERDECIMALS = new Property<Integer>("numberDecimals", Integer.class, false);
	
	public static final Property<Character> SIGNDEFAULT = new Property<Character>("signDefault", Character.class, false);
	
	public static final Property<BigDecimal> VALUEDEAFULT = new Property<BigDecimal>("valueDeafult", BigDecimal.class, false);
	
	public static final Property<BigDecimal> LOCKEDDEFAULT = new Property<BigDecimal>("lockedDefault", BigDecimal.class, false);
	
	public static final Property<Character> SIGNMIN = new Property<Character>("signMin", Character.class, false);
	
	public static final Property<BigDecimal> VALUEMIN = new Property<BigDecimal>("valueMin", BigDecimal.class, false);
	
	public static final Property<BigDecimal> LOCKEDMIN = new Property<BigDecimal>("lockedMin", BigDecimal.class, false);
	
	public static final Property<Character> SIGNMAX = new Property<Character>("signMax", Character.class, false);
	
	public static final Property<BigDecimal> VALUEMAX = new Property<BigDecimal>("valueMax", BigDecimal.class, false);
	
	public static final Property<BigDecimal> LOCKEDMAX = new Property<BigDecimal>("lockedMax", BigDecimal.class, false);
	
	public static final Property<String> RATETYPE = new Property<String>("rateType", String.class, false);
	
	public static final Property<Character> CLASE = new Property<Character>("clase", Character.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
