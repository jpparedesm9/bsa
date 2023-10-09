package com.cobis.gestionasesores.widgets.form.singlechoice;

import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Question;
import com.cobis.gestionasesores.widgets.form.QuestionAdapter;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by bqtdesa02 on 8/17/2017.
 */

public class SingleChoiceViewHolder extends QuestionAdapter.QuestionViewHolder {

    private TextView mQuestionText;
    private Spinner mQuestionSpinner;
    private SingleQuestionAdapter mAdapter;

    @BindView(R.id.img_geo)
    ImageView mGeoImg;

    public SingleChoiceViewHolder(View itemView) {
        super(itemView);
        ButterKnife.bind(this, itemView);
        mQuestionSpinner = itemView.findViewById(R.id.spinner_options);
        mQuestionText = itemView.findViewById(R.id.text_question);
        mAdapter = new SingleQuestionAdapter(itemView.getContext(), android.R.layout.simple_spinner_item);
        mQuestionSpinner.setAdapter(mAdapter);
    }

    @Override
    public void onBind(final Question question, final QuestionAdapter.QuestionListener questionListener, boolean showAnswers) {
        mQuestionText.setText(question.getQuestion());
        mAdapter.setQuestions(question.getOptions());
        mQuestionSpinner.setSelection(mAdapter.getItemPositionByCode(question.getValue()));
        mQuestionSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String oldValue = question.getValue();
                question.setValue(mAdapter.getItemCode(position));
                questionListener.onQuestionValueChange(question, question.getValue(), oldValue);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });

        mGeoImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                questionListener.onGpsMapDialogClick(question);
            }
        });
        if (!showAnswers){
            mQuestionSpinner.setVisibility(View.GONE);
        }
    }

    @Override
    public void showError(boolean showError) {
        if(showError){
            mAdapter.showError(R.string.val_field_required);
        }else{
            mQuestionText.setError(null);
        }
    }

    @Override
    public void showGeoReference(boolean shouldShow) {
        mGeoImg.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
        mQuestionSpinner.setVisibility(shouldShow? View.GONE : View.VISIBLE);
    }
}