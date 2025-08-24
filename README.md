# Smart Sustainability Tracker

A Salesforce-based application to track, manage, and visualize carbon emissions and offsets for sustainability projects. Built with **Apex**, **Visualforce**, **Lightning Web Components (LWC)**, **Flows**, and **Reports & Dashboards**.

---

## 📝 Features

- **Project Management**
  - Create and track sustainability projects
  - View project details, status, and dates
  - Calculate carbon balance (emissions minus offsets)

- **Emission Tracking**
  - Record emission events (e.g., travel, energy, food, waste)
  - Automatic calculation using emission factors
  - Display emissions in datatables and charts

- **Offset Management**
  - Track offset actions like tree planting or carbon credits
  - Automatic roll-up to project carbon balance

- **Visualizations**
  - Reports and Dashboards for project-wise emissions and offsets
  - Charts comparing emissions vs offsets

- **User Interface**
  - Lightning Web Components (LWC) for modern UX
  - Visualforce pages for detailed project and emission views
  - Form components to add emissions and offsets easily

- **Automation**
  - Apex triggers to auto-update project totals
  - Flows for notifications and validations

---

## 🛠 Tech Stack

- Salesforce Platform (Salesforce DX)
- Apex Classes & Triggers
- Lightning Web Components (LWC)
- Visualforce Pages
- Salesforce Reports & Dashboards
- Flows for automation

---

## 📂 Directory Structure

force-app/
├─ main/
│ ├─ default/
│ │ ├─ classes/ # Apex classes & triggers
│ │ ├─ lwc/ # Lightning Web Components
│ │ ├─ pages/ # Visualforce pages
│ │ ├
│ │ └─ objects/ # Custom objects & fields

yaml
Copy
Edit

---

## 🚀 Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/Smart-Sustainability-Tracker.git
Deploy to your Salesforce org using Salesforce CLI:

bash
Copy
Edit
sfdx force:source:deploy -p force-app/main/default
Assign permission sets as required (if any).

Add Lightning Web Components to Lightning pages via App Builder.

Run test classes to validate Apex logic:

bash
Copy
Edit
sfdx force:apex:test:run --wait 10
⚡ Usage
Open the Project Detail page to view project data, emissions, offsets, and carbon balance.

Add new emissions or offsets using the provided LWC forms.

Visualize emissions vs offsets using dashboards and charts.

📌 Notes
Ensure all custom fields and objects are deployed before running LWC.

Apex triggers must be active for automatic calculation of project totals.

Test classes cover all major functionality; run them to verify deployment.

📝 Author
Atharva Abhay Bal

GitHub: https://github.com/atharvabal9

Email: atharvabal9@gmail.com