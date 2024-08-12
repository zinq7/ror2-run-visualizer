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
  } else if (rotation == 180) {
    itemY = bottom - (itemY - top);
    itemX = right - (itemX - left);
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

Map<String, Object> multiMap(Map<List<String>, Object> map) {
  var newMap = <String, Object>{};
  for (var entry in map.entries) {
    var keyList = entry.key;
    for (var key in keyList) {
      newMap[key] = entry.value;
    }
  }
  return newMap;
}

Map stageMap = multiMap({
  ["MAP_SNOWYFOREST_TITLE", "snowyforest"]: {
    "image": "lib/assets/maps/snowyforest.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 423, 217, -423, -255, rotation: 90),
  },
  ["MAP_BLACKBEACH_TITLE_2", "blackbeach2"]: {
    "image": "lib/assets/maps/blackbeach2.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -405, 226, 417, -233),
  },
  ["blackbeach", "MAP_BLACKBEACH_TITLE"]: {
    "image": "lib/assets/maps/blackbeach.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -463, 125, 460, -393),
  },
  ["golemplains2", "MAP_GOLEMPLAINS_TITLE_2"]: {
    "image": "lib/assets/maps/golemplains2.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -447, 149, 447, -343),
  },
  ["golemplains", "MAP_GOLEMPLAINS_TITLE"]: {
    "image": "lib/assets/maps/golemplains.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 465, 317, -550, -252, rotation: 90),
  },
  ["foggyswamp", "MAP_FOGGYSWAMP_TITLE"]: {
    "image": "lib/assets/maps/foggyswamp.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -460, 161, 560, -410),
  },
  ["goolake", "MAP_GOOLAKE_TITLE"]: {
    "image": "lib/assets/maps/goolake_v1.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 433, 341, -432, -142, rotation: 90),
  },
  ["ancientloft", "MAP_ANCIENTLOFT_TITLE"]: {
    "image": "lib/assets/maps/ancientloft_v2.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 432, 292, -432, -192, rotation: 90),
  },
  ["sulfurpools", "MAP_SULFURPOOLS_TITLE"]: {
    "image": "lib/assets/maps/sulfurpools.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 462, 260, -462, -260),
  },
  ["wispgraveyard", "MAP_WISPGRAVEYARD_TITLE"]: {
    "image": "lib/assets/maps/wispgraveyard.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -740, 348, 498, -348),
  },
  ["frozenwall", "MAP_FROZENWALL_TITLE"]: {
    "image": "lib/assets/maps/frozenwall.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -540, 304, 540, -304),
  },
  ["dampcavesimple", "MAP_DAMPCAVESIMPLE_TITLE"]: {
    "image": "lib/assets/maps/dampcavesimple.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -775, 233, 775, -663),
  },
  ["shipgraveyard", "MAP_SHIPGRAVEYARD_TITLE"]: {
    "image": "lib/assets/maps/shipgraveyard.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 339, 190, -339, -190, rotation: 90),
  },
  ["rootjungle", "MAP_ROOTJUNGLE_TITLE"]: {
    "image": "lib/assets/maps/rootjungle_bigplateau.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 339, 190, -339, -190, rotation: 90),
  },
  ["skymeadow", "MAP_SKYMEADOW_TITLE"]: {
    "image": "lib/assets/maps/bridgemeadow.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, 588, 328, -588, -328, rotation: 90),
  },
  ["lakes", "MAP_LAKES_TITLE"]: {
    "image": "lib/assets/maps/lakes.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -367, 190, 350, -198),
  },
  ["moon2", "MAP_MOON2_TITLE"]: {
    "image": "lib/assets/maps/moon2.png",
    "ratio": (a, b, c, d) => ratioWithCorners(a, b, c, d, -1050, 1100, 1830, -500),
  }
});


// moon2
// topleft: -1050, 1100
// bottomright: 1830, -500

// lakes
// topleft: -367, 170
// bottomright: 350, -178 

// dampcavesimple
// tr: -775, 233
// bl: 775, -663,

// shipgraveyard: (rotation 90)
// tr: 339, 190
// bl: -339, -190

// rootjungle: (rotation 90)
// tr: 339, 190
// bl: -339, -190 (SAME AS SIRENS 
// 
// skymeadow (rotation 90)
// tr: 588, 328
// bl: -588, -328


// sulfurpools:
// topleft: -462, 260,
// bottomright: 462, -260 (fully centered stage nice)

// wispgraveyard: 
// tr: -740, 348
// bl: 498, -348

// frozenwall:
// tr: -540, 304
// bl: 540, -304



// ancientloft: (90 rot)
// topleft: 432, 292
// bottomright: -432, -192

// goodlake: (90 rot)
// topleft: 433, 341
// bottomright: -432,-142

// foggyswamp: (0 rot)
// topleft: -460, 161
// bottomright: 560, -410


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
