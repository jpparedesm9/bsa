package com.cobis.gestionasesores.data.repositories;

import com.cobis.gestionasesores.data.enums.TerritorialOrganization;
import com.cobis.gestionasesores.data.models.PostalCode;
import com.cobis.gestionasesores.data.source.PostalCodeDataSource;
import com.cobis.gestionasesores.data.source.local.PersistencePostalCode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;

import io.reactivex.Observable;

/**
 * Created by mnaunay on 08/06/2017.
 */

public class PostalCodeRepository implements PostalCodeDataSource {
    private static PostalCodeRepository INSTANCE;

    public static PostalCodeRepository getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new PostalCodeRepository();
        }
        return INSTANCE;
    }

    private PostalCodeRepository() {
    }

    @Override
    public Observable<List<PostalCode>> getStates() {
        return Observable.fromCallable(new Callable<List<PostalCode>>() {
            @Override
            public List<PostalCode> call() throws Exception {
                List<PostalCode> result = new ArrayList<>();
                PersistencePostalCode persistence = null;
                try {
                    persistence = new PersistencePostalCode();
                    result = persistence.getStates();
                } finally {
                    if (persistence != null) {
                        persistence.close();
                    }
                }
                return result;
            }
        });

    }

    @Override
    public Observable<List<PostalCode>> getTowns(final int state) {
        return Observable.fromCallable(new Callable<List<PostalCode>>() {
            @Override
            public List<PostalCode> call() throws Exception {
                List<PostalCode> result = new ArrayList<PostalCode>();
                PersistencePostalCode persistence = null;
                try {
                    persistence = new PersistencePostalCode();
                    result = persistence.getPostalCodes(state, TerritorialOrganization.TOWN);
                } finally {
                    if (persistence != null) {
                        persistence.close();
                    }
                }
                return result;
            }
        });

    }

    @Override
    public Observable<List<PostalCode>> getVillages(final int town) {
        return Observable.fromCallable(new Callable<List<PostalCode>>() {
            @Override
            public List<PostalCode> call() throws Exception {
                List<PostalCode> result = new ArrayList<PostalCode>();
                PersistencePostalCode persistence = null;
                try {
                    persistence = new PersistencePostalCode();
                    result = persistence.getPostalCodes(town, TerritorialOrganization.VILLAGE);
                } finally {
                    if (persistence != null) {
                        persistence.close();
                    }
                }
                return result;
            }
        });
    }


    @Override
    public Observable<Map<String, Object>> search(final String postalCode) {
        return Observable.fromCallable(new Callable<Map<String, Object>>() {
            @Override
            public Map<String, Object> call() throws Exception {
                Map<String, Object> result = null;
                PersistencePostalCode persistence = null;
                try {
                    persistence = new PersistencePostalCode();
                    List<PostalCode> villages = persistence.getVillagesByPostalCode(postalCode);
                    if (villages.size() > 0) {
                        PostalCode town = persistence.getPostalCodeById(villages.get(0).getParent());
                        PostalCode state = persistence.getPostalCodeById(town.getParent());
                        result = new HashMap<>();
                        result.put(TerritorialOrganization.STATE, state);
                        result.put(TerritorialOrganization.TOWN, town);
                        result.put(TerritorialOrganization.VILLAGE, villages);
                    }
                } finally {
                    if (persistence != null) {
                        persistence.close();
                    }
                }
                return result;
            }
        });
    }

    @Override
    public PostalCode getTerritorial(@TerritorialOrganization final String level, final String code) {
        PostalCode result = null;
        PersistencePostalCode persistence = null;
        try {
            persistence = new PersistencePostalCode();
            result = persistence.getPostalCodeByCode(level, code);
        } finally {
            if (persistence != null) {
                persistence.close();
            }
        }
        return result;
    }
}
