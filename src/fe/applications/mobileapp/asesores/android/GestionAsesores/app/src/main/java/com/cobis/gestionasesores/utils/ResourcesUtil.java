package com.cobis.gestionasesores.utils;

import android.support.annotation.DrawableRes;
import android.support.annotation.StringRes;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.enums.DocumentType;
import com.cobis.gestionasesores.data.enums.RiskLevel;
import com.cobis.gestionasesores.data.enums.SyncItemType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.widgets.GaugeView;

import static com.cobis.gestionasesores.data.enums.Catalog.CAT_ACTIVITY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CITY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CONTINENT;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_COUNTRY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_CURRENCY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_DATA_STATE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_DAY_OF_WEEK;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_JOB_TITLE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_NATIONALITY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_OCCUPATION;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_OFFICE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_PARISH;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_PRODUCT;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_PROVINCE;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_SEX;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_SUBSIDIARY;
import static com.cobis.gestionasesores.data.enums.Catalog.CAT_ZONE;

/**
 * Utility for resources: string, raw, colors, etc
 * Created by Miguel on 18/07/2017.
 */

public final class ResourcesUtil {
    private ResourcesUtil() {
    }

    public static
    @StringRes
    int getDocumentName(@DocumentType String documentType) {
        switch (documentType) {
            case DocumentType.AUTHORIZATION:
                return R.string.document_type_aut;
            case DocumentType.PROOF_ADDRESS:
                return R.string.document_type_bas;
            case DocumentType.FRONT_IDENTIFICATION:
                return R.string.document_type_id_front;
            case DocumentType.BACK_IDENTIFICATION:
                return R.string.document_type_id_back;
            case DocumentType.NOTICE_PRIVACY:
                return R.string.document_type_notice_privacy;
            case DocumentType.SHORT_REQUEST:
                return R.string.document_type_short_request;
            default:
                Log.e("ResourcesUtil:getDocumentName:Document type don't have resource: " + documentType);
                return 0;
        }
    }

    @DrawableRes
    public static int getDocumentStatusResource(int status) {
        switch (status) {
            case SyncStatus.SYNCED:
                return R.drawable.ic_sync_status_synced;
            case SyncStatus.PENDING:
                return R.drawable.ic_sync_status_pending;
            default:
                return R.drawable.ic_sync_status_pending;
        }
    }

    @DrawableRes
    public static int getSyncStatusResource(@SyncStatus int status) {
        switch (status) {
            case SyncStatus.DRAFT:
                return R.drawable.ic_sync_status_draft;
            case SyncStatus.PENDING:
                return R.drawable.ic_sync_status_pending;
            case SyncStatus.SYNCED:
                return R.drawable.ic_sync_status_synced;
            case SyncStatus.ERROR:
                return R.drawable.ic_sync_status_error;
            case SyncStatus.UNKNOWN:
                return R.drawable.ic_sync_status_unknown;
            default:
                Log.e("SyncStatus is not supported!! " + status);
                return -1;
        }
    }


    @StringRes
    public static int getCatalogName(@Catalog int code) {
        switch (code) {
            case CAT_ACTIVITY:
                return R.string.catalog_name_activity;
            case CAT_JOB_TITLE:
                return R.string.catalog_name_job_title;
            case CAT_SEX:
                return R.string.catalog_name_sex;
            case CAT_DAY_OF_WEEK:
                return R.string.catalog_name_day_of_week;
            case CAT_CONTINENT:
                return R.string.catalog_name_continent;
            case CAT_DATA_STATE:
                return R.string.catalog_name_data_state;
            case CAT_SUBSIDIARY:
                return R.string.catalog_name_subsidiary;
            case CAT_OFFICE:
                return R.string.catalog_name_office;
            case CAT_CURRENCY:
                return R.string.catalog_name_currency;
            case CAT_ZONE:
                return R.string.catalog_name_zone;
            case CAT_PRODUCT:
                return R.string.catalog_name_product;
            case CAT_COUNTRY:
                return R.string.catalog_name_country;
            case CAT_PROVINCE:
                return R.string.catalog_name_province;
            case CAT_CITY:
                return R.string.catalog_name_city;
            case CAT_PARISH:
                return R.string.catalog_name_parish;
            case CAT_OCCUPATION:
                return R.string.catalog_name_occupation;
            case CAT_NATIONALITY:
                return R.string.catalog_name_nationality;
            default:
                return 0;
        }
    }


    /**
     * Allows get string resource for risk level passed
     *
     * @param riskLevel Risk level
     * @return String resource
     */
    @StringRes
    public static int getRiskLevelStringResource(@RiskLevel String riskLevel) {
        switch (riskLevel) {
            case RiskLevel.LOW:
                return R.string.risk_level_low;
            case RiskLevel.MEDIUM:
                return R.string.risk_level_medium;
            case RiskLevel.HIGH:
                return R.string.risk_level_hight;
            default:
                throw new RuntimeException("Risk level resource not found: " + riskLevel);
        }
    }


    /**
     * Allows get item of the Gauge view to render
     *
     * @param riskLevel Risk level
     * @return GaugeView item render
     */
    public static @GaugeView.Item String getGaugeItemFromRiskLevel(@RiskLevel String riskLevel) {
        switch (riskLevel) {
            case RiskLevel.LOW:
                return GaugeView.FIRST_ITEM;
            case RiskLevel.MEDIUM:
                return GaugeView.SECOND_ITEM;
            case RiskLevel.HIGH:
                return GaugeView.THIRD_ITEM;
            default:
                throw new RuntimeException("Risk level resource not found: " + riskLevel);
        }
    }

    /**
     * Gets the correct string resource for a sync item type
     * @param syncItem sync item type
     * @return resource for that sync item type
     */
    @StringRes
    public static int getSyncItemResource(@SyncItemType int syncItem){
        switch (syncItem) {
            case SyncItemType.CUSTOMER:
                return R.string.synchronization_type_customers;
            case SyncItemType.PROSPECT:
                return R.string.synchronization_type_prospects;
            case SyncItemType.GROUP:
                return R.string.synchronization_type_groups;
            case SyncItemType.INDIVIDUAL_APPLICATION:
                return R.string.synchronization_type_individual_applications;
            case SyncItemType.GROUP_APPLICATION:
                return R.string.synchronization_type_group_applications;
            case SyncItemType.PAYMENT:
                return R.string.synchronization_type_payments;
            case SyncItemType.GROUP_VERIFICATION:
                return R.string.synchronization_type_group_verifications;
            case SyncItemType.INDIVIDUAL_VERIFICATION:
                return R.string.synchronization_type_individual_verifications;
            default:
               Log.e("Sync item resource not found: " + syncItem);
               return 0;
        }
    }
}
