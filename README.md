# [No overview available.][no overview available]

A survey of Apple developer documentation.

---

It's become a truism among iOS and macOS developers that
Apple's documentation is often incomplete or missing altogether.

But to what extent is this actually the case?

This project aims to provide some objective metrics for
evaluating the quality and quantity of the docs on
[developer.apple.com/documentation][apple developer documentation].

## Methodology

This project uses a scraper to crawl and download
API symbol documentation from Apple's official documentation website.

An API symbol is any page navigable from and within
https://developer.apple.com/documentation
that has a declaration
(i.e. articles and sample code aren't counted).
An API symbol is undocumented if an HTML element matches the selector `.nodocumentation`.

The proportion of documented to undocumented symbols is then tabulated
for each framework published by Apple.

### Limitations

- This project only denotes API symbols as being undocumented
  according to Apple's own self-reported information.
  An API symbol may not be counted as undocumented
  under the following circumstances:
  1. The symbol is omitted from the website
  2. The symbol isn't linked from a framework
  3. The symbol has no information but isn't marked as being undocumented
- This project doesn't make any claims about
  the quality or usefulness of documentation;
  instead, it seeks to establish a baseline for coverage,
  which is a precondition for comprehensive reference documentation.

### Known Issues

- The scraper doesn't currently handle all frameworks or API symbols correctly.
  For example,
  property list keys, entitlements, and REST endpoints aren't supported.
- API symbols may provide different content for Swift and Objective-C;
  the scraper doesn't currently handle this in a consistent way.
- Deprecated API symbols aren't treated differently from nondeprecated symbols.

### Next Steps

- Establish infrastructure for automatically updating coverage statistics.
- Publish a cache of reference documentation.
- Evaluate documentation quality using metrics like
  number of words, sentences, code figures, images, and readability.

## License

MIT

## Contact

Mattt ([@mattt](https://twitter.com/mattt))

[no overview available]: https://nooverviewavailable.com
[apple developer documentation]: https://developer.apple.com/documentation
