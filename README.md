# HFI_Experimentation_SecondaryTaskPrograms
Code for secondary task programs for use in cognitive load experiments

This repo contains Processing scripts that generate a randomized, pre-calculated visual stimulus sequence designed for block experiments. It displays an alternating sequence of colored shapes (circles and squares) and blank screens, allowing for real-time speed adjustments and timing logs.

This has only ben used in demos thus far. The content below describes what is in the v3 sketch rather than the older v2.

## Prerequisites & Setup

To run this script, you will need the Processing IDE installed on your computer.

* **Download Processing:** [https://processing.org/download](https://processing.org/download)
* **Installation:** Choose the correct version for your operating system (Windows, macOS, or Linux), extract the files, and open the Processing application. 


## What's New in v3

Version 3 introduces several quality-of-life improvements for the experimenter, bug fixes, and better data tracking:

* **Manual Start/Stop & Run Timers:** The sequence no longer starts automatically. The screen remains black until the experimenter presses the `RIGHT` arrow to engage the loop. Pressing the `LEFT` arrow now stops the loop and calculates the total run time in milliseconds.
* **Console Logging:** Added real-time feedback for the experimenter. The Processing console now outputs the start/stop status, total run time, and the current speed multiplier (`scalar`) whenever it is adjusted. 
* **Boundary Constraints:** Fixed an issue from v2 where shapes could spawn on the exact edge of the window and be partially cut off. Shapes are now constrained using padding to ensure they are always 100% visible on screen.
* **Stability Fixes & Tweaks:** * Fixed an array index out-of-bounds bug that would crash the program at the end of the `200` item sequence.
  * Improved the accuracy of the delay calculations when changing speeds by switching the math function from `floor()` to `round()`.
* **Smooth Rendering & Instant Controls:** Replaced the freezing `delay()` function with a non-blocking `millis()` timer, and removed the `PGraphics` buffer. This completely eliminates screen flicker between shapes and ensures that keyboard commands (like pausing or changing speeds) are registered instantly, even during long wait periods.

### How to Run
1. Open the .pde file (v3) in Processing
2. Press the **Play** button (or `Ctrl+R` / `Cmd+R`) to run the sketch. The screen will initially be black until you start the sequence.

---

## How It Works

The script pre-generates an array of `200` steps (`len = 200`). The sequence alternates strictly between:
* **Stimulus (Even steps):** A shape (circle or square) in a randomized color (Yellow, Red, or Blue) appears at a random location on the screen. It stays on screen for a randomized wait time.
* **Blank (Odd steps):** The screen returns to black for a randomized duration before the next stimulus appears.

The script runs in **Full Screen** mode and outputs interaction logs (like run times and speed adjustments) directly to the Processing console.

---

## Controls

The experimenter can control the flow and speed of the sequence using the arrow keys. 

| Key | Action | Console Output |
| :--- | :--- | :--- |
| **`RIGHT Arrow`** | Starts or resumes the stimulus loop. | Prints "Looping engaged". Records start time. |
| **`LEFT Arrow`** | Stops or pauses the stimulus loop. | Prints "Looping disengaged" and the total run time in milliseconds. |
| **`UP Arrow`** | **Increases** sequence speed by reducing the wait time scalar (minimum 0.1). | Prints the new time scalar value. |
| **`DOWN Arrow`** | **Decreases** sequence speed by increasing the wait time scalar. | Prints the new time scalar value. |

---

## Configuration

If you need to tweak the experiment parameters, you can easily modify the global variables at the top of the script:

* **`dotSize`**: (Default: `60`) Changes the diameter/width of the circles and squares.
* **`len`**: (Default: `200`) The total number of steps in the sequence (including both stimuli and blanks).
* **`colors`**: The array containing the RGB values for the shapes. By default, it uses Yellow, Red, Blue, and Black.
* **`waitSpeeds`**: An array of predefined delays in milliseconds (Default: `500`, `1000`, `2000`, `3000`, `4000`).

---

## Notes & Troubleshooting

* **Multi-Monitor Setups (Linux/Ubuntu):** By default, Processing's `fullScreen()` command may open the experiment on a secondary monitor. If the window appears on the wrong screen, simply press **`Alt + F7`** to "grab" the window and use your mouse or arrow keys to move it to your preferred display. This safely bypasses the program's built-in start/stop keyboard controls.
* **Console Tracking:** Ensure you keep the Processing console visible on your secondary monitor during the experiment, as all trial times and looping toggles are printed there rather than on the visual display.
* **Variable Value Visibility:** Ensure you keep the Processing console visible on your secondary monitor during the experiment, as all trial times and looping toggles are printed there rather than on the visual display.
