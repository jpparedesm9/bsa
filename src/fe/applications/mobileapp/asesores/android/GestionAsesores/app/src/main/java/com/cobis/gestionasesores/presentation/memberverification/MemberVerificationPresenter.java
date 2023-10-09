package com.cobis.gestionasesores.presentation.memberverification;

import android.location.Location;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.QuestionLocationCode;
import com.cobis.gestionasesores.data.enums.QuestionType;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.models.MemberVerification;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.requests.GeoReference;
import com.cobis.gestionasesores.domain.usecases.SaveMemberVerificationUseCase;
import com.cobis.gestionasesores.presentation.error.ErrorPresenter;
import com.cobis.gestionasesores.utils.Util;
import com.cobis.gestionasesores.widgets.GeoReferenceDialog;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import io.reactivex.annotations.NonNull;
import io.reactivex.observers.DisposableObserver;

public class MemberVerificationPresenter extends ErrorPresenter implements MemberVerificationContract.Presenter, GeoReferenceDialog.GeoReferenceListener {
    private MemberVerificationContract.View mView;
    private int mVerificationId;
    private MemberVerification mMember;
    private SaveMemberVerificationUseCase mSaveMemberVerificationUseCase;

    private boolean mIsSaved = true;

    private Question mGeoReferenceQuestion;
    private String mGeoReferenceOldValue;

    public MemberVerificationPresenter(MemberVerificationContract.View view, int verificationId, MemberVerification member, SaveMemberVerificationUseCase saveMemberVerificationUseCase) {
        super(view);
        mView = view;
        mVerificationId = verificationId;
        mMember = member;
        mSaveMemberVerificationUseCase = saveMemberVerificationUseCase;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mView.showName(mMember.getName());
        mView.showQuestions(sortQuestions(mMember.getQuestions()));
        mView.hideActions(mMember.getStatus() != SyncStatus.SYNCED);
        checkError(mMember);
    }

    @Override
    public void onSave(List<Question> questions) {
        if (validateQuestions(questions, true)) {
            save(questions, SyncStatus.PENDING, true, true);
        }
    }

    @Override
    public void onSaveDraft(List<Question> questions, boolean exit) {
        mIsSaved = true;
        save(questions, validateQuestions(questions, false) ? SyncStatus.PENDING : SyncStatus.DRAFT, false, exit);
    }

    @Override
    public void onChangeQuestion(Question question, String newValue, String oldValue) {
        if (valuesChanged(newValue, oldValue)) {
            mIsSaved = false;
            if (question.needGeo()) {
                mGeoReferenceQuestion = question;
                mGeoReferenceOldValue = oldValue;
                mView.requestGeoReference(this);
            }
        }
    }

    @Override
    public void onTryToExit() {
        if (!mIsSaved) {
            mView.showConfirmSaveChanges();
        } else {
            mView.sendResult();
        }
    }

    @Override
    public void onGpsMapDialogClick(Question question) {
        switch (question.getCode()) {
            case QuestionLocationCode.GROUP_QUESTION6: //question related with home
                mView.showGpsMapDialog(question, mMember.getHomeAddressGeoReference());
                break;
            case QuestionLocationCode.GROUP_QUESTION12: //question related with bussines
                mView.showGpsMapDialog(question, mMember.getBusinessAddressGeoReference());
                break;
            default:
                mView.showGeoLocationError();
                break;
        }
    }

    @Override
    public void activateQuestion(Question question) {

    }

    @Override
    public void updateQuestionGeoreference(Question question, Location markLocation, Location officialLocation) {

        if (mMember.getBusinessAddressGeoReference().getLatitude() == mMember.getHomeAddressGeoReference().getLatitude()
                && mMember.getBusinessAddressGeoReference().getLongitude() == mMember.getHomeAddressGeoReference().getLongitude()){
            mMember.getHomeAddressGeoReference().setLatitude(markLocation.getLatitude());
            mMember.getHomeAddressGeoReference().setLongitude(markLocation.getLongitude());
            mMember.addGeoReference(QuestionLocationCode.GROUP_QUESTION6, mMember.getHomeAddressGeoReference());
            mMember.getBusinessAddressGeoReference().setLatitude(markLocation.getLatitude());
            mMember.getBusinessAddressGeoReference().setLongitude(markLocation.getLongitude());
            mMember.addGeoReference(QuestionLocationCode.GROUP_QUESTION12, mMember.getBusinessAddressGeoReference());

            GeoReference officialLocationData;
            switch (question.getCode()) {
                case QuestionLocationCode.GROUP_QUESTION6: //question related with home
                    officialLocationData = mMember.getHomeAddressGeoReference();
                    officialLocationData.setLatitude(officialLocation.getLatitude());
                    officialLocationData.setLongitude(officialLocation.getLongitude());
                    mMember.setOfficialGeoReference(officialLocationData);
                    break;
                case QuestionLocationCode.GROUP_QUESTION12: //question related with bussines
                    officialLocationData = mMember.getHomeAddressGeoReference();
                    officialLocationData.setLatitude(officialLocation.getLatitude());
                    officialLocationData.setLongitude(officialLocation.getLongitude());
                    mMember.setOfficialGeoReference(officialLocationData);
                    break;
                default:
                    mView.showGeoLocationError();
                    break;
            }
            mView.activateGpsQuestions();
            return;
        }else {
            GeoReference officialLocationData = new GeoReference();
            officialLocationData.setLatitude(officialLocation.getLatitude());
            officialLocationData.setLongitude(officialLocation.getLongitude());
            switch (question.getCode()) {
                case QuestionLocationCode.GROUP_QUESTION6: //question related with home
                    mMember.getHomeAddressGeoReference().setLatitude(markLocation.getLatitude());
                    mMember.getHomeAddressGeoReference().setLongitude(markLocation.getLongitude());
                    officialLocationData.setAddressId(mMember.getHomeAddressGeoReference().getAddressId());
                    break;
                case QuestionLocationCode.GROUP_QUESTION12: //question related with bussines
                    mMember.getBusinessAddressGeoReference().setLatitude(markLocation.getLatitude());
                    mMember.getBusinessAddressGeoReference().setLongitude(markLocation.getLongitude());
                    officialLocationData.setAddressId(mMember.getBusinessAddressGeoReference().getAddressId());
                    break;
                default:
                    mView.showGeoLocationError();
                    break;
            }
            mMember.addGeoReference(QuestionLocationCode.GROUP_QUESTION6, mMember.getHomeAddressGeoReference());
            mMember.addGeoReference(QuestionLocationCode.GROUP_QUESTION12, mMember.getBusinessAddressGeoReference());
            mMember.setOfficialGeoReference(officialLocationData);
        }
    }

    @Override
    public void setGpsToQuestion(Question question) {
        mIsSaved = false;
        if (question.needGeo()) {
            mGeoReferenceQuestion = question;
            mView.requestGeoReference(this);
        }
    }

    private void save(List<Question> questions, int status, final boolean tryOnline, final boolean exit) {
        mView.showSaveProgress();
        mMember.setQuestions(questions);
        mMember.setStatus(status);
        mSaveMemberVerificationUseCase.execute(new SaveMemberVerificationUseCase.Params(mVerificationId, mMember, tryOnline), new DisposableObserver<ResultData>() {
            @Override
            public void onNext(@NonNull ResultData resultData) {
                if (resultData.getType() == ResultType.SUCCESS) {
                    mView.showSaveSuccess(resultData.getErrorMessage(), exit);
                    if (exit && resultData.getErrorMessage() == null) {
                        mView.sendResult();
                    }
                } else {
                    mView.showSaveError(resultData.getErrorMessage());
                }
            }

            @Override
            public void onError(@NonNull Throwable e) {
                Log.e("MemberVerificationPresenter: Error saving verification! ", e);
                mView.hideSaveProgress();
                if (Util.isNetworkError(e)) {
                    mView.showNetworkError();
                } else {
                    mView.showSaveError(null);
                }
            }

            @Override
            public void onComplete() {
                mView.hideSaveProgress();
            }
        });
    }

    private boolean validateQuestions(List<Question> questions, boolean showErrors) {
        mView.clearErrors();
        String errorCode = null;
        for (Question question : questions) {
            if (question.getType() != QuestionType.HEADER && question.isActive() && StringUtils.isEmpty(question.getValue())) {
                if (errorCode == null) {
                    errorCode = question.getCode();
                }
                if (showErrors) {
                    mView.showQuestionError(question.getCode());
                }
            }
        }

        if (errorCode != null && showErrors) {
            mView.viewQuestion(errorCode);
        }

        return errorCode == null;
    }

    public boolean valuesChanged(String newValue, String oldValue) {
        return !(newValue == null && oldValue == null) && ((newValue == null) || !newValue.equals(oldValue));
    }

    @Override
    public void onLocationFound(double lat, double lng) {
        if (mGeoReferenceQuestion != null) {
            Location userLocation = new Location("");
            userLocation.setLatitude(lat);
            userLocation.setLongitude(lng);

            Location questionLocation = new Location("");
            switch (mGeoReferenceQuestion.getCode()) {
                case QuestionLocationCode.GROUP_QUESTION6: //question related with home
                    questionLocation.setLatitude(mMember.getHomeAddressGeoReference().getLatitude());
                    questionLocation.setLongitude(mMember.getHomeAddressGeoReference().getLongitude());
                    if (userLocation.distanceTo(questionLocation) <= BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.ALLOWEDDISTANCE)){
                        mMember.addGeoReference(mGeoReferenceQuestion.getCode(), mMember.getHomeAddressGeoReference());
                        updateQuestionGeoreference(mGeoReferenceQuestion, questionLocation, userLocation);
                        mView.activateQuestion(mGeoReferenceQuestion);
                        mGeoReferenceQuestion = null;
                        mGeoReferenceOldValue = null;
                    }else {
//                        mView.showGpsIsTooFar(userLocation, questionLocation, BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.ALLOWEDDISTANCE), userLocation.distanceTo(questionLocation), "home");
                        mView.showGpsIsTooFar(userLocation, questionLocation);
                    }
                    break;
                case QuestionLocationCode.GROUP_QUESTION12: //question related with bussines
                    questionLocation.setLatitude(mMember.getBusinessAddressGeoReference().getLatitude());
                    questionLocation.setLongitude(mMember.getBusinessAddressGeoReference().getLongitude());
                    if (userLocation.distanceTo(questionLocation) <= BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.ALLOWEDDISTANCE)){
                        mMember.addGeoReference(mGeoReferenceQuestion.getCode(), mMember.getBusinessAddressGeoReference());
                        updateQuestionGeoreference(mGeoReferenceQuestion, questionLocation, userLocation);
                        mView.activateQuestion(mGeoReferenceQuestion);
                        mGeoReferenceQuestion = null;
                        mGeoReferenceOldValue = null;
                    }else {
//                        mView.showGpsIsTooFar(userLocation, questionLocation, BankAdvisorApp.getInstance().getConfig().getInteger(Parameters.ALLOWEDDISTANCE), userLocation.distanceTo(questionLocation), "bussines");
                        mView.showGpsIsTooFar(userLocation, questionLocation);
                    }
                    break;
                default:
                    mView.showGeoLocationError();
                    break;
            }
        }
    }

    @Override
    public void onCancel() {
        if (mGeoReferenceQuestion != null) {
            mGeoReferenceQuestion.setValue(mGeoReferenceOldValue);
            mView.updateQuestion(mGeoReferenceQuestion);
            mGeoReferenceQuestion = null;
            mGeoReferenceOldValue = null;
        }
    }

    private List<Question> sortQuestions(List<Question> questions) {
        Collections.sort(questions, new Comparator<Question>() {
            @Override
            public int compare(Question o1, Question o2) {
                if (o1.getPosition() == o2.getPosition()) {
                    return 0;
                } else if (o1.getPosition() < o2.getPosition()) {
                    return -1;
                } else {
                    return 1;
                }
            }
        });
        return questions;
    }
}