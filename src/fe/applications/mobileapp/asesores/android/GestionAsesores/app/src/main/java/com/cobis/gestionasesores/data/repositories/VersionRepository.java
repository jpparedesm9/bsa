package com.cobis.gestionasesores.data.repositories;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.VersionConcept;
import com.cobis.gestionasesores.data.source.local.PersistenceVersion;

/**
 * Created by Miguel on 18/06/2017.
 */

public class VersionRepository {
    private static VersionRepository sInstance;

    public static VersionRepository getInstance() {
        if(sInstance == null){
            sInstance = new VersionRepository();
        }
        return sInstance;
    }

    private VersionRepository(){}

    public void updateVersion(@VersionConcept String concept, int version){
        PersistenceVersion persistence=null;
        try
        {
            persistence = new PersistenceVersion();
            if(persistence.count(concept)==0){
                persistence.addVersion(concept,version);
            }else{
                persistence.update(concept,version);
            }
        }catch (Exception ex){
            Log.d("VersionRepository::updateVersion: ",ex);
        }finally {
            if(persistence != null){
                persistence.close();
            }
        }
    }

    public int getVersion(@VersionConcept String concept){
        PersistenceVersion persistence=null;
        int version = -1;
        try
        {
            persistence = new PersistenceVersion();
            version = persistence.getVersionValue(concept);
        }catch (Exception ex){
            Log.e("VersionRepository::getVersion: ",ex);
        }finally {
            if(persistence != null){
                persistence.close();
            }
        }
        return version;
    }


}
