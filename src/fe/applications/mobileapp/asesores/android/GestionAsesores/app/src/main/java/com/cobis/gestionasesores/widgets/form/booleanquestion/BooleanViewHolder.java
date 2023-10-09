package com.cobis.gestionasesores.widgets.form.booleanquestion;

import android.content.Context;
import android.location.Location;
import android.support.v4.app.FragmentManager;
import android.view.View;
import android.widget.ImageView;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.QuestionAnswer;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.widgets.BooleanQuestionView;
import com.cobis.gestionasesores.widgets.GeoMapDialog;
import com.cobis.gestionasesores.widgets.form.QuestionAdapter;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by bqtdesa02 on 8/17/2017.
 */
public class BooleanViewHolder extends QuestionAdapter.QuestionViewHolder {

    public static final String GEO_MAP_DIALOG = "geo_map_dialog";

    @BindView(R.id.boolean_question)
    BooleanQuestionView mQuestionView;
    @BindView(R.id.img_geo)
    ImageView mGeoImg;
    public BooleanViewHolder(View itemView) {
        super(itemView);
        ButterKnife.bind(this, itemView);
    }

    @Override
    public void onBind(final Question question, final QuestionAdapter.QuestionListener questionListener, boolean showAnswers) {
        mQuestionView.setQuestion(question.getQuestion());
        Boolean check = null;
        if (StringUtils.isNotEmpty(question.getValue())) {
            check = QuestionAnswer.YES.equals(question.getValue());
        }
        mQuestionView.checkOption(check);
        mQuestionView.setOptionCheckListener(new BooleanQuestionView.OnOptionCheckListener() {
            @Override
            public void onCheck(@BooleanQuestionView.CheckOption int checkedOption) {
                String oldValue = question.getValue();
                question.setValue(checkedOption == BooleanQuestionView.CheckOption.POSITIVE ? QuestionAnswer.YES : QuestionAnswer.NO);
                questionListener.onQuestionValueChange(question, question.getValue(), oldValue);
            }
        });

        mGeoImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                questionListener.onGpsMapDialogClick(question);
            }
        });
        mQuestionView.setInteractiv(showAnswers);
    }

    @Override
    public void showError(boolean showError) {
        if (showError) {
            mQuestionView.showError(R.string.val_field_required);
        } else {
            mQuestionView.clearError();
        }
    }

    @Override
    public void showGeoReference(boolean shouldShow) {
        mGeoImg.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
    }
}