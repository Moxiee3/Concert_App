class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "images/on5.png",
    title: "Your concert trip starts",
    subTitle:
        "Explore a vast of concert happening \naround you. Whether you're into rock, pop, \njazz or classical, we've got you covered.",
  ),
  Items(
    img: "images/on6.png",
    title: "Concert with Music Lovers",
    subTitle:
        "Join our community of music enthusiasts. \nShare your experieences, discuss,\nperformances, and make new friends.",
  ),
  Items(
    img: "images/on3.png",
    title: "Real-time Updates",
    subTitle:
        "Get real-tine updates about concert \nschedules venue changes, and more. Stay \ninformed and never miss a beat.",
  ),
];
