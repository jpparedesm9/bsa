package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Alicuota {

	public static final String EN_ALICUOTAT010 = "EN_ALICUOTAT010";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Alicuota";
	
	
	public static final Property<String> ALICUOTA = new Property<String>("Alicuota", String.class, false);
	
	public static final Property<String> CTAAHORROS = new Property<String>("CtaAhorros", String.class, false);
	
	public static final Property<String> ALICUOTAAHORRO = new Property<String>("AlicuotaAhorro", String.class, false);
	
	public static final Property<String> CTACERTIFICADA = new Property<String>("CtaCertificada", String.class, false);
	
	public static final Property<String> ALICUOTACERTIFICADA = new Property<String>("AlicuotaCertificada", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
