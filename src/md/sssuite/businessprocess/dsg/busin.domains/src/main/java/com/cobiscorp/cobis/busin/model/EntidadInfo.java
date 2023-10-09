package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class EntidadInfo {

	public static final String EN_ENIDADINO519 = "EN_ENIDADINO519";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "EntidadInfo";
	
	
	public static final Property<String> SECTOR = new Property<String>("sector", String.class, false);
	
	public static final Property<String> OFICINA = new Property<String>("oficina", String.class, false);
	
	public static final Property<String> DESTINOFINANCIERO = new Property<String>("destinoFinanciero", String.class, false);

	public static final Property<String> GEOGRAPHICALDESTINATION = new Property<String>("geographicalDestination", String.class, false);
	
	public static final Property<String> LINEACREDITO = new Property<String>("lineaCredito", String.class, false);
	
	public static final Property<String> DESTINOECONOMICO = new Property<String>("destinoEconomico", String.class, false);
	
	public static final Property<String> TIPOPRODUCTO = new Property<String>("tipoProducto", String.class, false);
	
	public static final Property<String> OTRODESTINO = new Property<String>("otroDestino", String.class, false);
	
	public static final Property<String> DESTECONOMICODESCRIPTION = new Property<String>("destEconomicoDescription", String.class, false);
	
	public static final Property<String> DESTECONOMICOBUSQUEDA = new Property<String>("destEconomicoBusqueda", String.class, false);
	
	public static final Property<String> BANCA = new Property<String>("banca", String.class, false);
	
	public static final Property<String> UBICACION = new Property<String>("ubicacion", String.class, false);
	
	public static final Property<String> NUEVODESTINO = new Property<String>("nuevoDestino", String.class, false);
	
	public static final Property<String> FECHAPROCESO = new Property<String>("fechaProceso", String.class, false);
	
	public static final Property<String> INSURANCEPACKAGE = new Property<String>("insurancePackage", String.class, false);
	
	public static final Property<String> TERMMEDICALASSISTANCE = new Property<String>("termMedicalAssistance", String.class, false);

	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
