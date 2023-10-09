package com.cobis.gestionasesores.data.models;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

/**
 * Created by bqtdesa02 on 7/11/2017.
 */
public class ProspectDataTest {
    @Test
    public void getNameNull() throws Exception {
        ProspectData prospectData =
                new ProspectData.Builder()
                        .setFirstName(null)
                        .setSecondName(null)
                        .build();

        assertNull(prospectData.getName());
    }

    @Test
    public void getNameEmpty(){
        ProspectData prospectData =
                new ProspectData.Builder()
                        .setFirstName("")
                        .setSecondName("")
                        .build();

        assertEquals("", prospectData.getName());
    }

    @Test
    public void getSecondNameEmpty(){
        ProspectData prospectData =
                new ProspectData.Builder()
                        .setFirstName("Jose")
                        .setSecondName("")
                        .build();

        assertEquals("Jose", prospectData.getName());
    }

    @Test
    public void getFirstNameEmpty(){
        ProspectData prospectData =
                new ProspectData.Builder()
                        .setFirstName("")
                        .setSecondName("Ignacio")
                        .build();

        assertEquals("Ignacio", prospectData.getName());
    }

    @Test
    public void getName(){
        ProspectData prospectData =
                new ProspectData.Builder()
                        .setFirstName("Jose")
                        .setSecondName("Ignacio")
                        .build();

        assertEquals("Jose Ignacio", prospectData.getName());
    }
}