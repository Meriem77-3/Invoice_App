# 📄 Invoice App

A modern Flutter application for generating and previewing invoices.

---

## 🚀 Description

This mobile app allows you to create, preview, and manage invoices interactively. The interface is clean, professional, and uses a blue color palette for a modern look.

---

## ✨ Main Features

- **Dynamic invoice creation**:
  - Enter client name, email, invoice date
  - Add, edit, and remove articles
- **Automatic calculations**:
  - Real-time update of totals (excl. tax, VAT, incl. tax)
- **Modern preview**:
  - Tab "Preview" shows a structured, printable invoice with blue-themed design
- **UI/UX**:
  - Blue color palette, gradients, rounded cards, icons, and clear layout
  - Responsive and mobile-friendly
  - Conditional display (e.g., "No articles" message)

---

## 🎨 Color Palette

- **Primary:** Blue (`Colors.blue` shades)
- **Gradients:** From `Colors.blue.shade600` to `Colors.blue.shade900`
- **No green/orange**: All highlights and accents use blue

---

## 🖼️ Screenshots

   per at the root of the project named results


## 🛠️ Technical Details

- **State Management**: Simple use of `StatefulWidget` and `setState`
- **Modularity**:
  - `InvoiceForm`: main form and state
  - `ArticleForm`: widget for each article
  - `InvoicePreview`: modern, blue-themed invoice preview
- **UI/UX**:
  - `TabBar` for navigation
  - `Card`, `Divider`, `Table`, and icons for structure

- **Validation**: Numeric fields for quantity and unit price

---

## 📦 Installation

1. **Clone the project**
   ```bash
   git clone <repo-url>
   cd facture_app
   ```
2. **Install dependencies**
   ```bash
   flutter pub get
   ```
3. **Run the app**
   ```bash
   flutter run -d chrome
   ```

---

## 👨‍💻  Contact

- Developed by:ASSOULI MERIEM
- Contact: meriemassoulli@gmail.com


