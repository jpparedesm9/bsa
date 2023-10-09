package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class MemberAmount {

	public static final String EN_MEMBERANU_548 = "EN_MEMBERANU_548";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "MemberAmount";
	
	public static final Property<Character> TYPEPAYMENT = new Property<Character>("typePayment", Character.class, false);
	
	public static final Property<Integer> SECUENTIAL = new Property<Integer>("secuential", Integer.class, false);
	
	public static final Property<String> ACCOUNTNUMBER = new Property<String>("accountNumber", String.class, false);
	
	public static final Property<Integer> MEMBERID = new Property<Integer>("memberId", Integer.class, false);
	
	public static final Property<String> MEMBERNAME = new Property<String>("memberName", String.class, false);
	
	public static final Property<Integer> CREDIT = new Property<Integer>("credit", Integer.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
