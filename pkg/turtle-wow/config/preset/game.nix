{ }:
let wow = import ../../wow-types.nix { };
in {
  accountName = ""; # Default account name
  gxWindow = wow.true; # Enables windowed mode
  gxMaximize = wow.true; # Maximizes the window
  scriptMemory = wow.false; # Amount of memory allocated for scripts
  gxCursor = wow.false; # Disables hardware cursor
  hwDetect = wow.false; # Disables hardware detection on startup
  gxColorBits = "24"; # Sets the color depth in bits
  gxDepthBits = "24"; # Sets the depth buffer depth in bits
  gxResolution = "1920x1080"; # Sets the screen resolution
  gxRefresh = "60"; # Sets the screen refresh rate in Hz
  gxMultisampleQuality =
    "0.000000"; # Sets the multisampling quality for anti-aliasing
  gxFixLag = wow.false; # Fix cursor lag. Requires gxCursor "1"
  fullAlpha = wow.true; # Enables full alpha transparency
  lodDist = "100.000000"; # Level of detail distance
  SmallCull = "0.040000"; # Sets the distance at which small objects are culled
  DistCull =
    "500.000000"; # Sets the distance at which distant objects are culled
  trilinear = wow.true; # Enables trilinear filtering
  frillDensity = "32"; # Density of environment frills like grass and bushes
  farclip = "477"; # Maximum view distance
  specular = wow.true; # Enables specular highlights
  pixelShaders = wow.true; # Enables pixel shaders
  particleDensity = "1.000000"; # Density of particle effects
  unitDrawDist =
    "300.000000"; # Distance at which units (NPCs, players) are drawn
  movie = wow.false; # Disables intro movie
  readTOS = wow.true; # Indicates that the Terms of Service have been read
  readEULA =
    wow.true; # Indicates that the End User License Agreement has been read
  realmName = "";
  realmList = ""; # Sets the realm list server address
  patchlist = ""; # Sets the patch list server address
  M2UsePixelShaders = wow.true; # Enables use of pixel shaders for models
  Gamma = "1.000000"; # Gamma correction level
  lastCharacterIndex = "1"; # Index of the last character used
  MusicVolume = "0.40000000596046"; # Volume level for music
  SoundVolume = wow.true; # Volume level for sound effects
  MasterVolume = wow.true; # Master volume level
  gameTip = "0"; # Current tip
  AmbienceVolume = "0.60000002384186"; # Volume level for ambient sounds
  uiScale = "1"; # Scale factor for the user interface
  checkAddonVersion = wow.false;
  profanityFilter = wow.false;
  autoSelfCast =
    wow.true; # Automatically cast beneficial spells on yourself when you have no target
  mouseSpeed = "0.5";
  cameraYawMoveSpeed = "180";
  cameraYawSmoothSpeed = "180";
  UnitNameOwn = wow.false; # Show own name
  UnitNameNPC = wow.true; # Show NPC names
  cameraSmoothStyle = wow.false;
  cameraWaterCollision = wow.true;
  cameraPivot = wow.true;
  statusBarText = wow.true;
  UberTooltips = wow.true; # Show extended tooltips
  UnitNamePlayerGuild = wow.true;
  cameraTerrainTilt = wow.false;
  cameraBobbing = wow.false;
  showGameTips = wow.true; # Show loading screen tips
  cameraDistanceMaxFactor = "1";
  assistAttack = wow.false; # Automatically assist on attack
  deselectOnClick = wow.true; # Inverse of sticky targeting
  AutoInteract = wow.true;
  mouseInvertPitch = wow.false;
  BlockTrades = wow.false; # Block incoming trade requests
  minimapInsideZoom = "0";
  cameraCustomViewSmoothing = wow.false;
  cameraView = "0";
  cameraDistanceC = "20.000000";
  cameraPitchC = "0.000000";
  cameraYawC = "0.000000";
}
