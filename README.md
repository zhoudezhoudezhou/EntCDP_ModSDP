# EntCDP and ModSDP:

## Introduction

- **EntCDP**: aims to identify **common signaling pathways** across multiple cancer types.  
  To run EntCDP: `run_EntCDP.m`
- **ModSDP**: aims to identify **specific signaling pathways** in one group of cancers **compared to another group**.  
  To run ModSDP: `run_ModSDP.m`

---

## Requirements

- **MATLAB** (tested on R2021a and above)
- **IBM ILOG CPLEX Optimizer** (for solving ModSDP via mathematical programming)
- Alternatively, a Genetic Algorithm (GA)-based solver is provided: `ModSDP_GA_matlab.m` (does not require CPLEX)

> [Download IBM CPLEX here](https://www.ibm.com/products/ilog-cplex-optimization-studio)
