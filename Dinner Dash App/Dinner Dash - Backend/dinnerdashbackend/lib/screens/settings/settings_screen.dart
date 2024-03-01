

import 'package:dinnerdashbackend/blocs/settings/settings_bloc.dart';
import 'package:dinnerdashbackend/config/responsive.dart';
import 'package:dinnerdashbackend/widgets/custom_appbar.dart';
import 'package:dinnerdashbackend/widgets/custom_drawer.dart';
import 'package:dinnerdashbackend/widgets/custom_layout.dart';
import 'package:dinnerdashbackend/widgets/custom_text_form_field.dart';
import 'package:dinnerdashbackend/widgets/opening_hours_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


/*class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: CustomLayout(
        title: 'Settings',
        widgets: [
         // _buildImage(),
          Responsive.isDesktop(context) || Responsive.isWideDesktop(context) ?      
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _buildBasicInformation(context),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: _buildRestaurantDescription(context),
                ),
              ],
            ),
          ) : 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBasicInformation(context),
                const SizedBox(height: 10,),
                _buildRestaurantDescription(context),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Opening Hours',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            _buildOpeningHours()
        ],
      ),
    );
  }

  BlocBuilder<SettingsBloc, SettingsState> _buildOpeningHours() {
    return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              if (state is SettingsLoading) {
            return Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            );
          }
          if (state is SettingsLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.restaurant.openingHours!.length,
                
                itemBuilder: (context, index){
                  var openingHours = state.restaurant.openingHours![index];
                  
                  return OpeningHoursSettings(
                    openingHours: openingHours,
                    onSliderChanged: (value){
                      context.read<SettingsBloc>().add(
                        UpdateOpeningHours(
                          openingHours: openingHours.copyWith(
                            openAt: value.start, 
                            closeAt: value.end,
                          ),
                        ),
                      );
                    },
                    onCheckboxChanged: (value){
                      context.read<SettingsBloc>().add(
                        UpdateOpeningHours(openingHours: openingHours.copyWith(isOpen: value),
                        ),
                      );
                    }
                  );
                });
            } else {
              return const Text('Error loading settings');
            }
          },
        );
  }

  Container _buildBasicInformation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).colorScheme.background,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            );
          }
          if (state is SettingsLoaded) {
            return Column(
              children: [
                Text(
                  'Basic Info',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Name',
                  hasTitle: true,
                  initialValue: state.restaurant.name ?? '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateSettings(
                        restaurant: state.restaurant.copyWith(name: value),
                      ),
                    );
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Image',
                  hasTitle: true,
                  initialValue: state.restaurant.imageUrl ?? '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateSettings(
                        restaurant: state.restaurant.copyWith(imageUrl: value),
                      ),
                    );
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Tags',
                  hasTitle: true,
                  initialValue: state.restaurant.tags?.join(',') ?? '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateSettings(
                        restaurant: state.restaurant.copyWith(tags: value.split(',')),
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return const Text('Error loading settings');
          }
        },
      ),
    );
  }

  Container _buildRestaurantDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).colorScheme.background,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary),
            );
          }
          if (state is SettingsLoaded) {
            return Column(
              children: [
                Text(
                  'Restaurant Description',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  maxLines: 5,//num input lines
                  title: 'Description',
                  hasTitle: false,
                  initialValue: (state.restaurant.description != null)
                      ? state.restaurant.description!
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateSettings(
                        restaurant: state.restaurant.copyWith(description: value),
                      ),
                    );
                  },
                ),
                
              ],
            );
          } else {
            return const Text('Error loading settings');
          }
        },
      ),
    );

  BlocBuilder<SettingsBloc, SettingsState> _buildImage() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const SizedBox();
        }
        if (state is SettingsLoaded) {
          return state.restaurant.imageUrl != null
              ? Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.restaurant.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox();
        } else {
          return const Text('Error loading settings');
        }
      },
    );
  }
}


}*/


import 'package:dinnerdashbackend/blocs/settings/settings_bloc.dart';
import 'package:dinnerdashbackend/config/responsive.dart';
import 'package:dinnerdashbackend/widgets/custom_appbar.dart';
import 'package:dinnerdashbackend/widgets/custom_drawer.dart';
import 'package:dinnerdashbackend/widgets/custom_layout.dart';
import 'package:dinnerdashbackend/widgets/custom_text_form_field.dart';
import 'package:dinnerdashbackend/widgets/opening_hours_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: CustomLayout(
        title: 'Settings',
        widgets: [
          _buildImage(context),
          Responsive.isDesktop(context) || Responsive.isWideDesktop(context)
              ? IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildBasicInformation(context),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: _buildRestaurantDescription(context),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBasicInformation(context),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildRestaurantDescription(context),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Opening Hours',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          _buildOpeningHours(context),
        ],
      ),
    );
  }

  BlocBuilder<SettingsBloc, SettingsState> _buildOpeningHours(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return Center(
            child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
          );
        }
        if (state is SettingsLoaded) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.restaurant.openingHours!.length,
              itemBuilder: (context, index) {
                var openingHours = state.restaurant.openingHours![index];
                return OpeningHoursSettings(
                  openingHours: openingHours,
                  onSliderChanged: (start, end) {
                    // Handle slider change
                  },
                  onCheckboxChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateOpeningHours(openingHours: openingHours.copyWith(isOpen: value)),
                    );
                  },
                );
              });
        } else {
          return const Text('Error loading settings');
        }
      },
    );
  }

  BlocBuilder<SettingsBloc, SettingsState> _buildImage(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const SizedBox();
        }
        if (state is SettingsLoaded) {
          return state.restaurant.imageUrl != null
              ? Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.restaurant.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox();
        } else {
          return const Text('Error loading settings');
        }
      },
    );
  }

  Container _buildBasicInformation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).colorScheme.background,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(
              child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
            );
          }
          if (state is SettingsLoaded) {
            return Column(
              children: [
                Text(
                  'Basic Info',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Name',
                  hasTitle: true,
                  initialValue: state.restaurant.name ?? '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateSettings(
                        restaurant: state.restaurant.copyWith(name: value),
                      ),
                    );
                  },
                ),
               CustomTextFormField(
                  maxLines: 1,
                  title: 'Image',
                  hasTitle: true,
                  initialValue: state.restaurant.imageUrl ?? '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateSettings(
                        restaurant: state.restaurant.copyWith(imageUrl: value),
                      ),
                    );
                  },
                ),
                CustomTextFormField(
                  maxLines: 1,
                  title: 'Tags',
                  hasTitle: true,
                  initialValue: state.restaurant.tags?.join(',') ?? '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateSettings(
                        restaurant: state.restaurant.copyWith(tags: value.split(',')),
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return const Text('Error loading settings');
          }
        },
      ),
    );
  }

  Container _buildRestaurantDescription(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Theme.of(context).colorScheme.background,
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary),
            );
          }
          if (state is SettingsLoaded) {
            return Column(
              children: [
                Text(
                  'Restaurant Description',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  maxLines: 5,//num input lines
                  title: 'Description',
                  hasTitle: false,
                  initialValue: (state.restaurant.description != null)
                      ? state.restaurant.description!
                      : '',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateSettings(
                        restaurant: state.restaurant.copyWith(description: value),
                      ),
                    );
                  },
                ),
                
              ],
            );
          } else {
            return const Text('Error loading settings');
          }
        },
      ),
    );

  BlocBuilder<SettingsBloc, SettingsState> _buildImage() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const SizedBox();
        }
        if (state is SettingsLoaded) {
          return state.restaurant.imageUrl != null
              ? Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.restaurant.imageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const SizedBox();
        } else {
          return const Text('Error loading settings');
        }
      },
    );
  }
}


}
