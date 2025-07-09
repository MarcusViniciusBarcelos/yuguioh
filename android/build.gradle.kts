// android/build.gradle.kts (projeto Flutter, nível “android”)
import org.gradle.api.tasks.Delete

plugins {
    id("com.android.application") version "8.10.1" apply false
    kotlin("android")             version "1.9.0"   apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val externalBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(externalBuildDir)
subprojects {
    project.layout.buildDirectory.value(externalBuildDir.dir(project.name))
    evaluationDependsOn(":app")
}

// Tarefa clean unificada
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
