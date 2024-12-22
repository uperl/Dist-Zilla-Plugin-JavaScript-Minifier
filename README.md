# Dist::Zilla::Plugin::JavaScript::Minifier ![linux](https://github.com/uperl/Dist-Zilla-Plugin-JavaScript-Minifier/workflows/linux/badge.svg) ![macos](https://github.com/uperl/Dist-Zilla-Plugin-JavaScript-Minifier/workflows/macos/badge.svg) ![windows](https://github.com/uperl/Dist-Zilla-Plugin-JavaScript-Minifier/workflows/windows/badge.svg) ![msys2-mingw](https://github.com/uperl/Dist-Zilla-Plugin-JavaScript-Minifier/workflows/msys2-mingw/badge.svg)

Minify JavaScript in your dist.

# SYNOPSIS

```
[JavaScript::Minifier]
```

# DESCRIPTION

Compress JavaScript files in your distribution using [JavaScript::Minifier::XS](https://metacpan.org/pod/JavaScript::Minifier::XS).  By default for
each `foo.js` file in your distribution this plugin will create a `foo.min.js`
which has been compressed.

# ATTRIBUTES

## finder

Specifies a [FileFinder](https://metacpan.org/pod/Dist::Zilla::Role::FileFinder) for the JavaScript files that
you want compressed.  If this is not specified, it will compress all the JavaScript
files that do not have a `.min.` in their filenames.  Roughly equivalent to
this:

```
[FileFinder::ByName / JavaScriptFiles]
file = *.js
skip = .min.
[JavaScript::Minifier]
finder = JavaScriptFiles
```

## output\_regex

Regular expression substitution used to generate the output filenames.  By default
this is

```
[JavaScript::Minifier]
output_regex = /\.js$/.min.js/
```

which generates a `foo.min.js` for each `foo.js`.

## output

Output filename.  Not used by default, but if specified, all JavaScript files are merged and
compressed into a single file using this as the output filename.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2012-2024 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
