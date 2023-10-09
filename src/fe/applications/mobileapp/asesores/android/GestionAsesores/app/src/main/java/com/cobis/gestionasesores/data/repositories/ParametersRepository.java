package com.cobis.gestionasesores.data.repositories;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.models.Parameter;
import com.cobis.gestionasesores.data.source.ParametersDataSource;
import com.cobis.gestionasesores.data.source.local.PersistenceParameters;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Repository for access to applications parameters
 * Created by mnaunay on 26/06/2017.
 */

public class ParametersRepository implements ParametersDataSource {
    private static ParametersRepository sInstance;

    public static ParametersRepository getInstance() {
        if(sInstance == null){
            sInstance = new ParametersRepository();
        }
        return sInstance;
    }

    private ParametersRepository() {
    }

    @Override
    public Map<String, String> getAll() {
        Map<String, String> parameters = new HashMap<>();
        PersistenceParameters persistence = null;
        try
        {
            persistence = new PersistenceParameters();
            parameters = persistence.getAll();
        }catch (Exception ex){
            Log.e("ParametersRepository::getAll: ",ex);
        }finally {
            if(persistence != null){persistence.close();}
        }
        return parameters;
    }

    @Override
    public void saveRemoteParameter(List<Parameter> parameterList) {
        PersistenceParameters persistence = null;
        try
        {
            persistence = new PersistenceParameters();
            for (Parameter parameter : parameterList) {
                persistence.saveRemoteParameter(parameter);
            }
        }catch (Exception ex){
            Log.e("ParametersRepository::saveRemoteParameter: ",ex);
        }finally {
            if(persistence != null){persistence.close();}
        }
    }

    @Override
    public void clearValuesRemoteParameters() {
        PersistenceParameters persistence = null;
        try
        {
            persistence = new PersistenceParameters();
            persistence.clearValuesRemoteParameters();
        }catch (Exception ex){
            Log.e("ParametersRepository::clearRemoteParameters: ",ex);
        }finally {
            if(persistence != null){persistence.close();}
        }
    }
}
