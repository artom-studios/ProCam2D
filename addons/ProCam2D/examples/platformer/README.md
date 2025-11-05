# Atmospheric Platformer Example

An atmospheric minimalist platformer demonstrating **ProCam2D** with parallax backgrounds and clean geometric design.

## Features

- **Atmospheric Design**: Deep purple/blue night atmosphere with teal platforms
- **Parallax Backgrounds**: Multiple layered backgrounds creating depth
- **Large Explorable Level**: Extended platforming area (4000x1200px)
- **Smooth Camera**: ProCam2D follows the player with customizable settings
- **Clean Aesthetics**: Minimalist geometric shapes with thoughtful color theory

## What's Included

- **Player.gd**: Character controller with smooth acceleration, friction, and jump mechanics (Godot 4.5)
- **Player.tscn**: Player scene with centered ColorRect sprite and PCamTarget node
- **Platformer.tscn**: Large atmospheric level with parallax layers and 16+ platforms

## How to Run

1. Make sure ProCam2D plugin is enabled in your Godot 4.5 project
2. Open `Platformer.tscn` in the Godot editor
3. Run the scene (F6) or set it as the main scene and run the project (F5)

## Controls

- **Arrow Keys**: Move left and right
- **Space**: Jump

## Design Elements

### Color Palette
- **Sky Gradient**: Deep purple (#1a1628) to dark blue (#0a0d1c)
- **Parallax Mountains**: Dark purple silhouettes (#2d1b4e)
- **Platforms**: Bright teal (#2dd4bf) with darker outlines (#14b8a6)
- **Ground**: Dark teal (#134e4a)
- **Player**: Coral pink (#ff667f) - stands out against the cool background
- **UI**: Light cyan (#a5f3fc) with drop shadows

### Parallax Layers
1. **Static Sky**: Gradient background (no movement)
2. **Far Mountains** (0.2x motion): Large mountain silhouettes
3. **Mid Shapes** (0.4x motion): Triangular geometric shapes
4. **Near Shapes** (0.6x motion): Rectangular pillars in foreground

## How ProCam2D is Used

This example demonstrates the basic setup of ProCam2D:

1. **ProCam2D Node**: Added to the scene (can be placed anywhere in the scene tree)
2. **PCamTarget Node**: Attached as a child of the Player node
3. The camera automatically follows the player with smooth movement

## Customizing the Camera

You can customize the camera behavior by selecting the ProCam2D node and adjusting properties in the inspector:

### Basic Properties to Try

- **Follow Mode**: Change between SINGLE_TARGET and MULTI_TARGET
- **Drag Type**: Try different drag types:
  - SMOOTH_DAMP: Smooth following with damping
  - LOOK_AHEAD: Camera anticipates player movement
  - AUTO_SPEED: Speed adjusts based on player velocity
  - SPRING_DAMP: Bouncy, spring-like following

- **Smooth Drag Speed**: Adjust how quickly the camera follows (try Vector2(3, 3) for faster)
- **Offset**: Add an offset to the camera position (e.g., Vector2(0, -50) to look slightly upward)
- **Zoom**: Change the zoom level (try 1.5 for closer, 0.8 for farther)

### Adding Screen Shake

To add screen shake when the player lands:

1. Select the ProCam2D node
2. In the Inspector, expand the "Addons" property
3. Increase the Array size to 1
4. Click on the [empty] field and select "New PCamShake"
5. Configure the shake properties (amplitude, duration, frequency)
6. Access it in code:

```gdscript
# In Player.gd
func _physics_process(delta):
    var was_in_air = not is_on_floor()

    # ... movement code ...

    velocity = move_and_slide(velocity, Vector2.UP)

    # Trigger shake on landing
    if was_in_air and is_on_floor():
        var shake_addon = procam.get_addons()[0]
        shake_addon.shake()
```

### Using Camera Limits

You can constrain the camera to stay within certain bounds:

1. Select ProCam2D node
2. Set the limit properties:
   - `left_limit`: -100
   - `right_limit`: 1124
   - `top_limit`: -100
   - `bottom_limit`: 700

### Adding Zones

You can add special camera zones to the level:

#### PCamRoom (Room Constraints)
1. Add a PCamRoom node to the scene
2. Position it where you want the room
3. Set the room_size property (e.g., Vector2(800, 600))
4. The camera will be constrained to this room when the player enters it

#### PCamZoom (Zoom Zones)
1. Add a PCamZoom node to the scene
2. Position it where you want the zoom effect
3. Set radius (for circular) or rectangle_size
4. Set zoom_factor (e.g., 1.5 for closer view)
5. Enable gradual_zoom for smooth transitions

#### PCamMagnet (Camera Attraction)
1. Add a PCamMagnet node to the scene
2. Position it where you want to attract the camera
3. Set the magnet_shape (CIRCLE or RECTANGLE)
4. Set attract_repel (ATTRACT or REPEL)
5. Configure radius or rectangle_size
6. Adjust force and falloff_curve

## Next Steps

- Try adding more platforms and creating a full level
- Experiment with different camera settings to find what feels best
- Add camera zones (PCamRoom, PCamZoom, PCamMagnet) to create dynamic camera behavior
- Create cinematics using PCamCinematic nodes
- Try the mouse follow addon for pointer influence

## Learn More

Check out the main [ProCam2D README](../../README.md) for complete documentation on all features and nodes.
