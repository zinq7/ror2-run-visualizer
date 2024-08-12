'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "025944e9461a0068f423f9d73317f6ae",
"assets/AssetManifest.bin.json": "b15a2cd3d0084f6e94f406e73dd2975d",
"assets/AssetManifest.json": "ff65f4c53c499d86cf266998ca9d5537",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/lib/assets/bodies/ACIDLARVA_BODY_NAME.png": "92607f4bdbd421cb6278449f798c372d",
"assets/lib/assets/bodies/AFFIXEARTH_HEALER_BODY_NAME.png": "320bd765244f0b219a86addc5f7239fb",
"assets/lib/assets/bodies/ANCIENTWISP_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/ARCHWISP_BODY_NAME.png": "71714afc2fc20553a75f8b372d957589",
"assets/lib/assets/bodies/ARTIFACTSHELL_BODY_NAME.png": "d71cf57893de82e3d308481569d2ac9c",
"assets/lib/assets/bodies/ASSASSIN2_BODY_NAME.png": "f68f53eae5925d41111f9d5b645e5cc9",
"assets/lib/assets/bodies/BANDIT2_BODY_NAME.png": "02020b87781fa35ac6fdc07dd864243a",
"assets/lib/assets/bodies/BANDIT_BODY_NAME.png": "02020b87781fa35ac6fdc07dd864243a",
"assets/lib/assets/bodies/BEETLEGUARD_BODY_NAME.png": "12262ad5b34433c00290e9bb42d7bdf8",
"assets/lib/assets/bodies/BEETLEQUEEN_BODY_NAME.png": "ddb65ed2ac25f62dbf7abd7a3f633509",
"assets/lib/assets/bodies/BEETLE_BODY_NAME.png": "a53fef37cdf580bdc169e03a72c62c6c",
"assets/lib/assets/bodies/BEETLE_CRYSTAL_BODY_NAME.png": "a53fef37cdf580bdc169e03a72c62c6c",
"assets/lib/assets/bodies/BELL_BODY_NAME.png": "d2c71fec2e591df05fb5a065b2cecac8",
"assets/lib/assets/bodies/BISON_BODY_NAME.png": "4ef3c06edf5370943a907fdea24c9872",
"assets/lib/assets/bodies/BOMBER_BODY_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/bodies/BROTHER_BODY_NAME.png": "245fc90d2f2a279cc6d1af23508ffeb7",
"assets/lib/assets/bodies/CAPTAIN_BODY_NAME.png": "e87f4f5301c526988390f04218e2a919",
"assets/lib/assets/bodies/CLAYBOSS_BODY_NAME.png": "3f73ce28e1beec72fd31d384078e55d3",
"assets/lib/assets/bodies/CLAYBRUISER_BODY_NAME.png": "46ff860d238c310ff2903583459e45a5",
"assets/lib/assets/bodies/CLAYGRENADIER_BODY_NAME.png": "ca28313799d3daf53a0104a712c05693",
"assets/lib/assets/bodies/CLAY_BODY_NAME.png": "d94f665d655c220326b3704ee3f93fc6",
"assets/lib/assets/bodies/COMMANDO_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/CROCO_BODY_NAME.png": "c8af2e5774f28166554a5fd84499e0fe",
"assets/lib/assets/bodies/DRONEBACKUP_BODY_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/bodies/DRONE_BACKUP_BODY_NAME.png": "301b4f0d3a89ed27158a0cdd0cb47ca4",
"assets/lib/assets/bodies/DRONE_COMMANDER_BODY_NAME.png": "e8725a4cf8ccea29195b5e5cafd9bebf",
"assets/lib/assets/bodies/DRONE_GUNNER_BODY_NAME.png": "b2426f38b0c5fe9a4b59425b8e03061f",
"assets/lib/assets/bodies/DRONE_HEALING_BODY_NAME.png": "a888a3b7365c6bf44a42deebd16e9f76",
"assets/lib/assets/bodies/DRONE_MEGA_BODY_NAME.png": "52e4737ad612ab30abe0ddc8620265c6",
"assets/lib/assets/bodies/DRONE_MISSILE_BODY_NAME.png": "588a7f4136898bd941f481d190112e6d",
"assets/lib/assets/bodies/ELECTRICWORM_BODY_NAME.png": "d573b74a4faf0d8f52f2b92126ac8a34",
"assets/lib/assets/bodies/EMERGENCYDRONE_BODY_NAME.png": "7cb78c46b62e1592e6b66498f8bdb8a0",
"assets/lib/assets/bodies/ENFORCER_BODY_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/bodies/ENGITURRET_BODY_NAME.png": "9612160e675839855796ba676cd9996e",
"assets/lib/assets/bodies/ENGI_BODY_NAME.png": "0b891c5549db1a59ec66e66dd9b070dd",
"assets/lib/assets/bodies/EQUIPMENTDRONE_BODY_NAME.png": "3a8d32c25c00339f50127ffb5b8d2f59",
"assets/lib/assets/bodies/FLAMEDRONE_BODY_NAME.png": "11b8cfacc6d330dd7d6f2b716e39739b",
"assets/lib/assets/bodies/FLYINGVERMIN_BODY_NAME.png": "ca60e586b90890f7ddc283495b7552da",
"assets/lib/assets/bodies/FUSIONCELL_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/GEEP_BODY_NAME.png": "e84034c9849c7eed8b2600a263846061",
"assets/lib/assets/bodies/GIP_BODY_NAME.png": "8344fc10b9632eecc98c0234edf8cb22",
"assets/lib/assets/bodies/GOLEM_BODY_NAME.png": "e34d99cc8273180fef86dd39b109a5ee",
"assets/lib/assets/bodies/GRANDPARENT_BODY_NAME.png": "50e1160f5603cdd6170c4f89f2afd9fc",
"assets/lib/assets/bodies/GRAVEKEEPER_BODY_NAME.png": "ce99f2f556acf277879add287855b2a7",
"assets/lib/assets/bodies/GREATERWISP_BODY_NAME.png": "71714afc2fc20553a75f8b372d957589",
"assets/lib/assets/bodies/GUP_BODY_NAME.png": "e9795f577ae0def76ea6548aff295d23",
"assets/lib/assets/bodies/HAND_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/HERETIC_BODY_NAME.png": "d779a343983ff2833bf365efe20801d5",
"assets/lib/assets/bodies/HERMIT_CRAB_BODY_NAME.png": "de53374b2bf076155cf4604185898ce2",
"assets/lib/assets/bodies/HUNTRESS_BODY_NAME.png": "cafebde14b7d070b201aa1003ae9f34d",
"assets/lib/assets/bodies/IMPBOSS_BODY_NAME.png": "18b9aab4bc2ad09b1f4e7beb04948010",
"assets/lib/assets/bodies/IMP_BODY_NAME.png": "55a023616712b2134942d2c4b3f0527d",
"assets/lib/assets/bodies/JELLYFISH_BODY_NAME.png": "c60e08805c995438fca9bdcb654d2420",
"assets/lib/assets/bodies/LEMURIANBRUISER_BODY_NAME.png": "66d8dc36d9f253f0f042b0eb7adb6dbf",
"assets/lib/assets/bodies/LEMURIAN_BODY_NAME.png": "5dccd7afc6d3546ea8210376c208768c",
"assets/lib/assets/bodies/LOADER_BODY_NAME.png": "00f7b5e5c13a7b379cf506ab62f20a84",
"assets/lib/assets/bodies/LUNAREXPLODER_BODY_NAME.png": "fcd49f37c466e1fab55c181490938c99",
"assets/lib/assets/bodies/LUNARGOLEM_BODY_NAME.png": "00b1de9ea2aa9555df4dc2e097158354",
"assets/lib/assets/bodies/LUNARWISP_BODY_NAME.png": "41944cac238f619da5dd27ed0eac76d3",
"assets/lib/assets/bodies/MAGE_BODY_NAME.png": "4b3cd2f1f937a65cea8020c3f4c9ee61",
"assets/lib/assets/bodies/MAGMAWORM_BODY_NAME.png": "59ebecced0f45492c40da82518746eca",
"assets/lib/assets/bodies/MAJORCONSTRUCT_BODY_NAME.png": "d2cc15d05c4c3d95cc8fb6d1d19be556",
"assets/lib/assets/bodies/MAULINGROCK_BODY_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/bodies/MEGACONSTRUCT_BODY_NAME.png": "427f6b36fb6b40b41cc33ee9ce258f48",
"assets/lib/assets/bodies/MERC_BODY_NAME.png": "dca38127ff71f50d1f8fb8dc6c0a5bd8",
"assets/lib/assets/bodies/MINIMUSHROOM_BODY_NAME.png": "e8b18d1a66c81f1165dfa53814dcb9f0",
"assets/lib/assets/bodies/MINORCONSTRUCT_BODY_NAME.png": "2cb6395f8d79d0cb93be447388845936",
"assets/lib/assets/bodies/NULLIFIER_BODY_NAME.png": "0921ae3446939466c8fe8897f574bfa0",
"assets/lib/assets/bodies/PARENT_BODY_NAME.png": "feb6f1e0519f95eebd6766113bf01218",
"assets/lib/assets/bodies/POD_BODY_NAME.png": "de863fc168b5969eb12c86f6db62ca22",
"assets/lib/assets/bodies/POT2_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/POTMOBILE_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/RAILGUNNER_BODY_NAME.png": "8fa504270beb66f2d6f0d1c1d9ad533a",
"assets/lib/assets/bodies/ROBOBALLBOSS_BODY_NAME.png": "ec52236e0febe791e9910c988c2d229e",
"assets/lib/assets/bodies/ROBOBALLGREENBUDDY_BODY_NAME.png": "574a04d094db6e0c3302bd6e98ce8469",
"assets/lib/assets/bodies/ROBOBALLMINI_BODY_NAME.png": "574a04d094db6e0c3302bd6e98ce8469",
"assets/lib/assets/bodies/ROBOBALLREDBUDDY_BODY_NAME.png": "574a04d094db6e0c3302bd6e98ce8469",
"assets/lib/assets/bodies/SCAVLUNAR1_BODY_NAME.png": "2076dea8b857c96507a4d8ac5fe3ebd5",
"assets/lib/assets/bodies/SCAVLUNAR2_BODY_NAME.png": "2076dea8b857c96507a4d8ac5fe3ebd5",
"assets/lib/assets/bodies/SCAVLUNAR3_BODY_NAME.png": "2076dea8b857c96507a4d8ac5fe3ebd5",
"assets/lib/assets/bodies/SCAVLUNAR4_BODY_NAME.png": "2076dea8b857c96507a4d8ac5fe3ebd5",
"assets/lib/assets/bodies/SCAV_BODY_NAME.png": "cf44ebc260935683d2602bef3231ed7a",
"assets/lib/assets/bodies/SHOPKEEPER_BODY_NAME.png": "ff4e66f8efd7469439eb74d602d91fab",
"assets/lib/assets/bodies/SNIPER_BODY_NAME.png": "dc840cce800b3acc67cd458e04e03f4c",
"assets/lib/assets/bodies/SQUIDTURRET_BODY_NAME.png": "f546ac9fe4d61fa4edd0e9b01d06d3cb",
"assets/lib/assets/bodies/SULFURPOD_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/SUPERROBOBALLBOSS_BODY_NAME.png": "b7ddebd0a33dec59247c43976233d790",
"assets/lib/assets/bodies/TIMECRYSTAL_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/TITANGOLD_BODY_NAME.png": "9e6ef43c3a153bf09db5d0d02f69c1b2",
"assets/lib/assets/bodies/TITAN_BODY_NAME.png": "d9720d62fc71077ffab35b503fbb4746",
"assets/lib/assets/bodies/TOOLBOT_BODY_NAME.png": "75c3c4b86826fce2df7ad7028287649c",
"assets/lib/assets/bodies/TREEBOT_BODY_NAME.png": "c53488e424337e296ef1639001868d49",
"assets/lib/assets/bodies/TURRET1_BODY_NAME.png": "8c6d27b02a37ec9ff098f3488914f934",
"assets/lib/assets/bodies/UNIDENTIFIED.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/bodies/URCHINTURRET_BODY_NAME.png": "c1ff168f7f12cfcb880d2cb4ab99ac2f",
"assets/lib/assets/bodies/VAGRANT_BODY_NAME.png": "eb622f7847f1a7ad3af9cb8cfd6ecac9",
"assets/lib/assets/bodies/VERMIN_BODY_NAME.png": "2b022c053ce551ca554981841a6fdf11",
"assets/lib/assets/bodies/VOIDBARNACLE_BODY_NAME.png": "f55ed8fea86b38607e5fae97de3d44ee",
"assets/lib/assets/bodies/VOIDINFESTOR_BODY_NAME.png": "9ffa1a6a4bed05c9dfc2c9968e770221",
"assets/lib/assets/bodies/VOIDJAILER_BODY_NAME.png": "2610d785fd89c8123831a16bbf0ff62b",
"assets/lib/assets/bodies/VOIDMEGACRAB_BODY_NAME.png": "ac52c80563b198c260955598508e9169",
"assets/lib/assets/bodies/VOIDRAIDCRAB_BODY_NAME.png": "0f1bd92d1ee504f53fcfe22e63474d86",
"assets/lib/assets/bodies/VOIDSURVIVOR_BODY_NAME.png": "10bc306ece6f6470cee0fdbf90ee74e6",
"assets/lib/assets/bodies/VULTURE_BODY_NAME.png": "e46b29caa6036ad0ebf385e9044cab01",
"assets/lib/assets/bodies/WISP_BODY_NAME.png": "ada298d0d08da8f2ea29f77f3305e009",
"assets/lib/assets/icons/blank.png": "a9e973fe55048670adcbdb2a1b8fbd3a",
"assets/lib/assets/icons/CASINOCHEST_NAME.png": "dccdc80cf1f6a1393e874bfad87ab91e",
"assets/lib/assets/icons/CATEGORYCHEST2_DAMAGE_NAME.png": "c600c0d1a77346df007f048a83215589",
"assets/lib/assets/icons/CATEGORYCHEST2_HEALING_NAME.png": "906ea6aaa851d6b6c1c056955f7bbf9e",
"assets/lib/assets/icons/CATEGORYCHEST2_UTILITY_NAME.png": "acebce1ce59642e89e34c1aab612af69",
"assets/lib/assets/icons/CATEGORYCHEST_DAMAGE_NAME.png": "bdcb827d907662681397e99c7d80cfee",
"assets/lib/assets/icons/CATEGORYCHEST_HEALING_NAME.png": "bd13cd9d835b4e77484baeda406dd66e",
"assets/lib/assets/icons/CATEGORYCHEST_UTILITY_NAME.png": "8adf0769ac72649d6ed88f0bc10502d5",
"assets/lib/assets/icons/CHEST1_NAME.png": "8ae37de6abce416394b53068ba9c1756",
"assets/lib/assets/icons/CHEST1_STEALTHED_NAME.png": "b800e196e9615e5bbc43bb1943f6b2e4",
"assets/lib/assets/icons/CHEST2_NAME.png": "144e68f1858d20bf857706062ef2ec65",
"assets/lib/assets/icons/DAMAGE.png": "5b51bb2296e99b6b352d8cabf17c8dbf",
"assets/lib/assets/icons/DRONE_GUNNER_INTERACTABLE_NAME.png": "95fee191f43f9f187973996865e7d51b",
"assets/lib/assets/icons/DRONE_HEALING_INTERACTABLE_NAME.png": "8894acf47f741984fb9a49b9504ee80f",
"assets/lib/assets/icons/DRONE_MISSILE_INTERACTABLE_NAME.png": "94f4f31782bd5db03c188da4d3679079",
"assets/lib/assets/icons/DUPLICATOR2_NAME.png": "6d6ac538f19c10e14bab1783b292beff",
"assets/lib/assets/icons/DUPLICATOR3_NAME.png": "c79244db170351bd9452402835a8f9f6",
"assets/lib/assets/icons/DUPLICATOR_NAME.png": "845faff88a2dd069e40ba1df63732e03",
"assets/lib/assets/icons/EQUIPMENTBARREL_NAME.png": "b9ccb137fe4a4dcf44709e590ef96bcd",
"assets/lib/assets/icons/EQUIPMENTDRONE_INTERACTABLE_NAME.png": "e8ab2c64e12395beaac7c5c7bed7886e",
"assets/lib/assets/icons/FLAMEDRONE_INTERACTABLE_NAME.png": "fa5f935b624a1d376c4bb784665ae954",
"assets/lib/assets/icons/GOLDCHEST_NAME.png": "2d7519d4c55fdbefa7b8c80f03022304",
"assets/lib/assets/icons/HEALING.png": "66a9b665cd8415aa7e431d8a7dbb2cb6",
"assets/lib/assets/icons/LOCKBOX_NAME.png": "85cc567348b304775ec53de09fcf9d99",
"assets/lib/assets/icons/LOCKEDTREEBOT_NAME.png": "a93673faf8a85634638e2be0ad19f67e",
"assets/lib/assets/icons/LUNAR_CHEST_NAME.png": "169c1022e6a584e3dfeaa7110cb3d08a",
"assets/lib/assets/icons/MULTISHOP_GREEN_NAME.png": "ac2bbb9fa54d55fe3051990dd5221bf5",
"assets/lib/assets/icons/MULTISHOP_ORANGE_NAME.png": "86247da4e35fdc9eb1038e04a5b1c7b2",
"assets/lib/assets/icons/MULTISHOP_WHITE_NAME.png": "5c13d39ce69fe057e7bdc08df423e387",
"assets/lib/assets/icons/NEWT_STATUE_NAME.png": "72bb023844e3e8df7262a9a36e2b98c0",
"assets/lib/assets/icons/SHRINE_BLOOD_NAME.png": "804168d88c6f90de75e59ffb376963d1",
"assets/lib/assets/icons/SHRINE_BOSS_NAME.png": "61d34770effed89265f50476aa838078",
"assets/lib/assets/icons/SHRINE_CHANCE_NAME.png": "8250324b01da92fb69f11750ab764ddd",
"assets/lib/assets/icons/SHRINE_CLEANSE_NAME.png": "180fc71f749973f76729e2c65c7e1a73",
"assets/lib/assets/icons/SHRINE_COMBAT_NAME.png": "ff914f517ce38b5430a0fa29f93ef1f6",
"assets/lib/assets/icons/SHRINE_GOLDSHORES_NAME.png": "1f0ece6c6f00ba810883b71c574149fb",
"assets/lib/assets/icons/SHRINE_HEALING_NAME.png": "6cc7485583963382e49e6a7050d15523",
"assets/lib/assets/icons/SHRINE_RESTACK_NAME.png": "d9b5053ba4447a6cc6083b1a7032dbe0",
"assets/lib/assets/icons/TELEPORTER_NAME.png": "5977d389e3e0f2d3db7eb03e2774fc37",
"assets/lib/assets/icons/TURRET1_INTERACTABLE_NAME.png": "8c61f48bb4510fadd34999711bfba5c8",
"assets/lib/assets/icons/UTILITY.png": "ca16367bc7204c273058be683bdcac5f",
"assets/lib/assets/icons/VOIDCAMPCENTER_NAME.png": "7d7c015f762c44e3479ea1e093ce5788",
"assets/lib/assets/icons/VOID_CHEST_NAME(1).png": "5a00751551c918115ae75607d0dea104",
"assets/lib/assets/icons/VOID_CHEST_NAME.png": "0db50afff81f5b4e1dea96f9eb7e0d0d",
"assets/lib/assets/icons/VOID_TRIPLE_NAME.png": "9162cd4c3beab51f43f460d5107bd6cc",
"assets/lib/assets/items/ARTIFACT_BOMB_NAME.png": "4fb70ae57484fb6edaa884ccdad262a4",
"assets/lib/assets/items/ARTIFACT_COMMAND_NAME.png": "303bde1241b00d3b1f249c6f61b45c9e",
"assets/lib/assets/items/ARTIFACT_ELITEONLY_NAME.png": "d64733655bd949d244b4c9918eff1bcf",
"assets/lib/assets/items/ARTIFACT_ENIGMA_NAME.png": "65223ff0d5aca5eb9f0ceb77047e4100",
"assets/lib/assets/items/ARTIFACT_FRIENDLYFIRE_NAME.png": "8e791c4cc242556bb2c79c440d8a984b",
"assets/lib/assets/items/ARTIFACT_GLASS_NAME.png": "624c6f53902693c13c824a35d8b81e2a",
"assets/lib/assets/items/ARTIFACT_MIXENEMY_NAME.png": "a308c5f5a733306a73e864a34e8bbce0",
"assets/lib/assets/items/ARTIFACT_MONSTERTEAMGAINSITEMS_NAME.png": "44ab7736eeae6c99bf964ba6925ea72a",
"assets/lib/assets/items/ARTIFACT_RANDOMSURVIVORONRESPAWN_NAME.png": "f6c7678cd51af4568ebf3272d65c14ff",
"assets/lib/assets/items/ARTIFACT_SACRIFICE_NAME.png": "6e86ec673dfadd714f2f7a3aeb0221cf",
"assets/lib/assets/items/ARTIFACT_SHADOWCLONE_NAME.png": "265aeffc0d9c5fad6c9fcef5ac899e9b",
"assets/lib/assets/items/ARTIFACT_SINGLEMONSTERTYPE_NAME.png": "453c026c0bb07a6a22f83fdb9f1678a8",
"assets/lib/assets/items/ARTIFACT_SWARMS_NAME.png": "9eb9b377e709c17c05164d35933e4b21",
"assets/lib/assets/items/ARTIFACT_TEAMDEATH_NAME.png": "b1f867d7ff9500453e437ce8d7682c19",
"assets/lib/assets/items/ARTIFACT_WEAKASSKNEES_NAME.png": "63468c39d5e600ba1f5ba0bb5bc333be",
"assets/lib/assets/items/ARTIFACT_WISPONDEATH_NAME.png": "1d74e3b5312ce1b2d7836d7b1a5d7c34",
"assets/lib/assets/items/blank.png": "a9e973fe55048670adcbdb2a1b8fbd3a",
"assets/lib/assets/items/BLOOD_EFFECT_NAME.png": "ffd55d767915496c3bdf3caa82137fa6",
"assets/lib/assets/items/CHANCE_FAIL_EFFECT_NAME.png": "780f5a8b95e5bc04107b5f692fc9041f",
"assets/lib/assets/items/COMBAT_EFFECT_NAME.png": "be681d576afec111e9dea81bfff6b19f",
"assets/lib/assets/items/EQUIPMENT_AFFIXBLUE_NAME.png": "c55bb3e7e98b120e4563daafc1ce2d1e",
"assets/lib/assets/items/EQUIPMENT_AFFIXEARTH_NAME.png": "c653265f206705c4daba436989a4e85f",
"assets/lib/assets/items/EQUIPMENT_AFFIXGOLD_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/EQUIPMENT_AFFIXHAUNTED_NAME.png": "66b83ac7683edac2a49dc38f2c91bcd3",
"assets/lib/assets/items/EQUIPMENT_AFFIXLUNAR_NAME.png": "dd6a1861c30ededbfb367ba0317c476a",
"assets/lib/assets/items/EQUIPMENT_AFFIXPOISON_NAME.png": "0d1d721fb987fee86d39fe3b9628942b",
"assets/lib/assets/items/EQUIPMENT_AFFIXRED_NAME.png": "585c6da6528c1e024921c9c3f428850c",
"assets/lib/assets/items/EQUIPMENT_AFFIXSECRETSPEED_NAME.png": "4c2f1843890e8333a355939fa888127e",
"assets/lib/assets/items/EQUIPMENT_AFFIXVOID_NAME.png": "c653265f206705c4daba436989a4e85f",
"assets/lib/assets/items/EQUIPMENT_AFFIXWHITE_NAME.png": "d754bea4281a2d93ba2ad4a559f75642",
"assets/lib/assets/items/EQUIPMENT_BFG_NAME.png": "a496576b12ef707997636431cd34d417",
"assets/lib/assets/items/EQUIPMENT_BLACKHOLE_NAME.png": "321e2e3eac34fcb5c94ff0e3bea8a43c",
"assets/lib/assets/items/EQUIPMENT_BOSSHUNTERCONSUMED_NAME.png": "760b62575b32892b366386b3aa700132",
"assets/lib/assets/items/EQUIPMENT_BOSSHUNTER_NAME.png": "e7322d5fc22f5147fbddf79c50410011",
"assets/lib/assets/items/EQUIPMENT_BURNNEARBY_NAME.png": "5834395ff777ed9ac9ba6d9f2453d3e3",
"assets/lib/assets/items/EQUIPMENT_CLEANSE_NAME.png": "5be5f6e6db376bee53bcf6749e0c64a0",
"assets/lib/assets/items/EQUIPMENT_COMMANDMISSILE_NAME.png": "bf85774354348b12b3f2619dc28b39fa",
"assets/lib/assets/items/EQUIPMENT_CRIPPLEWARD_NAME.png": "d98bda7a4ff58fde92c63c548ea83ca5",
"assets/lib/assets/items/EQUIPMENT_CRITONUSE_NAME.png": "79aff3b82bc8f3cb663311fa1a612e8f",
"assets/lib/assets/items/EQUIPMENT_DEATHPROJECTILE_NAME.png": "bc17d212c8ff6998f5706404dfe13eb1",
"assets/lib/assets/items/EQUIPMENT_DRONEBACKUP_NAME.png": "9d93978c0680522c86c0d898337524ac",
"assets/lib/assets/items/EQUIPMENT_FIREBALLDASH_NAME.png": "1a7df2aea5760c4858784aedf32d0fd8",
"assets/lib/assets/items/EQUIPMENT_FRUIT_NAME.png": "309a36e7072630d1c6fef45da8cc7f06",
"assets/lib/assets/items/EQUIPMENT_GAINARMOR_NAME.png": "de2eb060ff2de48fffa7600742437074",
"assets/lib/assets/items/EQUIPMENT_GATEWAY_NAME.png": "4ff8cfb976dd878fdaebabbdb6235167",
"assets/lib/assets/items/EQUIPMENT_GHOSTGUN_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/EQUIPMENT_GOLDGAT_NAME.png": "f97e39c238b790737715372183d8c090",
"assets/lib/assets/items/EQUIPMENT_GUMMYCLONE_NAME.png": "ea3db1f7d69805a23e4903b54b39e63c",
"assets/lib/assets/items/EQUIPMENT_IRRADIATINGLASER_NAME.png": "fa071b3f03163d14f4f0d85a0ec95a02",
"assets/lib/assets/items/EQUIPMENT_JETPACK_NAME.png": "51cafc96a5dc238f2a4863117aa2f4e4",
"assets/lib/assets/items/EQUIPMENT_LIFESTEALONHIT_NAME.png": "f470027a89508ee97d2944d2cf2eb080",
"assets/lib/assets/items/EQUIPMENT_LIGHTNING_NAME.png": "6c59d77d929371d48c5fde968e5629ed",
"assets/lib/assets/items/EQUIPMENT_LUNARPORTALONUSE_NAME.png": "9cdd1d25f80b89d013031cde49778127",
"assets/lib/assets/items/EQUIPMENT_LUNARPOTION_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/EQUIPMENT_METEOR_NAME.png": "67d87e6ed1dbe597e6565b6f64f83625",
"assets/lib/assets/items/EQUIPMENT_MOLOTOV_NAME.png": "805d5c85ab8d84aa6140227c8640aa08",
"assets/lib/assets/items/EQUIPMENT_MULTISHOPCARD_NAME.png": "14da12f70adb930bf7c5f29866fabcc2",
"assets/lib/assets/items/EQUIPMENT_ORBITALLASER_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/EQUIPMENT_ORBONUSE_NAME.png": "37906c06d8eb21739a118ffb73c51e29",
"assets/lib/assets/items/EQUIPMENT_PASSIVEHEALING_NAME.png": "8b4c6bbd28cead5cdd477ca415d086af",
"assets/lib/assets/items/EQUIPMENT_QUESTVOLATILEBATTERY_NAME.png": "bd049788976420aefe20f27d5d66e5f8",
"assets/lib/assets/items/EQUIPMENT_RECYCLER_NAME.png": "909769ddab6398d9bff0a313a0b4af01",
"assets/lib/assets/items/EQUIPMENT_SAWMERANG_NAME.png": "fd275437df99472668537571d4fd95b1",
"assets/lib/assets/items/EQUIPMENT_SCANNER_NAME.png": "247a7beff01afc0b68b9e0e73f17e993",
"assets/lib/assets/items/EQUIPMENT_SOULCORRUPTOR_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/EQUIPMENT_SOULJAR_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/EQUIPMENT_TEAMWARCRY_NAME.png": "9e5c7733e2b7553b3bf39c2ef2f4f213",
"assets/lib/assets/items/EQUIPMENT_TONIC_NAME.png": "0a62ae2d542ea84413924ac02d46bcd2",
"assets/lib/assets/items/EQUIPMENT_VENDINGMACHINE_NAME.png": "95410aedce35d0e662d04a831f3747af",
"assets/lib/assets/items/ITEM_AACANNON_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_ALIENHEAD_NAME.png": "2e57ee53cb75342ed089eb72e85a0987",
"assets/lib/assets/items/ITEM_ANCESTRALINCUBATOR_NAME.png": "de863fc168b5969eb12c86f6db62ca22",
"assets/lib/assets/items/ITEM_ARMORREDUCTIONONHIT_NAME.png": "3c07716d043e21cc0e2adb2b9f02d8ad",
"assets/lib/assets/items/ITEM_ARTIFACTKEY_NAME.png": "bc44b9338995511d9a68e8b845ba93f5",
"assets/lib/assets/items/ITEM_ATTACKSPEEDANDMOVESPEED_NAME.png": "2665966bf39bc577316161fa7dd74f7e",
"assets/lib/assets/items/ITEM_ATTACKSPEEDONCRIT_NAME.png": "37140af2df81bdd941a75d9979171cc1",
"assets/lib/assets/items/ITEM_AUTOCASTEQUIPMENT_NAME.png": "cb78db7228822deb7086530b435651fb",
"assets/lib/assets/items/ITEM_BANDOLIER_NAME.png": "74bc7601f872d0efe8b22172fb71fbf4",
"assets/lib/assets/items/ITEM_BARRIERONKILL_NAME.png": "426b169b741c0df1b4938c6bf43ab096",
"assets/lib/assets/items/ITEM_BARRIERONOVERHEAL_NAME.png": "8d489d69fea4d8d5fc6573dc05b4ddc5",
"assets/lib/assets/items/ITEM_BEARVOID_NAME.png": "f93c5fc023a6b07b6846a23eb1bf10ba",
"assets/lib/assets/items/ITEM_BEAR_NAME.png": "690cb6030ce96d3847ed3b1197132d83",
"assets/lib/assets/items/ITEM_BEETLEGLAND_NAME.png": "76f563567ea0bea6f483bc0b7755e875",
"assets/lib/assets/items/ITEM_BEHEMOTH_NAME.png": "84ce5e283761fb158ab17a7020907433",
"assets/lib/assets/items/ITEM_BLEEDONHITANDEXPLODE_NAME.png": "e44424ab8b9f1e1d78b6b038372a6577",
"assets/lib/assets/items/ITEM_BLEEDONHITVOID_NAME.png": "ae8c0f2a8e8afd78a2e2ab5d57a79475",
"assets/lib/assets/items/ITEM_BLEEDONHIT_NAME.png": "d68250cf46ea1be15cdf07bfff6e81bd",
"assets/lib/assets/items/ITEM_BONUSGOLDPACKONKILL_NAME.png": "c87ef67468937599f7c1289e155267de",
"assets/lib/assets/items/ITEM_BOOSTATTACKSPEED_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_BOOSTDAMAGE_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_BOOSTHP_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_BOSSDAMAGEBONUS_NAME.png": "196906d191ccb12257bea64fa6c35e9d",
"assets/lib/assets/items/ITEM_BOUNCENEARBY_NAME.png": "bee4ac94c2a5274e9499c8dd2b31e226",
"assets/lib/assets/items/ITEM_BURNNEARBY_NAME.png": "5834395ff777ed9ac9ba6d9f2453d3e3",
"assets/lib/assets/items/ITEM_CAPTAINDEFENSEMATRIX_NAME.png": "3279fa889e482df7fcba53bd3be5487d",
"assets/lib/assets/items/ITEM_CHAINLIGHTNINGVOID_NAME.png": "cd02dc8d97a58c1dd8a56297a930fcd7",
"assets/lib/assets/items/ITEM_CHAINLIGHTNING_NAME.png": "660363e1015f46e407ddb4d9cc8ad7bb",
"assets/lib/assets/items/ITEM_CLOVERVOID_NAME.png": "dc86daa1f77f294e9ca9d00cafc90c6c",
"assets/lib/assets/items/ITEM_CLOVER_NAME.png": "093601fb675c2f3c8f5feeaf940d2aac",
"assets/lib/assets/items/ITEM_CONVERTCRITCHANCETOCRITDAMAGE_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_COOLDOWNONCRIT_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_CRIPPLEWARDONLEVEL_NAME.png": "d98bda7a4ff58fde92c63c548ea83ca5",
"assets/lib/assets/items/ITEM_CRITDAMAGE_NAME.png": "f891f5591aba5a47ba85477722fba563",
"assets/lib/assets/items/ITEM_CRITGLASSESVOID_NAME.png": "d5531fee76e8976252802f27bfd22a69",
"assets/lib/assets/items/ITEM_CRITGLASSES_NAME.png": "58433620f0c5aa2d806468623090afe2",
"assets/lib/assets/items/ITEM_CRITHEAL_NAME.png": "367a98205f184d4dd013fa105fe066b8",
"assets/lib/assets/items/ITEM_CROWBAR_NAME.png": "fbd7072d510b4e0a23b17f8150b67cfc",
"assets/lib/assets/items/ITEM_CUTHP_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_DAGGER_NAME.png": "911ad52e93fb132a5c66bf82c05b4344",
"assets/lib/assets/items/ITEM_DEATHMARK_NAME.png": "4d566ca451326fc09b73993eca17411b",
"assets/lib/assets/items/ITEM_DRIZZLEPLAYERHELPER_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_DRONEWEAPONSBOOST_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_DRONEWEAPONSDISPLAY1_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_DRONEWEAPONSDISPLAY2_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_DRONEWEAPONS_NAME.png": "9d75d58c7cbfe6121527fec872773ce1",
"assets/lib/assets/items/ITEM_ELEMENTALRINGVOID_NAME.png": "883daae71c15aceddb723d4ed23621cf",
"assets/lib/assets/items/ITEM_EMPOWERALWAYS_NAME.png": "8db3bc181b63593034290269b6bb6409",
"assets/lib/assets/items/ITEM_ENERGIZEDONEQUIPMENTUSE_NAME.png": "dfeb0ae2c04a38505cd8ba485f08c643",
"assets/lib/assets/items/ITEM_EQUIPMENTMAGAZINEVOID_NAME.png": "f3770f993772af71c9b19e2a20028e52",
"assets/lib/assets/items/ITEM_EQUIPMENTMAGAZINE_NAME.png": "7bf6b942c23f1db0b0fed53a67a977c9",
"assets/lib/assets/items/ITEM_EXECUTELOWHEALTHELITE_NAME.png": "ed036a20ed0e0b4ec19a1966b2969738",
"assets/lib/assets/items/ITEM_EXPLODEONDEATHVOID_NAME.png": "6faded5634aed47ce3af07a111c94325",
"assets/lib/assets/items/ITEM_EXPLODEONDEATH_NAME.png": "4e933315575928fbaebf31a01e78cd6b",
"assets/lib/assets/items/ITEM_EXTRALIFECONSUMED_NAME.png": "2a562efac158487be3ba1ca10ee558f9",
"assets/lib/assets/items/ITEM_EXTRALIFEVOIDCONSUMED_NAME.png": "19e2eccec226ec1e1d777ae0709c7656",
"assets/lib/assets/items/ITEM_EXTRALIFEVOID_NAME.png": "5f8d3770fa06f9d6486c60852ceffa80",
"assets/lib/assets/items/ITEM_EXTRALIFE_NAME.png": "e81ff952868cde1800a4c6274af46c55",
"assets/lib/assets/items/ITEM_FALLBOOTS_NAME.png": "bde1d8c56260999add2c2af979107ebc",
"assets/lib/assets/items/ITEM_FEATHER_NAME.png": "303c81e318cd2e9c9cf8cfdf7878c3b5",
"assets/lib/assets/items/ITEM_FIREBALLSONHIT_NAME.png": "c9ef0fe0da8a4a8acd8255b2975272a4",
"assets/lib/assets/items/ITEM_FIRERING_NAME.png": "0671231f182f1b10f1f14bebf640b4aa",
"assets/lib/assets/items/ITEM_FIREWORK_NAME.png": "513ac8b31937d6ce4a9a4c952c752a7d",
"assets/lib/assets/items/ITEM_FLATHEALTH_NAME.png": "025e4671f00ab59928ae3bdfec02efa3",
"assets/lib/assets/items/ITEM_FOCUSEDCONVERGENCE_NAME.png": "c2b93f417ea4df007d89eed6666b23f1",
"assets/lib/assets/items/ITEM_FRAGILEDAMAGEBONUSCONSUMED_NAME.png": "f947a497e6505605a13d4fe727bb473b",
"assets/lib/assets/items/ITEM_FRAGILEDAMAGEBONUS_NAME.png": "a261cc90987f5daeac13d33f0f31cf3a",
"assets/lib/assets/items/ITEM_FREECHEST_NAME.png": "923d33ae3474d87901042b575a0f481b",
"assets/lib/assets/items/ITEM_GHOSTONKILL_NAME.png": "498b1a2979a81a6c456df8b9f976e585",
"assets/lib/assets/items/ITEM_GHOST_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_GOLDONHIT_NAME.png": "0ab9aa69e08c9b06def44f3379513ae9",
"assets/lib/assets/items/ITEM_GOLDONHURT_NAME.png": "b4e349c0a9feaac9b58dff7636917a34",
"assets/lib/assets/items/ITEM_GUMMYCLONEIDENTIFIER_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_HALFATTACKSPEEDHALFCOOLDOWNS_NAME.png": "22bb28a4ef5a3293f4250823dba5a2c2",
"assets/lib/assets/items/ITEM_HALFSPEEDDOUBLEHEALTH_NAME.png": "ec971f28f59c3539a78455f4b8697692",
"assets/lib/assets/items/ITEM_HEADHUNTER_NAME.png": "43b1663adfe3ef7fe4af1527fc12554c",
"assets/lib/assets/items/ITEM_HEALINGPOTIONCONSUMED_NAME.png": "73c6ed5a3297cf73129047d46fcc942b",
"assets/lib/assets/items/ITEM_HEALINGPOTION_NAME.png": "25983ecdfbc6c0656047a7ecdde558ca",
"assets/lib/assets/items/ITEM_HEALONCRIT_NAME.png": "1e65793597793ad27edb83947725aabd",
"assets/lib/assets/items/ITEM_HEALTHDECAY_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_HEALWHILESAFE_NAME.png": "4d28c01c81f137102b1e2f39581b68b0",
"assets/lib/assets/items/ITEM_HOOF_NAME.png": "3dac71085340b2c5a79adbd938ed4e6e",
"assets/lib/assets/items/ITEM_ICERING_NAME.png": "9546269a886e3684da0b8e5b8e0b09b7",
"assets/lib/assets/items/ITEM_ICICLE_NAME.png": "bce4c5d2952e042b157a3013e00a2d69",
"assets/lib/assets/items/ITEM_IGNITEONKILL_NAME.png": "6e7787d0257ad6549b05651a11a2f003",
"assets/lib/assets/items/ITEM_IMMUNETODEBUFF_NAME.png": "85798ae6299d90840341d550db429e15",
"assets/lib/assets/items/ITEM_INCREASEHEALING_NAME.png": "b4aa68776c8ccc15b863b76617cdef6a",
"assets/lib/assets/items/ITEM_INFUSION_NAME.png": "20e21b4c608c0830cfd5a8dc80b76e37",
"assets/lib/assets/items/ITEM_INTERSTELLARDESKPLANT_NAME.png": "5ce7a0af233ed114523151bc96d83433",
"assets/lib/assets/items/ITEM_INVADINGDOPPELGANGER_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_JUMPBOOST_NAME.png": "26083b610360b951ce6b2d1abae239ec",
"assets/lib/assets/items/ITEM_KILLELITEFRENZY_NAME.png": "3d2bee7f82d56bc62c86268f4b177f22",
"assets/lib/assets/items/ITEM_KNURL_NAME.png": "a403b0a7531738601e868977e627487a",
"assets/lib/assets/items/ITEM_LASERTURBINE_NAME.png": "5e2d381c0971215eac3668a932c2b0be",
"assets/lib/assets/items/ITEM_LEVELBONUS_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_LIGHTNINGSTRIKEONHIT_NAME.png": "e91f8f0ed0829b5fc343d91ef947cb97",
"assets/lib/assets/items/ITEM_LUNARBADLUCK_NAME.png": "e997f415c292aa6ac3384a8be8ad78ce",
"assets/lib/assets/items/ITEM_LUNARDAGGER_NAME.png": "a3988eea26db362725dda7010fb24794",
"assets/lib/assets/items/ITEM_LUNARPRIMARYREPLACEMENT_NAME.png": "02a173c98f0a017a472e298a5f1f43ae",
"assets/lib/assets/items/ITEM_LUNARSECONDARYREPLACEMENT_NAME.png": "1e6523d420cc28d65e179d7e6e69c168",
"assets/lib/assets/items/ITEM_LUNARSPECIALREPLACEMENT_NAME.png": "f826a73a9d6f8299e3029f732da9a1e2",
"assets/lib/assets/items/ITEM_LUNARSUN_NAME.png": "8db3bc181b63593034290269b6bb6409",
"assets/lib/assets/items/ITEM_LUNARTRINKET_NAME.png": "351bdb8f9f45062a92e03019fa208ac6",
"assets/lib/assets/items/ITEM_LUNARUTILITYREPLACEMENT_NAME.png": "4d1e08b61968e2ed56dc6cf3fa34d8ae",
"assets/lib/assets/items/ITEM_LUNARWINGS_NAME.png": "ee50de8e55a4ff6240c213329893fd8c",
"assets/lib/assets/items/ITEM_MAGEATTUNEMENT_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_MEDKIT_NAME.png": "b3bd7a43cf8bcd3c6250fd957c3d9686",
"assets/lib/assets/items/ITEM_MINIONLEASH_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_MINORCONSTRUCTONKILL_NAME.png": "172789daea6cf7af5162ba2712172493",
"assets/lib/assets/items/ITEM_MISSILEVOID_NAME.png": "96f946dd124bfb3f1faf4d4753bb56cc",
"assets/lib/assets/items/ITEM_MISSILE_NAME.png": "72f7dcb432951cd62016655ee465076f",
"assets/lib/assets/items/ITEM_MONSOONPLAYERHELPER_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_MONSTERSONSHRINEUSE_NAME.png": "195ecc0e84ecbfcd4f017f3885862549",
"assets/lib/assets/items/ITEM_MOREMISSILE_NAME.png": "f0763fa76e72d97d1c3a4006218db7b0",
"assets/lib/assets/items/ITEM_MOVESPEEDONKILL_NAME.png": "9c80539680512801760a274934b6d278",
"assets/lib/assets/items/ITEM_MUSHROOMVOID_NAME.png": "4c6ea31c7e90e42f22636cf6d63cc754",
"assets/lib/assets/items/ITEM_MUSHROOM_NAME.png": "1f62e0ae433a6ee9352774be3912c53e",
"assets/lib/assets/items/ITEM_NEARBYDAMAGEBONUS_NAME.png": "2431daedac4aa647e8fdf44255408d98",
"assets/lib/assets/items/ITEM_NOVAONHEAL_NAME.png": "f4ff84c93af04e5e462b46ef3fd720f4",
"assets/lib/assets/items/ITEM_NOVAONLOWHEALTH_NAME.png": "63d3f749b11f9dc77e6c498e38773596",
"assets/lib/assets/items/ITEM_OUTOFCOMBATARMOR_NAME.png": "1a771d3ccf1c49bdaf0e846d1f0c8c11",
"assets/lib/assets/items/ITEM_PARENTEGG_NAME.png": "5aa53c784f4cb6652799a246bd1b091e",
"assets/lib/assets/items/ITEM_PEARL_NAME.png": "bcf297637e3205d75d90a2275f3f3486",
"assets/lib/assets/items/ITEM_PERMANENTDEBUFFONHIT_NAME.png": "55ebb9834de5b2b8eaaba6b6ffb6cfb6",
"assets/lib/assets/items/ITEM_PERSONALSHIELD_NAME.png": "ad3e1f2db3a09162cf894b218667f6de",
"assets/lib/assets/items/ITEM_PHASING_NAME.png": "9bcec6e5d0d93aeb7e49978e3867f319",
"assets/lib/assets/items/ITEM_PLANTONHIT_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_PLASMACORE_NAME.png": "6c61c0c0035ca9ade90b39a8818b5051",
"assets/lib/assets/items/ITEM_PRIMARYSKILLSHURIKEN_NAME.png": "d64a67cae087d32ba2c1fcbb51df583f",
"assets/lib/assets/items/ITEM_RANDOMDAMAGEZONE_NAME.png": "2d75ed2aa161581f46e82a3f4e549a83",
"assets/lib/assets/items/ITEM_RANDOMEQUIPMENTTRIGGER_NAME.png": "9c453d58da52292056c2792c04ee2a40",
"assets/lib/assets/items/ITEM_RANDOMLYLUNAR_NAME.png": "7f9a835c70958d826af93ec2e25d72bd",
"assets/lib/assets/items/ITEM_REGENERATINGSCRAPCONSUMED_NAME.png": "134c552fa1a67edbdf5fadf89e9ea19f",
"assets/lib/assets/items/ITEM_REGENERATINGSCRAP_NAME.png": "ac0f3e53be5183c2b9aa5390214df6dc",
"assets/lib/assets/items/ITEM_REPEATHEAL_NAME.png": "367a98205f184d4dd013fa105fe066b8",
"assets/lib/assets/items/ITEM_REPULSIONARMORPLATE_NAME.png": "e848ac8392baae35d890b51f0ca8294b",
"assets/lib/assets/items/ITEM_ROBOBALLBUDDY_NAME.png": "b539a6372890cb3d1682d2b3cc11a482",
"assets/lib/assets/items/ITEM_SCRAPGREENSUPPRESSED_NAME.png": "acbd57fe6397e71506f42fa2f635059f",
"assets/lib/assets/items/ITEM_SCRAPGREEN_NAME.png": "9d2f51197a49b924679fe06d54b8bfb3",
"assets/lib/assets/items/ITEM_SCRAPREDSUPPRESSED_NAME.png": "2a36d56d706bb855465c76cd2c5f7a5c",
"assets/lib/assets/items/ITEM_SCRAPRED_NAME.png": "527043b5238486cd37b43157d7fd15e5",
"assets/lib/assets/items/ITEM_SCRAPWHITESUPPRESSED_NAME.png": "dcbf2fc4b2bde72642e760a962c3c6a0",
"assets/lib/assets/items/ITEM_SCRAPWHITE_NAME.png": "3a70ee13a7fb09d36916ccd5a7fd8fcf",
"assets/lib/assets/items/ITEM_SCRAPYELLOW_NAME.png": "7b6871b03b5536d65073dc3bd90e32be",
"assets/lib/assets/items/ITEM_SECONDARYSKILLMAGAZINE_NAME.png": "d731062e2c287a9e3e4ef1251d1c83d8",
"assets/lib/assets/items/ITEM_SEED_NAME.png": "b3df138c5d66e60a90b59521c75b0290",
"assets/lib/assets/items/ITEM_SHIELDONLY_NAME.png": "ab6d245bb8141a5903e8a616dd6016ec",
"assets/lib/assets/items/ITEM_SHINYPEARL_NAME.png": "cd767ab847d5f6631fdf7031212a1e5c",
"assets/lib/assets/items/ITEM_SHOCKNEARBY_NAME.png": "036741c242b1c172dceb0c39ba865e90",
"assets/lib/assets/items/ITEM_SIPHONONLOWHEALTH_NAME.png": "2f44900ffcf5b1d081b6c7c71f9fa8ee",
"assets/lib/assets/items/ITEM_SKULLCOUNTER_NAME.png": "7e71c87377e7dab0db2b77cda8409688",
"assets/lib/assets/items/ITEM_SLOWONHITVOID_NAME.png": "d52e45d0adbda5d618c5277ac89627de",
"assets/lib/assets/items/ITEM_SLOWONHIT_NAME.png": "5c1dfff9ebae58b589070ceed45d6afc",
"assets/lib/assets/items/ITEM_SPRINTARMOR_NAME.png": "ed88934ef7028b4bd127ca407ff4e490",
"assets/lib/assets/items/ITEM_SPRINTBONUS_NAME.png": "104afd7ca873688aaf3c4dcae36a8d91",
"assets/lib/assets/items/ITEM_SPRINTOUTOFCOMBAT_NAME.png": "ece4ba09e6d05b25ace5a482843bd6ee",
"assets/lib/assets/items/ITEM_SPRINTWISP_NAME.png": "8be4c407b57f1b0c7f6dbe3aa323f6f8",
"assets/lib/assets/items/ITEM_SQUIDTURRET_NAME.png": "6afc37d307eb83335bcb0f8634d58ff1",
"assets/lib/assets/items/ITEM_STICKYBOMB_NAME.png": "21b1a5fa228de3404a6e43224df2775c",
"assets/lib/assets/items/ITEM_STRENGTHENBURN_NAME.png": "00dce3492edb85c51ff1c17bd1f89a46",
"assets/lib/assets/items/ITEM_STUNCHANCEONHIT_NAME.png": "179cb6c142a1a964ff3291e4bc1face9",
"assets/lib/assets/items/ITEM_SYRINGE_NAME.png": "d5b3c64b288d9536521fb46f65b6a610",
"assets/lib/assets/items/ITEM_TALISMAN_NAME.png": "20a7fc0639076ff47715262f75b9e440",
"assets/lib/assets/items/ITEM_TEMPESTONKILL_NAME.png": "26083b610360b951ce6b2d1abae239ec",
"assets/lib/assets/items/ITEM_THORNS_NAME.png": "a84a8d301f06e7fb5141e9c9b1b03b82",
"assets/lib/assets/items/ITEM_TITANGOLDDURINGTP_NAME.png": "3d212f02782e0a86fa97ac884f0d1a0f",
"assets/lib/assets/items/ITEM_TONICAFFLICTION_NAME.png": "e9e3e2611bf5b3a2e259b63d0d3c3cec",
"assets/lib/assets/items/ITEM_TOOTH_NAME.png": "bd842f82535b14e69579775b45943158",
"assets/lib/assets/items/ITEM_TPHEALINGNOVA_NAME.png": "4277ab38f164385220343e4b8ecf740a",
"assets/lib/assets/items/ITEM_TREASURECACHEVOID_NAME.png": "02f040a6699a5012ab024e20ecad27be",
"assets/lib/assets/items/ITEM_TREASURECACHE_NAME.png": "84e92f65482600e50b680d2213bcdfc6",
"assets/lib/assets/items/ITEM_UTILITYSKILLMAGAZINE_NAME.png": "466db89dd915ace7234dcd93de635314",
"assets/lib/assets/items/ITEM_VOIDMEGACRABITEM_NAME.png": "08f48460b4fe4c9818531be57f69b96b",
"assets/lib/assets/items/ITEM_WARCRYONCOMBAT_NAME.png": "b888aefbf2c58687eff0cd919e313cc3",
"assets/lib/assets/items/ITEM_WARCRYONMULTIKILL_NAME.png": "b888aefbf2c58687eff0cd919e313cc3",
"assets/lib/assets/items/ITEM_WARDONLEVEL_NAME.png": "eff3801973267effa73e907b11b8635d",
"assets/lib/assets/items/LAZARUSWINGS_NAME.png": "e96f4bf172b75759e2d9839af7f39cad",
"assets/lib/assets/items/MOUNTAIN_EFFECT_NAME.png": "508801ebd73ed6f29aa46f754b1e8dda",
"assets/lib/assets/items/WOODS_EFFECT_NAME.png": "c3244629ba1be8dab5196cefcb205426",
"assets/lib/assets/maps/ancientloft_v1.png": "cfed39c8b6cec9b8ee75abcef6725f55",
"assets/lib/assets/maps/ancientloft_v2.png": "5455f1ed2baec83775cff0fd6dfea513",
"assets/lib/assets/maps/blackbeach.png": "b99ef8f25dc0c7b1f174ebc9292a0cab",
"assets/lib/assets/maps/blackbeach2.png": "cf8a9b9b3ab12afb356566ccb2676afd",
"assets/lib/assets/maps/bridgemeadow.png": "4889816731172bafbd658ecb7cb5aba4",
"assets/lib/assets/maps/dampcavesimple.png": "53014d27554059c1e713a77ce300d0e2",
"assets/lib/assets/maps/foggyswamp.png": "6d715c4e49ac035c86ec0992007d36d2",
"assets/lib/assets/maps/frozenwall.png": "2440fffe81d342bbaea0697f8c8b9f86",
"assets/lib/assets/maps/golemplains.png": "adcb66264a432068dfc90e1c6eda1017",
"assets/lib/assets/maps/golemplains2.png": "3cbacaf73d5a9017cd0d7748d1fbdc5f",
"assets/lib/assets/maps/goolake_v1.png": "6260c6382f2f2f88894862ca0796b7ab",
"assets/lib/assets/maps/lakes.png": "92a4ee627655adfd94d8cca505b2e1f4",
"assets/lib/assets/maps/moon2.png": "212bbfe3f8773a650b2100a984003f14",
"assets/lib/assets/maps/overlayable_goolake.png": "6d9207af5f3c68a8f6f78e8cc4db5c57",
"assets/lib/assets/maps/rootjungle_bigplateau.png": "4ec673e276697e90da9dec341b4ca3a6",
"assets/lib/assets/maps/shipgraveyard.png": "d967b50cd8f0ed690407a026ff205ef4",
"assets/lib/assets/maps/skymeadow_bridgeless.png": "2ee0f7b787a395e57b030c738184f3e2",
"assets/lib/assets/maps/snowyforest.png": "3bbbcf74e4f8f7cabd1a0bb6dab6cbc8",
"assets/lib/assets/maps/sulfurpools.png": "ae12881a0995090d70d429d17cc798f9",
"assets/lib/assets/maps/wispgraveyard.png": "3090ec71b25aff604f0e37c478d0d96c",
"assets/lib/assets/misc/background.jpg": "264260a3a6af85c39541e52588a9b6dd",
"assets/lib/assets/misc/background_fight.jpg": "42bd671622e7c6c20f319dbb745e97a5",
"assets/lib/assets/misc/DeathEvent-OLD.png": "e96f4bf172b75759e2d9839af7f39cad",
"assets/lib/assets/misc/DeathEvent.png": "b3216e7d5c61317f119058872066a8e6",
"assets/lib/assets/misc/dot.png": "abe89480d8b6829f481adfb9cad72d89",
"assets/lib/assets/misc/select_file.png": "b92889d53cb761060bd98c26357ea102",
"assets/lib/assets/stages/MAP_ANCIENTLOFT_TITLE.png": "52e17a589758e6fa972a05a0ae961138",
"assets/lib/assets/stages/MAP_ARENA_TITLE.png": "517d0cf40ef6d747eea5551a9fafe580",
"assets/lib/assets/stages/MAP_ARTIFACTWORLD_TITLE.png": "c99812656fe69521bc4ce2bfb6cb9497",
"assets/lib/assets/stages/MAP_BAZAAR_TITLE.png": "667c2fc33904668657aa09fa7f583d86",
"assets/lib/assets/stages/MAP_BLACKBEACH_TITLE.png": "678a892779d5333c8d8d2118b11fcc87",
"assets/lib/assets/stages/MAP_DAMPCAVE_TITLE.png": "1f98d104a30ecc676d5554a5da00e3c6",
"assets/lib/assets/stages/MAP_FOGGYSWAMP_TITLE.png": "10e734bc367233bd9491599ab86ea0a3",
"assets/lib/assets/stages/MAP_FROZENWALL_TITLE.png": "f88a0d796871894e9fd372c42b3715d7",
"assets/lib/assets/stages/MAP_GOLDSHORES_TITLE.png": "b86739f4b9cc967e8b8e4c7d4d213bb3",
"assets/lib/assets/stages/MAP_GOLEMPLAINS_TITLE.png": "4b61e9c4d0cc5ffe3b5816c983ac7c31",
"assets/lib/assets/stages/MAP_GOOLAKE_TITLE.png": "927c4500fdcf344abd97e552f791c98d",
"assets/lib/assets/stages/MAP_INFINITETOWER_TITLE.png": "517d0cf40ef6d747eea5551a9fafe580",
"assets/lib/assets/stages/MAP_LIMBO_TITLE.png": "9cbe1b8a0d59ac5c8a4bbc1fa0123cb1",
"assets/lib/assets/stages/MAP_MOON_TITLE.png": "1ee391317283038c0573efe406b0bc67",
"assets/lib/assets/stages/MAP_MYSTERYSPACE_TITLE.png": "2d470f8f013b480436b0bbfddcb01931",
"assets/lib/assets/stages/MAP_ROOTJUNGLE_TITLE.png": "785dc17a91e961feb63cf448fff535e4",
"assets/lib/assets/stages/MAP_SHIPGRAVEYARD_TITLE.png": "e289dd18ac2183f02aa9b0d2a65059cf",
"assets/lib/assets/stages/MAP_SKYMEADOW_TITLE.png": "8d05cd912c92fcbb49e9b4a315cafe2f",
"assets/lib/assets/stages/MAP_SNOWYFOREST_TITLE.png": "6ceb582f3e4a447bcc49311c0275d22d",
"assets/lib/assets/stages/MAP_SULFURPOOLS_TITLE.png": "226309f9cac30772b192e2095815fd3f",
"assets/lib/assets/stages/MAP_VOIDRAID_TITLE.png": "e41f41e1ca369f4f91f73bccaf51c854",
"assets/lib/assets/stages/MAP_VOIDSTAGE_TITLE.png": "d4ec888668fe2e1bbcf669012d85adb3",
"assets/lib/assets/stages/MAP_WISPGRAVEYARD_TITLE.png": "a5f6bf9f9188accc0ff88ac7eab58259",
"assets/lib/map_shit/event_overlayer.dart": "9ff5a1d2d9dacd55bbce7db0cbed8bf9",
"assets/lib/map_shit/loot_overlayer.dart": "8fcd06c188b24598cba3ed605d077183",
"assets/lib/map_shit/map_to_image_helper.dart": "c61b54f54b488f0c027565726cae55c6",
"assets/lib/map_shit/multiitem_position_delegate.dart": "3568ab345b405e8b7758d102087bb42f",
"assets/lib/map_shit/stage_view.dart": "b1cc467bba2abab6a2553325c51d42bd",
"assets/NOTICES": "b41b44b571155e98e62a537aaaa22d79",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "9a39ab8aa3d828142935da9efe99b3a2",
"canvaskit/canvaskit.wasm": "afdcccf150b5cba228e27c813548b842",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "43ec75ce562f82c5dc5be1a738d87e37",
"canvaskit/chromium/canvaskit.wasm": "3909da2fbccad1a2e4a1f42750d24977",
"canvaskit/skwasm.js": "e95d3c5713624a52bf0509ccb24a6124",
"canvaskit/skwasm.js.symbols": "0b8baeff2b4484d2d6be67a7e082f9db",
"canvaskit/skwasm.wasm": "ee4afa1790abb925360fd9519c5194f7",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "bfeb265305829c91044609829118cb1b",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "eda3aa60ca24e71c8598d256c61c4e9a",
"/": "eda3aa60ca24e71c8598d256c61c4e9a",
"main.dart.js": "3aa37eab6dea152282f5bbca3376883f",
"manifest.json": "c4cd1337db9da283a8433de90fb18b19",
"version.json": "f87e4c94597958d2930a763a16a7e3e0"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
