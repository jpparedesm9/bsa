package com.cobis.cloud.sofom.service.oxxo.utils;

import java.lang.reflect.Field;
import java.util.Map;

import com.cobis.cloud.sofom.service.oxxo.anotations.DataType;
import com.cobis.cloud.sofom.service.oxxo.anotations.OxxoValidation;
import com.cobis.cloud.sofom.service.oxxo.dto.CodeResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class OxxoValidator {

	private static final ILogger LOGGER = LogFactory.getLogger(OxxoValidator.class);
	private static CodeResponse respCode = new CodeResponse();

	public OxxoValidator() {
	}

	public static <T> CodeResponse validate(T request) {
		//Metodo para validaciones de campos requedo, tipo de dato, dimension de caracteres
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("INICIA METODO VALIDATE");
		try {

			for (Field field : request.getClass().getDeclaredFields()) {
				if (!validateField(field, request)) {
					break;
				}
			}

		} catch (IllegalArgumentException e) {
			LOGGER.logError("Error al validar", e);
		} catch (IllegalAccessException e) {
			LOGGER.logError("Error al validar", e);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("FINALIZA METODO VALIDATE");
		}

		return respCode;
	}

	public static CodeResponse validateRequired(boolean isRequired, Object value, Object name) {

		CodeResponse codResp = new CodeResponse();

		if ((isRequired && value == null) || (isRequired && "".equals(value))) {
			codResp.setCode("03");
			codResp.setDescription("PARAMETRO " + name + " OBLIGATORIO Y NO INFORMADO");
			LOGGER.logError("Código: " + codResp.getCode() + "   " + "Descripción: " + codResp.getDescription());
		} else {
			return null;
		}

		return codResp;
	}

	public static CodeResponse validateDataType(DataType dataType, Object value, Object name) {

		CodeResponse codResp = new CodeResponse();

		if (value != null && !value.toString().matches(dataType.getRegularExpression())) {

			codResp.setCode("02");
			codResp.setDescription("FORMATO DE PARAMETRO INCORRECTO PARA EL CAMPO:" + name);
			LOGGER.logError("Código: " + codResp.getCode() + "   " + "Descripción: " + codResp.getDescription());
		} else {
			codResp = null;
		}

		return codResp;
	}

	public static CodeResponse validateMaxLength(int maxLength, Object value, Object name) {

		CodeResponse codResp = new CodeResponse();

		if (value != null && value.toString().length() > maxLength) {

			codResp.setCode("01");
			codResp.setDescription("LONGITUD DE PARAMETROS INCOMPLETA PARA EL CAMPO: " + name);
			LOGGER.logError("Código: " + codResp.getCode() + "   " + "Descripción: " + codResp.getDescription());

		} else {
			codResp = null;
		}

		return codResp;
	}

	public static CodeResponse validateDate(boolean isDate, Object value, Object name, int maxLength) {
		CodeResponse codResp = new CodeResponse();
		if (isDate && OxxoValidateDate.verificaDate(value.toString(), maxLength) == false) {

			codResp.setCode("04");
			codResp.setDescription("FECHA INVALIDA: " + name);
			LOGGER.logError("Código: " + codResp.getCode() + "   " + "Descripción: " + codResp.getDescription());
		} else {
			codResp = null;
		}

		return codResp;
	}

	public static <T> boolean validateField(Field field, T request) throws IllegalArgumentException, IllegalAccessException {
		boolean isValid = true;
		int validationType = 1;
		OxxoValidation oxxoValidation = field.getAnnotation(OxxoValidation.class);
		field.setAccessible(true);
		
		while (isValid && validationType <= 4) {
			switch (validationType) {
			case 1:
				respCode = validateRequired(oxxoValidation.required(), field.get(request), field.getName());
				break;
			case 2:
				respCode = validateMaxLength(oxxoValidation.maxlength(), field.get(request), field.getName());
				break;
			case 3:
				respCode = validateDataType(oxxoValidation.dataType(), field.get(request), field.getName());
				break;
			case 4:
				respCode = validateDate(oxxoValidation.date(), field.get(request), field.getName(), oxxoValidation.maxlength());
				break;
			default:
				break;
			}
			isValid = respCode == null ? true : false;
			validationType++;
		}

		return isValid;

	}

	public static boolean validateResponse(Map<String, Object> outputs, String[] requiredFields) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start validateResponse");
		try {
			if (outputs == null) {
				return false;
			}
			for (String field : requiredFields) {
				if (!validateResponseField(outputs.get(field), field)) {
					return false;
				}
			}
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish validateResponse");
		}
		return true;

	}

	public static boolean validateResponseField(Object object, String field) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start validateResponseField");
		try {
			if (object == null || "".equals(String.valueOf(object).trim())) {
				LOGGER.logError("Error campo requerido >> [" + field + "]:" + (object == null ? null : String.valueOf(object).trim()));
				return false;
			}
			LOGGER.logDebug("[" + field + ": " + object + "]");

		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish validateResponseField");
		}
		return true;
	}
}
