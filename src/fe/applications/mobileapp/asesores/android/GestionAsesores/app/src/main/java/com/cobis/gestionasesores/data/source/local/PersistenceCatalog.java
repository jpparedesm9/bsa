package com.cobis.gestionasesores.data.source.local;


import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.persistence.EPersistenceConstraints;
import com.bayteq.libcore.persistence.EPersistenceFieldType;
import com.bayteq.libcore.persistence.EPersistenceOrderBy;
import com.bayteq.libcore.persistence.PersistenceField;
import com.bayteq.libcore.persistence.PersistenceWhereParameter;
import com.bayteq.libcore.persistence.internal.Cursor;
import com.bayteq.libcore.persistence.internal.PersistenceQueryListener;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.source.CatalogDataSource;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;

import io.reactivex.Observable;

/**
 * Catalog
 * Created by mnaunay on 06/06/2017.
 */
public class PersistenceCatalog extends Database implements CatalogDataSource {
    private static final String TABLE_NAME = "item_catalog";
    private static final String FIELD_ID = "id";
    private static final String FIELD_CATALOG = "catalog";
    private static final String FIELD_CODE = "code";
    private static final String FIELD_VALUE = "value";

    public PersistenceCatalog() {
        super();
        if (!this.getPersistenceDAO().checkIfTableExists(TABLE_NAME)) {
            List<PersistenceField> fields = new ArrayList<>();
            fields.add(new PersistenceField(FIELD_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsPrimaryKey));
            fields.add(new PersistenceField(FIELD_CATALOG, EPersistenceFieldType.PersistenceFieldTypeChar, EPersistenceConstraints.PersistenceConstraintsNotNull));
            fields.add(new PersistenceField(FIELD_CODE, EPersistenceFieldType.PersistenceFieldTypeText));
            fields.add(new PersistenceField(FIELD_VALUE, EPersistenceFieldType.PersistenceFieldTypeText));

            if (this.getPersistenceDAO().createTable(TABLE_NAME, fields)) {
                this.getPersistenceDAO().createIndex(TABLE_NAME, FIELD_CATALOG, EPersistenceOrderBy.PersistenceOrderByASC);
            }
        }
    }

    public int count() {
        try {
            return this.getPersistenceDAO().countRecords(TABLE_NAME);
        } catch (Exception ex) {
            Log.e("PersistenceCatalog::count: ", ex);
        }
        return 0;
    }

    public void deleteRows(){
        getPersistenceDAO().deleteRecords(TABLE_NAME);
    }

    @Override
    public Observable<Map<Integer, List<CatalogItem>>> getCatalogItemsByCodes(final @Catalog int[] codes) {
        return Observable.fromCallable(new Callable<Map<Integer, List<CatalogItem>>>() {
            @Override
            public Map<Integer, List<CatalogItem>> call() throws Exception {
                Map<Integer, List<CatalogItem>> result = new HashMap<>();
                for (int code : codes) {
                    result.put(code, getCatalogItemsByCode(code));
                }
                return result;
            }
        });
    }

    @Override
    public Observable<List<CatalogItem>> search(final @Catalog int code, final String keyword) {
        return Observable.fromCallable(new Callable<List<CatalogItem>>() {
            @Override
            public List<CatalogItem> call() throws Exception {
                final List<CatalogItem> result = new ArrayList<>();

                List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
                whereParameters.add(new PersistenceWhereParameter(FIELD_CATALOG, code));
                if (!keyword.isEmpty()) {
                    whereParameters.add(new PersistenceWhereParameter(FIELD_VALUE, PersistenceWhereParameter.LIKE_OPERATOR, keyword, StringUtils.EMPTY));
                }

                getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters/* FIELD_VALUE, EPersistenceOrderBy.PersistenceOrderByASC*/, new PersistenceQueryListener() {
                    @Override
                    public void didReadRow(Cursor cursor, int i) {
                        result.add(parse(cursor));
                    }
                });

                return result;
            }
        });
    }

    @Override
    public Observable<CatalogItem> getCatalogItemByItemCode(final @Catalog int code,final String itemCode) {
        return Observable.fromCallable(new Callable<CatalogItem>() {
            @Override
            public CatalogItem call() throws Exception {
                final List<CatalogItem> result = new ArrayList<>();

                List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
                whereParameters.add(new PersistenceWhereParameter(FIELD_CATALOG, code));
                whereParameters.add(new PersistenceWhereParameter(FIELD_CODE, itemCode));

                getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, new PersistenceQueryListener() {
                    @Override
                    public void didReadRow(Cursor cursor, int i) {
                        result.add(parse(cursor));
                    }
                });

                return result.isEmpty()? null: result.get(0);
            }
        });
    }

    public List<CatalogItem> getCatalogItemsByCode(@Catalog int code) {
        final List<CatalogItem> result = new ArrayList<>();

        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_CATALOG, code));

        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters/*, FIELD_VALUE, EPersistenceOrderBy.PersistenceOrderByASC*/, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parse(cursor));
            }
        });
        return result;
    }

    private CatalogItem parse(Cursor cursor) {
        return new CatalogItem(
                cursor.getInt(cursor.getColumnIndex(FIELD_CATALOG)),
                cursor.getString(cursor.getColumnIndex(FIELD_CODE)),
                cursor.getString(cursor.getColumnIndex(FIELD_VALUE))
        );
    }
}
