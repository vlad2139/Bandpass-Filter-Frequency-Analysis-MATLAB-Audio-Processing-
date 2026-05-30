# Bandpass Filter - Frequency Analysis (MATLAB GUI)

## 📌 Project Overview
This project provides a versatile software tool for cleaning audio signals from background noise and isolating specific instruments or voices[cite: 7, 70]. [cite_start]It integrates numerical signal processing with computer graphics to create an interactive frequency analysis application[cite: 7, 69]. 

[cite_start]This was developed as part of the "Computer Assisted Graphics" course by Bob Vlad Ștefan (Faculty of Electronics, Telecommunications and Information Technology - ETTI, Year II, Series B, Group 2126)[cite: 2, 3, 4, 5, 36, 37, 38, 39].

## 🎯 Main Objectives
* [cite_start]**Audio Processing:** Digital filtering of signals using Butterworth algorithms[cite: 9, 49].
* [cite_start]**Graphical User Interface (GUI):** An ergonomic control panel for manipulating parameters in real-time[cite: 10, 50].
* [cite_start]**Multi-Axis Visualization:** Simultaneous representation of the audio signal in four complementary modes: Time, Frequency, Magnitude, and Spectrogram[cite: 11, 51].

## ⚙️ Theoretical Background
[cite_start]A bandpass filter allows signals within a specific frequency range (the passband) to pass through without attenuation (or very little), while heavily attenuating frequencies outside this range[cite: 13, 14, 42, 43]. [cite_start]Structurally, it combines a High-Pass Filter (FTS) and a Low-Pass Filter (FTJ) in series[cite: 15, 41].

### Butterworth Filter Implementation
[cite_start]The application uses a Butterworth filter based on the Magnitude Equation to determine the response amplitude[cite: 22]:

$$|H(j\omega)| [cite_start]= \frac{1}{\sqrt{1 + \epsilon^2 \left(\frac{\omega}{\omega_c}\right)^{2n}}}$$ [cite: 22, 58, 63]

Where:
* [cite_start]$n$ = Filter order [cite: 23, 65]
* [cite_start]$\omega$ = Working frequency [cite: 24, 66]
* [cite_start]$\epsilon$ = Parameter determining the passband ripple [cite: 25, 67]

### Spectral Analysis
* [cite_start]**Fast Fourier Transform (FFT):** Visually highlights the elimination of unwanted spectral components[cite: 28, 61].

[cite_start]$$X(k) = \sum_{n=0}^{N-1} x(n)e^{-j\frac{2\pi}{N}kn}$$ [cite: 28, 58]

## 🖥️ User Interface (GUI) Guide
[cite_start]The intuitive interface is organized into three main sections[cite: 31]:
1. [cite_start]**Control Panel:** Options to load the audio file, set the Start/Stop cut-off frequencies, and choose the filter order[cite: 32, 54].
2. [cite_start]**Visualization Zone:** Four independent axes for comparative signal analysis (Time, Magnitude, FFT, Spectrogram)[cite: 33, 55].
3. [cite_start]**Playback System:** Dedicated buttons for comparative listening between the original and filtered signal, plus a STOP button[cite: 34, 56].

## 📂 Repository Structure
Ensure the following files are included in the repository:
* `ProiectFTB.m` — The main MATLAB executable script containing the audio processing logic and the GUI interface.
* `audio.wav` — Sample audio file provided for testing the application's filtering capabilities.
* `FTB_doc.docx` — The complete written project documentation.
* `FTB_presentation.pptx` — The presentation slides.

## 🚀 How to Run
1. Open MATLAB.
2. Ensure all project files are in your current working directory.
3. Run the script by typing `ProiectFTB` in the command window.
4. Click **📂 INCARCA AUDIO** to load the provided `.wav` file.
5. Adjust the **Frecventa START (Hz)** and **Frecventa STOP (Hz)** fields (e.g., 300 and 1000).
6. Select the **Ordin Filtru** from the dropdown menu.
7. Click **⚡ APLICA FILTRUL** to process the audio and render the visualization graphs.
8. Use the **🔊 Play Original** and **🎧 Play Filtrat** buttons to hear the audio differences, and **🛑 STOP** to halt playback.
