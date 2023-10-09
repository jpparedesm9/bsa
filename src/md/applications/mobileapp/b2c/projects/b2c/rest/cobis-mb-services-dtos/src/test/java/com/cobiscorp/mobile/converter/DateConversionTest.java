package com.cobiscorp.mobile.converter;

import java.util.Calendar;

import org.junit.Assert;
import org.junit.Test;

public class DateConversionTest {

	@Test
	public void convertDate() {
		Calendar date = new Calendar.Builder().set(Calendar.YEAR, 2018).set(Calendar.MONTH, 11).set(Calendar.DATE, 6).build();
		String stringDate = DateConverter.calendarToFormattedString(date);
		Assert.assertEquals("Dic 06, 2018", stringDate);
	}
}
