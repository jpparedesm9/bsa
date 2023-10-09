package com.cobiscorp.ecobis.busin.model;

import com.cobiscorp.ecobis.busin.enums.ParameterType;

public class InputParameterDto {

	private String parameter;

	private String value;

	private ParameterType parameterType;

	/**
	 * 
	 */
	public InputParameterDto() {
		super();
	}

	/**
	 * @param parameter
	 *            Parametros de entrada del sp Ej.@t_trn=1,@i_operacion=1 ()
	 * @param value
	 * @param type
	 */
	public InputParameterDto(String parameter, String value, ParameterType parameterType) {
		super();
		this.parameter = parameter;
		this.value = value;
		this.parameterType = parameterType;
	}

	/**
	 * @return the parameter
	 */
	public String getParameter() {
		return parameter;
	}

	/**
	 * @param parameter
	 *            the parameter to set
	 */
	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * @param value
	 *            the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}

	/**
	 * @return the parameterType
	 */
	public ParameterType getParameterType() {
		return parameterType;
	}

	/**
	 * @param parameterType
	 *            the parameterType to set
	 */
	public void setParameterType(ParameterType parameterType) {
		this.parameterType = parameterType;
	}

}
