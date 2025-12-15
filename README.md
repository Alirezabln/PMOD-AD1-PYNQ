# FPGA/SoC ADC Acquisition & Tomography Project

## 📖 Overview
This project implements a complete data acquisition pipeline on a Xilinx Zynq SoC (PYNQ board) for capturing, buffering, and analyzing analog signals from SiPM detectors. The design integrates custom VHDL modules, AXI DMA, and Python processing to enable continuous sampling, timestamping, and tomography reconstruction.

Key features:
- **ADC + SPI Controller** for PMOD AD1 modules
- **Sample Packer** to align 12‑bit ADC data into 32‑bit words
- **Asynchronous FIFO** for safe clock domain crossing
- **AXI Stream Bridge + DMA** for high‑throughput transfers to DDR
- **Python/PYNQ layer** for visualization, FFT analysis, and tomography algorithms

<img width="958" height="229" alt="image" src="https://github.com/user-attachments/assets/565779d2-6499-4d05-8f4f-616334477833" />


---

## ⚙️ System Architecture
1. **Hardware (FPGA logic)**
   - SPI controller for ADC
   - Sample packer
   - Dual‑clock FIFO
   - AXI Stream bridge
   - AXI DMA to DDR
  
<img width="732" height="250" alt="image" src="https://github.com/user-attachments/assets/0780d98b-acd7-4480-a23c-c38a14d6df90" />


2. **Software (PS + Python)**
   - PYNQ MMIO for register control
   - DMA buffer acquisition
   - NumPy/Matplotlib for analysis
   - Tomography reconstruction algorithms (future work)
     
<img width="601" height="317" alt="image" src="https://github.com/user-attachments/assets/998747a5-f22e-4aaf-b5d9-df503df75b1d" />


---

## 🚀 Getting Started

### Prerequisites
- Xilinx PYNQ board (Zynq‑7020)
- PMOD AD1 ADC module
- Vivado for bitstream generation
- Python 3 with PYNQ libraries

### Installation
Clone the repository:
```bash
git clone https://github.com/Alirezabln/PMOD-AD1-PYNQ
cd PMOD-AD1-PYNQ
