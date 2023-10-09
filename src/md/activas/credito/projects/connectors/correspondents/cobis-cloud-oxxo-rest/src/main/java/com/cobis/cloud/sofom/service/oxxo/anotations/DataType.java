package com.cobis.cloud.sofom.service.oxxo.anotations;

public enum DataType {
	ALFANUMERICO_ESPACIOS("[a-zA-Z ]*"), //Alfanumérico, incluyendo los espacios
	NUMERICO("[0-9]*"), //Sólo valores numéricos
	ESPECIAL("[$%/()=:;*+^\\[{\\]}.¿?!#@|]*"), //Sólo caracteres especiales
	ALFANUMERICO("[a-zA-Z 0-9]*"), // Alfanumérico
	ALFANUMERICO_ESPECIAL("[a-zA-Z $%/()=:;*+^\\[{\\]}.¿?!#@|]*"), //Sólo caracteres alfanuméricos y especiales
	NUMERICO_ESPECIAL("[0-9$%/()=:;*+^\\[{\\]}.¿?!#@|]*"), //Sólo caracteres numéricos y especiales
	ALFANUMERICO_NUMERICO_ESPECIAL("[a-zA-Z0-9 $%/()=:;*+^\\[{\\]}.¿?!#@|]*"); //Caracteres Alfabéticos, numéricos y especiales
	
	private String regularExpression;
	
	private DataType(String regularExpression){
		this.regularExpression=regularExpression;
	}
	
	public String getRegularExpression(){
		return regularExpression;
	}
}
