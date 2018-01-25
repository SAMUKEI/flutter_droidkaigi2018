class Link {
  final String linkType;
  final String title;
  final String url;

  static Link parse(dynamic json) {
    return new Link(
        linkType: json['linkType'],
        title: json['title'],
        url: json['url']
    );
  }

  Link({
    this.linkType,
    this.title,
    this.url
  });
}
