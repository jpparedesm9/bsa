package com.cobiscorp.ecobis.cloud.service.util;

import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.util.Calendar;

import static org.hamcrest.CoreMatchers.containsString;
import static org.hamcrest.MatcherAssert.assertThat;

public class CalendarUtilTest {

    @Test
    public void itShouldSerializeDates() throws IOException {
        String isoString = "1988-09-01T09:50:17.997Z";

        Calendar calendar = CalendarUtil.fromISOTime(isoString);
        String toISOTime = CalendarUtil.toISOTime(calendar);

        assertThat(toISOTime, containsString(isoString));
    }

    @Test
    public void itShouldDeserializeDates() throws IOException {
        String date = "03/28/1985";
        Calendar calendar = CalendarUtil.from(date);
        Assert.assertEquals(calendar.get(Calendar.DAY_OF_MONTH), 28);
        Assert.assertEquals(calendar.get(Calendar.YEAR), 1985);
        Assert.assertEquals(calendar.get(Calendar.MONTH), 2);
    }
}
