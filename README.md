# ProCam2D - Professional 2D Camera for Godot 4

![procam icon](https://i.ibb.co/dkT2tPQ/procam-icon.png)

<p align="center">
  <strong>A feature-rich, intuitive 2D camera system that makes your game feel professional from day one.</strong>
</p>

<p align="center">
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-key-features">Features</a> •
  <a href="#-examples">Examples</a> •
  <a href="#-documentation">Documentation</a> •
  <a href="#-contributing">Contributing</a>
</p>

---

## 🎯 Overview

**ProCam2D** is a standalone 2D camera system for Godot 4 that goes far beyond the built-in `Camera2D`. Whether you're making a platformer, top-down shooter, or split-screen co-op game, ProCam2D gives you cinematic-quality camera control with minimal setup.

> **Why ProCam2D?** Because your camera should be as polished as your gameplay.

### ✨ What Makes It Special?

- 🎮 **Zero Hassle Setup**: Drop in a node, add targets, done
- 🔌 **Extensible Architecture**: Built-in addons + write your own
- 🎬 **Cinematic Tools**: Smooth transitions, camera shake, zoom zones, and more
- 🖥️ **Split-Screen Ready**: Supports 2, 3, 4+ players out of the box
- 🎯 **Smart Following**: Multi-target tracking with auto-zoom
- 🧩 **Modular Design**: Only use what you need

---

## 🚀 Quick Start

### Installation

1. **Download** ProCam2D from the [Asset Library](https://godotengine.org/asset-library) or [clone this repo](https://github.com/artom-studios/ProCam2D)
2. **Enable** the plugin: `Project → Project Settings → Plugins → ProCam2D → Enable`
3. **You're ready!** The `procam` autoload is now available globally.

### Your First Camera (30 Seconds)

1. Press **`Ctrl+A`** and search for **`ProCam2D`**
2. Add it to your scene (can be anywhere in the tree)
3. Add a **`PCamTarget`** as a child of your player
4. **Run the game** — Your camera is now following your player!

```gdscript
# Access from anywhere via the autoload
procam.zoom = 1.5
procam.smooth_drag_speed = Vector2(10, 10)
```

That's it! You now have a professional camera with smooth following.

---

## 🎨 Key Features

### 🎯 Smart Target Following

**Single Target Mode**: Focus on your main character with buttery-smooth motion
```gdscript
procam.follow_mode = ProCam2D.FollowMode.SINGLE_TARGET
```

**Multi-Target Mode**: Automatically frames multiple players/enemies
```gdscript
procam.follow_mode = ProCam2D.FollowMode.MULTI_TARGET
procam.auto_zoom = true  # Zooms out to fit everyone
```

### 🎬 Cinematic Sequences

Create professional cutscenes with `PCamCinematic` nodes:

```gdscript
# Place PCamCinematic nodes in your level
# They all share the same cinematic_id = "intro"

func _on_player_entered_trigger():
    procam.start_cinematic("intro")  # Plays the sequence automatically
```

### 🌊 Influence Nodes

Add invisible zones that affect camera behavior:

| Node | Purpose | Use Case |
|------|---------|----------|
| **PCamMagnet** | Attracts/Repels camera | Boss intro, secret areas |
| **PCamRoom** | Constrains to a rectangle | Zelda-style room transitions |
| **PCamZoom** | Changes zoom in an area | Wideangle vistas, tight corridors |
| **PCamPath** | Follows a path | 2D side-scroller rails |

All influence nodes support `camera_id` for per-camera control and `affect_all_cameras` for global effects.

### 🎮 Multiple Drag Types

Choose the feel that fits your game:

```gdscript
# Smooth and cinematic
procam.drag_type = ProCam2D.DragType.SMOOTH_DAMP

# Predictive (looks ahead of movement)
procam.drag_type = ProCam2D.DragType.LOOK_AHEAD

# Responsive (adapts to speed)
procam.drag_type = ProCam2D.DragType.AUTO_SPEED

# Bouncy (spring physics)
procam.drag_type = ProCam2D.DragType.SPRING_DAMP
```

### 🔌 Powerful Addon System

Extend the camera with built-in addons or write your own:

**Built-in Addons:**
- **PCamShake**: 7 shake types + 8 presets (gunshot, earthquake, etc.)
- **PCamMouseFollow**: Cursor-based camera offset (great for aiming)
- **PCamGrids**: Snap to grid (pixel-perfect movement)

**Add via Code:**
```gdscript
var shake = PCamShake.new()
shake.apply_preset(shake.Preset.EXPLOSION)
procam.add_addon(shake)
shake.shake()  # Boom!
```

**Add via Inspector:**
Just expand the `Addons` array and pick from the list.

---

## 🖥️ Split-Screen Multiplayer

ProCam2D makes split-screen **dead simple**. Here's a 2-player setup:

### Setup (GDQuest Method - Recommended)

1. Create your **World** in `SubViewport1`
2. Add **ProCam2D** for Player 1 (inside World, `camera_id = "1"`)
3. Add **ProCam2D** for Player 2 (in `SubViewport2`, `camera_id = "2"`)
4. **Share the world** from Viewport 1:

```gdscript
func _ready():
    # This line shares the world across both viewports
    $SubViewportContainer2/SubViewport.world_2d = $SubViewportContainer1/SubViewport.world_2d
```

5. Assign **PCamTargets** with matching `camera_id` values

### 3+ Player Split-Screen

Use a `GridContainer` with as many viewports as you need! See `examples/split_screen/split_screen_4player.tscn` for a working 4-player demo.

### Per-Camera Effects

```gdscript
# Add shake only to Player 1's camera
var cam1 = procam.get_camera_by_id("1")
cam1.add_addon(PCamShake.new())

# Different drag type for Player 2
var cam2 = procam.get_camera_by_id("2")
cam2.drag_type = ProCam2D.DragType.SPRING_DAMP
```

---

## 📚 Core Concepts

### The Autoload: `procam`

The `procam` singleton is your main interface:

**Single Camera (Auto-manages `current_camera`):**
```gdscript
# Uses ProCam2D enums via the autoload
procam.drag_type = procam.DragType.SMOOTH_DAMP
procam.follow_mode = procam.FollowMode.MULTI_TARGET
procam.zoom = 2.0
procam.allow_rotation = true
procam.start_cinematic("intro")
```

**Multi-Camera (Access specific cameras by ID):**
```gdscript
# Get camera by ID and use it directly
var cam1 = procam.get_camera_by_id("1")
cam1.zoom = 1.5
cam1.drag_type = procam.DragType.SPRING_DAMP
cam1.start_cinematic("player1_intro")

var cam2 = procam.get_camera_by_id("2")
cam2.zoom = 2.0
cam2.drag_type = procam.DragType.LOOK_AHEAD
cam2.stop_cinematic()
```

**Iterate all cameras:**
```gdscript
for cam in procam.get_cameras():
    cam.global_debug_draw = true
```

> **💡 API Consistency**: All `ProCam2D` methods and properties work identically whether accessed via the autoload (`procam.start_cinematic()`) or directly on a camera instance (`cam1.start_cinematic()`). The autoload simply delegates to `current_camera`.

### Priority System

Higher priority = higher precedence. Applies to:
- **Targets** (single-target mode picks highest)
- **Rooms** (overlapping rooms)
- **Paths** (overlapping paths)
- **Cinematics** (sequence order)
- **Addons** (processing order)

```gdscript
# Player target has priority 10
player_target.priority = 10

# Boss target has priority 20 (will be followed instead)
boss_target.priority = 20
```

### Camera IDs & Affect All

```gdscript
# This PCamMagnet only affects camera "1"
magnet.camera_id = "1"

# This PCamRoom affects ALL cameras
room.affect_all_cameras = true
```

---

## 📦 Examples Included

Explore the `addons/ProCam2D/examples/` folder:

| Example | What It Shows |
|---------|---------------|
| **`split_screen_gdquest.tscn`** | 2-player split-screen with WASD controls |
| **`split_screen_4player.tscn`** | 4-player grid layout (2x2) |
| **`loader_demo.tscn`** | Async scene loading with progress bar |

Each example is fully commented and ready to run!

---

## 🎓 API Reference

### ProCam2D Node

#### Follow Settings
```gdscript
follow_mode: FollowMode               # SINGLE_TARGET or MULTI_TARGET
drag_type: DragType                   # Movement feel (4 types)
smooth_drag: bool                     # Smooth camera motion
smooth_drag_speed: Vector2            # Drag smoothing speed
prediction_time: Vector2              # Look-ahead time (LOOK_AHEAD mode)
```

#### Offset & Rotation
```gdscript
offset: Vector2                       # Camera offset from target
smooth_offset: bool                   # Smooth offset transitions
smooth_offset_speed: float            # Offset smoothing speed
allow_rotation: bool                  # Follow target rotation
smooth_rotation: bool                 # Smooth rotation transitions
smooth_rotation_speed: float          # Rotation smoothing speed
```

#### Zoom
```gdscript
zoom: float                           # Manual zoom level
smooth_zoom: bool                     # Smooth zoom transitions
smooth_zoom_speed: float              # Zoom smoothing speed
auto_zoom: bool                       # Auto-fit multiple targets
min_zoom: float                       # Min zoom (auto mode)
max_zoom: float                       # Max zoom (auto mode)
zoom_margin: float                    # Padding for auto-zoom
```

#### Limits
```gdscript
left_limit: int                       # Left boundary
right_limit: int                      # Right boundary
top_limit: int                        # Top boundary
bottom_limit: int                     # Bottom boundary
smooth_limit: bool                    # Smooth limit clamping
```

#### Deadzones (Margins)
```gdscript
use_h_margins: bool                   # Enable horizontal deadzone
use_v_margins: bool                   # Enable vertical deadzone
left_margin: float                    # Left deadzone (0-1)
right_margin: float                   # Right deadzone (0-1)
top_margin: float                     # Top deadzone (0-1)
bottom_margin: float                  # Bottom deadzone (0-1)
```

#### Methods
```gdscript
start_cinematic(id: String)           # Play cinematic sequence
stop_cinematic()                      # Stop current cinematic
reset_camera()                        # Snap to target instantly
add_addon(addon: PCamAddon)           # Add camera addon
remove_addon(addon: PCamAddon)        # Remove camera addon
get_addons() -> Array                 # Get all addons
get_camera_bounds() -> Rect2          # Get visible area
```

#### Signals
```gdscript
cinematic_started(cinematic_id)       # Cinematic began
cinematic_stopped(cinematic_id)       # Cinematic ended
addon_message(message)                # Addon sent a message
```

---

### PCamTarget

The node that tells the camera where to follow.

```gdscript
priority: int                         # Target priority (higher = more important)
radius: float                         # Auto-zoom radius
offset: Vector2                       # Offset from parent position
influence: Vector2                    # How much to influence camera (0-1+)
rotation_influence: float             # Rotation influence (0-1+)
disable_outside_limits: bool          # Ignore target outside limits
camera_id: String                     # Which camera to affect
```

---

### PCamCinematic

Defines a cinematic camera point.

```gdscript
cinematic_id: String                  # Sequence identifier
hold_time: float                      # How long to hold this point
target_zoom: float                    # Zoom level at this point
drag_speed: Vector2                   # Move speed to this point
rotation_speed: float                 # Rotation speed
zoom_speed: float                     # Zoom speed
priority: int                         # Order in sequence (higher = sooner)
camera_id: String                     # Specific camera
affect_all_cameras: bool              # Affect all cameras
```

---

### PCamMagnet

Attracts or repels the camera.

```gdscript
attract_repel: AttractRepel           # ATTRACT or REPEL
magnet_shape: MagnetShape             # CIRCLE or RECTANGLE
radius: float                         # Circle radius
rectangle_size: Vector2               # Rectangle size
use_full_force: bool                  # Full snap vs. gradual force
force: Vector2                        # Force strength (if not full)
falloff_curve: Curve                  # Force falloff curve
```

**Signals:**
- `magnet_entered()`
- `magnet_exited()`

---

### PCamZoom

Changes zoom in an area.

```gdscript
zoom_shape: ZoomShape                 # CIRCLE or RECTANGLE
radius: float                         # Circle radius
rectangle_size: Vector2               # Rectangle size
zoom_factor: float                    # Zoom multiplier
gradual_zoom: bool                    # Smooth transition
```

**Signals:**
- `zoom_area_entered()`
- `zoom_area_exited()`
- `zoom_level_changed(zoom_level)`

---

### PCamRoom

Constrains camera to a room.

```gdscript
room_size: Vector2                    # Room dimensions
zoom: float                           # Forced zoom level
open_sides: BitMask                   # Which sides are open (left/right/top/bottom)
```

**Signals:**
- `room_entered(room)`
- `room_exited(room)`

---

### PCamPath

Constrains camera to a path.

```gdscript
constraint_axis: AxisConstraint       # X or Y axis
```

---

## 🛠️ Writing Custom Addons

Addons let you modify camera behavior at specific stages. Here's a template:

```gdscript
extends PCamAddon
class_name MyCustomAddon

@export var my_property: float = 1.0

func setup(camera):
    stage = "pre_process"  # "pre_process", "post_smoothing", or "final_adjust"

func pre_process(camera, delta):
    # Modify target values before smoothing
    camera._target_position += Vector2(10, 0) * my_property

func exit(camera):
    # Cleanup when removed
    pass
```

### Addon Stages

| Stage | When It Runs | Use For |
|-------|--------------|---------|
| **pre_process** | Before smoothing | Modifying `_target_position`, `_target_zoom`, `_target_rotation` |
| **post_smoothing** | After smoothing | Modifying `_current_position`, `_current_zoom`, `_current_rotation` |
| **final_adjust** | Final step | Screen shake, post-processing effects |

### Example: Grid Snapping

```gdscript
extends PCamAddon
class_name PCamGrids

@export var grid_size := Vector2(64, 64)
@export var grid_offset := Vector2.ZERO

func setup(camera):
    stage = "pre_process"

func pre_process(camera, delta):
    var snapped = camera._target_position.snapped(grid_size) + grid_offset
    camera._target_position = snapped
```

**Add it:**
```gdscript
procam.add_addon(PCamGrids.new())
```

---

## 🔧 Advanced Tips

### Smooth Transitions Between Targets

```gdscript
# Switch targets smoothly
func switch_to_boss():
    player_target.priority = 0
    boss_target.priority = 100
    # Camera smoothly transitions due to smooth_drag
```

### Triggering Camera Shake on Hit

```gdscript
func _on_player_hit():
    var shake = procam.get_addons()[0]  # If you added it via inspector
    shake.add_trauma(0.5)  # Procedural shake intensity
```

### Dynamic Zoom Zones

```gdscript
# Create zoom zones at runtime
var zoom_zone = PCamZoom.new()
zoom_zone.position = Vector2(500, 300)
zoom_zone.radius = 200
zoom_zone.zoom_factor = 2.0
add_child(zoom_zone)
```

### Pixel-Perfect Camera

```gdscript
var camera = procam.current_camera
camera.pixel_perfect = true  # Rounds position every frame
```

---

## 🎬 Cinematic Sequences Example

```gdscript
# Scene setup: Place 3 PCamCinematic nodes
# All with cinematic_id = "intro"
# Priority: 0, 1, 2 (plays in order)

func start_intro():
    procam.start_cinematic("intro")

func _ready():
    procam.cinematic_started.connect(_on_cinematic_started)
    procam.cinematic_stopped.connect(_on_cinematic_stopped)

func _on_cinematic_started(id):
    print("Cinematic " + id + " started!")
    player.disable_input()

func _on_cinematic_stopped(id):
    print("Cinematic " + id + " ended!")
    player.enable_input()
```

---

## 🎮 PCamShake Presets

The shake addon comes with 8 cinematic presets:

| Preset | Feel | Use Case |
|--------|------|----------|
| **GUNSHOT** | Quick recoil | Weapons, punches |
| **EXPLOSION** | Strong burst | Big explosions |
| **EARTHQUAKE** | Continuous rumble | Boss stomps, terrain events |
| **IMPACT** | Sudden jolt | Collisions, landings |
| **HANDHELD** | Subtle sway | Atmospheric immersion |
| **RUMBLE** | Low vibration | Engines, machinery |
| **VIBRATION** | High frequency | Electric shocks |
| **WOBBLY** | Gentle wave | Drunk effect, underwater |

```gdscript
var shake = PCamShake.new()
shake.apply_preset(shake.Preset.EXPLOSION)
procam.add_addon(shake)
shake.shake()
```

---

## 🐛 Troubleshooting

### Camera Not Following?
- Check that your `PCamTarget` has the correct `camera_id`
- Verify `enabled = true` on both camera and target
- Ensure target is in the scene tree

### Split-Screen Not Working?
- Make sure `world_2d` is shared correctly
- Verify each camera has a unique `camera_id`
- Check that targets match their camera IDs

### Influence Nodes Not Working?
- Set `affect_all_cameras = true` OR match `camera_id`
- Check that the node is enabled
- Verify position is within range

### Jittery Camera?
- Use `process_frame = PHYSICS` for physics-based games
- Lower `smooth_drag_speed` for slower following
- Enable `smooth_limit` for smoother boundary clamping

---

## 🤝 Contributing

We love contributions! Here's how to help:

1. **Fork** this repository
2. **Create a branch** (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open a Pull Request**

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

### Reporting Bugs

Found a bug? [Open an issue](https://github.com/artom-studios/ProCam2D/issues) with:
- Godot version
- ProCam2D version
- Steps to reproduce
- Expected vs. actual behavior

---

## 📜 License

ProCam2D is licensed under the **MIT License**. See [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

- **GDQuest** for split-screen architecture inspiration
- The **Godot Community** for feedback and support
- **You** for using ProCam2D!

---

<p align="center">
  <strong>Made with ❤️ for the Godot community</strong><br>
  <sub>Star this repo if ProCam2D makes your game better!</sub>
</p>

<p align="center">
  <a href="https://github.com/artom-studios/ProCam2D">🌟 Star on GitHub</a> •
  <a href="https://github.com/artom-studios/ProCam2D/issues">🐛 Report Bug</a> •
  <a href="https://github.com/artom-studios/ProCam2D/discussions">💬 Discussions</a>
</p>
