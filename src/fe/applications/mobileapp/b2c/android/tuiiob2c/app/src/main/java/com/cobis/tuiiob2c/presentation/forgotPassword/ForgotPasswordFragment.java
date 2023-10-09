package com.cobis.tuiiob2c.presentation.forgotPassword;


import android.app.DatePickerDialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.text.InputType;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.data.models.Answer;
import com.cobis.tuiiob2c.data.models.Question;
import com.cobis.tuiiob2c.data.models.ViewQuestionModel;
import com.cobis.tuiiob2c.presentation.resetPassword.ResetPasswordActivity;
import com.cobis.tuiiob2c.root.App;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * A simple {@link Fragment} subclass.
 */
public class ForgotPasswordFragment extends Fragment implements ForgotPasswordMVP.ForgotPasswordView {

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.linearlayout)
    LinearLayout mMainLinearLayout;
    List<ViewQuestionModel> answersViews = new ArrayList<>();
    Calendar myCalendar = Calendar.getInstance();
    EditText auxEditText;
    @Inject
    public ForgotPasswordMVP.ForgotPasswordPresenter presenter;

    public static ForgotPasswordFragment newInstance() {
        Bundle args = new Bundle();
        ForgotPasswordFragment fragment = new ForgotPasswordFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectForgotPassword(this);

        return inflater.inflate(R.layout.fragment_forgot_password, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
    }

    @Override
    public void onResume() {
        super.onResume();
        presenter.setView(this);
        presenter.start();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        presenter.unSuscribe();
    }

    @Override
    public void showForgotPasswordSuccess() {
        Intent intent = new Intent(getContext(), ResetPasswordActivity.class);
        startActivity(intent);
    }

    @Override
    public void showForgotPasswordError(String message) {
        new AlertDialog.Builder(Objects.requireNonNull(getContext()))
                .setTitle(R.string.app_name)
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .show();
    }

    @Override
    public void setQuestions(List<Question> questions) {
        mMainLinearLayout.removeAllViews();
        if (questions != null && questions.size() > 0) {
            for (Question question : questions) {
                /*Title*/
                ViewQuestionModel questionModel = new ViewQuestionModel();
                questionModel.setQuestion(question);
                TextView tv = new TextView(getContext());
                tv.setText(question.getQuestion());
                LinearLayout.LayoutParams titleQuestionParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
                titleQuestionParams.setMargins(0, 16, 0, 4);
                questionModel.setTitleView(tv);
                mMainLinearLayout.addView(tv, titleQuestionParams);
                /*Answer*/
                EditText et = new EditText(getContext());
                LinearLayout.LayoutParams editTextParam = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
                editTextParam.setMargins(0, 0, 0, 0);
                switch (question.getResponseType()) {
                    case "N":
                        et.setInputType(InputType.TYPE_CLASS_NUMBER);
                        break;
                    case "A":
                        et.setInputType(InputType.TYPE_CLASS_TEXT);
                        break;
                    case "F":
                        et.setInputType(InputType.TYPE_CLASS_DATETIME);
                        et.setFocusable(false);
                        et.setOnClickListener(v -> {
                            auxEditText = et;
                            new DatePickerDialog(Objects.requireNonNull(getContext()), date, myCalendar
                                    .get(Calendar.YEAR), myCalendar.get(Calendar.MONTH),
                                    myCalendar.get(Calendar.DAY_OF_MONTH)).show();
                        });
                        break;
                    default:
                        et.setInputType(InputType.TYPE_CLASS_NUMBER);
                        break;
                }
                questionModel.setAswerView(et);
                mMainLinearLayout.addView(et, editTextParam);
                /*Boolean*/
                if (question.getAllowEmptyAnswer()) {
                    CheckBox checkBox = new CheckBox(getContext());
                    checkBox.setText("No tengo");
                    editTextParam.setMargins(0, 0, 0, 0);
                    questionModel.setBooleanView(checkBox);
                    checkBox.setOnCheckedChangeListener((buttonView, isChecked) -> et.setEnabled(!isChecked));
                    mMainLinearLayout.addView(checkBox, editTextParam);
                }
                answersViews.add(questionModel);
            }

            Button sendButton = new Button(getContext());
            sendButton.setText("Enviar Respuestas");
            sendButton.setTextColor(getResources().getColor(R.color.white_transparent));
            sendButton.setBackgroundColor(getResources().getColor(R.color.colorPrimary));
            sendButton.setOnClickListener(onSendClickListener);
            LinearLayout.LayoutParams buttonParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT);
            buttonParams.setMargins(32, 32, 64, 64);
            sendButton.setAllCaps(false);
            sendButton.setPadding(64, 16, 64, 16);
            mMainLinearLayout.addView(sendButton, buttonParams);

        } else {
            Toast.makeText(getContext(), "Hubo un problema al obtener las preguntas", Toast.LENGTH_SHORT).show();
            Objects.requireNonNull(getActivity()).finish();
        }
    }

    View.OnClickListener onSendClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if (validateAswers()){
                List<Answer> answers = new ArrayList<>();
                for (ViewQuestionModel questionModel : answersViews) {
                    Answer answer = new Answer();
                    answer.setQuestionId(questionModel.getQuestion().getQuestionId());
                    if (questionModel.getBooleanView() != null && questionModel.getBooleanView().isChecked()){
                        answer.setAnswer("");
                    }else {
                        answer.setAnswer(questionModel.getAswerView().getText().toString());
                    }
                    answers.add(answer);
                }
                presenter.onClickAnswerQuestions(answers);
            }
        }
    };

    DatePickerDialog.OnDateSetListener date = (view, year, monthOfYear, dayOfMonth) -> {
        myCalendar.set(Calendar.YEAR, year);
        myCalendar.set(Calendar.MONTH, monthOfYear);
        myCalendar.set(Calendar.DAY_OF_MONTH, dayOfMonth);
        updateLabel();
    };

    private void updateLabel() {
        String myFormat = "MM/dd/yyyy";
        SimpleDateFormat sdf = new SimpleDateFormat(myFormat, Locale.US);
        auxEditText.setText(sdf.format(myCalendar.getTime()));
    }


    private boolean validateAswers() {
        boolean result = true;
        for (ViewQuestionModel questionModel : answersViews) {
            questionModel.getAswerView().setError(null);
            questionModel.getAswerView().clearFocus();
        }
        for (ViewQuestionModel questionModel : answersViews) {
            if (questionModel.getBooleanView() == null || !questionModel.getBooleanView().isChecked()){
                if (TextUtils.isEmpty(questionModel.getAswerView().getText().toString())){
                    result = false;
                    questionModel.getAswerView().setError("Campo Obligatorio");
                }
            }
        }
        return result;
    }

    @Override
    public void showLoading() {
        mProgressll.setVisibility(View.VISIBLE);
    }

    @Override
    public void hideLoading() {
        mProgressll.setVisibility(View.GONE);
    }
}
