package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.enums.DocumentType;
import com.cobis.gestionasesores.data.models.DocumentsData;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.DocumentDataSource;
import com.cobis.gestionasesores.data.source.PersonDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by mnaunay on 14/07/2017.
 */

public class SaveDocumentUseCase extends UseCase<SaveDocumentUseCase.Params,ResultData> {
    private DocumentDataSource mDocumentDataSource;
    private PersonDataSource mPersonDataSource;

    public SaveDocumentUseCase(DocumentDataSource documentDataSource, PersonDataSource personDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mDocumentDataSource = documentDataSource;
        mPersonDataSource = personDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Params parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                return mDocumentDataSource.saveDocument(parameter.personId,parameter.data,parameter.type);
            }
        });
    }

    public static class Params{
        private int personId;
        private DocumentsData data;
        private @DocumentType String type;

        public Params(int personId, DocumentsData data, String type) {
            this.personId = personId;
            this.data = data;
            this.type = type;
        }
    }
}