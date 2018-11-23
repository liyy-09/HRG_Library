package com.hrg.main.activity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import com.alibaba.android.arouter.facade.Postcard;
import com.alibaba.android.arouter.facade.callback.NavigationCallback;
import com.alibaba.android.arouter.launcher.ARouter;
import com.hrg.common.base.BaseActivity;
import com.hrg.main.R;

public class MainActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_activity_main);

        findViewById(R.id.main_main_click).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                startActivity(new Intent(MainActivity.this, BottomNavigationActivity.class));

                Bundle bundle = new Bundle();
                bundle.putInt("age", 28);

                ARouter.getInstance()
                        .build("/ric/detail", "ric")
                        .with(bundle)
                        .navigation();
            }
        });
    }
}
