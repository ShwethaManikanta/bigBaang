import 'package:bigbaang/FrontEnd/CommonWidgets/common_styles.dart';
import 'package:bigbaang/FrontEnd/Pages/Cart/cart.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/home_page.dart';
import 'package:bigbaang/FrontEnd/Pages/HomePage/widgets/search_delgate.dart';
import 'package:bigbaang/FrontEnd/Pages/SearchBar/search_screen.dart';
import 'package:bigbaang/FrontEnd/Pages/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeBottomScreen extends StatefulWidget {
  const HomeBottomScreen({Key? key}) : super(key: key);

  @override
  _HomeBottomScreenState createState() => _HomeBottomScreenState();
}

class _HomeBottomScreenState extends State<HomeBottomScreen> {
  int selectedIndex = 0;

  final List<Widget> _childScreen = [
    HomePage(),
    SearchScreen(),
    CartPage(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: CustomAnimatedBottomBar(
          /*  child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: darkOrange,
            unselectedItemColor: Colors.grey,
            currentIndex: selectedIndex,
            selectedLabelStyle: labelTextStyle,
            unselectedLabelStyle: labelTextStyle,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'FOODIE',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.takeout_dining),
                label: 'Meat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'SEARCH',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart),
                label: 'CART',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'ACCOUNT',
              ),
            ],
        ),*/
          containerHeight: 45,
          selectedIndex: selectedIndex,
          showElevation: true,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          itemCornerRadius: 12,
          bottomMargin: 3,
          iconSize: 18,
          curve: Curves.easeIn,
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            //BottomNavyBarItem custom model.
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: Center(
                  child:
                      Text("Home", style: CommonStyles.blackText12BoldW400())),
              activeColor: Colors.white,
              inactiveColor: Colors.indigo,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.search),
              title: Center(
                  child: Text(
                '  Search',
                style: CommonStyles.blackText12BoldW400(),
              )),
              activeColor: Colors.white,
              inactiveColor: Colors.indigo,
              textAlign: TextAlign.center,
            ),
            /*   BottomNavyBarItem(
              icon: const Icon(Icons.no_meals_sharp),
              title: const Text('Meat'),
              activeColor: Colors.brown[800],
              inactiveColor: Colors.brown[800],
              textAlign: TextAlign.center,
            ),*/

            BottomNavyBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              title: Center(
                  child: Text(
                'Cart',
                style: CommonStyles.blackText12BoldW400(),
              )),
              activeColor: Colors.white,
              inactiveColor: Colors.indigo,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.account_circle),
              title: Text(
                'Account',
                style: CommonStyles.blackText12BoldW400(),
              ),
              activeColor: Colors.white,
              inactiveColor: Colors.indigo,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: _childScreen[selectedIndex],
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    this.icon,
    this.title,
    this.activeColor = Colors.indigo,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget? icon;
  final Widget? title;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
}

class CustomAnimatedBottomBar extends StatelessWidget {
  const CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.itemCornerRadius = 50,
    this.bottomMargin = 0,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int>? onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: bottomMargin),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.only(top: 3),
      child: SafeArea(
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: containerHeight,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected!(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: Colors.transparent,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double? iconSize;
  final bool? isSelected;
  final BottomNavyBarItem? item;
  final Color? backgroundColor;
  final double? itemCornerRadius;
  final Duration? animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    this.item,
    this.isSelected,
    this.backgroundColor,
    this.animationDuration,
    this.itemCornerRadius,
    this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected! ? 80 : 70,
        height: double.maxFinite,
        duration: animationDuration!,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected! ? Colors.indigo : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius!),
        ),
        child: Center(
          child: SizedBox(
            width: isSelected! ? 80 : 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected!
                        ? item!.activeColor!.withOpacity(1)
                        : item!.inactiveColor,
                  ),
                  child: item!.icon!,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 2),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(
                      color: isSelected! ? Colors.brown[800] : Colors.black,
                    ),
                    maxLines: 1,
                    textAlign: item!.textAlign,
                    child: item!.title!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
