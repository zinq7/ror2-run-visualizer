List siphoned(x, y, stageX, stageY) {
  const xScale = 0.2171; // -200 = %, 200 = 1.0 - this%;
  const realStartX = -(2 * 200 * xScale) - 200, realEndX = -realStartX, realXLength = 2 * realEndX;

  // const yScale = 0; // same here
  const realEndY = 200, realYLength = 2 * realEndY;

  double xCoeff = (x + realEndX) / realXLength; // x is from -288 to 288. RealEnd is 566. x + 288 / 566 will give %
  double yCoeff = (y + realEndY) / realYLength;

  return [
    stageX * xCoeff,
    stageY * yCoeff,
  ];
}

const stageMap = {
  "Siphoned Forest": {
    "image": "lib/map_shit/accurate_siphoned.png",
    "ratio": siphoned,
  },
};
