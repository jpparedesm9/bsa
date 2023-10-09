package com.cobis.gestionasesores;

import android.support.test.runner.AndroidJUnit4;

import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.CreditApp;
import com.cobis.gestionasesores.data.models.GroupCreditApp;
import com.cobis.gestionasesores.data.source.local.PersistenceCreditApp;

import org.junit.Test;
import org.junit.runner.RunWith;

import java.util.List;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

/**
 * Created by mnaunay on 22/06/2017.
 */

@RunWith(AndroidJUnit4.class)
public class CreditAppPersistenceTest {

    @Test
    public void addGroup(){
        GroupCreditApp groupCreditApp = new GroupCreditApp.Builder()
                .setId(1)
                .setApplicantName("Group: "+System.currentTimeMillis())
                .setAmount(2)
                .build();
        PersistenceCreditApp persistence = new PersistenceCreditApp();
        persistence.deleteRows();
        assertTrue(persistence.addCreditApp(groupCreditApp)>0);
        persistence.close();
    }


    @Test
    public void updateGroup(){
        GroupCreditApp groupCreditApp = new GroupCreditApp.Builder()
                .setId(1)
                .setApplicantName("Group: "+System.currentTimeMillis())
                .setAmount(2)
                .setId(1)
                .build();
        PersistenceCreditApp persistence = new PersistenceCreditApp();
        assertTrue(persistence.updateCreditApp(1,groupCreditApp));
        persistence.close();
    }

    @Test
    public void getLast(){
        PersistenceCreditApp persistence = new PersistenceCreditApp();
        List<CreditApp> data = persistence.getAll(CreditAppType.UNKNOWN, SyncStatus.UNKNOWN);
        assertNotNull(data);
    }

    @Test
    public void deleteGroup(){
        PersistenceCreditApp persistence = new PersistenceCreditApp();
        assertTrue(persistence.deleteCreditApp(1));
        persistence.close();
    }
}
