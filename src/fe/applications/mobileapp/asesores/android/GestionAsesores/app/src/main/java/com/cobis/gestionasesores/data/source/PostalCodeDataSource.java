package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.enums.TerritorialOrganization;
import com.cobis.gestionasesores.data.models.PostalCode;

import java.util.List;
import java.util.Map;

import io.reactivex.Observable;

/**
 * Created by mnaunay on 08/06/2017.
 */

public interface PostalCodeDataSource {
    Observable<List<PostalCode>> getStates();
    Observable<List<PostalCode>> getTowns(int state);
    Observable<List<PostalCode>> getVillages(int town);
    Observable<Map<String,Object>> search(String postalCode);
    PostalCode getTerritorial(@TerritorialOrganization String level, String code);
}
