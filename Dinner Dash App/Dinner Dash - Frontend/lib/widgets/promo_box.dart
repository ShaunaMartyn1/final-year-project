import 'package:flutter/material.dart';
import 'package:flutter_app/models/promo_model.dart';

class PromoBox extends StatelessWidget {
  final Promo promo;

  const PromoBox({
    Key? key,
    required this.promo,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
              image: NetworkImage(promo.imageUrl,),
              fit: BoxFit.cover,
            ),
          ),
      ),
      ClipPath(
        clipper: PromoCustomClipper(),
        child: Container(
            margin: const EdgeInsets.only(right: 5.0),
            width: MediaQuery.of(context).size.width - 60,//40
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 15,
                right: 25,
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(promo.title, style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 15),//space between text -for promos
                Text(promo.description,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white
                  ),
                )
              ],),
            ),
        ),
      ),
    ],
    );
  }
}

class PromoCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    //4 points/edges of custom clipper
    var path = new Path();
    path.lineTo(0,0);
    path.lineTo(0, size.height);
    path.lineTo(620, size.height);
    path.lineTo(750, 0);

    return path;
    
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}