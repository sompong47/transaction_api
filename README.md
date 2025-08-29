# 💰 Transaction Management App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.8.1-0175C2?style=for-the-badge&logo=dart)
![GetX](https://img.shields.io/badge/GetX-4.7.2-9C27B0?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

**แอปพลิเคชันจัดการบันทึกการเงินส่วนบุคคล ด้วย Flutter**

[🚀 การติดตั้ง](#-การติดตั้งและรัน) • [📱 ฟีเจอร์](#-ฟีเจอร์หลัก) • [🏗️ โครงสร้าง](#️-โครงสร้างโปรเจ็กต์) • [📋 API](#-api-documentation)

</div>

---

## 📖 เกี่ยวกับโปรเจ็กต์

แอปพลิเคชัน Flutter สำหรับการจัดการบันทึกรายรับ-รายจ่ายส่วนบุคคล พร้อมระบบ Authentication ที่สมบูรณ์ เชื่อมต่อกับ RESTful API และจัดเก็บข้อมูลใน Local Storage ด้วย Hive Database

### 🌟 จุดเด่น

- ✅ **Real-time Updates** - อัปเดตข้อมูลแบบ Real-time ด้วย GetX Reactive Programming
- ✅ **Offline Support** - ทำงานได้แม้ไม่มีอินเทอร์เน็ตด้วย Local Storage
- ✅ **Modern UI/UX** - ใช้ Material Design 3 กับ Custom Theme
- ✅ **Secure Authentication** - JWT Token Authentication ที่ปลอดภัย
- ✅ **CRUD Operations** - สร้าง อ่าน อัปเดต และลบรายการได้ครบถ้วน

## 🎯 API ที่เรียกใช้

**Backend API:** [`https://transactions-cs.vercel.app`](https://transactions-cs.vercel.app)  
**GitHub Repository:** [Apisit250aps/transactions](https://github.com/Apisit250aps/transactions)

## 📱 ฟีเจอร์หลัก

### 🔐 **Authentication System**

- 🚪 เข้าสู่ระบบด้วยอีเมลและรหัสผ่าน
- 📝 สมัครสมาชิกใหม่
- 🔑 รีเซ็ตรหัสผ่าน
- 🚪 ออกจากระบบ
- 🔒 Auto-login Detection

### 💸 **Transaction Management**

- ➕ เพิ่มรายการรายรับ/รายจ่ายใหม่
- 📊 แสดงรายการทุกธุรกรรม
- ✏️ แก้ไขรายการที่มีอยู่
- 🗑️ ลบรายการที่ไม่ต้องการ
- 📅 เลือกวันที่ธุรกรรม
- 💰 จัดการ Wallet แยกตามประเภท

### 🎨 **UI/UX Features**

- 🌈 **Material Design 3** - ใช้ Material Design ล่าสุด
- 🎨 **Custom Theme** - ธีมสีน้ำเงินสวยงาม
- 📱 **Responsive Design** - ปรับขนาดได้กับทุกหน้าจอ
- ✅ **Form Validation** - ตรวจสอบข้อมูลครบถ้วน
- ⏳ **Loading States** - แสดงสถานะการโหลด
- ⚠️ **Error Handling** - จัดการข้อผิดพลาดอย่างเหมาะสม

### 🛠️ **Technical Features**

- 🔄 **State Management** - GetX Controller Pattern
- 🗄️ **Local Storage** - Hive NoSQL Database
- 🌐 **API Integration** - HTTP Client ที่มีประสิทธิภาพ
- 🧭 **Navigation Management** - GetX Routing System
- 🔔 **Real-time Updates** - Reactive UI Updates

## 🏗️ โครงสร้างโปรเจ็กต์

```
lib/
├── components/                    # 🧩 UI Components ที่ใช้ซ้ำ
│   ├── drawer.dart               # 📱 Navigation Drawer
│   ├── transaction_card.dart     # 💳 Transaction Display Card
│   └── user_profile_card.dart    # 👤 User Profile Card
├── controllers/                   # 🎮 State Management Controllers
│   ├── auth_controller.dart      # 🔐 Authentication Logic
│   └── transac_controller.dart   # 💸 Transaction Management
├── model/                        # 📊 Data Models
│   └── transaction.dart          # 💰 Transaction Data Model
├── routes/                       # 🧭 Navigation Routes
│   ├── app_pages.dart           # 📄 Page Definitions & Bindings
│   └── app_routes.dart          # 🛣️ Route Name Constants
├── screens/                      # 📱 Application Screens
│   ├── splash_screen.dart       # 🌅 Initial Loading Screen
│   ├── login.dart               # 🔑 Login Screen
│   ├── regis.dart               # 📝 Registration Screen
│   ├── forget_pass.dart         # 🔑 Password Reset Screen
│   ├── home.dart                # 🏠 Main Dashboard
│   └── transaction_form.dart    # 📝 Add/Edit Transaction Form
├── services/                     # ⚙️ Business Logic Services
│   └── storage_service.dart     # 🗄️ Local Storage Management
├── utils/                        # 🛠️ Utilities & Helpers
│   ├── api.dart                 # 🌐 API Configuration
│   └── navigation_helper.dart   # 🧭 Navigation Utilities
└── main.dart                     # 🚀 Application Entry Point
```

## 🛠️ เทคโนโลยีที่ใช้

<div align="center">

| หมวดหมู่                | เทคโนโลยี     | เวอร์ชัน | วัตถุประสงค์          |
| ----------------------- | ------------- | -------- | --------------------- |
| 🎯 **Core**             | Flutter SDK   | `^3.8.1` | Framework หลัก        |
| 🎯 **Core**             | Dart          | `^3.8.1` | Programming Language  |
| 🎮 **State Management** | GetX          | `^4.7.2` | State, Routing & DI   |
| 🗄️ **Database**         | Hive          | `^2.2.3` | Local NoSQL Database  |
| 🌐 **HTTP Client**      | HTTP          | `^1.5.0` | API Communication     |
| 📁 **File System**      | Path Provider | `^2.1.4` | File Path Management  |
| 🧪 **Testing**          | Flutter Test  | Built-in | Unit & Widget Testing |
| 📋 **Code Quality**     | Flutter Lints | `^5.0.0` | Static Code Analysis  |

</div>

### 🏗️ Architecture Patterns

- **📐 MVC Pattern** - Model-View-Controller Architecture
- **🎮 GetX Pattern** - Reactive State Management
- **📦 Repository Pattern** - Data Access Layer
- **🧩 Component-Based UI** - Reusable UI Components
- **🔄 Reactive Programming** - Real-time UI Updates

## 🚀 การติดตั้งและรัน

### 📋 ความต้องการของระบบ

<div align="center">

| ⚙️ ระบบ            | 🔢 เวอร์ชันขั้นต่ำ     | 📝 หมายเหตุ                    |
| ------------------ | ---------------------- | ------------------------------ |
| 📱 **Flutter SDK** | `^3.8.1`               | Required                       |
| 🎯 **Dart SDK**    | `^3.8.1`               | มาพร้อม Flutter                |
| 💻 **IDE**         | Any                    | Android Studio / VS Code แนะนำ |
| 📱 **Platform**    | Android 6.0+ / iOS 12+ | สำหรับการทดสอบ                 |
| 🌐 **Internet**    | Required               | สำหรับ API Calls               |

</div>

### 📦 ขั้นตอนการติดตั้ง

```bash
# 1️⃣ Clone Repository
git clone https://github.com/your-username/api_consume.git
cd api_consume

# 2️⃣ ติดตั้ง Dependencies
flutter pub get

# 3️⃣ ตรวจสอบการติดตั้ง
flutter doctor

# 4️⃣ รันแอปพลิเคชัน
flutter run
```

### 🔧 การตั้งค่า

#### 🌐 API Configuration

ไฟล์ `lib/utils/api.dart` มีการตั้งค่า API Endpoint ดังนี้:

```dart
final BASE_URL = 'https://transactions-cs.vercel.app';

// Authentication Endpoints
final LOGIN_ENDPOINT = '/api/auth/login';
final REGISTER_ENDPOINT = '/api/auth/register';

// Transaction Endpoints
final TRANSACTION_ENDPOINT = '/api/transaction';
final CREATE_TRANSACTION_ENDPOINT = '/api/transaction';
```

#### 📁 Assets Configuration

โครงสร้าง Assets ใน `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

**Assets ที่ใช้:**

- 🏛️ `comsci_logo.png` - โลโก้สาขาวิทยาการคอมพิวเตอร์
- 🎯 `logo.png` - โลโก้หลักของแอป
- 🔄 `reset.png` - ไอคอน Reset Password

## 📋 API Documentation

### 🔐 Authentication Endpoints

| Method | Endpoint             | Description | Body                      |
| ------ | -------------------- | ----------- | ------------------------- |
| `POST` | `/api/auth/login`    | เข้าสู่ระบบ | `{email, password}`       |
| `POST` | `/api/auth/register` | สมัครสมาชิก | `{name, email, password}` |

### 💰 Transaction Endpoints

| Method   | Endpoint                  | Description     | Headers                         |
| -------- | ------------------------- | --------------- | ------------------------------- |
| `GET`    | `/api/transaction`        | ดูรายการทั้งหมด | `Authorization: Bearer {token}` |
| `POST`   | `/api/transaction`        | เพิ่มรายการใหม่ | `Authorization: Bearer {token}` |
| `PUT`    | `/api/transaction/{uuid}` | แก้ไขรายการ     | `Authorization: Bearer {token}` |
| `DELETE` | `/api/transaction/{uuid}` | ลบรายการ        | `Authorization: Bearer {token}` |

## 🏗️ ฟีเจอร์โดยละเอียด

### 🎮 **Controllers**

#### 🔐 `AuthController` (`lib/controllers/auth_controller.dart`)

```dart
class AuthController extends GetxController {
  // 🚪 จัดการสถานะการเข้าสู่ระบบ
  // 🔑 เชื่อมต่อ API Login/Register/Reset Password
  // 💾 จัดเก็บ Token ใน Hive Local Storage
  // 🔄 Auto-login Detection เมื่อเปิดแอป
}
```

#### 💸 `TransactionController` (`lib/controllers/transac_controller.dart`)

```dart
class TransactionController extends GetxController {
  // 📊 จัดการ State ของรายการธุรกรรม
  // ➕ เพิ่มรายการใหม่ (addTransaction)
  // ✏️ แก้ไขรายการ (updateTransaction)
  // 🗑️ ลบรายการ (removeTransaction)
  // 🔄 Real-time Updates ด้วย RxList
}
```

### ⚙️ **Services**

#### 🗄️ `StorageService` (`lib/services/storage_service.dart`)

```dart
class StorageService {
  // 🔒 ใช้ Hive Database สำหรับ Local Storage
  // 🎫 จัดเก็บ JWT Token อย่างปลอดภัย
  // 👤 เก็บข้อมูล User Profile
  // 🔄 Persistent Storage ข้าม Session
}
```

### 📱 **Screens Overview**

#### 🌅 **Splash Screen** (`splash_screen.dart`)

- ⏳ Loading Screen แรกเริ่ม
- 🔍 ตรวจสอบสถานะการล็อกอิน
- 🧭 นำทางไปหน้าที่เหมาะสม (Login/Home)

#### 🔑 **Login Screen** (`login.dart`)

- 📝 ฟอร์มเข้าสู่ระบบด้วยอีเมล/รหัสผ่าน
- ✅ Form Validation ครบถ้วน
- ⏳ Loading State ขณะประมวลผล
- ⚠️ Error Handling และแสดงข้อความ

#### 📝 **Register Screen** (`regis.dart`)

- 📋 ฟอร์มสมัครสมาชิกใหม่
- 🔒 ตรวจสอบความปลอดภัยรหัสผ่าน
- 🌐 Integration กับ API Backend

#### 🔑 **Forget Password** (`forget_pass.dart`)

- 📧 ฟอร์มรีเซ็ตรหัสผ่านผ่านอีเมล
- ✉️ ส่งลิงก์รีเซ็ตไปยังอีเมล

#### 🏠 **Home Screen** (`home.dart`)

- 📊 Dashboard หลักแสดงรายการธุรกรรม
- 🧭 Navigation Drawer พร้อม Menu
- ➕ FloatingActionButton สำหรับเพิ่มรายการ
- 🔄 Real-time Updates ด้วย GetX Obx

#### 📝 **Transaction Form** (`transaction_form.dart`)

- 📋 ฟอร์มเพิ่ม/แก้ไข/ลบรายการธุรกรรม
- 📅 Date Picker สำหรับเลือกวันที่
- 💰 DropDown เลือกประเภท รายรับ/รายจ่าย
- 🔄 Modal Bottom Sheet Design

## 🧪 การทดสอบและ Quality Assurance

### 🔍 คำสั่งทดสอบ

```bash
# 🧪 รันการทดสอบทั้งหมด
flutter test

# 📋 ตรวจสอบ Code Quality และ Linting
flutter analyze

# 🏗️ ทดสอบการ Build
flutter build apk --debug

# 📊 ตรวจสอบ Dependencies
flutter pub deps
```

### 🎯 Test Coverage

- ✅ **Unit Tests** - Logic และ Business Rules
- ✅ **Widget Tests** - UI Components
- ⚠️ **Integration Tests** - End-to-End Testing (ขณะพัฒนา)

## 📱 Platform Support

<div align="center">

| Platform       | Status          | Notes                   |
| -------------- | --------------- | ----------------------- |
| 🤖 **Android** | ✅ Full Support | API Level 21+           |
| 🍎 **iOS**     | ✅ Full Support | iOS 12.0+               |
| 🌐 **Web**     | ⚠️ Limited      | ไม่รองรับ Local Storage |
| 💻 **Desktop** | ⚠️ Limited      | Windows/macOS/Linux     |

</div>

## 🔒 Security Features

- 🔐 **JWT Token Authentication** - ระบบยืนยันตัวตนที่ปลอดภัย
- 🗄️ **Secure Local Storage** - จัดเก็บข้อมูลด้วย Hive Encryption
- ✅ **Input Validation** - ตรวจสอบข้อมูลนำเข้าทุกฟิลด์
- ⚠️ **Error Handling** - จัดการข้อผิดพลาดอย่างเหมาะสม
- ⏰ **Auto-logout** - ออกจากระบบอัตโนมัติเมื่อ Token หมดอายุ
- 🛡️ **API Security** - ส่งข้อมูลผ่าน HTTPS เท่านั้น

## 🤝 การพัฒนาต่อ

### 📋 Code Style Guidelines

```dart
// ✅ ใช้ Flutter/Dart conventions
class TransactionController extends GetxController {
  // ✅ Comments เป็นภาษาไทย (อธิบายโค้ด)
  // ✅ ชื่อตัวแปรและฟังก์ชันเป็นภาษาอังกฤษ

  final RxList<TransactionData> transactions = <TransactionData>[].obs;

  // เพิ่มรายการธุรกรรมใหม่
  void addTransaction(TransactionData transaction) {
    transactions.add(transaction);
  }
}
```

### 🔄 Git Workflow

```bash
# 📝 Commit Message Conventions
git commit -m "feat: add transaction CRUD functionality"
git commit -m "fix: handle API timeout error"
git commit -m "style: update transaction card UI"
git commit -m "refactor: improve auth controller structure"
git commit -m "docs: update README with API documentation"
```

### 🎯 Development Roadmap

- [ ] 📊 **Analytics Dashboard** - สถิติรายรับ-รายจ่าย
- [ ] 📁 **Category Management** - จัดหมวดหมู่รายการ
- [ ] 📤 **Export/Import** - ส่งออกข้อมูล CSV/PDF
- [ ] 🌙 **Dark Mode** - โหมดธีมมืด
- [ ] 🔔 **Push Notifications** - แจ้งเตือนรายการ
- [ ] 📈 **Charts & Reports** - กราฟและรายงาน

## 📄 License

```
MIT License

Copyright (c) 2024 Computer Science Department
Sisaket Rajabhat University

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software for educational and development purposes.
```

## 👨‍💻 ผู้พัฒนา

<div align="center">

  **นายสมพงษ์ ใยคำ**  
🏛️ **สาขาวิทยาการคอมพิวเตอร์**  
🎓 **มหาวิทยาลัยราชภัฏศรีสะเกษ**

</div>

---

## 📞 การติดต่อและสนับสนุน

<div align="center">

### 🆘 ต้องการความช่วยเหลือ?

📋 **สร้าง Issue** ในโปรเจ็กต์นี้ได้เลย  
💬 **แชร์ความคิดเห็น** ผ่าน Discussions  
⭐ **ให้ Star** ถ้าโปรเจ็กต์นี้มีประโยชน์

### 🙏 ขอบคุณที่ใช้งาน

**Happy Coding! 🚀**

</div>
