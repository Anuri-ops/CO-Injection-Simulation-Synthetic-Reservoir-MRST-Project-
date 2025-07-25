
# CO₂ Injection Simulation – Synthetic Reservoir (MRST Project)

This project simulates **CO₂ injection** into a 2D synthetic saline aquifer using the **MATLAB Reservoir Simulation Toolbox (MRST)**. It demonstrates basic concepts of enhanced oil recovery (EOR) and CO₂ plume migration in porous media.

---

##  Objective

Model and visualise the behaviour of injected CO₂ in a homogeneous reservoir using:
- A 2D grid (60 × 40 cells)
- Homogeneous rock and fluid properties
- One injector and one producer
- 10 simulation steps over 100 days

---

##  Tools and Framework

- **MRST (2025a)** – Modules used:
  - `ad-core`, `ad-blackoil`, `mrst-gui`
- **MATLAB**
- **Autodiff-based simulation engine (AD-Blackoil)**
- **Saturation visualization with `plotCellData()`**

---

##  Model Setup

- **Grid**: 600 × 400 m domain, 10 × 10 m cells  
- **Porosity**: 20%  
- **Permeability**: 100 mD  
- **Initial Conditions**: 100% brine-saturated, 100 bars  
- **Injection**: CO₂ at top-left (rate-controlled)  
- **Production**: Bottom-right (BHP-controlled)

---

##  Simulation Details

```matlab
G = cartGrid([60, 40], [600, 400]);
rock.poro = 0.2;
rock.perm = 100 * milli*darcy;

fluid = initSimpleADIFluid('phases', 'WG', ... % Water-Gas system
                           'mu', [1, 0.06]*centi*poise, ...
                           'rho', [1000, 700], ...
                           'n', [2, 2]);

% Initial state: full brine saturation
state0 = initResSol(G, 100*barsa, [1, 0]);
```

---

##  Result Preview

At Time Step 10 (end of simulation), CO₂ saturation near the injector was:

![CO₂ Saturation](co2_saturation_t10.png)

---

##  How to Run

1. Ensure MRST 2025a is installed and `ad-core`, `ad-blackoil`, `mrst-gui` are added:
   ```matlab
   mrstModule add ad-core ad-blackoil mrst-gui
   ```
2. Run the script: `co2_injection_simulation.m`
3. Plots will show saturation development at each time step

---

##  Key Takeaways

- Grid generation and geometry computation in MRST
- Setting up rock and fluid properties
- Well configuration and control types
- Saturation visualisation
- Basic CO₂ storage behaviour in porous media

---

##   Notes

This project was created to strengthen the foundational understanding of reservoir simulation using MRST.

