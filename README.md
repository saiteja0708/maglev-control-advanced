# Magnetic Levitation System — Advanced Control Design

Implementation and benchmarking of three control strategies for a nonlinear magnetic levitation 
system, modelled and simulated in MATLAB/Simulink.

---

## 🎯 Project Overview

A magnetic levitation system is inherently unstable and nonlinear — making it an ideal testbed 
for advanced control design. This project models the system dynamics, linearizes around an 
operating point, and implements three controllers of increasing complexity to achieve stable 
levitation.

---

## ⚙️ Controllers Implemented

| Controller | Approach | Strength |
|---|---|---|
| State-Space (Pole Placement) | Linearized model, full state feedback | Fast, predictable response |
| Feedback Linearization | Cancels nonlinearities exactly | Handles large deviations |
| Fuzzy Logic Controller | Rule-based, no model required | Robust to model uncertainty |

---

## 🛠️ Tools

- MATLAB / Simulink
- Control System Toolbox
- Fuzzy Logic Toolbox

---

## 📂 File Structure

| File | Description |
|---|---|
| `pole_placement_controller_and_observer.m` | State-space controller with Luenberger observer |
| `fuzzy_controller_final.m` | Final tuned fuzzy logic controller |
| `fuzzy_controller_comparison.m` | Fuzzy controller variant for benchmarking |
| `SoSe24_report2_Karanam_Parackanirappel Shaji.pdf` | Full project report |

---

## 👤 My Contribution

Responsible for all MATLAB/Simulink implementation — including nonlinear system modelling, 
linearization, pole placement with Luenberger observer design, feedback linearization, and 
fuzzy logic controller design and tuning. My partner handled report writing and documentation.

---

## 📈 Key Takeaways

- Feedback linearization achieved the most accurate tracking for large reference steps
- Fuzzy logic showed the best robustness when system parameters varied
- Pole placement provided the fastest settling time around the nominal operating point
