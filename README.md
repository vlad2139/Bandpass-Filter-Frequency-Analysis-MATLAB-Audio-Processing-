# Bandpass Filter - Audio Frequency Analysis (MATLAB GUI)

## 📌 Project Overview
This repository contains a comprehensive Digital Signal Processing (DSP) application built in MATLAB. The project provides an interactive Graphical User Interface (GUI) designed for the advanced frequency analysis and dynamic filtering of audio signals. By integrating numerical processing with real-time computer graphics, the tool allows users to clean audio files from background noise or isolate specific instruments and vocal frequencies.

## ⚙️ Core Functionality & Architecture
The core logic relies on a digital Butterworth filter design, renowned for its flat frequency response in the passband. The application functions as a bandpass filter, which structurally operates as a combination of High-Pass and Low-Pass filters connected in series. 

Key processing features include:
* **Dynamic Frequency Control:** Users can define custom lower (Start) and upper (Stop) cut-off frequencies to create a highly specific passband window.
* **Adjustable Filter Order:** The system supports dynamic switching between multiple filter orders (2nd, 4th, 8th, and 16th order), allowing users to control the steepness of the attenuation (roll-off) outside the selected frequency band.
* **Real-Time Signal Processing:** The audio array is processed entirely within the MATLAB environment, instantly applying the transfer function to the loaded audio data and preparing it for comparative playback.

## 📊 Visualization Suite
To provide a complete analytical overview, the interface renders four simultaneous, independent visualization axes:
1. **Time Domain Analysis:** A comparative plot displaying the amplitude of the raw audio signal overlaid with the filtered signal over time.
2. **Passband Characteristics:** A linear magnitude representation showing the frequency response and bandwidth window of the active Butterworth filter.
3. **Spectral Frequency (FFT):** A Fast Fourier Transform (FFT) plot that visualizes the signal in the frequency domain, explicitly highlighting the elimination of unwanted spectral components.
4. **Heatmap Spectrogram:** A time-frequency representation utilizing color intensity to display the sound's "sonic fingerprint", mapped across dynamic ranges.

## 🖥️ Graphical User Interface (GUI) Guide
The interface is structured ergonomically into distinct control and feedback zones:
* **Control Panel:** Features a file explorer button to load local audio files (`.wav`, `.mp3`, `.m4a`), text fields for precise frequency input, and a dropdown menu for selecting the filter order.
* **Processing Execution:** A dedicated "Aplica Filtrul" (Apply Filter) action button triggers the DSP algorithms and updates all visual graphs simultaneously.
* **Playback System:** Includes isolated audio controls to seamlessly switch between listening to the "Original" track and the "Filtered" result, complete with a Stop command for workflow efficiency.

## 📂 Repository Structure
Ensure the following files are present in the root directory for the application to function correctly:
* `ProiectFTB.m` — The primary MATLAB executable script containing the integrated DSP logic and GUI architecture.
* `audio.wav` — A sample audio file provided for testing the application's filtering and noise-reduction capabilities.
* `FTB_doc.docx` — The complete technical documentation and theoretical background of the project.
* `FTB_presentation.pptx` — The academic presentation slides summarizing the project's objectives and results.

## 🚀 How to Run
1. Open the MATLAB environment.
2. Navigate your working directory to the folder containing the repository files.
3. Run the application by typing `ProiectFTBbun` in the command window or by executing the script directly.
4. Click **📂 INCARCA AUDIO** to load the provided sample file or any supported custom audio file.
5. Define the target passband by adjusting the **Frecventa START (Hz)** and **Frecventa STOP (Hz)** parameters.
6. Select the desired **Ordin Filtru** (Filter Order) for roll-off severity.
7. Click **⚡ APLICA FILTRUL** to process the data and render the analytical plots.
8. Use the **🔊 Play Original** and **🎧 Play Filtrat** buttons to audit the results.

## 👨‍💻 Author
This application was developed as the final project for the "Computer Assisted Graphics" course by Bob Vlad Ștefan (Faculty of Electronics, Telecommunications and Information Technology - ETTI, Year II, Series B, Group 2126).
