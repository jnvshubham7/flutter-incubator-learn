Step 3: Dart ecosystem
======================

**Estimated time**: 1 day

These steps describe the common [Dart] tooling, packages and ecosystem approaches, proven to be especially useful and commonly used when building modern modular [Dart] applications.




## Project structure

> The Dart ecosystem uses _packages_ to manage shared software such as libraries and tools. To get Dart packages, you use the **pub package manager**. You can find publicly available packages on the [pub.dev site][pub.dev], or you can load packages from the local file system or elsewhere, such as Git repositories. Wherever your packages come from, pub manages version dependencies, helping you get package versions that work with each other and with your SDK version.
> 
> Most [Dart-savvy IDEs][11] offer support for using pub that includes creating, downloading, updating, and publishing packages. Or you can use [`dart pub` on the command line][12].

[Dart] project represents a [Dart] package when it has a [`pubspec.yaml`] manifest file.
```yaml
name: task
description: A sample command-line application.
version: 1.0.0
# repository: https://github.com/my_org/my_repo

environment:
  sdk: ^3.0.2

# Add regular dependencies here.
dependencies:
  # path: ^1.8.0

# Add development dependencies here.
dev_dependencies:
  lints: ^2.0.0
  test: ^1.21.0
```

> To import libraries found in packages, use the `package:` prefix:
> ```dart
> import 'package:js/js.dart' as js;
> import 'package:intl/intl.dart';
> ```

The initial files layout of a [Dart] project looks like this:
```
lib/
├── ...
└── main.dart
pubspec.yaml
```
However, real-world [Dart] projects, depending on their needs, may also include a `test/` directory for [unit testing][13], an `example/` directory providing usage examples (if it's a library), and [other similar ones][16].

To learn more about packages, dependencies and project structure in [Dart], read through the following articles:
- [Dart Guides: How to use packages][14]
- [Dart Guides: Creating packages][15]
- [Dart Docs: Package layout conventions][16]
- [Dart Docs: Package dependencies][17]




## Tooling

When it comes to sharing [Dart] code with anyone, it's necessary to follow some core guidelines in order for the source code to be readable and consistent in its style. Such core guidelines in [Dart] are called [Effective Dart].

[Dart] provides several [CLI tools][20] for maintaining project source code and helping following project guidelines.


### Formatter

[`dart format`] tool formats source code according to [Effective Dart] style.

However, this tool is not as smart as it could be. In order for it to format the code in a more readable and beautiful way, [`dart format`] relies [on commas][21].

For better understanding of [`dart format`] purpose, capabilities and usage, read through the following articles:
- [Dart Tools: `dart format`][`dart format`]
- [Dart Tools: Code formatting][21]
- [Official `dart_style` package docs][`dart_style`]
- [Official `dart_style` package FAQ][22]


### Analyzer

[`dart analyze`] tool uses the [`analyzer`] package to perform the basic source code [static analysis][32] and to [lint][33] it against [Effective Dart] guidelines or any other custom code style rules.

For better understanding of [`dart analyze`] purpose, capabilities and usage, read through the following articles:
- [Dart Tools: `dart analyze`][`dart analyze`]
- [Dart Guides: Customizing static analysis][31]
- [Official `analyzer` package docs][`analyzer`]


### Documentation

[`dart doc`] tool uses the [`dartdoc`] package to generates an [HTML] documentation right from the project source code.

For better understanding of [`dart doc`] purpose, capabilities and usage, read through the following articles:
- [Dart Tools: `dart doc`][`dart doc`]
- [Dart Docs: Documentation comments][41]
- [Effective Dart: Documentation][42]
- [Official `dartdoc` package docs][`dartdoc`]




## Task

Create a [Dart] package (`dart create -t package task`) implementing a simple `Calculator` class having `sum`, `subtract`, `multiply` and `divide` methods.
- Use [`dart format`] to format the code.
- Configure the [`analyzer`] package and use [`dart analyze`].
- Generate its [API] documentation using [`dart doc`].




## Questions

After completing everything above, you should be able to answer (and understand why) the following questions:
- What is pub? What it does? Why do we need it?
- What is pub spec? Which purpose does it serve?
- What is the purpose of `pubspec.lock` file? When and why it should be stored in [VCS], and when not? 
- What does "version range" mean? How is it useful for dependencies?
- Where is pub able to get dependencies from?
- What is the difference between development dependencies and regular one? Which ones should be used and when?
- How [Dart] projects are structured in files? Which are common conventions and what for?
- What do we need [Effective Dart] for? Why is it vital?
- What is `dart format` used for? What are the benefits of using it?
- How commas are used to guide code formatting in [Dart]?
- What is static analysis? What is linting? How they are represented in [Dart]? Why should we use them?
- Why source code documentation matters? How is it represented in [Dart]?
- Which are good practices for documenting code and [API]s in [Dart]? 
- How can one publish and serve [API] documentation in [Dart]? 




[`analyzer`]: https://pub.dev/packages/analyzer
[`crypto`]: https://pub.dev/packages/crypto
[`dart analyze`]: https://dart.dev/tools/dart-analyze
[`dart doc`]: https://dart.dev/tools/dart-doc
[`dart format`]: https://dart.dev/tools/dart-format
[`dart_style`]: https://pub.dev/documentation/dart_style
[`dartdoc`]: https://pub.dev/documentation/dartdoc
[`pubspec.yaml`]: https://dart.dev/tools/pub/pubspec
[API]: https://en.wikipedia.org/wiki/API
[Dart]: https://dart.dev
[Effective Dart]: https://dart.dev/guides/language/effective-dart
[Flutter]: https://flutter.dev
[HTML]: https://en.wikipedia.org/wiki/HTML
[pub.dev]: https://pub.dev
[VCS]: https://en.wikipedia.org/wiki/Version_control

[11]: https://dart.dev/tools#ides-and-editors
[12]: https://dart.dev/tools/pub/cmd
[13]: https://en.wikipedia.org/wiki/Unit_testing
[14]: https://dart.dev/guides/packages
[15]: https://dart.dev/guides/libraries/create-library-packages
[16]: https://dart.dev/tools/pub/package-layout
[17]: https://dart.dev/tools/pub/dependencies
[20]: https://dart.dev/tools/dart-tool
[21]: https://docs.flutter.dev/tools/formatting#using-trailing-commas
[22]: https://github.com/dart-lang/dart_style/wiki/FAQ
[31]: https://dart.dev/guides/language/analysis-options
[32]: https://en.wikipedia.org/wiki/Static_program_analysis
[33]: https://en.wikipedia.org/wiki/Lint_(software)
[41]: https://dart.dev/language/comments#documentation-comments
[42]: https://dart.dev/effective-dart/documentation


Here are the questions and answers in Markdown format:

**Q: What is pub? What it does? Why do we need it?**
A:

---

The Dart ecosystem uses _packages_ to manage shared software such as libraries and tools. To get Dart packages, you use the **pub package manager**. You can find publicly available packages on the [pub.dev site][pub.dev], or you can load packages from the local file system or elsewhere, such as Git repositories.

---

**Q: What is pub spec? Which purpose does it serve?**
A:

---

[pubspec.yaml] manifesto file. It serves as a configuration file for pub.

---

**Q: What is the purpose of `pubspec.lock` file? When and why it should be stored in [VCS], and when not?**
A:

---

`pubspec.lock` is a file that pub generates to record the exact versions of packages that your project requires. This file is important for ensuring that the project builds consistently across different machines and environments. It should be stored in version control (`VCS`) to ensure that everyone working on the project knows which packages were installed at a particular point in time.

---

**Q: What does "version range" mean? How is it useful for dependencies?**
A:

---

A version range is a specification for the range of versions that a package can be, usually in the form of a minimum and a maximum version. This is useful for dependencies because it allows you to specify which versions of a package are compatible with your project.

---

**Q: Where is pub able to get dependencies from?**
A:

---

Pub can get dependencies from publicly available packages on [pub.dev], from the local file system, from Git repositories, or from anywhere else.

---

**Q: What is the difference between development dependencies and regular one? Which ones should be used and when?**
A:

---

Development dependencies are packages that you need only during the development process, such as testing or debugging tools. Regular dependencies are packages that you need for the application to run. Development dependencies should be used sparingly and only when necessary, while regular dependencies should be used to provide core functionality for your application.

---

**Q: How [Dart] projects are structured in files? Which are common conventions and what for?**
A:

---

The initial files layout of a Dart project looks like this:
```
lib/
    ...
    main.dart
pubspec.yaml
```
However, real-world Dart projects, depending on their needs, may also include a `test/` directory for unit testing, an `example/` directory providing usage examples (if it's a library), and other similar ones.

---

**Q: What do we need [Effective Dart] for? Why is it vital?**
A:

---

[Eeffective Dart] provides guidelines for writing clean, consistent, and readable code.

---

**Q: What is `dart format` used for? What are the benefits of using it?**
A:

---

`dart format` is a tool that formats source code according to Effective Dart style.

---

**Q: How commas are used to guide code formatting in [Dart]?**
A:

---

In Dart, commas are used to separate items in a list or tuple.

---

**Q: What is static analysis? What is linting? How they are represented in [Dart]? Why should we use them?**
A:

---

Static analysis is the process of analyzing source code without actually running it. Linting is a type of static analysis that checks code for syntax and style errors. In Dart, static analysis is commonly done using the `dart analyze` tool, while linting is done using the `dart analyze` tool with specific configuration.

---

**Q: Why source code documentation matters? How is it represented in [Dart]?**
A:

---

Source code documentation matters because it helps other developers understand how to use your code and how it works. In Dart, source code documentation is represented using certain conventions, such as documentation comments, which are specified in the `dartdoc` package.

---

**Q: Which are good practices for documenting code and [API]s in [Dart]?**
A:

---

Good practices for documenting code and APIs in Dart include using clear and concise language, providing examples and code snippets, and following conventions for documentation comments.

---

**Q: How can one publish and serve [API] documentation in [Dart]?**
A:

---

API documentation can be published and served using the `dartdoc` package and a web server such as `multer`.