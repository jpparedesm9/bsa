package com.cobiscorp.cobis.assets.reports.commons;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

/***
 * Esta clase permite setear un mapa de parametros para los reportes validado
 * valores
 * 
 * @author CobisCorp
 * 
 */
public class Util {
	private static final ILogger logger = LogFactory.getLogger(Util.class);
	private Map<String, Object> params;

	/***
	 * Permite setear un parametro con un valor valido, caso contrario con un valor
	 * por defecto
	 * 
	 * @param pName
	 * @param value
	 * @param defaultValue
	 */
	public void mapValuesToParams(String pName, Object value, Object defaultValue) {
		try {
			if (value != null && this.getParams() != null) {
				this.getParams().put(pName, value);
			} else {
				this.getParams().put(pName, defaultValue);
			}
		} catch (Exception ex) {
			logger.logDebug("REPORTE  ERROR EN EL MAPEO DE DATOS PARA: " + pName + " :: ex=" + ex);
		}
	}

	@SuppressWarnings("unchecked")
	public void error(ServiceResponseTO serviceResponseTO) {

		if (!serviceResponseTO.isSuccess()) {
			List<MessageTO> errorMessages = serviceResponseTO.getMessages();
			for (MessageTO message : errorMessages) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("Mensaje  -  Codigo: " + message.getCode() + ", Detalle:" + message.getMessage());
				}
			}
		}
	}

	/**
	 * Convierte de mm/dd/yyyy a dd/mm/yyyy
	 * 
	 * @param date
	 * @return
	 */
	public String convertDate(String date) {
		if (date != null) {
			String dateArray[] = date.split("/");
			if (dateArray != null && dateArray.length == 3) {
				return dateArray[1] + "/" + dateArray[0] + "/" + dateArray[2];
			}
		}
		return date;
	}

	// Setters & getters

	public Map<String, Object> getParams() {
		return params;
	}

	public void setParams(Map<String, Object> params) {
		this.params = params;
	}

	/**
	 * Convierte a letras un numero de la forma $123,456.32
	 * 
	 * @param number
	 *            Numero en representacion texto
	 * @throws NumberFormatException
	 *             Si valor del numero no es valido (fuera de rango o )
	 * @return Numero en letras
	 */
	public static String convertNumberToLetter(String number) {
		return convertNumber(number);
	}

	/**
	 * Convierte un numero en representacion numerica a uno en representacion de
	 * texto. El numero es valido si esta entre 0 y 999'999.999
	 * 
	 * @param doubleNumber
	 *            Numero a convertir
	 * @return Numero convertido a texto
	 * @throws NumberFormatException
	 *             Si el numero esta fuera del rango
	 */
	public static String convertNumberToLetter(double doubleNumber) {

		StringBuilder converted = new StringBuilder();

		String patternThreeDecimalPoints = "#.###";

		DecimalFormat format = new DecimalFormat(patternThreeDecimalPoints);
		format.setRoundingMode(RoundingMode.DOWN);

		// formateamos el numero, para ajustarlo a el formato de tres puntos
		// decimales
		String formatedDouble = format.format(doubleNumber);
		double doubleNumberNew = Double.parseDouble(formatedDouble);

		// Validamos que sea un numero legal
		if (doubleNumberNew > 999999999)
			throw new NumberFormatException("El numero es mayor de 999'999.999, " + "no es posible convertirlo");

		if (doubleNumberNew < 0)
			throw new NumberFormatException("El numero debe ser positivo");

		String splitNumber[] = String.valueOf(doubleNumberNew).replace('.', '#').split("#");

		// Descompone el trio de millones
		int millon = Integer
				.parseInt(String.valueOf(getDigitAt(splitNumber[0], 8)) + String.valueOf(getDigitAt(splitNumber[0], 7)) + String.valueOf(getDigitAt(splitNumber[0], 6)));
		if (millon == 1)
			converted.append("**UN MILLON ");
		else if (millon > 1)
			converted.append("**").append(convertNumber(String.valueOf(millon))).append("MILLONES ");

		// Descompone el trio de miles
		int miles = Integer.parseInt(String.valueOf(getDigitAt(splitNumber[0], 5)) + String.valueOf(getDigitAt(splitNumber[0], 4)) + String.valueOf(getDigitAt(splitNumber[0], 3)));
		if (millon >= 1) {
			if (miles == 1)
				converted.append(convertNumber(String.valueOf(miles))).append("MIL ");
			else if (miles > 1)
				converted.append(convertNumber(String.valueOf(miles))).append("MIL ");
		} else {
			if (miles == 1)
				converted.append("**UN MIL ");

			if (miles > 1)
				converted.append("**").append(convertNumber(String.valueOf(miles))).append("MIL ");
		}

		// Descompone el ultimo trio de unidades
		int cientos = Integer
				.parseInt(String.valueOf(getDigitAt(splitNumber[0], 2)) + String.valueOf(getDigitAt(splitNumber[0], 1)) + String.valueOf(getDigitAt(splitNumber[0], 0)));
		if (miles >= 1 || millon >= 1) {
			if (cientos >= 1)
				converted.append(convertNumber(String.valueOf(cientos)));
		} else {
			if (cientos == 1)
				converted.append("**UN ");
			if (cientos > 1)
				converted.append("**").append(convertNumber(String.valueOf(cientos)));
		}

		if (millon + miles + cientos == 0)
			converted.append("**CERO ");

		// Descompone los centavos
		String valor = splitNumber[1];
		if (valor.length() == 1) {
			converted.append(splitNumber[1]).append("0").append("/100 ");
		} else {
			converted.append(splitNumber[1]).append("/100 ");
		}
		converted.append("U.S. DOLARES**");
		return converted.toString();
	}

	/**
	 * Convierte los trios de numeros que componen las unidades, las decenas y las
	 * centenas del numero.
	 * 
	 * @param number
	 *            Numero a convetir en digitos
	 * @return Numero convertido en letras
	 */
	private static String convertNumber(String number) {

		if (number.length() > 3)
			throw new NumberFormatException("La longitud maxima debe ser 3 digitos");

		// Caso especial con el 100
		if (number.equals("100")) {
			return "CIEN ";
		}

		StringBuilder output = new StringBuilder();
		if (getDigitAt(number, 2) != 0)
			output.append(ConstantValue.CENTENAS[getDigitAt(number, 2) - 1]);

		int k = Integer.parseInt(String.valueOf(getDigitAt(number, 1)) + String.valueOf(getDigitAt(number, 0)));

		if (k <= 20)
			output.append(ConstantValue.UNIDADES[k]);
		else if (k > 30 && getDigitAt(number, 0) != 0)
			output.append(ConstantValue.DECENAS[getDigitAt(number, 1) - 2]).append("Y ").append(ConstantValue.UNIDADES[getDigitAt(number, 0)]);
		else
			output.append(ConstantValue.DECENAS[getDigitAt(number, 1) - 2]).append(ConstantValue.UNIDADES[getDigitAt(number, 0)]);

		return output.toString();
	}

	/**
	 * Retorna el digito numerico en la posicion indicada de derecha a izquierda
	 * 
	 * @param origin
	 *            Cadena en la cual se busca el digito
	 * @param position
	 *            Posicion de derecha a izquierda a retornar
	 * @return Digito ubicado en la posicion indicada
	 */
	private static int getDigitAt(String origin, int position) {
		if (origin.length() > position && position >= 0)
			return origin.charAt(origin.length() - position - 1) - 48;
		return 0;
	}

	public static String convertMonthsToLetter(String number) throws NumberFormatException {

		String month = ConstantValue.MES[Integer.parseInt(number)].toString();

		return month;
	}

	public String monthDescription(Calendar c1) {
		String month = "";
		if (c1.get(Calendar.MONTH) == 0) {
			month = "ENERO";
		} else if (c1.get(Calendar.MONTH) == 1) {
			month = "FEBRERO";
		} else if (c1.get(Calendar.MONTH) == 2) {
			month = "MARZO";
		} else if (c1.get(Calendar.MONTH) == 3) {
			month = "ABRIL";
		} else if (c1.get(Calendar.MONTH) == 4) {
			month = "MAYO";
		} else if (c1.get(Calendar.MONTH) == 5) {
			month = "JUNIO";
		} else if (c1.get(Calendar.MONTH) == 6) {
			month = "JULIO";
		} else if (c1.get(Calendar.MONTH) == 7) {
			month = "AGOSTO";
		} else if (c1.get(Calendar.MONTH) == 8) {
			month = "SEPTIEMBRE";
		} else if (c1.get(Calendar.MONTH) == 9) {
			month = "OCTUBRE";
		} else if (c1.get(Calendar.MONTH) == 10) {
			month = "NOVIEMBRE";
		} else if (c1.get(Calendar.MONTH) == 11) {
			month = "DICIEMBRE";
		}
		return month;
	}

	public String numberCero(Integer c) {
		String numberCero = "";
		if (c < 10) {
			numberCero = "0" + String.valueOf(c);
		} else {
			numberCero = String.valueOf(c);
		}
		return numberCero;
	}

}