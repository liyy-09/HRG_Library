package com.hrg.common.http;

import android.util.Log;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;

public class RetrofitFactory {
    private static final long TIME_OUT = 8;

    // Retrofit是基于OkHttpClient的，可以创建一个OkHttpClient进行一些配置
    private static OkHttpClient httpClient = new OkHttpClient.Builder()
            .addInterceptor(new Interceptor() {
                @Override
                public Response intercept(Chain chain) throws IOException {
                    Request.Builder builder = chain.request().newBuilder();

                    // TODO
                    builder.addHeader("Cookie", "token=");

                    builder.addHeader("Accept", "application/vnd.apple.mpegurl");

                    Request request = chain.request();
                    Log.d("RetrofitFactory", "request url：" + request.url());

                    return chain.proceed(builder.build());
                }
            })
            /*
            这里可以添加一个HttpLoggingInterceptor，因为Retrofit封装好了从Http请求到解析，
            出了bug很难找出来问题，添加HttpLoggingInterceptor拦截器方便调试接口
             */
            .addInterceptor(new HttpLoggingInterceptor(new HttpLoggingInterceptor.Logger() {
                @Override
                public void log(String message) {
                    Log.d("HttpLoggingInterceptor", message);
                }
            }).setLevel(HttpLoggingInterceptor.Level.HEADERS))
            .connectTimeout(TIME_OUT, TimeUnit.SECONDS)
            .readTimeout(TIME_OUT, TimeUnit.SECONDS)
            .build();

    private static RetrofitService retrofitService = new Retrofit.Builder()
            .baseUrl("http://60.174.207.15:8085/ztlapi/")// TODO
            .addConverterFactory(GsonConverterFactory.create())// 添加Gson转换器
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())// 添加Retrofit到RxJava的转换器
            .client(httpClient)
            .build()
            .create(RetrofitService.class);

    public static RetrofitService getRetrofitService() {
        return retrofitService;
    }
}
