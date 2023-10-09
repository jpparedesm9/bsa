package com.cobis.gestionasesores;

import android.support.test.runner.AndroidJUnit4;

import com.cobis.gestionasesores.data.enums.TerritorialOrganization;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.repositories.PostalCodeRepository;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 * Created by mnaunay on 26/07/2017.
 */

@RunWith(AndroidJUnit4.class)
public class PostalCodeTest {

    @Test
    public void getPostalCodeStateTest() {
        PostalCodeRepository repository = PostalCodeRepository.getInstance();
        PostalCode postalCode=   repository.getTerritorial(TerritorialOrganization.STATE, "9");
        Assert.assertEquals(postalCode.getName(),"Ciudad de Mexico");
    }

    @Test
    public void getPostalCodeTownTest() {
        PostalCodeRepository repository = PostalCodeRepository.getInstance();
        PostalCode postalCode = repository.getTerritorial(TerritorialOrganization.TOWN, "283");
        Assert.assertEquals(postalCode.getName(),"Canelas");
    }


    @Test
    public void getPostalCodeVillageTest() {
        PostalCodeRepository repository = PostalCodeRepository.getInstance();
        PostalCode postalCode = repository.getTerritorial(TerritorialOrganization.VILLAGE, "30245");
        Assert.assertEquals(postalCode.getName(),"San Benito");
    }
}
