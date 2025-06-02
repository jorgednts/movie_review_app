import 'package:flutter/material.dart';

class DefaultSearchBarWithAnchor extends StatelessWidget {
  final SearchController searchController;
  final void Function(SearchController) onTap;
  final void Function(String, SearchController) onChanged;
  final IconData searchIcon;
  final void Function() onSearch;
  final List<String> suggestions;
  final void Function(String) onSuggestionSelected;
  final IconData suggestionTrailingIcon;

  const DefaultSearchBarWithAnchor({
    super.key,
    required this.searchController,
    required this.onTap,
    required this.onChanged,
    this.searchIcon = Icons.search,
    required this.onSearch,
    required this.suggestions,
    required this.onSuggestionSelected,
    this.suggestionTrailingIcon = Icons.north_west,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: searchController,
      isFullScreen: false,
      shrinkWrap: true,
      viewElevation: 0,
      builder:
          (context, controller) => SearchBar(
            controller: searchController,
            onTap: () => onTap(controller),
            onChanged: (value) => onChanged(value, controller),
            elevation: WidgetStatePropertyAll<double>(0),
            trailing: [IconButton(onPressed: onSearch, icon: Icon(searchIcon))],
          ),
      textInputAction: TextInputAction.search,
      viewTrailing: [
        IconButton(onPressed: searchController.clear, icon: Icon(Icons.clear)),
        IconButton(
          onPressed: () {
            searchController.closeView(searchController.text);
            onSearch();
          },
          icon: Icon(searchIcon),
        ),
      ],
      suggestionsBuilder:
          (context, controller) =>
              suggestions
                  .map(
                    (suggestion) => ListTile(
                      onTap: () => onSuggestionSelected(suggestion),
                      title: Text(
                        suggestion,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium
                      ),
                      trailing: Icon(suggestionTrailingIcon),
                    ),
                  )
                  .toList(),
    );
  }
}
