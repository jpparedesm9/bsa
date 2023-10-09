package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DistributionEntity {

	public static final String EN_DISTRIBUN_831 = "EN_DISTRIBUN_831";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DistributionEntity";
	
	
	public static final Property<String> PRODUCTO = new Property<String>("producto", String.class, false);
	
	public static final Property<String> DESCRIPCION = new Property<String>("descripcion", String.class, false);
	
	public static final Property<String> TIPOOPERACION = new Property<String>("tipoOperacion", String.class, false);
	
	public static final Property<String> RIESGO = new Property<String>("riesgo", String.class, false);
	
	public static final Property<Double> MONTO = new Property<Double>("monto", Double.class, false);
	
	public static final Property<String> MONEDA = new Property<String>("moneda", String.class, false);
	
	public static final Property<String> OBSERVACION = new Property<String>("observacion", String.class, false);
	
	public static final Property<Integer> NUMEROLINEA = new Property<Integer>("numeroLinea", Integer.class, false);
	
	public static final Property<String> DESCRIPCIONMONEDA = new Property<String>("descripcionMoneda", String.class, false);
	
	public static final Property<String> DESCRIPCIONOPERACION = new Property<String>("descripcionOperacion", String.class, false);
	
	public static final Property<String> DESCRIPCIONRIESGO = new Property<String>("descripcionRiesgo", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
