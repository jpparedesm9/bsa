package com.cobiscorp.cobis.loans.reports.dto;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class FormatDateExpression {
	private String city;
	private Calendar date;

	public String formatDMY(Date dateI) {
		SimpleDateFormat formatDMY = new SimpleDateFormat("dd/MM/yyyy");
		String date = formatDMY.format(dateI);
		return date;
	}

	public FormatDateExpression() {
		this("", Calendar.getInstance());
	}

	public FormatDateExpression(Calendar date) {
		this("", date);
	}

	public FormatDateExpression(String city) {
		this(city, Calendar.getInstance());
	}

	public FormatDateExpression(String city, Calendar date) {
		this.setCity(city);
		this.setDate(date);
	}

	public String getLegal() {
		return FormatDateExpression.getLegalForDocument(this.city, this.date);
	}

	public static String getLegalForDocument(Calendar date) {
		String valueRespopnse = "";
		if ((date != null)) {
			Locale espaniol = new Locale("es", "ES");
			SimpleDateFormat sdf = new SimpleDateFormat("dd 'de' MMMMM 'de' yyyy", espaniol);
			valueRespopnse = sdf.format(date.getTime());
		}
		return valueRespopnse;
	}

	public static String getLegalForDocument(String city, Calendar date) {
		String valueRespopnse = "";
		boolean hasCity = false;
		if ((city != null) && (city.trim().length() > 0)) {
			valueRespopnse = city;
			hasCity = true;
		}

		if ((date != null)) {
			Locale espaniol = new Locale("es", "ES");
			SimpleDateFormat sdf = new SimpleDateFormat("dd 'de' MMMMM 'de' yyyy", espaniol);
			valueRespopnse = valueRespopnse + ((hasCity) ? ", " : "") + sdf.format(date.getTime());
		}
		return valueRespopnse;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public Calendar getDate() {
		return date;
	}

	public void setDate(Calendar date) {
		this.date = date;
	}

}
