package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.MemberCreditApp;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.source.PersonDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 10/16/2017.
 */

public class GetCompleteMemberCreditUseCase extends UseCase<MemberCreditApp,MemberCreditApp> {

    private PersonDataSource mPersonDataSource;

    public GetCompleteMemberCreditUseCase(PersonDataSource personDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mPersonDataSource = personDataSource;
    }

    @Override
    protected Observable<MemberCreditApp> createObservableUseCase(final MemberCreditApp parameter) {
        return Observable.fromCallable(new Callable<MemberCreditApp>() {
            @Override
            public MemberCreditApp call() throws Exception {
                Person person  = mPersonDataSource.getPersonByServerId(parameter.getCustomerServerId());
                if(person != null){
                    Section section = Person.getSection(SectionCode.CUSTOMER_DATA,person.getSections());
                    if(section != null && section.getSectionData() != null){
                        CustomerData customerData = (CustomerData) section.getSectionData();
                        parameter.setCustomerNumber(customerData.getCustomerNumber());
                    }
                }
                return parameter;
            }
        });
    }
}
