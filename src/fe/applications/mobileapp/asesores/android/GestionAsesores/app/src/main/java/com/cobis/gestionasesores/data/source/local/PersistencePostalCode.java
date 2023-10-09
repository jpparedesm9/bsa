package com.cobis.gestionasesores.data.source.local;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.persistence.EPersistenceConstraints;
import com.bayteq.libcore.persistence.EPersistenceFieldType;
import com.bayteq.libcore.persistence.EPersistenceOrderBy;
import com.bayteq.libcore.persistence.PersistenceField;
import com.bayteq.libcore.persistence.PersistenceWhereParameter;
import com.bayteq.libcore.persistence.internal.Cursor;
import com.bayteq.libcore.persistence.internal.PersistenceQueryListener;
import com.cobis.gestionasesores.data.enums.TerritorialOrganization;
import com.cobis.gestionasesores.data.models.PostalCode;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mnaunay on 08/06/2017.
 */

public class PersistencePostalCode extends Database {
    private static final String TABLE_NAME = "postal_code";
    private static final String FIELD_ID = "id";
    private static final String FIELD_PARENT = "parent";
    private static final String FIELD_POSTAL_CODE = "postal_code";
    private static final String FIELD_LEVEL = "level";
    private static final String FIELD_NAME = "name";
    private static final String FIELD_CODE = "code";

    public PersistencePostalCode() {
        if (!this.getPersistenceDAO().checkIfTableExists(TABLE_NAME)) {
            createTable();
        }
    }

    /**
     * Allows create table
     */
    private void createTable(){
        List<PersistenceField> fields = new ArrayList<>();
        fields.add(new PersistenceField(FIELD_ID, EPersistenceFieldType.PersistenceFieldTypeInteger, EPersistenceConstraints.PersistenceConstraintsPrimaryKey));
        fields.add(new PersistenceField(FIELD_PARENT, EPersistenceFieldType.PersistenceFieldTypeInteger));
        fields.add(new PersistenceField(FIELD_POSTAL_CODE, EPersistenceFieldType.PersistenceFieldTypeText));
        fields.add(new PersistenceField(FIELD_LEVEL, EPersistenceFieldType.PersistenceFieldTypeText));
        fields.add(new PersistenceField(FIELD_NAME, EPersistenceFieldType.PersistenceFieldTypeText));
        fields.add(new PersistenceField(FIELD_CODE, EPersistenceFieldType.PersistenceFieldTypeText));
        if(getPersistenceDAO().createTable(TABLE_NAME, fields)){
            getPersistenceDAO().createIndex(TABLE_NAME,FIELD_POSTAL_CODE,"");
        }
    }

    public List<PostalCode> getStates() {
        final List<PostalCode> result = new ArrayList<>();
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_LEVEL, TerritorialOrganization.STATE));
        whereParameters.add(new PersistenceWhereParameter(FIELD_NAME, PersistenceWhereParameter.NOT_EQUAL_OPERATOR, "", ""));
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASC, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parseToEntity(cursor));
            }
        });
        return result;
    }

    /**
     * Gets postal code list
     *
     * @param parent                  Postal code parent
     * @param territorialOrganization @{{@link TerritorialOrganization}}
     * @return List of postal codes
     */
    public List<PostalCode> getPostalCodes(int parent, @TerritorialOrganization String territorialOrganization) {
        final List<PostalCode> result = new ArrayList<>();
        if (parent >= 0) {
            List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
            whereParameters.add(new PersistenceWhereParameter(FIELD_LEVEL, territorialOrganization));
            whereParameters.add(new PersistenceWhereParameter(FIELD_PARENT, parent));
            whereParameters.add(new PersistenceWhereParameter(FIELD_NAME, PersistenceWhereParameter.NOT_EQUAL_OPERATOR, "", ""));
            getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASC, new PersistenceQueryListener() {
                @Override
                public void didReadRow(Cursor cursor, int i) {
                    result.add(parseToEntity(cursor));
                }
            });
        }
        return result;
    }

    /**
     * Gets postal code list
     *
     * @param postalCode
     * @return List of postal codes
     */
    public List<PostalCode> getVillagesByPostalCode(String postalCode) {
        final List<PostalCode> result = new ArrayList<>();
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_LEVEL, TerritorialOrganization.VILLAGE));
        whereParameters.add(new PersistenceWhereParameter(FIELD_POSTAL_CODE, postalCode));
        whereParameters.add(new PersistenceWhereParameter(FIELD_NAME, PersistenceWhereParameter.NOT_EQUAL_OPERATOR, "", ""));
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASC, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parseToEntity(cursor));
            }
        });
        return result;
    }

    /**
     * Gets postal code by identifier
     *
     * @param id Identifier
     * @return @{{@link PostalCode}}
     */
    public PostalCode getPostalCodeById(int id) {
        final List<PostalCode> result = new ArrayList<>();
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_ID, id));
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters, FIELD_NAME, EPersistenceOrderBy.PersistenceOrderByASC, new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parseToEntity(cursor));
            }
        });
        return result.isEmpty() ? null : result.get(0);
    }

    /**
     * Gets a postal code row by level of territorial organization and code (COBIS)
     * <p>State column has a Composite Code [code COBIS],[Code Sexpomex]</p>
     * @param level
     * @param code
     * @return
     */
    public PostalCode getPostalCodeByCode(@TerritorialOrganization String level, String code){
        final List<PostalCode> result = new ArrayList<>();
        List<PersistenceWhereParameter> whereParameters = new ArrayList<>();
        whereParameters.add(new PersistenceWhereParameter(FIELD_LEVEL, level));
        if(level==TerritorialOrganization.STATE){
            whereParameters.add(new PersistenceWhereParameter(FIELD_CODE,PersistenceWhereParameter.LIKE_OPERATOR,(code+",%"),null));
        }else{
            whereParameters.add(new PersistenceWhereParameter(FIELD_CODE,code));
        }
        getPersistenceDAO().queryRecords(TABLE_NAME, whereParameters,new PersistenceQueryListener() {
            @Override
            public void didReadRow(Cursor cursor, int i) {
                result.add(parseToEntity(cursor));
            }
        });
        return result.isEmpty() ? null : result.get(0);
    }

    /**
     * Count of records
     *
     * @return Integer
     */
    public int count() {
        try {
            return this.getPersistenceDAO().countRecords(TABLE_NAME);
        } catch (Exception ex) {
            Log.e("PersistencePostalCode::count: ", ex);
        }
        return 0;
    }

    /**
     * Allows delete table if exits and create
     */
    public void recreate() {
        if(getPersistenceDAO().checkIfTableExists(TABLE_NAME)) {
            getPersistenceDAO().dropTable(TABLE_NAME);
        }
        createTable();
    }

    /**
     * Allows to parse row table to entity
     *
     * @param cursor Row table
     * @return @{{@link PostalCode}}
     */
    private PostalCode parseToEntity(Cursor cursor) {
        return new PostalCode(
                cursor.getInt(cursor.getColumnIndex(FIELD_ID)),
                cursor.getInt(cursor.getColumnIndex(FIELD_PARENT)),
                cursor.getString(cursor.getColumnIndex(FIELD_NAME)),
                cursor.getString(cursor.getColumnIndex(FIELD_POSTAL_CODE)),
                cursor.getString(cursor.getColumnIndex(FIELD_CODE)));


    }
}
