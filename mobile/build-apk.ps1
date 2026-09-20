param(
    [Parameter(Mandatory = $true)] [string] $SdkRoot,
    [Parameter(Mandatory = $true)] [string] $JdkHome
)

$ErrorActionPreference = 'Stop'
$project = $PSScriptRoot
$main = Join-Path $project 'app\src\main'
$build = Join-Path $project 'build\manual'
$output = Join-Path $project 'apk\A-Tiempo-debug.apk'
$tools = Join-Path $SdkRoot 'build-tools\35.0.0'
$androidJar = Join-Path $SdkRoot 'platforms\android-35\android.jar'
$aapt2 = Join-Path $tools 'aapt2.exe'
$aapt = Join-Path $tools 'aapt.exe'
$d8 = Join-Path $tools 'd8.bat'
$zipalign = Join-Path $tools 'zipalign.exe'
$apksigner = Join-Path $tools 'apksigner.bat'
$javac = Join-Path $JdkHome 'bin\javac.exe'
$jar = Join-Path $JdkHome 'bin\jar.exe'
$keytool = Join-Path $JdkHome 'bin\keytool.exe'

foreach ($path in @($aapt2, $aapt, $d8, $zipalign, $apksigner, $javac, $jar, $keytool, $androidJar)) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Falta la herramienta requerida: $path" }
}

New-Item -ItemType Directory -Force -Path $build, (Join-Path $build 'classes'), (Join-Path $build 'dex'), (Split-Path $output) | Out-Null

& $aapt2 compile --dir (Join-Path $main 'res') -o (Join-Path $build 'resources.zip')
if ($LASTEXITCODE -ne 0) { throw 'Falló aapt2 compile' }

& $aapt2 link -o (Join-Path $build 'app-unsigned.apk') `
    --manifest (Join-Path $main 'AndroidManifest.xml') -I $androidJar `
    --min-sdk-version 27 --target-sdk-version 35 --version-code 1 --version-name 1.0.0 `
    --java (Join-Path $build 'generated') (Join-Path $build 'resources.zip')
if ($LASTEXITCODE -ne 0) { throw 'Falló aapt2 link' }

& $javac -source 8 -target 8 -cp $androidJar -d (Join-Path $build 'classes') `
    (Join-Path $main 'java\com\atiempo\app\MainActivity.java') `
    (Join-Path $build 'generated\com\atiempo\app\R.java')
if ($LASTEXITCODE -ne 0) { throw 'Falló javac' }

& $jar cf (Join-Path $build 'classes.jar') -C (Join-Path $build 'classes') .
if ($LASTEXITCODE -ne 0) { throw 'Falló jar' }
& $d8 --min-api 27 --lib $androidJar --output (Join-Path $build 'dex') (Join-Path $build 'classes.jar')
if ($LASTEXITCODE -ne 0) { throw 'Falló d8' }

# aapt2 -A en Windows almacena rutas anidadas con barras invertidas.
# aapt agrega las rutas relativas con barras normales, como espera WebView.
Push-Location $main
try {
    & $aapt add (Join-Path $build 'app-unsigned.apk') assets/index.html assets/css/fonts.css assets/css/style.css assets/js/app.js assets/fonts/Atkinson-Hyperlegible-Next-Latin.woff2
    if ($LASTEXITCODE -ne 0) { throw 'Falló empaquetar assets' }
} finally { Pop-Location }
Push-Location (Join-Path $build 'dex')
try {
    & $aapt add (Join-Path $build 'app-unsigned.apk') classes.dex
    if ($LASTEXITCODE -ne 0) { throw 'Falló empaquetar DEX' }
} finally { Pop-Location }

& $zipalign -f 4 (Join-Path $build 'app-unsigned.apk') (Join-Path $build 'app-aligned.apk')
if ($LASTEXITCODE -ne 0) { throw 'Falló zipalign' }

$keystore = Join-Path $build 'debug.keystore'
if (-not (Test-Path -LiteralPath $keystore)) {
    & $keytool -genkeypair -keystore $keystore -storepass android -keypass android `
        -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 10000 `
        -dname 'CN=Android Debug,O=Android,C=US' -noprompt
    if ($LASTEXITCODE -ne 0) { throw 'Falló crear la clave de depuración' }
}

& $apksigner sign --ks $keystore --ks-key-alias androiddebugkey `
    --ks-pass pass:android --key-pass pass:android --out $output `
    (Join-Path $build 'app-aligned.apk')
if ($LASTEXITCODE -ne 0) { throw 'Falló firmar el APK' }
& $apksigner verify --verbose $output
if ($LASTEXITCODE -ne 0) { throw 'La firma del APK no es válida' }

Write-Output "APK listo: $output"
