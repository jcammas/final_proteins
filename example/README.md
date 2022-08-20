# proteins_example

Demonstrates how to use the proteins plugin.

#### Mandatory part

# Login View Controller:

- A user must be able to login with a fingerprint sensor (TouchID on iOS, biometricmanager on android) using a button => ok
- If login fails you must display a popup warning authentication failed => ok
- If the Phone is not compatible the button should be hidden => ok (but always compatible with face id also)
- The LoginViewController should ALWAYS be displayed when launching the app meaning
  if you press the Home button and relaunch the app whitout quitting it, it should show
  the LoginViewController ! => ok

# Protein List View Controller:

- You must list all the ligands provided in ligands.txt (see resources) => ok
- You should be able to search a ligand through the list => ok
- If you cannot load the ligand through the website display a warning popup => ok
- When loading the ligand you should display a spinning wheel or any clean loading animation. => ok

# Protein View Controller:

- For this part you can use SceneKit on iOS, filament on android or even raw Metal/Vulkan
  anything integrated in a classic app is OK. (No full GameEngine!) => ok
- Display the ligand model in 3D => ok
- You must use CPK coloringYou should at least represent the ligand using Balls and Sticks model => ok
- When clicking on an atom display the atom type (C, H, O, etc.) => ok
- Share your modelisation through a ‘Share‘ button => ok
- You should be able to ‘play‘ (zoom, rotate...) with the ligand. => ok

# bonus

- mise en place d'un server node js mongodb avec inscription connexion user et déconnexion
- darkmode
- Face ID
- vue 2D
- design responsive
- logo fait maison
- custom message when sharing your screenshot
