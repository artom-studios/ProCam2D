# Mouse Follow Example

A top-down aiming demo showcasing **ProCam2D's PCamMouseFollow addon**, which creates dynamic camera movement based on mouse cursor position.

## Features

- **Dynamic Mouse Follow**: Camera shifts toward your cursor for better visibility in aim direction
- **Top-Down Aiming**: Player rotates to face the mouse cursor
- **Smooth Camera Movement**: Configurable influence and smoothing for natural feel
- **Training Arena**: Targets and obstacles to navigate around
- **Visual Crosshair**: Always centered on mouse position

## What's Included

- **Player.gd**: Top-down character controller with mouse-based rotation (Godot 4.5)
- **Player.tscn**: Player scene with turret design and PCamTarget node
- **MouseFollow.tscn**: Arena scene with ProCam2D and mouse follow addon configured
- **Crosshair.gd**: Simple script to position crosshair at mouse location

## How to Run

1. Make sure ProCam2D plugin is enabled in your Godot 4.5 project
2. Open `MouseFollow.tscn` in the Godot editor
3. Run the scene (F6) or set it as the main scene and run the project (F5)

## Controls

- **WASD / Arrow Keys**: Move in all directions
- **Mouse**: Aim (player rotates to face cursor)

## How Mouse Follow Works

The **PCamMouseFollow addon** is configured on the ProCam2D node with these settings:

### Key Parameters

- **max_distance** (300.0): Maximum distance from camera center where mouse influence applies
- **influence** (0.5, 0.5): How much the camera shifts toward the cursor (50% in both axes)
- **smoothing** (8.0): How quickly the camera interpolates to the target position
- **deadzone_radius** (10.0): Small area around center where no influence is applied

### How It Feels

When you move your mouse cursor away from the center of the screen:
- The camera smoothly shifts toward the cursor direction
- You get better visibility in the direction you're aiming
- The effect is subtle but makes a huge difference in gameplay feel
- Perfect for twin-stick shooters, top-down games, or any game with aiming mechanics

## Design Elements

### Color Palette
- **Background**: Dark blue-gray (#181a26) - reduces eye strain
- **Grid Lines**: Subtle blue guides (10% opacity)
- **Player**: Red/coral body (#ff4d66) with cyan turret (#3399cc) and white gun
- **Obstacles**: Vibrant orange (#ff8033) with darker outlines
- **Targets**: Teal/cyan pentagons (#33cc99) with darker outlines
- **UI**: Bright cyan text (#66ccff)
- **Crosshair**: Semi-transparent white

### Why This Color Scheme?
- Dark background reduces visual fatigue during aiming
- Warm obstacles (orange) vs cool targets (cyan) for instant recognition
- Player uses both warm (body) and cool (turret) colors to stand out against everything
- High contrast for clarity during fast gameplay

## Customizing the Mouse Follow

Select the ProCam2D node and expand the "Addons" array to adjust the PCamMouseFollow settings:

### Increasing Mouse Influence
```gdscript
# More aggressive camera shift toward cursor
influence = Vector2(0.8, 0.8)  # Default is (0.5, 0.5)
```

### Faster Camera Response
```gdscript
# Snappier camera movement
smoothing = 15.0  # Default is 8.0 (higher = faster)
```

### Wider Active Area
```gdscript
# Mouse affects camera from farther away
max_distance = 500.0  # Default is 300.0
```

### Larger Deadzone
```gdscript
# Bigger center area with no camera shift
deadzone_radius = 50.0  # Default is 10.0
```

## Adding Mouse Follow to Your Game

To add mouse follow to your own project:

1. Add a ProCam2D node to your scene
2. Add a PCamTarget as a child of your player
3. In the ProCam2D inspector, expand "Addons" array and increase size
4. Click the [empty] field and select "New PCamMouseFollow"
5. Configure the parameters to taste
6. Test and tweak until it feels right!

### Code Example

You can also add it via code:

```gdscript
var mouse_follow = PCamMouseFollow.new()
mouse_follow.max_distance = 300.0
mouse_follow.influence = Vector2(0.5, 0.5)
mouse_follow.smoothing = 8.0
mouse_follow.deadzone_radius = 10.0
procam.add_addon(mouse_follow)
```

## Tips for Best Results

1. **Start Subtle**: Begin with low influence (0.3-0.5) and increase if needed
2. **Match Your Game Speed**: Fast games need faster smoothing
3. **Consider UI**: Make sure UI elements don't interfere with mouse tracking
4. **Test on Different Screen Sizes**: Mouse follow feels different on various resolutions
5. **Combine with Other Features**: Works great with zoom and look-ahead drag types

## Use Cases

This mouse follow setup is perfect for:

- **Top-down shooters**: Better visibility in aim direction
- **Twin-stick games**: Enhanced spatial awareness
- **Strategy games**: Preview areas before moving
- **Adventure games**: Look around without moving character
- **Any game with cursor-based aiming or interaction**

## Learn More

Check out the main [ProCam2D README](../../../../README.md) for complete documentation on all features, addons, and camera behaviors.
