package com.cobis.gestionasesores;

import android.support.test.runner.AndroidJUnit4;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.source.local.PersistenceGroup;

import org.junit.Test;
import org.junit.runner.RunWith;

import java.util.List;

import static org.junit.Assert.assertNotNull;

/**
 * Created by Miguel on 06/07/2017.
 */
@RunWith(AndroidJUnit4.class)
public class GroupInstrumentedTest {


    @Test
    public void searchCustomerWithoutCreditApps() throws Exception {
        PersistenceGroup persistence = new PersistenceGroup();
        List<Group> result =  persistence.getAllWithoutCredit();
        assertNotNull(result);
        result = persistence.getAllWithoutCredit();
        Log.d("Result: "+result.toString());
        assertNotNull(result);
    }
}
