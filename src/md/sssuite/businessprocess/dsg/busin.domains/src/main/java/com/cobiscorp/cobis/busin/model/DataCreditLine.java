package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class DataCreditLine {

	public static final String EN_DATACRELD_626 = "EN_DATACRELD_626";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DataCreditLine";
	
	
	public static final Property<String> TRAMITE = new Property<String>("tramite", String.class, false);
	
	public static final Property<Integer> LINEA = new Property<Integer>("linea", Integer.class, false);
	
	public static final Property<String> OFICINA = new Property<String>("oficina", String.class, false);
	
	public static final Property<String> OFICIAL = new Property<String>("oficial", String.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("sector", String.class, false);
	
	public static final Property<String> CIUDAD = new Property<String>("ciudad", String.class, false);
	
	public static final Property<Date> FECHAINICIO = new Property<Date>("fechaInicio", Date.class, false);
	
	public static final Property<Integer> NRODIAS = new Property<Integer>("nroDias", Integer.class, false);
	
	public static final Property<Date> FECHAVENCIMIENTO = new Property<Date>("fechaVencimiento", Date.class, false);
	
	public static final Property<String> MONEDA = new Property<String>("moneda", String.class, false);
	
	public static final Property<Double> MONTO = new Property<Double>("monto", Double.class, false);
	
	public static final Property<Character> ROTATIVA = new Property<Character>("rotativa", Character.class, false);
	
	public static final Property<String> PAIS = new Property<String>("pais", String.class, false);
	
	public static final Property<Integer> CODIGOCIUDAD = new Property<Integer>("codigoCiudad", Integer.class, false);
	
	public static final Property<String> CODIGOOFICINA = new Property<String>("codigoOficina", String.class, false);
	
	public static final Property<String> CODIGOOFICIAL = new Property<String>("codigoOficial", String.class, false);
	
	public static final Property<Integer> CODIGOCLIENTE = new Property<Integer>("codigoCliente", Integer.class, false);
	
	public static final Property<String> USUARIO = new Property<String>("usuario", String.class, false);
	
	public static final Property<String> DESCRIPCIONMONEDA = new Property<String>("descripcionMoneda", String.class, false);
	
	public static final Property<String> SECTORDESC = new Property<String>("sectorDesc", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
