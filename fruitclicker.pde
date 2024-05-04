import processing.sound.*; 

PImage mangoImage;
float mangoX, mangoY, mangoSize;
int mangoCount = 0;
int mangosPerClick = 1;
int autoClickerPrice = 100;
int autoClickerCount = 0;
int upgradePrice = 50;
int lastUpdateTime = 0;
int fertilizerPrice = 200; // New upgrade price
int fertilizerCount = 0;

// Sounds, die wir abspielen wollen, wenn etwas gemacht wird
SoundFile soundUpgrade;
SoundFile soundAutoClickerBuy;
SoundFile soundFeritlizerBuy;
SoundFile soundBackgroundMusic;

void setup() {
  size(1920, 1200);
  mangoImage = loadImage("fruit.png"); // Change to your mango image
  mangoSize = 400;
  mangoX = width / 2 - mangoSize / 2;
  mangoY = height / 2 - mangoSize / 2;
  textSize(24);
  
  soundUpgrade = new SoundFile(this, "./sounds/Rise01.mp3");
  soundAutoClickerBuy = new SoundFile(this, "./sounds/Rise02.mp3");
  soundFeritlizerBuy = new SoundFile(this, "./sounds/Rise04.mp3");
  soundBackgroundMusic = new SoundFile(this, "./sounds/sakura.mp3");
  soundBackgroundMusic.amp(0.05);
  soundBackgroundMusic.loop(1);
}

void draw() {
  background(255); 
    // Draw mango
  image(mangoImage, mangoX, mangoY, mangoSize, mangoSize);
  
   // Set text properties
  textSize(32); // Bigger text for better readability
  fill(255, 255, 255, 200); // White text with some transparency
  textFont(createFont("Arial", 32)); // Change "Arial" to your preferred font if needed

    // Draw semi-transparent rectangles behind text for better visibility
  fill(0, 100); // Semi-transparent black background for text
  rect(40, 25, 480, 40); // Adjust size and position as needed for "mangos:"
  rect(40, 55, 480, 40); // For "mangos per click:"
  rect(40, 85, 480, 40); // For "Buy Upgrade"
  rect(40, 115, 480, 40); // For "Buy Auto Clicker"
  rect(40, 145, 480, 40); // For "Buy Fertilizer"
  


  // Reset fill for text and draw it
  fill(255); // White text
  text("mangos: " + mangoCount, 50, 50);
  text("mangos per click: " + mangosPerClick, 50, 80);
  text("Buy Upgrade (+" + (mangosPerClick + 1) + " per click): " + upgradePrice + " mangos", 50, 110);
  text("Buy Auto Clicker: " + autoClickerPrice + " mangos", 50, 140);
  text("Buy Fertilizer: " + fertilizerPrice + " mangos", 50, 170);


  // Update auto clickers
  if (millis() - lastUpdateTime > 1000) { // Update every second
    int additionalmangos = autoClickerCount;
    if (fertilizerCount > 0) { additionalmangos *= (1 + fertilizerCount); } // Double output if fertilizer is active
    mangoCount += additionalmangos;
    lastUpdateTime = millis();
  }

  // Optional: Display random bonus mango feature
}

void mousePressed() {
  // Check if mango is clicked
  if (mouseX > mangoX && mouseX < mangoX + mangoSize && mouseY > mangoY && mouseY < mangoY + mangoSize) {
    //change mango size here
    mangoCount += mangosPerClick;
  }

  // Check if upgrade button is clicked
  if (mouseX > 50 && mouseX < 350 && mouseY > 90 && mouseY < 120) {
    if (mangoCount >= upgradePrice) {
      mangoCount -= upgradePrice;
      mangosPerClick++;
      upgradePrice *= 2; // Increase the price for the next upgrade
      soundUpgrade.play();
    }
  }

  // Check if auto clicker button is clicked
  if (mouseX > 50 && mouseX < 350 && mouseY > 120 && mouseY < 150) {
    if (mangoCount >= autoClickerPrice) {
      mangoCount -= autoClickerPrice;
      autoClickerCount++;
      autoClickerPrice *= 2; // Increase the price for the next auto clicker
      soundAutoClickerBuy.play();
    }
  }

  // Check if fertilizer upgrade button is clicked
  if (mouseX > 50 && mouseX < 350 && mouseY > 150 && mouseY < 180) {
    if (mangoCount >= fertilizerPrice) {
      mangoCount -= fertilizerPrice;
      fertilizerCount++;
      fertilizerPrice *= 3; // Increase the price for the next purchase
      fertilizerPrice /= 2;
      soundFeritlizerBuy.play();
    }
  }
}
