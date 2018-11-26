import 'package:github_trending/core/core.dart';
import 'package:flutter/material.dart';
import 'package:github_trending/message_provider.dart';

class DescriptionWidget extends StatefulWidget {
  DescriptionWidget(this.trending);
  final Trending trending;

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool _isExpandable;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpandable = widget.trending.description.length > 120;
  }

  void _toggleExpandedState() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = AnimatedCrossFade(
      firstChild: Text(widget.trending.description.substring(0, widget.trending.description.length > 120 ? 120 : widget.trending.description.length)),
      secondChild: Text(widget.trending.description),
      crossFadeState:
      _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: kThemeAnimationDuration,
    );

    return InkWell(
      onTap: _isExpandable ? _toggleExpandedState : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(_isExpandable, _isExpanded),
            const SizedBox(height: 8.0),
            content,
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  _Title(this.expandable, this.expanded);
  final bool expandable;
  final bool expanded;

  Widget _buildExpandCollapsePrompt(Messages messages) {
    const captionStyle = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    );

    return Text(
      expanded ? messages.collapseDescription : messages.expandDescription,
      style: captionStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = MessageProvider.of(context);
    final content = <Widget>[
      Text(
        messages.description,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ];

    if (expandable) {
      content.add(Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: _buildExpandCollapsePrompt(messages),
      ));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: content,
    );
  }
}
