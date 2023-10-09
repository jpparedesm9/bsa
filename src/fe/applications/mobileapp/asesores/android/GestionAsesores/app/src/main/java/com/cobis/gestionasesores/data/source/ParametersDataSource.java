package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.models.Parameter;

import java.util.List;
import java.util.Map;

/**
 * Created by mnaunay on 26/06/2017.
 */

public interface ParametersDataSource {
    Map<String,String> getAll();

    void saveRemoteParameter(List<Parameter> parameterList);

    void clearValuesRemoteParameters();
}
