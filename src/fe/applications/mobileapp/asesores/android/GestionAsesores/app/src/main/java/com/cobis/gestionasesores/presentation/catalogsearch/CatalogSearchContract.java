package com.cobis.gestionasesores.presentation.catalogsearch;

import android.support.annotation.NonNull;

import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

/**
 * Created by bqtdesa02 on 6/7/2017.
 */

public interface CatalogSearchContract {

    interface CatalogSearchView extends BaseView<CatalogSearchPresenter>{
        void showNoResultsFound();
        void showResults(List<CatalogItem> results);
        void showSearchError();
        void showTitle(@Catalog int code);
        void clearResults();
    }

    interface CatalogSearchPresenter extends BasePresenter{
        void onKeywordChange(@NonNull String keyword);
    }
}
