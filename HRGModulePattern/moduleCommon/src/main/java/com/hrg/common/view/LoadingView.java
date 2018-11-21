package com.hrg.common.view;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.hrg.common.R;

public class LoadingView extends Dialog {

    private Context context;
    private TextView tv;

    public LoadingView(Context context) {
        super(context, R.style.com_MyDialog);
        this.context = context;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        init();

        setCanceledOnTouchOutside(false);
    }

    public void init() {
        LayoutInflater inflater = LayoutInflater.from(context);
        View view = inflater.inflate(R.layout.com_loading, null);
        setContentView(view);

        ImageView gifIV = view.findViewById(R.id.loading_git_iv);
        tv = view.findViewById(R.id.loading_text);

        Glide.with(this.context).load(R.mipmap.loading)
                .diskCacheStrategy(DiskCacheStrategy.NONE)
                .into(gifIV);

        Window dialogWindow = getWindow();
        WindowManager.LayoutParams lp = dialogWindow.getAttributes();
        DisplayMetrics d = context.getResources().getDisplayMetrics(); // 获取屏幕宽、高用
        lp.width = (int) (d.widthPixels * 0.3); // 高度设置为屏幕的比例
        dialogWindow.setAttributes(lp);
    }

    public void setContentText(String text) {
        if (text == null) {
            return;
        }

        tv.setText(text);
    }

}