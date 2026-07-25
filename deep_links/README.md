# Deep Links Setup (ZAY)

Open product/shop screens in the app when installed; otherwise open the Play Store / App Store.

This is **not** Firebase Dynamic Links. It uses Android App Links + iOS Universal Links.

---

## How it works

```
User taps https://zaymarketplace.online/product/123
        │
        ├─ App installed  → OS opens ZAY → product details
        └─ App not installed → browser loads URL → store_fallback.html → Store
```

Supported URLs:

| URL | Opens in app |
|-----|----------------|
| `https://zaymarketplace.online/product/{id}` | Product details |
| `https://zaymarketplace.online/shop/{id}` | Shop details |
| `https://zaymarketplace.online/products/{id}` | Product details (alias) |
| `https://zaymarketplace.online/shops/{id}` | Shop details (alias) |

Also works with `www.zaymarketplace.online`.

---

## Folder contents (upload to Laravel)

| File | Destination on server |
|------|------------------------|
| `.well-known/assetlinks.json` | `public/.well-known/assetlinks.json` |
| `.well-known/apple-app-site-association` | `public/.well-known/apple-app-site-association` |
| `store_fallback.html` | `public/store_fallback.html` |

> This `deep_links/` folder is a staging copy for the backend. It is **not** bundled into the Flutter app.

---

## Flutter app (already done)

- Util: `lib/app/utils/deep_links_util.dart`
- Init in `main.dart` + handle after splash
- Share buttons on product/shop details use these HTTPS links
- Android: App Links intent-filter in `AndroidManifest.xml`
- iOS: Associated Domains in `Runner.entitlements`

Host constant: `Constants.deepLinkHost` → `zaymarketplace.online`

---

## Before hosting — replace placeholders

### 1. `assetlinks.json` (Android)

Replace:

- `REPLACE_WITH_YOUR_RELEASE_SHA256`
- `REPLACE_WITH_YOUR_DEBUG_SHA256`

Get fingerprints:

```bash
# Debug
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# Release (your upload/keystore)
keytool -list -v -keystore /path/to/your-release.keystore -alias YOUR_ALIAS
```

Use the **SHA256** value (colons optional; Google accepts both forms).

Package name must stay: `com.zay`

### 2. `apple-app-site-association` (iOS)

Replace `TEAM_ID` with your Apple Developer Team ID:

```text
"appID": "XXXXXXXXXX.com.zay"
```

Find Team ID: [Apple Developer → Membership](https://developer.apple.com/account) → Team ID.

Bundle ID must stay: `com.zay`

### 3. `store_fallback.html`

Replace `idYOUR_APP_ID` with the real App Store URL once published, e.g.:

```text
https://apps.apple.com/app/id1234567890
```

Play Store is already:

```text
https://play.google.com/store/apps/details?id=com.zay
```

---

## Laravel backend setup

### A) Place files

```text
public/
├── .well-known/
│   ├── assetlinks.json
│   └── apple-app-site-association   ← no .json extension
└── store_fallback.html
```

### B) Routes (`routes/web.php`)

```php
Route::get('/product/{id}', function () {
    return response()->file(public_path('store_fallback.html'));
})->whereNumber('id');

Route::get('/shop/{id}', function () {
    return response()->file(public_path('store_fallback.html'));
})->whereNumber('id');

Route::get('/products/{id}', function () {
    return response()->file(public_path('store_fallback.html'));
})->whereNumber('id');

Route::get('/shops/{id}', function () {
    return response()->file(public_path('store_fallback.html'));
})->whereNumber('id');
```

Do **not** break `/api/*`.  
Do **not** intercept `/.well-known/*` with auth or redirects.

If `/product/{id}` or `/shop/{id}` already power a real website, do not replace those pages — ask the mobile team for different deep-link paths.

### C) Apple content-type (`public/.htaccess`)

```apache
<Files "apple-app-site-association">
    Header set Content-Type "application/json"
</Files>
```

Requirements for both well-known files:

- HTTPS
- HTTP **200** (no 301/302)
- No login / auth wall
- AASA: `Content-Type: application/json`, **no** file extension

---

## Verify server

```bash
curl -I https://zaymarketplace.online/.well-known/assetlinks.json
curl -I https://zaymarketplace.online/.well-known/apple-app-site-association
curl -I https://zaymarketplace.online/product/1
curl -I https://zaymarketplace.online/shop/1
```

Expected:

- All return `200`
- Apple file content-type is `application/json`
- `/product/1` and `/shop/1` return the fallback HTML (not 404)

Also open in a browser (app uninstalled):  
`https://zaymarketplace.online/product/1` → should redirect to the store.

---

## Verify mobile

### Android

```bash
adb shell pm get-app-links com.zay
```

Domain should show as verified. Or use Android Studio → App Links Assistant.

Test:

```bash
adb shell am start -a android.intent.action.VIEW \
  -d "https://zaymarketplace.online/product/1" com.zay
```

### iOS

1. Xcode → Signing & Capabilities → Associated Domains:
   - `applinks:zaymarketplace.online`
   - `applinks:www.zaymarketplace.online`
2. Install a **release/TestFlight** build (Universal Links are unreliable on some debug setups)
3. Open the link from Notes or Safari (not always from inside Chrome)

---

## What is deferred vs not

| Feature | Supported? |
|---------|------------|
| Open app to product/shop if installed | Yes |
| Open store if not installed | Yes (via fallback HTML) |
| Install then auto-land on that product | **No** (deferred deep link — needs Branch/AppsFlyer or custom infra) |

---

## Troubleshooting

| Problem | Likely cause |
|---------|----------------|
| Link always opens browser | Well-known files missing, wrong SHA256/Team ID, or redirects on `/.well-known` |
| Android not verified | Wrong SHA256 (debug vs Play App Signing), or `assetlinks.json` unreachable |
| iOS never opens app | Wrong Team ID, AASA wrong content-type, or path not listed |
| Store redirect never happens | `/product/{id}` 404 or not serving `store_fallback.html` |
| Share works but wrong screen | Path/host mismatch vs `DeepLinksUtil` / `Constants.deepLinkHost` |

---

## Message for Laravel BE (copy/paste)

Hi,

Please set up App Links / Universal Links on `zaymarketplace.online`.

**Goal**

- App installed → open product/shop in the mobile app  
- App not installed → browser opens URL → redirect to Play/App Store  

**Links**

- `https://zaymarketplace.online/product/{id}`  
- `https://zaymarketplace.online/shop/{id}`  

**1) Files under `public/`**

- `public/.well-known/assetlinks.json`  
- `public/.well-known/apple-app-site-association` (no extension, `Content-Type: application/json`)  
- `public/store_fallback.html`  

Both well-known URLs must return HTTPS 200 with no redirect and no auth.

**2) Routes in `routes/web.php`**

Serve `store_fallback.html` for `/product/{id}`, `/shop/{id}`, and optional `/products/{id}`, `/shops/{id}` (numeric id). Do not break `/api/*` or `/.well-known/*`.

**3) `.htaccess`**

Force `Content-Type: application/json` for `apple-app-site-association`.

**4) Placeholders**

- Android SHA-256 fingerprints in `assetlinks.json`  
- Apple `TEAM_ID` in AASA → `TEAM_ID.com.zay`  
- Real App Store URL in `store_fallback.html`  

Files are attached from the mobile repo `deep_links/` folder.

Please confirm when live so we can test.

Thanks!
