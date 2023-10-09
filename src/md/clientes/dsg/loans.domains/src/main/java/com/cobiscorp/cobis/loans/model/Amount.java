package com.cobiscorp.cobis.loans.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Amount {

	public static final String EN_MONTOSVSY_937 = "EN_MONTOSVSY_937";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Amount";
	
	
	public static final Property<BigDecimal> AUTHORIZEDAMOUNT = new Property<BigDecimal>("authorizedAmount", BigDecimal.class, false);
	
	public static final Property<String> CREDITBUREAU = new Property<String>("creditBureau", String.class, false);
	
	public static final Property<Character> CYCLEPARTICIPATION = new Property<Character>("cycleParticipation", Character.class, false);
	
	public static final Property<BigDecimal> VOLUNTARYSAVINGS = new Property<BigDecimal>("voluntarySavings", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INCREMENT = new Property<BigDecimal>("increment", BigDecimal.class, false);
	
	public static final Property<Integer> MEMBERID = new Property<Integer>("memberId", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<Integer> SECUENTIAL = new Property<Integer>("secuential", Integer.class, false);
	
	public static final Property<BigDecimal> RESULTAMOUNT = new Property<BigDecimal>("resultAmount", BigDecimal.class, false);
	
	public static final Property<String> MEMBERNAME = new Property<String>("memberName", String.class, false);
	
	public static final Property<String> RISKLEVEL = new Property<String>("riskLevel", String.class, false);
	
	public static final Property<String> CHECKRENAPO = new Property<String>("checkRenapo", String.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<String> SAFEREPORT = new Property<String>("safeReport", String.class, false);
	
	public static final Property<String> OLDOPERATION = new Property<String>("oldOperation", String.class, false);
	
	public static final Property<Integer> CREDIT = new Property<Integer>("credit", Integer.class, false);
	
	public static final Property<String> SAFEPACKAGE = new Property<String>("safePackage", String.class, false);
	
	public static final Property<BigDecimal> PROPOSEDMAXIMUMSAVING = new Property<BigDecimal>("proposedMaximumSaving", BigDecimal.class, false);
	
	public static final Property<BigDecimal> OLDBALANCE = new Property<BigDecimal>("oldBalance", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
