pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        properties.getProperty("flutter.sdk")
            ?: throw GradleException("flutter.sdk não definido em local.properties")
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

// <-- Adicione este bloco abaixo de pluginManagement:
plugins {
    // plugin “loader” que injeta todo o código do Flutter
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    // Android Gradle Plugin
    id("com.android.application")     version "8.10.1" apply false
    // Kotlin Android Plugin
    id("org.jetbrains.kotlin.android") version "1.9.0" apply false
}

include(":app")
rootProject.name = "ap2"