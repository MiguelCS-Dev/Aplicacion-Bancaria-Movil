# 📱 Flutter Banking App

Aplicación móvil desarrollada en Flutter que simula operaciones bancarias como transferencias, historial de transacciones y pagos mediante QR.

Este proyecto fue creado como parte de mi portafolio para demostrar conocimientos en desarrollo móvil, arquitectura limpia y uso de Firebase.


## 🏗️ Tecnologías utilizadas

- Flutter
- Dart
- Firebase (Authentication, Firestore / Realtime DB)
- Clean Architecture (Data / Domain / Presentation)
- Bloc / Cubit para manejo de estado

## 🚀 Funcionalidades principales

- Autenticación de usuarios
- Transferencias entre cuentas
- Historial de transacciones
- Generación y visualización de recibos de transacción
- Pago mediante código QR
- Perfil de usuario
- Consulta de saldo

## 🧪 Acceso de prueba

Puedes usar los siguientes usuarios para probar la app:

| Usuario | Email             | Password |
|--------|------------------|----------|
| Tester | tester@test.com  | 123456   |
| Demo   | demo@demo.com    | 123456   |

También puedes registrarte con nuevos usuarios si lo prefieres.

## 📋 Requisitos

Antes de ejecutar el proyecto, asegúrate de tener instalado lo siguiente:

### 🛠️ Herramientas

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 
- [Dart](https://dart.dev/get-dart) 
- [Android Studio](https://developer.android.com/studio) 
- Emulador Android o dispositivo físico


### 🔥 Firebase

El proyecto utiliza Firebase para autenticación y base de datos. Ya incluye la configuración necesaria mediante FlutterFire, por lo que puede ejecutarse directamente sin pasos adicionales.

Si el usuario desea usar su propia base de datos, puede crear un proyecto en Firebase, configurar Authentication y Firestore o Realtime Database, y ejecutar `flutterfire configure` para generar sus propios archivos de configuración.


### 📱 Verificación del entorno

Puedes verificar que todo esté correctamente instalado ejecutando:

```bash
flutter doctor
```

## ⚙️ Configuración del proyecto

### 1. Clonar el repositorio

```bash
git clone https://github.com/MiguelCS-Dev/Aplicacion-Bancaria-Movil.git
cd Aplicacion-Bancaria-Movil
cd bank_app
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Ejecutar la aplicación

```bash
flutter run
```

## 📦 Build APK

Para generar el APK en modo release:

```bash
flutter build apk --release
```

El archivo se genera en:

```bash
build/app/outputs/flutter-apk/app-release.apk
```



## ⚠️  Notas

- Esta aplicación es solo para fines demostrativos (portafolio)  
- No utiliza datos reales ni transacciones reales  
- Algunas funcionalidades pueden estar simplificadas  


## 📌 Estado del proyecto

Proyecto funcional con todas las funcionalidades principales implementadas para fines de portafolio.

## 👨‍💻 Autor

Desarrollado por **Miguel Córdoba Sanchez**
