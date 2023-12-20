package com.crossroad.app_hello_world_1;

import androidx.annotation.RequiresApi;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.webkit.WebViewAssetLoader;
import androidx.webkit.WebViewClientCompat;
import androidx.core.view.WindowCompat;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.webkit.JavascriptInterface;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.util.Log;
import org.json.JSONObject;
// import android.webkit.WebViewClient;

@SuppressLint("SetJavaScriptEnabled")
public class MainActivity extends AppCompatActivity {

    private WebView myWebView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        myWebView = findViewById(R.id.webview);

        // Local web view.
        final WebViewAssetLoader assetLoader = new WebViewAssetLoader.Builder()
                .addPathHandler("/assets/", new WebViewAssetLoader.AssetsPathHandler(this))
                .addPathHandler("/res/", new WebViewAssetLoader.ResourcesPathHandler(this))
                .build();
        myWebView.setWebViewClient(new LocalContentWebViewClient(assetLoader));
        myWebView.loadUrl("https://appassets.androidplatform.net/assets/index.html");

        // Internet web view.
        // myWebView.setWebViewClient(new WebViewClient());
        // myWebView.loadUrl("http://william-brendel.com");

        // Make sure javascript scripts are enabled.
        WebSettings webSettings = myWebView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        webSettings.setDatabaseEnabled(true);
        webSettings.setDomStorageEnabled(true);
        webSettings.setMediaPlaybackRequiresUserGesture(false);

        // Make background black.
        myWebView.setBackgroundColor(Color.parseColor("black"));

        // Full screen
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false);

        // Add web interface
        myWebView.addJavascriptInterface(new WebAppInterface(this), "Android");
    }

    private class WebAppInterface {
        Context context;
        Resources resources;
        Resources.Theme theme;
    
        // Instantiate the interface and set the context
        WebAppInterface(Context c) {
            context = c;
            resources = context.getResources();
            theme = context.getTheme();
        }

        // Get the console
        @JavascriptInterface
        public void console(String type, String msg) {
            switch (type.toLowerCase()) {
                case "e":
                case "err":
                case "error":
                    Log.e("", msg);
                    break;
                case "w":
                case "warning":
                case "warn":
                    Log.w("", msg);
                    break;
                case "d":
                case "deb":
                case "debug":
                    Log.d("", msg);
                    break;
                case "v":
                case "verb":
                case "verbose":
                    Log.v("", msg);
                    break;
                default:
                    Log.i("", msg);
                    break;
            }
        }

        // Get the density
        @JavascriptInterface
        public float getDensity() {
            return resources.getDisplayMetrics().density;
        }

        // Get the nav bar height
        @JavascriptInterface
        public int getNavigationBarHeight() {
            int resourceId = resources.getIdentifier("navigation_bar_height", "dimen", "android");
            return resourceId > 0 ? resources.getDimensionPixelSize(resourceId) : 0;
        }

        // Get status bar height
        @JavascriptInterface
        public int getStatusBarHeight() {
            int resourceId = resources.getIdentifier("status_bar_height", "dimen", "android");
            return resourceId > 0 ? resources.getDimensionPixelSize(resourceId) : 0;
        }

        // Get action bar height
        @JavascriptInterface
        public int getActionBarHeight() {
            int height;
            try (TypedArray styledAttributes = theme.obtainStyledAttributes(
                    new int[]{android.R.attr.actionBarSize}
            )) {
                height = (int) styledAttributes.getDimension(0, 0);
                styledAttributes.recycle();
            }
            return height;
        }

        // Check if navigation bar is showing
        @JavascriptInterface
        public boolean hasNavigationBar() {
            int resourceId = resources.getIdentifier("config_showNavigationBar", "bool", "android");
            return resourceId > 0 && resources.getBoolean(resourceId);
        }

        // Check if action bar is showing
        @JavascriptInterface
        public boolean hasActionBar() {
            ActionBar actionBar = getSupportActionBar();
            return actionBar != null && actionBar.isShowing();
        }

        // Sharing module
        @JavascriptInterface
        public void share(String jsonData) {
            try {
                JSONObject data = new JSONObject(jsonData); //Convert from string to object, can also use JSONArray
             } catch (Exception ex) {return;}
        }
    }

    private static class LocalContentWebViewClient extends WebViewClientCompat {

        private final WebViewAssetLoader mAssetLoader;

        LocalContentWebViewClient(WebViewAssetLoader assetLoader) {
            mAssetLoader = assetLoader;
        }

        @Override
        @RequiresApi(21)
        public WebResourceResponse shouldInterceptRequest(WebView view,
                                                          WebResourceRequest request) {
            return mAssetLoader.shouldInterceptRequest(request.getUrl());
        }

        @Override
        @SuppressWarnings("deprecation") // to support API < 21
        public WebResourceResponse shouldInterceptRequest(WebView view,
                                                          String url) {
            return mAssetLoader.shouldInterceptRequest(Uri.parse(url));
        }
    }

    @Override
    public void onBackPressed() {
        if (myWebView.canGoBack()) {
            myWebView.goBack();
        } else {
            super.onBackPressed();
        }
    }
}