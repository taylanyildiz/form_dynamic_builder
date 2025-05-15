# 🧩 Form Dynamic Builder

**Form Dynamic Builder** is a powerful Flutter-based drag-and-drop form builder that allows users to create fully dynamic and interactive forms with advanced logic capabilities.

🌐 Live Demo: [**Demo**](https://form-builder-flutter.web.app/)

---

## ✨ Features

- 🔧 **Drag & Drop Interface**: Easily add and position multiple form components visually.
- 🧠 **Conditional Logic**: Enable or disable components based on complex conditions involving the values of other components.  
  _Example: Field X is only enabled when Field Y and Z's values are both greater than 10._
- 🔗 **Value Dependency**: Make one component's value depend on the processed values of others.  
  _Example: Field X's value is always half of Field Y's value._
- 📦 **JSON Output**: Export your entire form as a clean and structured JSON configuration.
- 📋 **One-Click Copy**: Easily copy the generated JSON configuration to your clipboard.
- ☁️ **Deployed on Firebase**: Fully functional live deployment using Firebase Hosting.

---

## 🚀 Technologies Used

- **Flutter** – UI development
- **Riverpod** – State management
- **Firebase Hosting** – Live deployment

---

## 📸 Screenshots

> _Coming soon – or you can visit the live demo to explore._

---

## 🔄 How to Use

1. Go to the [live demo](https://form-builder-flutter.web.app/).
2. Drag components into the canvas.
3. Set properties, dependencies, and conditions.
4. Click to preview or export your form in JSON format.

---

## 📥 Future Improvements

- Component grouping and reusable blocks
- Validation rules per field
- Backend saving and retrieval of saved forms
- Dark mode

---

## 🛠️ Development

To run this project locally:

```bash
git clone https://github.com/taylanyildiz/form_dynamic_builder
cd form_dynamic_builder
flutter pub get
flutter run -d chrome