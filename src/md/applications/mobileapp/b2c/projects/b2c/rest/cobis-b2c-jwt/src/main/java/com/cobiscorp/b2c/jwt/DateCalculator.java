package com.cobiscorp.b2c.jwt;

import java.util.Calendar;
import java.util.Date;

public class DateCalculator {

    public DateCalculator() {
    }

    public Date getNow() {
        return Calendar.getInstance().getTime();
    }

    public Calendar addMinutes(Date date, int i) {
        Calendar tmp = Calendar.getInstance();
        tmp.setTimeInMillis(date.getTime() + i * 60 * 1000);
        return tmp;
    }
}
