package com.cobis.gestionasesores;

import android.support.test.runner.AndroidJUnit4;

import com.cobis.gestionasesores.data.enums.VersionConcept;
import com.cobis.gestionasesores.data.repositories.VersionRepository;
import com.cobis.gestionasesores.domain.businesslogic.InitManager;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

/**
 * Created by Miguel on 17/07/2017.
 */

@RunWith(AndroidJUnit4.class)
public class InitManagerTest {
    private InitManager manager;

    @Before
    public void setUp() throws Exception {
        manager = new InitManager(R.raw.catalogos,R.raw.postalcodes);
    }

    @Test
    public void loadPostalCodeTest() {
        VersionRepository.getInstance().updateVersion(VersionConcept.POSTAL_CODES,-1);
        Assert.assertTrue(manager.checkPostalCodesUpdate());
    }

    @Test
    public void loadCatalogsTest() {
        VersionRepository.getInstance().updateVersion(VersionConcept.CATALOGS,-1);
        Assert.assertTrue(manager.checkCatalogsUpdate());
    }
}
