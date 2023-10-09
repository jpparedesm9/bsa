package com.cobis.tuiiob2c.presentation.mainActivity.notifications;


import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.data.enums.NeedOtpType;
import com.cobis.tuiiob2c.data.enums.NotificationType;
import com.cobis.tuiiob2c.data.enums.ResponseMessageType;
import com.cobis.tuiiob2c.data.models.Notification;
import com.cobis.tuiiob2c.presentation.otpMessageVerification.OtpMessageVerificationActivity;
import com.cobis.tuiiob2c.root.App;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.inject.Inject;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * A simple {@link Fragment} subclass.
 */
public class NotificationsFragment extends Fragment implements NotificationsMVP.NotificationsView {

    public static final String ANSWER = "answer";
    public static final String NOTIFICATION_ID = "notification_id";

    @BindView(R.id.progress_bar_layout)
    LinearLayout mProgressll;
    @BindView(R.id.no_notif_text)
    LinearLayout mNoNotifText;
    @BindView(R.id.notification_layout)
    LinearLayout mNotificationLL;

//    String tempQuestionId;
//    List<String> questionsIds;

    @Inject
    public NotificationsMVP.NotificationsPresenter presenter;

    public static NotificationsFragment newInstance() {
        Bundle args = new Bundle();
        NotificationsFragment fragment = new NotificationsFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        ((App) Objects.requireNonNull(getActivity()).getApplication()).getComponent().injectNotifications(this);

        return inflater.inflate(R.layout.fragment_notifications, container, false);
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
    public void showMessages(List<Notification> notificationList) {
        if (notificationList == null || notificationList.size() == 0){
            mNotificationLL.setVisibility(View.GONE);
            mNoNotifText.setVisibility(View.VISIBLE);
        }else {
            mNoNotifText.setVisibility(View.GONE);
            mNotificationLL.setVisibility(View.VISIBLE);
            mNotificationLL.removeAllViews();
//            questionsIds = new ArrayList<>();
            for (Notification notification : notificationList) {
//                questionsIds.add(notification.getId());
                TextView description = new TextView(getContext());
                LinearLayout.LayoutParams descriptParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
                descriptParams.setMargins(0, 0, 0, 28);
                description.setText(notification.getDescription());
                mNotificationLL.addView(description, descriptParams);
                LinearLayout buttonsLL = new LinearLayout(getContext());
                buttonsLL.setOrientation(LinearLayout.HORIZONTAL);
                LinearLayout.LayoutParams llparams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
                llparams.setMargins(0, 0, 0, 0);
                buttonsLL.setGravity(Gravity.LEFT);
                mNotificationLL.addView(buttonsLL, llparams);
                switch (notification.getType()){
                    case NotificationType.YESORNO:
                        Button noButton = new Button(getContext());
                        noButton.setBackground(getResources().getDrawable(R.drawable.rounded_corner_back));
                        noButton.setTextColor(getResources().getColor(R.color.secondaryText));
                        noButton.setPadding(16,16,16,16);
                        noButton.setMinHeight(0);
                        noButton.setMinimumHeight(0);
                        noButton.setText("Rechazar");
                        LinearLayout.LayoutParams noButtonParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                        noButtonParams.setMargins(0,0,64,0);
                        buttonsLL.addView(noButton, noButtonParams);
                        noButton.setOnClickListener(v -> {
//                            tempQuestionId = notification.getId();
                            if (notification.getNeedsOtp().equals(NeedOtpType.YES)){
                                Intent intent = new Intent(getContext(), OtpMessageVerificationActivity.class);
                                intent.putExtra(ANSWER, ResponseMessageType.NO);
                                intent.putExtra(NOTIFICATION_ID, notification.getId());
                                startActivity(intent);
                            }else {
                                presenter.onSendResponseMessage(notification.getId(), ResponseMessageType.NO);
                            }
                        });

                        Button yesButton = new Button(getContext());
                        yesButton.setBackgroundColor(getResources().getColor(R.color.colorPrimary));
                        yesButton.setTextColor(getResources().getColor(R.color.white_transparent));
                        yesButton.setText("Aceptar");
                        yesButton.setPadding(16,16,16,16);
                        yesButton.setMinHeight(0);
                        yesButton.setMinimumHeight(0);
                        LinearLayout.LayoutParams yesButtonParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                        buttonsLL.addView(yesButton, yesButtonParams);
                        yesButton.setOnClickListener(v -> {
//                            tempQuestionId = notification.getId();
                            if (notification.getNeedsOtp().equals(NeedOtpType.YES)){
                                Intent intent = new Intent(getContext(), OtpMessageVerificationActivity.class);
                                intent.putExtra(ANSWER, ResponseMessageType.SI);
                                intent.putExtra(NOTIFICATION_ID, notification.getId());
                                startActivity(intent);
                            }else {
                                presenter.onSendResponseMessage(notification.getId(), ResponseMessageType.SI);
                            }
                        });
                        break;
                    case NotificationType.OK:
                        LinearLayout.LayoutParams okButtonParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                        Button okButton = new Button(getContext());
                        okButton.setBackgroundColor(getResources().getColor(R.color.colorPrimary));
                        okButton.setPadding(16,16,16,16);
                        okButton.setMinHeight(0);
                        okButton.setMinimumHeight(0);
                        okButton.setTextColor(getResources().getColor(R.color.white_transparent));
                        okButton.setText("Ok");

                        buttonsLL.addView(okButton, okButtonParams);
                        okButton.setOnClickListener(v -> {
//                            tempQuestionId = notification.getId();
                            if (notification.getNeedsOtp().equals(NeedOtpType.YES)){
                                Intent intent = new Intent(getContext(), OtpMessageVerificationActivity.class);
                                intent.putExtra(ANSWER, ResponseMessageType.OK);
                                intent.putExtra(NOTIFICATION_ID, notification.getId());
                                startActivity(intent);
                            }else {
                                presenter.onSendResponseMessage(notification.getId(), ResponseMessageType.OK);
                            }
                        });
                        break;
                }
                LinearLayout divider = new LinearLayout(getContext());
                LinearLayout.LayoutParams dividerParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, 2);
                dividerParams.setMargins(0, 32, 0, 32);
                divider.setBackgroundColor(getResources().getColor(R.color.divider));
                mNotificationLL.addView(divider, dividerParams);
            }
        }
    }

    @Override
    public void showMessageResponseSuccess() {
        Toast.makeText(getContext(), "Mensaje Enviado", Toast.LENGTH_SHORT).show();
        presenter.start();
    }

    @Override
    public void showMessageResponseError(String message) {
        Toast.makeText(getContext(), message, Toast.LENGTH_LONG).show();
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
