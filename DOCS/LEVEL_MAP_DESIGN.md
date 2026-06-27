# Level Map Design Concept & Gamification Strategy

## 1. Design Concept: The Winding Learning Path

To create an engaging experience similar to Duolingo or Candy Crush, the Level Map should feature a vertical, continuously scrolling "winding path". This gives the illusion of a journey or an adventure through different learning zones.

**Layout Mechanics:**
*   **Vertical Scrolling:** The user scrolls vertically (typically starting from the bottom and moving up, or top to bottom depending on preference, but bottom-up feels more like "climbing" to a goal).
*   **Curved Path:** A thick, dotted, or dashed line connects the level nodes. The line curves left and right rhythmically to keep the visual flow interesting and less rigid.
*   **Themed Zones:** Every 10-15 levels, the background and node styling subtly change (e.g., from a "Forest of Fundamentals" to "Mountains of Mastery") to signify progression.

**Level State Representations:**

*   **Locked Levels:**
    *   **Visual:** Grayed out or desaturated node. Perhaps a small padlock icon overlay.
    *   **Path:** The path leading to them is faint or dashed, showing it hasn't been traveled yet.
    *   **Interaction:** Tapping shows a tooltip like "Complete previous levels to unlock!" with a slight shake animation.

*   **Current (Active) Level:**
    *   **Visual:** The largest, most vibrant node on the screen. It should have a glowing aura or a gentle pulsating scale animation to draw immediate attention.
    *   **Character Avatar:** Place the user's avatar or a mascot character standing exactly on this node.
    *   **Path:** The path leading up to it is fully colored and vibrant.

*   **Completed Levels:**
    *   **Visual:** Brightly colored but slightly smaller than the active node. They display the number of "Stars" earned (1 to 3) directly below or above the node.
    *   **Style:** A golden rim or a checkmark badge indicates successful completion.
    *   **Interaction:** Tapping allows replaying the level.

---

## 2. Visual Elements & Animations

To make the experience addictive and polished, incorporate the following visual elements and micro-interactions:

**3D-Like Effects (Neumorphism / Soft 3D):**
*   **Nodes as Buttons:** Level nodes shouldn't be flat. Give them a subtle bevel, a drop shadow, and a top highlight to make them look like tactile, pressable "gummies" or 3D coins.
*   **Path Depth:** The winding path can have a slight inset shadow, making it look like a groove carved into the background landscape.

**Animations (Lottie / Rive):**
*   **Active Node Idle (Rive):** Use a Rive animation for the active level node so it breathes (slowly scaling up and down) or has a continuous shiny sweep passing over it.
*   **Unlock Sequence (Lottie):** When a user completes a level and returns to the map, play a Lottie animation showing the path quickly filling with color to the next node, and the padlock bursting off the new level.
*   **Mascot Idle:** The character standing on the current node should have a subtle idle breathing/blinking animation.

**Micro-Interactions & Haptics:**
*   **Tap Feedback:** Every tap on a playable node should trigger a slight scale-down (press effect), a pop sound, and a light haptic vibration.
*   **Star Celebration:** If a user clicks a completed level, the 3 stars should animate in one by one with a satisfying *ding-ding-ding*.
*   **Scrolling Parallax:** The background landscape (trees, clouds, castles) should scroll at a slightly slower rate than the level nodes to create a sense of depth (parallax effect).

---

## 3. Color Palette

A professional yet vibrant, "gamified educational" color scheme.

*   **Primary Color (Action / Active Level):**
    *   `#00D26A` (vibrant, encouraging green) - Used for completed paths, active nodes, and primary "Play" buttons.
*   **Secondary Color (Interactive / Quizzes):**
    *   `#FF9600` (warm, energetic orange) - Used for quiz nodes, warnings, and secondary actions.
*   **Accent Color (Final Exams / Boss Levels):**
    *   `#8A2BE2` (deep, royal purple) - Used for major milestones, final exams, or premium features. Creates a sense of mystery and reward.
*   **Background Color (Environment):**
    *   `#F4F7F6` (soft, off-white/light gray-blue) - Ensures the colorful nodes pop. Thematic elements (clouds, grass) can use variations of this.
*   **Locked State (Disabled):**
    *   `#E0E0E0` (neutral gray) - For locked nodes and un-traveled paths.
*   **Success / Stars:**
    *   `#FFD700` (golden yellow) - For stars earned, badges, and high scores.

---

## 4. Mock Data (JSON)

Below is a comprehensive list of mock data for testing the UI, including positional coordinates to map them along a winding curve.

```json
[
  {
    "id": 1,
    "title": "Introduction to Basics",
    "status": "completed",
    "stars_earned": 3,
    "type": "lesson",
    "reward_points": 50,
    "position_coordinates": {
      "x": 0.5,
      "y": 0.05
    }
  },
  {
    "id": 2,
    "title": "First Steps in Grammar",
    "status": "completed",
    "stars_earned": 2,
    "type": "lesson",
    "reward_points": 50,
    "position_coordinates": {
      "x": 0.3,
      "y": 0.15
    }
  },
  {
    "id": 3,
    "title": "Vocabulary Builder 1",
    "status": "completed",
    "stars_earned": 3,
    "type": "quiz",
    "reward_points": 100,
    "position_coordinates": {
      "x": 0.2,
      "y": 0.25
    }
  },
  {
    "id": 4,
    "title": "Sentence Structure",
    "status": "active",
    "stars_earned": 0,
    "type": "lesson",
    "reward_points": 75,
    "position_coordinates": {
      "x": 0.5,
      "y": 0.35
    }
  },
  {
    "id": 5,
    "title": "Common Phrases",
    "status": "locked",
    "stars_earned": 0,
    "type": "lesson",
    "reward_points": 50,
    "position_coordinates": {
      "x": 0.8,
      "y": 0.45
    }
  },
  {
    "id": 6,
    "title": "Pop Quiz: Basics",
    "status": "locked",
    "stars_earned": 0,
    "type": "quiz",
    "reward_points": 150,
    "position_coordinates": {
      "x": 0.7,
      "y": 0.55
    }
  },
  {
    "id": 7,
    "title": "Advanced Vocabulary",
    "status": "locked",
    "stars_earned": 0,
    "type": "lesson",
    "reward_points": 100,
    "position_coordinates": {
      "x": 0.5,
      "y": 0.65
    }
  },
  {
    "id": 8,
    "title": "Module 1 Final Exam",
    "status": "locked",
    "stars_earned": 0,
    "type": "final_exam",
    "reward_points": 500,
    "position_coordinates": {
      "x": 0.5,
      "y": 0.80
    }
  }
]
```

*Note on Coordinates:* `x` and `y` represent percentage-based placement relative to the screen width and total scrollable height (0.0 to 1.0). For example, `x: 0.5` is perfectly centered horizontally, while `x: 0.2` is towards the left. The `y` value increases as you move "up" the path.
