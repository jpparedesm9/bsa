package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.source.PersonDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by mnaunay on 25/07/2017.
 */

public class SaveSectionUseCase extends UseCase<SaveSectionUseCase.SectionRequest, ResultData> {
    private PersonDataSource mPersonDataSource;

    public SaveSectionUseCase(PersonDataSource personDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPersonDataSource = personDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final SectionRequest parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                ResultData resultData;
                if (parameter.person != null) {
                    resultData = mPersonDataSource.saveSection(parameter.person, parameter.section, false);
                } else {
                    resultData = mPersonDataSource.saveSection(parameter.personId, parameter.section, false);
                }
                return resultData;
            }
        });
    }

    public static class SectionRequest {
        private Person person;
        private Section section;
        private int personId;

        public SectionRequest(Person person, Section section, int personId) {
            this.person = person;
            this.section = section;
            this.personId = personId;
        }
    }
}
