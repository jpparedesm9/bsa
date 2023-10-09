package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class PrintingPaymentInfo {

	public static final String EN_PRINTINNP_519 = "EN_PRINTINNP_519";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PrintingPaymentInfo";
	
	
	public static final Property<Integer> NUMRECEIPT = new Property<Integer>("numReceipt", Integer.class, false);
	
	public static final Property<Integer> SECUENTIALING = new Property<Integer>("secuentialIng", Integer.class, false);
	
	public static final Property<Integer> SECUENTIALPAG = new Property<Integer>("secuentialPag", Integer.class, false);
	
	public static final Property<String> STATUSPAG = new Property<String>("statusPag", String.class, false);
	
	public static final Property<String> PAYMENTDATE = new Property<String>("paymentDate", String.class, false);
	
	public static final Property<Integer> OFFICIAL = new Property<Integer>("official", Integer.class, false);
	
	public static final Property<Boolean> ITEMSEL = new Property<Boolean>("itemSel", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
