package com.cobis.gestionasesores.data.models;

import org.junit.Test;

/**
 * Created by mnaunay on 04/08/2017.
 */

public class ReferenceUniTest {

    @Test
    public void testReferences(){
        ReferencesData local = new ReferencesData();
        local.getReferences().add(new Reference.Builder().setName("Ref001").setServerId(0).build());
        local.getReferences().add(new Reference.Builder().setName("Ref006").setServerId(0).build());


        ReferencesData remote = new ReferencesData();
        remote.getReferences().add(new Reference.Builder().setName("Ref001").setServerId(10).build());
        remote.getReferences().add(new Reference.Builder().setName("Ref002").setServerId(4).build());

        ReferencesData result = remote.merge(local);
        for(Reference ref:result.getReferences()){
            System.out.println(ref.getName()+ " "+ref.getServerId());
        }
    }
}
