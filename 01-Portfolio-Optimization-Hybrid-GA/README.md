# Hybrid Portfolio Optimization: GA, TOPSIS & Hybrid Clustering (SOM + K-means)
# Hybride Portfolio-Optimierung: GA, TOPSIS & Hybrid-Clustering (SOM + K-means)

## 🌎 Language / Sprache
- [English](#english)
- [Deutsch](#deutsch)

---

<a name="english"></a>
## 🇬🇧 English: Project Overview

### 📋 Description
This repository contains the MATLAB implementation of the research paper: **"A Hybrid Model for Portfolio Optimization Based on Stock Clustering and Different Investment Strategies"** (2017). 

### 🔬 Methodology & Logic
The source code implements a full pipeline for financial data processing:
1. **Data Preprocessing:** Implementation of variance-based normalization functions for 5 financial indicators.
2. **Hybrid Clustering:** Integration of **Self-Organizing Maps (SOM)** and **K-means** to identify stable stock groups.
3. **MVS Optimization:** A Genetic Algorithm (GA) designed to solve the **Mean-Variance-Skewness** multi-objective problem.

### 🔒 Data Availability Statement
The original dataset (66 TSE companies) is **not publicly available** due to confidentiality restrictions. 
* The code provided is **fully normalized** and structured to accept any standard financial time-series data.
* Users can input their own preprocessed data into the `newmvs.m` entry point.

---

<a name="deutsch"></a>
## 🇩🇪 Deutsch: Projektübersicht

### 📋 Beschreibung
MATLAB-Implementierung der Forschungsarbeit zur hybriden Portfolio-Optimierung (2017). 

### 🔬 Methodik & Logik
Der Quellcode enthält die vollständige Logik für:
1. **Datenvorverarbeitung:** Implementierung varianzbasierter Normalisierungsfunktionen.
2. **Hybrid-Clustering:** Kombination aus **SOM** und **K-means** zur Gruppierung von Aktien.
3. **MVS-Optimierung:** Ein genetischer Algorithmus zur Lösung des **Mean-Variance-Skewness** Modells.

### 🔒 Erklärung zur Datenverfügbarkeit
Der Original-Datensatz ist aufgrund von **Vertraulichkeitsbeschränkungen** nicht öffentlich zugänglich. 
* Der bereitgestellte Code ist **vollständig normalisiert** und auf die Verarbeitung standardisierter Finanzdaten ausgelegt.
* Eigene Datensätze können direkt in die `newmvs.m` Funktion geladen werden.

---

## 📁 Repository Structure / Struktur
- `/MATLAB-Source`: Core scripts (`newmvs.m`, `mygaobj.m`, `Crossover3.m`, etc.)
- `/Paper`: Full PDF of the published research paper.

## 📖 Citation / Zitierung
> Goudarzi, S., Jafari, M. J., & Afsar, A. (**2017**). [A Hybrid Model for Portfolio Optimization...](https://www.econjournals.com/index.php/ijefi/article/view/4758). *International Journal of Economics and Financial Issues*, 7(3), 602-608.

---
*Developed by: Siamak Goudarzi*
