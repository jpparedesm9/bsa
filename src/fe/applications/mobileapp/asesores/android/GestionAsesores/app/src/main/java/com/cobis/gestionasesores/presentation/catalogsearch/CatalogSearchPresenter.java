package com.cobis.gestionasesores.presentation.catalogsearch;

import android.support.annotation.NonNull;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;

import java.util.List;
import java.util.concurrent.TimeUnit;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 6/7/2017.
 */

public class CatalogSearchPresenter implements CatalogSearchContract.CatalogSearchPresenter {

    private static final int DEBOUNCE_TIME = 50; //milliseconds

    private CatalogSearchContract.CatalogSearchView mView;

    private int mCatalogCode;

    public CatalogSearchPresenter(CatalogSearchContract.CatalogSearchView view, int catalogCode) {
        mView = view;
        mCatalogCode = catalogCode;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mView.showTitle(mCatalogCode);
        search(StringUtils.EMPTY);
    }

    @Override
    public void onKeywordChange(@NonNull String keyword) {
        search(keyword);
    }

    private void search(String keyword){
        CatalogRepository.getInstance().search(mCatalogCode, keyword)
                .debounce(DEBOUNCE_TIME, TimeUnit.MILLISECONDS)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<List<CatalogItem>>() {
                    @Override
                    public void onNext(@NonNull List<CatalogItem> catalogItems) {
                        if(catalogItems.isEmpty()){
                            mView.clearResults();
                            mView.showNoResultsFound();
                        }else{
                            mView.showResults(catalogItems);
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        mView.clearResults();
                        mView.showSearchError();
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }
}
