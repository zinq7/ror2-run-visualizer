List ratioWithCorners(
    // item constants
    itemY,
    itemX,
    stageImageX,
    stageImageY,
    // stage constants
    left,
    top,
    right,
    bottom,
    // rotations
    {rotation = 0}) {
  // brotate
  if (rotation == 90) {
    var tmp = itemY;
    itemY = itemX;
    itemX = tmp;
  }

  // do math
  double xCoeff = ((itemX - left) / (right - left));
  double yCoeff = ((itemY - top) / (bottom - top));

  // print("x: $itemX vs width: ${right - left}, pos: ${xCoeff * (right - left)}\n");

  return [
    stageImageX * xCoeff,
    stageImageY * yCoeff,
  ];
}

Map stageMap = {
  "MAP_SNOWYFOREST_TITLE": {
    "image": "lib/assets/maps/snowyforest.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 423, 217, -423, -255, rotation: 90),
  },
  "MAP_BLACKBEACH_TITLE_2": {
    "image": "lib/assets/maps/blackbeach2.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -405, 226, 417, -233),
  },
  "MAP_BLACKBEACH_TITLE": {
    "image": "lib/assets/maps/blackbeach.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -463, 125, 460, -393),
  },
  "MAP_GOLEMPLAINS_TITLE_2": {
    "image": "lib/assets/maps/golemplains2.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -447, 149, 447, -343),
  },
  "MAP_GOLEMPLAINS_TITLE": {
    "image": "lib/assets/maps/golemplains.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 465, 317, -550, -252, rotation: 90),
  }
};


// blackbeach_goodfov
// topleft: -463, 0, 125
// bottomright: 460, 0, -393

// blackbeach2
// topleft: -405, 226
// bottomright: 417, -233

// siphonedforest
// topleft: 217, 423
// botleft: -255, -423 (parralel :)

// golemplains
// topleft: 465, 317
// botright: -550, -252

// golemplains2
// topleft: -447, 149
// bottomright: 447, -343