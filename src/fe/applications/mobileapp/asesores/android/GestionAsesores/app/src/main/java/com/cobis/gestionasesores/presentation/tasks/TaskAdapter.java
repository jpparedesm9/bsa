package com.cobis.gestionasesores.presentation.tasks;

import android.support.annotation.DrawableRes;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by bqtdesa02 on 8/15/2017.
 */

public class TaskAdapter extends RecyclerView.Adapter<TaskAdapter.TaskViewHolder> {

    private List<Task> mItems;
    private TaskListener mListener;


    public TaskAdapter(TaskListener listener) {
        mListener = listener;
        mItems = new ArrayList<>();
    }

    @Override
    public TaskViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View rowView = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_task, parent, false);
        return new TaskViewHolder(rowView);
    }

    @Override
    public void onBindViewHolder(final TaskViewHolder holder, int position) {
        holder.bindTask(mItems.get(position));
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mListener.onClickTask(mItems.get(holder.getAdapterPosition()));
            }
        });
    }

    @Override
    public int getItemCount() {
        return mItems.size();
    }

    public void setNewTasks(List<Task> newTasks){
        mItems.clear();
        mItems.addAll(newTasks);
        notifyDataSetChanged();
    }

    public void clear(){
        mItems.clear();
        notifyDataSetChanged();
    }

    public static class TaskViewHolder extends RecyclerView.ViewHolder{

        @BindView(R.id.text_title)
        TextView mNameText;
        @BindView(R.id.img_sync_status)
        ImageView mSyncStatusImg;
        @BindView(R.id.image_type)
        ImageView mTaskTypeImage;

        public TaskViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
        }

        public void bindTask(Task task){
            mNameText.setText(task.getName());

            int taskTypeImage = getImageTypeResource(task.getType());
            if(taskTypeImage > 0) {
                mTaskTypeImage.setImageResource(taskTypeImage);
            }

            int syncStatus = ResourcesUtil.getSyncStatusResource(task.getStatus());
            if(syncStatus > 0) {
                mSyncStatusImg.setImageResource(syncStatus);
            }else{
                mSyncStatusImg.setVisibility(View.INVISIBLE);
            }
        }

        @DrawableRes
        private int getImageTypeResource(@TaskType String type) {
            switch (type) {
                case TaskType.SOLIDARITY_PAYMENT:
                    return R.drawable.ic_user_group_money;
                case TaskType.GROUP_VERIFICATION:
                    return R.drawable.ic_user_group_document_checked;
                case TaskType.INDIVIDUAL_VERIFICATION:
                    return R.drawable.ic_user_document_checked;
                default:
                    Log.e("Task type is not supported!!");
                    return -1;
            }
        }
    }

    public interface TaskListener{
        void onClickTask(Task task);
    }
}
