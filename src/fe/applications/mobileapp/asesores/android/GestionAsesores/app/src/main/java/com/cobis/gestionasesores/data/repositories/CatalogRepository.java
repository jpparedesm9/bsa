package com.cobis.gestionasesores.data.repositories;

import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.source.CatalogDataSource;
import com.cobis.gestionasesores.data.source.local.PersistenceCatalog;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.reactivex.Observable;

/**
 * Created by bqtdesa02 on 6/6/2017.
 */

public class CatalogRepository implements CatalogDataSource {

    private static CatalogRepository INSTANCE;

    public static CatalogRepository getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new CatalogRepository();
        }
        return INSTANCE;
    }

    private CatalogRepository() {
    }

    @Override
    public Observable<Map<Integer, List<CatalogItem>>> getCatalogItemsByCodes(@Catalog int[] codes) {
        PersistenceCatalog persistenceCatalog = new PersistenceCatalog();
        return persistenceCatalog.getCatalogItemsByCodes(codes);
    }

    @Override
    public List<CatalogItem> getCatalogItemsByCode(@Catalog int code) {
        PersistenceCatalog persistence = null;
        List<CatalogItem> result  = new ArrayList<>();
        try {
            persistence = new PersistenceCatalog();
            result = persistence.getCatalogItemsByCode(code);
        }finally {
            if(persistence!= null){
                persistence.close();
            }
        }
        return result;
    }

    @Override
    public Observable<List<CatalogItem>> search(@Catalog int code, String keyword) {
        PersistenceCatalog persistenceCatalog = new PersistenceCatalog();
        return persistenceCatalog.search(code, keyword);
    }

    @Override
    public Observable<CatalogItem> getCatalogItemByItemCode(@Catalog int code, String itemCode) {
        PersistenceCatalog persistenceCatalog = new PersistenceCatalog();
        return persistenceCatalog.getCatalogItemByItemCode(code, itemCode);
    }
}
