package com.cobis.gestionasesores.presentation.person;

import android.support.annotation.NonNull;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.enums.PersonType;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SectionCode;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.mappers.PartnerDataMapper;
import com.cobis.gestionasesores.data.models.CustomerData;
import com.cobis.gestionasesores.data.models.PartnerData;
import com.cobis.gestionasesores.data.models.Person;
import com.cobis.gestionasesores.data.models.ProspectData;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Section;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.domain.usecases.ConvertToCustomerUserCase;
import com.cobis.gestionasesores.domain.usecases.GetPersonUseCase;
import com.cobis.gestionasesores.domain.usecases.ValidateProspectUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

public class PersonPresenter extends ErrorPresenter implements PersonContract.Presenter {
    private PersonContract.View mView;
    private int mPersonId;
    private int mPersonType;
    private Person mPerson;
    private GetPersonUseCase mGetPersonUseCase;
    private ValidateProspectUseCase mValidateProspectUseCase;
    private ConvertToCustomerUserCase mConvertToCustomerUseCase;

    public PersonPresenter(int personId, int personType, PersonContract.View view, ConvertToCustomerUserCase convertToCustomerUseCase, ValidateProspectUseCase validatorUseCase, GetPersonUseCase getPersonUseCase) {
        super(view);
        mPersonId = personId;
        mPersonType = personType;
        mView = view;
        mConvertToCustomerUseCase = convertToCustomerUseCase;
        mValidateProspectUseCase = validatorUseCase;
        mGetPersonUseCase = getPersonUseCase;
        mView.setPresenter(this);
    }

    @Override
    public void start() {
        loadPerson(mPersonId, mPersonType);
    }

    @Override
    public void onSectionSelected(Section section) {
        switch (section.getCode()) {
            case SectionCode.CUSTOMER_DATA:
                mView.startCustomerDataSection(mPerson);
                break;
            case SectionCode.PARTNER_DATA:
                if (mPerson.getSpouseId() <= 0 && section.getSectionData() == null) {
                    mView.showPartnerDialog();
                } else {
                    mView.startPartnerDataSection(mPerson.getId(), section);
                }
                break;
            case SectionCode.CUSTOMER_BUSINESS:
                mView.startCustomerBusinessSection(mPerson.getId(), section, mView.getCustomerAddressData());
                break;
            case SectionCode.CUSTOMER_REFERENCES:
                mView.startReferencesDataActivity(mPerson.getId(), section);
                break;
            case SectionCode.CUSTOMER_PAYMENTS:
                double otherIncome = 0;
                Section generalSection = Person.getSection(SectionCode.CUSTOMER_DATA, mPerson.getSections());
                if (generalSection != null && generalSection.getSectionData() != null) {
                    CustomerData customerData = (CustomerData) generalSection.getSectionData();
                    otherIncome = customerData.getOtherIncomeSourcesAmount();
                }
                mView.startCustomerPaymentSection(mPerson.getId(), section, otherIncome);
                break;
            case SectionCode.CUSTOMER_ADDRESS:
                mView.startCustomerAddressSection(mPerson.getId(), section);
                break;
            case SectionCode.PARTNER_WORK:
                mView.startPartnerWorkSection(mPerson.getId(), section);
                break;
            case SectionCode.CUSTOMER_DOCUMENTS:
                mView.startDocumentsSection(mPerson.getId(), section);
                break;
            case SectionCode.PROSPECT_DATA:
                mView.startProspectData(mPerson);
                break;
            case SectionCode.COMPLEMENTARY_DATA:
                mView.startComplementaryDataSection(mPerson.getId(), section);
                break;
        }
    }

    @Override
    public void onSectionChangedResult(int personId) {
        loadPerson(personId, mPersonType);
    }

    @Override
    public void onClickDelete() {
        mView.showAlertDelete(mPerson.getType());
    }

    @Override
    public void doDelete() {
        PersonRepository.getInstance().delete(mPerson.getId()).subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()).subscribeWith(new DisposableObserver<Boolean>() {
            @Override
            public void onNext(@io.reactivex.annotations.NonNull Boolean aBoolean) {
                mView.showMessageDeleteSuccess(mPerson.getType());
                mView.closeAndExit();
            }

            @Override
            public void onError(@io.reactivex.annotations.NonNull Throwable e) {
                mView.showMessageFail();
                mView.closeAndExit();
            }

            @Override
            public void onComplete() {

            }
        });
    }

    @Override
    public void convertToCustomer() {
        if (NetworkUtils.isOnline()) {
            mView.showConvertProgress();
            mConvertToCustomerUseCase.execute(mPerson.getId(), new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData data) {
                    if (data.getType() == ResultType.SUCCESS) {
                        mView.showConvertOption(false);
                        Person person = (Person) data.getData();
                        loadPerson(person.getId(), person.getType());
                    } else {
                        if (data.getData() != null) {
                            mView.showErrorConvertToCustomer();
                        } else {
                            mView.showValidateError(data.getErrorMessage());
                        }
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    mView.dismissProgress();
                    mView.showErrorConvertToCustomer();
                }

                @Override
                public void onComplete() {
                    mView.dismissProgress();
                }
            });
        } else {
            mView.showNotNetworkConnection();
        }
    }

    @Override
    public void onClickValidateProspect() {
        if (NetworkUtils.isOnline()) {
            mView.showValidateProgress();
            mValidateProspectUseCase.execute(mPerson.getId(), new DisposableObserver<ResultData>() {
                @Override
                public void onNext(@NonNull ResultData resultDomain) {
                    boolean isValidated = (resultDomain.getType() == ResultType.SUCCESS);
                    mView.showValidationLabel(isValidated);

                    if (isValidated) {
                        mView.showValidateSuccess(resultDomain.getErrorMessage());
                        mView.showValidateOption(false);
                        mView.showConvertOption(true);
                    } else {
                        if (resultDomain.getData() != null) {
                            mView.showNoValidateError();
                        } else {
                            mView.showValidateError(resultDomain.getErrorMessage());
                        }
                    }
                }

                @Override
                public void onError(@NonNull Throwable e) {
                    mView.dismissProgress();
                    mView.showValidationLabel(false);
                    if (Util.isNetworkError(e)) {
                        mView.showNetworkError();
                    } else {
                        mView.showValidateError(null);
                    }
                }

                @Override
                public void onComplete() {
                    mView.dismissProgress();
                }
            });
        } else {
            mView.showNotNetworkConnection();
        }
    }

    @Override
    public void onClickCreateNewPartner() {
        mView.startPartnerDataSection(mPerson.getId(), Person.getSection(SectionCode.PARTNER_DATA, mPerson.getSections()));
    }

    @Override
    public void onClickSelectPartner() {
        mView.goToSelectPartner(mPerson.getId());
    }

    @Override
    public void onSelectPartner(Person person) {
        PartnerData partnerData = null;
        switch (person.getType()) {
            case PersonType.PROSPECT:
                ProspectData prospectData = (ProspectData) Person.getSection(SectionCode.PROSPECT_DATA, person.getSections()).getSectionData();
                partnerData = PartnerDataMapper.fromProspectData(prospectData);
                break;
            case PersonType.CUSTOMER:
                CustomerData customerData = (CustomerData) Person.getSection(SectionCode.CUSTOMER_DATA, person.getSections()).getSectionData();
                partnerData = new PartnerData.Builder().addGeneralPersonData(customerData.getGeneralPersonData()).build();
                break;
            case PersonType.UNKNOWN:
            default:
                Log.e("Unknown person type!");

        }
        if (partnerData != null) {
            partnerData.setServerId(person.getServerId());
        }
        Section section = Person.getSection(SectionCode.PARTNER_DATA, mPerson.getSections());
        section.setSectionData(partnerData);
        mView.startPartnerDataSection(mPerson.getId(), section);
    }

    private void loadPerson(int personId, int personType) {
        mView.showLoadingProgress();
        mView.toggleDeleteOption(false);
        mGetPersonUseCase.execute(new GetPersonUseCase.GetPersonRequest(personId, personType), new DisposableObserver<Person>() {
            @Override
            public void onNext(@NonNull Person person) {
                mPerson = person;
                mPersonType = person.getType();
                initPerson(mPerson);
            }

            @Override
            public void onError(@NonNull Throwable e) {
                mView.dismissProgress();
                Log.e("PersonPresenter: loadPerson: Error loading person! ", e);
            }

            @Override
            public void onComplete() {
                mView.dismissProgress();
            }
        });
    }

    private void initPerson(Person person) {
        mView.showPersonName(person.getName());
        mView.toggleDeleteOption(person.getId() > 0 && person.getServerId() <= 0);
        mView.showSections(person.getSections());
        mView.showTitle(person.getType());
        if (person.getType() == PersonType.PROSPECT && person.getServerId() > 0) {
            mView.showValidationLabel(person.isValidated());
            mView.showValidateOption((person.getStatus() == SyncStatus.SYNCED || person.getStatus() == SyncStatus.PENDING) && !person.isValidated());
            mView.showConvertOption(person.isValidated());
        } else {
            mView.hideValidationLabel();
        }
        checkError(person);
    }
}