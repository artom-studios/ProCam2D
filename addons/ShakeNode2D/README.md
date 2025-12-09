# ShakeNode2D Plugin

A standalone shake effect plugin for Godot 4.x that can be attached to any `Node2D` or `Control` node to apply dynamic shake effects.

## Features

- **Universal Compatibility**: Works with any `Node2D` (sprites, scenes, etc.) or `Control` (UI elements)
- **8 Shake Types**: Vertical, Horizontal, Random, Perlin, Rotate, Circular, and Zoom
- **8 Built-in Presets**: Gunshot, Earthquake, Handheld, Explosion, Impact, Rumble, Vibration, and Wobbly
- **Trauma System**: Attack, sustain, and decay phases for realistic shake behavior
- **Endless Mode**: Optional continuous shaking until manually stopped
- **Signals**: `shake_started` and `shake_stopped` for event-driven programming

## Installation

1. Copy the `addons/ShakeNode2D` folder to your project's `addons/` directory
2. Open your project in Godot
3. Go to **Project → Project Settings → Plugins**
4. Enable the **ShakeNode2D** plugin

## Quick Start

1. Add a `ShakeNode2D` as a child to any node you want to shake (e.g., Sprite2D, Button, Panel)
2. Configure the shake properties in the Inspector
3. Call `shake()` from code to trigger the effect

### Example:

```gdscript
extends Sprite2D

@onready var shake = $ShakeNode2D

func _ready():
	# Use a preset
	shake.preset = ShakeNode2D.Preset.EARTHQUAKE
	shake.shake()

func on_player_hit():
	# Or customize settings
	shake.preset = ShakeNode2D.Preset.CUSTOM
	shake.intensity = 15.0
	shake.duration = 0.3
	shake.shake()
```

## API

### Methods

- `shake()` - Start or restart the shake effect
- `stop()` - Stop shaking and restore original transform
- `is_shaking() -> bool` - Check if currently shaking
- `add_trauma(amount: float)` - Add trauma to ongoing shake
- `reset_shake()` - Reset timer and trauma values

### Signals

- `shake_started` - Emitted when shake begins
- `shake_stopped` - Emitted when shake ends

### Properties

- **preset** - Choose from 9 presets (Custom, Gunshot, Earthquake, etc.)
- **speed** (0-100) - How fast the shake oscillates
- **intensity** (0-100) - Amplitude of the shake
- **shake_type** - Flags for enabled shake types (Vertical, Horizontal, etc.)
- **trauma_attack** (0-10) - Fade-in time in seconds
- **trauma_decay** (0-10) - Fade-out time in seconds
- **duration** (0-10) - Sustain time in seconds
- **endless** - If true, shake continues until `stop()` is called

## Presets

Each preset provides a distinct shake feel:

- **Gunshot**: Quick, sharp horizontal/vertical shake
- **Earthquake**: Slow, powerful shake with Perlin noise
- **Handheld**: Subtle continuous camera wobble
- **Explosion**: Random shake with zoom effect
- **Impact**: Strong vertical shake with rotation
- **Rumble**: Medium-intensity all-directional shake
- **Vibration**: Fast, short oscillation
- **Wobbly**: Slow rotation with Perlin noise

## Examples

See `addons/ShakeNode2D/examples/` for demonstration scenes.

## Credits

Derived from the ProCam2D shake system by Daz B. Like / Kalulu Games.

## License

MIT License - Feel free to use in commercial and personal projects.
