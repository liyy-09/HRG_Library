package com.hrg.rec.activity;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import com.alibaba.android.arouter.facade.annotation.Route;
import com.hrg.common.base.BaseActivity;
import com.hrg.rec.R;

@Route(path = "/ric/detail", group = "ric")
public class DetailActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.rec_activity_detail);

         int age = getIntent().getIntExtra("age", 1);

        TextView tv = (TextView) findViewById(R.id.ric_detail_tv);
        tv.setText("年龄：" + age);
    }
}
