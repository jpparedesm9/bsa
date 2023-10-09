package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.models.CatalogItem;

import java.util.List;
import java.util.Map;

import io.reactivex.Observable;

/**
 * Created by bqtdesa02 on 6/6/2017.
 */

public interface CatalogDataSource {
    Observable<Map<Integer,List<CatalogItem>>> getCatalogItemsByCodes(@Catalog int[] codes);
    Observable<List<CatalogItem>> search(@Catalog int code, String keyword);
    Observable<CatalogItem> getCatalogItemByItemCode(@Catalog int code, String itemCode);
    List<CatalogItem> getCatalogItemsByCode(@Catalog int code);
}
