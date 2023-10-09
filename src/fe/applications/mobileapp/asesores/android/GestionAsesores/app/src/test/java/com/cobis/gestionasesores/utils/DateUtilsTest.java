package com.cobis.gestionasesores.utils;

import org.junit.Test;

import java.util.Calendar;
import java.util.Date;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

/**
 * Created by mnaunay on 05/07/2017.
 */

public class DateUtilsTest {

    @Test
    public void parseMillisecondsDateTest() throws Exception {
        assertNull(DateUtils.parseMillisecondsDate(null));
        assertNotNull(DateUtils.parseMillisecondsDate(System.currentTimeMillis()));
    }

    @Test
    public void formatDateTest() throws Exception {
        Calendar c1 = Calendar.getInstance();
        c1.set(Calendar.DAY_OF_MONTH, 10);
        c1.set(Calendar.MONTH, 2);//month -1
        c1.set(Calendar.YEAR, 2017);

        assertEquals("10/03/2017", DateUtils.formatDate(c1.getTime().getTime()));
        assertNotEquals("10/02/2017", DateUtils.formatDate(c1.getTime().getTime()));
    }

    @Test
    public void parseDateTest() throws Exception {
        assertNotNull(DateUtils.parseTimeDate("10:59"));
        assertNull(DateUtils.parseTimeDate(null));
    }

    @Test
    public void parseTimeTest() throws Exception {
        Calendar c1 = Calendar.getInstance();
        c1.set(Calendar.HOUR_OF_DAY, 10);
        c1.set(Calendar.MINUTE, 59);
        assertEquals("10:59", DateUtils.formatTime(c1.getTime().getTime()));
    }


    @Test
    public void parseDateServer(){
        String server = "2017-06-20T05:00:00.000Z";
        Long result = DateUtils.parseDateFromService(server);

        Calendar calendarResult = Calendar.getInstance();
        calendarResult.setTimeInMillis(result);

        assertEquals(2017,calendarResult.get(Calendar.YEAR));
        assertEquals(6,calendarResult.get(Calendar.MONTH)+1);//month start  with 0
        assertEquals(20,calendarResult.get(Calendar.DAY_OF_MONTH));
    }

    @Test
    public void testGetAge(){
        String server = "1999-08-19T00:00:00.000Z";
        Long result = DateUtils.parseDateFromService(server);
        assertEquals(18,DateUtils.getAge(result));
    }

    @Test
    public void shouldComputeDate(){
        long ms = 1503396725505L;
        Date expectedDate = new Date(ms);
        System.out.println("Date: "+expectedDate.toString());
        assertTrue(isExpired(0,expectedDate));
    }

    public boolean isExpired(long leeway,Date exp) {
        if (leeway < 0) {
            throw new IllegalArgumentException("The leeway must be a positive value.");
        }
        long todayTime = (long) (Math.floor(new Date().getTime() / 1000) * 1000); //truncate millis
        Date pastToday = new Date((todayTime - leeway * 1000));
        boolean expValid = exp == null || !pastToday.after(exp);
        return !expValid;
    }
}