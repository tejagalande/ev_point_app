import 'package:ev_point/controllers/station/route_search_provider.dart';
import 'package:ev_point/views/station/route_map_screen.dart';
import 'package:ev_point/utils/constants.dart';
import 'package:ev_point/utils/theme/app_color.dart';
import 'package:ev_point/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RouteSearchScreen extends StatefulWidget {
  const RouteSearchScreen({super.key});

  @override
  State<RouteSearchScreen> createState() => _RouteSearchScreenState();
}

class _RouteSearchScreenState extends State<RouteSearchScreen> {
  final FocusNode _sourceFocusNode = FocusNode();
  final FocusNode _destinationFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _sourceFocusNode.addListener(_onSourceFocusChange);
    _destinationFocusNode.addListener(_onDestinationFocusChange);
  }

  void _onSourceFocusChange() {
    if (_sourceFocusNode.hasFocus) {
      // We need to access the provider without listening to it here
      // But since the provider is created in the build method's ChangeNotifierProvider,
      // we can't access it via context.read<RouteSearchProvider>() if it's not up in the tree yet.
      // However, the ChangeNotifierProvider is inside the build method of THIS widget's state?
      // No, usually we wrap the Scaffold.

      // Wait, if I wrap the Scaffold in ChangeNotifierProvider inside build,
      // then context.read<RouteSearchProvider>() won't work in initState or these listeners
      // because the context passed to build is the parent context, which doesn't have the provider yet.

      // To fix this, I should probably move the ChangeNotifierProvider up or use a Builder/Consumer
      // to get a context that has the provider.
      // OR, simpler: Just use the provider instance if I had access to it.

      // Let's look at the build method structure I'm planning.
      // build returns ChangeNotifierProvider -> Scaffold.
      // So 'context' in _onSourceFocusChange (which uses 'this.context') refers to the widget's context.
      // The widget's context is ABOVE the ChangeNotifierProvider created in build.
      // So context.read will FAIL.

      // Solution:
      // 1. Move ChangeNotifierProvider to the route definition (AppPages).
      // 2. Or wrap the body content in a Builder/Consumer and pass THAT context to some handler?
      // But focus listeners are outside build.

      // Actually, the best way for a screen-specific provider is often to pass it in or
      // use a nested Builder. But for FocusNode listeners which are outside build...

      // Let's try to access the provider via a GlobalKey or just rely on the fact that
      // we can use a Consumer to wrap the TextFields and they can update the state.
      // But I need to know WHEN focus changes.

      // Alternative: Don't use FocusNode listeners for state update.
      // Use `TapRegion` or `Focus` widget in the tree.
      // Or simply: The TextField `onTap` or `onTapOutside`?
      // `onTap` works when you tap it.
      // But what if you tab into it? FocusNode listener is better.

      // To make context.read work, I need the Provider to be above this widget.
      // But I'm creating it here.

      // Okay, I will wrap the content of the Scaffold body in a Builder,
      // and I will move the FocusNode listener logic to be triggered from within that Builder
      // or just accept that I need to find the provider.

      // Actually, I can just store the provider in a variable in `build`? No, that's messy.

      // Let's go with: Use `Focus` widget wrapping the TextField.
      // `Focus(onFocusChange: (hasFocus) { ... })`
      // This is much cleaner and works inside the tree where Provider is available!
    }
  }

  void _onDestinationFocusChange() {
    // See above. I will use Focus widget in build instead.
  }

  @override
  void dispose() {
    _sourceFocusNode.removeListener(_onSourceFocusChange);
    _destinationFocusNode.removeListener(_onDestinationFocusChange);
    _sourceFocusNode.dispose();
    _destinationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RouteSearchProvider(),
      child: Scaffold(
        backgroundColor: AppColor.white,

        appBar: AppBar(
          backgroundColor: AppColor.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Route Search",
            style: TextStyle(
              fontFamily: Constants.urbanistFont,
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(thickness: 0.5),
            Consumer<RouteSearchProvider>(
              builder: (context, provider, child) {
                return CustomButton(
                  title: "Search",
                  textColor: AppColor.white,
                  borderRadius: 30.r,
                  isShadow: true,
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  buttonColor: AppColor.primary_900,
                  onTapCallback: () {
                    if (provider.sourceLatLng != null &&
                        provider.destinationLatLng != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => RouteMapScreen(
                                source: provider.sourceLatLng!,
                                destination: provider.destinationLatLng!,
                              ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select both locations")),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: Consumer<RouteSearchProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // From Field
                  Text(
                    "From",
                    style: TextStyle(
                      fontFamily: Constants.urbanistFont,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) provider.setFocus(true);
                        },
                        child: TextField(
                          controller: provider.sourceController,
                          // focusNode: _sourceFocusNode, // We can use Focus widget instead or pass this node if needed
                          // If we use Focus widget, we don't strictly need to pass a FocusNode to TextField
                          // unless we want to control focus programmatically (which we might not need to).
                          // But wait, if I wrap TextField in Focus, the TextField has its own FocusNode.
                          // The Focus widget might not capture the TextField's focus unless I pass the node.

                          // Let's stick to the FocusNode approach but initialize the provider interaction
                          // inside the build method where we have access to 'provider'.
                          // Actually, the `Focus` widget is the best Flutter-way.
                          // It wraps the child and reports focus changes.
                          // But TextField manages its own focus.

                          // Let's use `Focus` widget with `child: TextField`.
                          // And we don't need to pass a FocusNode to TextField if we don't want to control it from outside.
                          // BUT, we might want to control it? No requirement to programmatically focus.

                          // Wait, `Focus` widget creates a FocusNode. TextField creates one if null.
                          // If I wrap TextField in Focus, I have two nodes.
                          // Correct way: Use `Focus` and pass `focusNode` to it, and ALSO pass that node to TextField?
                          // Or just use `FocusNode` and `addListener` inside `build`? No, adding listeners in build is bad.

                          // Simplest working solution:
                          // Use `Focus` widget. Pass a `FocusNode` to it. Pass SAME `FocusNode` to TextField.
                          // Handle `onFocusChange` in `Focus` widget.
                          focusNode: _sourceFocusNode,
                          onChanged: (value) => provider.searchPlaces(value),
                          decoration: InputDecoration(
                            hintText: "Your Location",
                            suffixIcon: Icon(
                              Icons.location_on,
                              color: AppColor.primary_500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_500,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_500,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: Constants.urbanistFont,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // To Field
                  Text(
                    "To",
                    style: TextStyle(
                      fontFamily: Constants.urbanistFont,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Focus(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) provider.setFocus(false);
                        },
                        child: TextField(
                          controller: provider.destinationController,
                          focusNode: _destinationFocusNode,
                          onChanged: (value) => provider.searchPlaces(value),
                          decoration: InputDecoration(
                            hintText: "Search Destination",
                            suffixIcon: Icon(
                              Icons.location_on,
                              color: AppColor.primary_500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_500,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.primary_500,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontFamily: Constants.urbanistFont,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Swap Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: provider.swapLocations,
                      icon: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.greyScale100,
                        ),
                        child: Icon(
                          Icons.swap_vert,
                          color: AppColor.primary_900,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // List View
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.predictions.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // Your Location Tile
                          return ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primary_500,
                              ),
                              child: Icon(
                                Icons.my_location,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              "Your Location",
                              style: TextStyle(
                                fontFamily: Constants.urbanistFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            onTap: () {
                              provider.selectYourLocation();
                            },
                          );
                        }

                        final prediction = provider.predictions[index - 1];
                        return ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primary_500,
                            ),
                            child: Icon(Icons.ev_station, color: Colors.white),
                          ),
                          title: Text(
                            prediction.primaryText,
                            style: TextStyle(
                              fontFamily: Constants.urbanistFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          subtitle: Text(
                            prediction.secondaryText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: Constants.urbanistFont,
                              color: AppColor.greyScale700,
                              fontSize: 14.sp,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                            color: AppColor.greyScale700,
                          ),
                          onTap: () => provider.selectPlace(prediction),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
