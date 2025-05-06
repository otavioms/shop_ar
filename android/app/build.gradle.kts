import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// Carregar propriedades do Flutter de forma segura
val localProperties = Properties().apply {
    runCatching {
        load(FileInputStream(rootProject.file("local.properties")))
    }
}
val flutterCompileSdk = localProperties["flutter.compileSdkVersion"]?.toString()?.toInt() ?: 34
val flutterTargetSdk = localProperties["flutter.targetSdkVersion"]?.toString()?.toInt() ?: 34
val flutterVersionCode = localProperties["flutter.versionCode"]?.toString()?.toInt() ?: 1
val flutterVersionName = localProperties["flutter.versionName"]?.toString() ?: "1.0.0"

android {
    namespace = "br.com.otavioms.shop_ar"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "br.com.otavioms.shop_ar"
        minSdk = 24
        targetSdk = flutterTargetSdk
        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    signingConfigs {
        create("release") {
            storeFile = file("keystore.jks") // Ajuste conforme seu keystore real
            storePassword = "senha"
            keyAlias = "alias"
            keyPassword = "senha"
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    implementation("com.google.ar:core:1.39.0")
}

flutter {
    source = "../.."
}
