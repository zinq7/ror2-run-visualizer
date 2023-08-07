String getPfp(String name) {
  if (pfpMap.containsKey(name)) {
    return pfpMap[name]!;
  } else {
    return "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/271deea8-e28c-41a3-aaf5-2913f5f48be6/de7834s-6515bd40-8b2c-4dc6-a843-5ac1a95a8b55.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI3MWRlZWE4LWUyOGMtNDFhMy1hYWY1LTI5MTNmNWY0OGJlNlwvZGU3ODM0cy02NTE1YmQ0MC04YjJjLTRkYzYtYTg0My01YWMxYTk1YThiNTUuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.BopkDn1ptIwbmcKHdAOlYHyAOOACXW0Zfgbs0-6BY-E";
  }
}

const pfpMap = <String, String>{
  "Cabbage123": "https://yt3.googleusercontent.com/_H-mAz3ZtQ3HQ08ymGa7S4bHVcso-U0NiixDU3D2zFx_2hJiGzOSzUr6OHrs1LRR9J7diYloVA=s176-c-k-c0x00ffffff-no-rj",
  "Nuxlar": "https://static-cdn.jtvnw.net/jtv_user_pictures/0565f80a-60e4-4cb3-a255-b69b3c30d501-profile_image-70x70.png",
  "zinqio": "https://static-cdn.jtvnw.net/jtv_user_pictures/9d1e7994-2ebf-4617-a4f6-8263984b4b79-profile_image-70x70.png",
  "ICap_I": "https://www.ikea.com/ca/en/images/products/knoeckla-step-trash-can-dark-gray__1029080_pe835654_s5.jpg",
  "Kei": "https://repository-images.githubusercontent.com/412098143/e4c94bec-9e90-4be5-aa6b-1d2fa97fc420",
  "no_pick": "https://1.bp.blogspot.com/-iCnFX7eWVjs/XR9NQutHXcI/AAAAAAAAJ9k/ISWH3UXgJF8QJdsV6P9wh3agzOwOF_aYgCLcBGAs/s1600/cat-1285634_1920.png"
};
