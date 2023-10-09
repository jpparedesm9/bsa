package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.SectionData;
import com.cobis.gestionasesores.data.source.PersonDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 7/24/2017.
 */

public class GetSectionDataUseCase extends UseCase<GetSectionDataUseCase.GetSectionRequest,SectionData> {
    private final PersonDataSource mPersonDataSource;

    public GetSectionDataUseCase(PersonDataSource personDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPersonDataSource = personDataSource;
    }

    @Override
    protected Observable<SectionData> createObservableUseCase(final GetSectionRequest parameter) {
        return Observable.fromCallable(new Callable<SectionData>() {
            @Override
            public SectionData call() throws Exception {
                return mPersonDataSource.getSectionData(parameter.personId,parameter.sectionCode,parameter.tryOnline);

            }
        });
    }

    public static class GetSectionRequest{
        private int personId;
        private String sectionCode;
        private boolean tryOnline;

        public GetSectionRequest(int personId, String sectionCode, boolean tryOnline) {
            this.personId = personId;
            this.sectionCode = sectionCode;
            this.tryOnline = tryOnline;
        }
    }
}
