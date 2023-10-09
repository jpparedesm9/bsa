package com.cobiscorp.b2c.jwt;

import java.util.Calendar;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.mockito.Spy;
import org.mockito.runners.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class DateCalculatorTest extends BaseTest {
    
    @Spy
    private DateCalculator dateCalculator;
    
    @Test
    public void shouldCalculateAffectDay() {
        
        Mockito.when(dateCalculator.getNow()).thenReturn(generateCalendar(2018, 12, 31, 23, 50).getTime());
        
        Calendar later = dateCalculator.addMinutes(dateCalculator.getNow(), 20);
        
        Assert.assertEquals(10, later.get(Calendar.MINUTE));
        Assert.assertEquals(1, later.get(Calendar.DATE));
        Assert.assertEquals(2019, later.get(Calendar.YEAR));
    }

}
