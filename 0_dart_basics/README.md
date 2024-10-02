Step 0: Become familiar with Dart basics
========================================

**Estimated time**: 1 day

Read and firmly study the [Dart Overview], provided by the [Dart] team. Learn about the language basics (syntax, types, functions, classes, asynchronous programming).

Be sure to check out the [Effective Dart] guidelines for writing consistent [Dart] code.

Investigate the [Core Libraries] available in [Dart], and learn how to enable [Dart Packages] and dependencies to use in your [Dart] project. You may explore the [pub.dev] for community made packages.

To practice the theory you may pass the [Dart Cheatsheet].




## Questions

After completing the steps above, you should be able to answer (and understand why) the following questions:
- What runtime [Dart] has? Does it use a GC (garbage collector)?
- What is [Dart] VM? How [Dart] works natively and in a browser, and why?
- What is JIT and AOT compilation? Which one [Dart] supports?
- What statically typing means? What is a benefit of using it?
- What memory model [Dart] has? Is it single-threaded or multiple-threaded?
- Does [Dart] has asynchronous programming? Parallel programming?
- Is [Dart] OOP language? Does it have an inheritance?

Once you're done, notify your mentor/lead in the appropriate [PR (pull request)][PR] (checkmark this step in [README](../README.md)), and he will examine what you have learned.




[Core Libraries]: https://dart.dev/guides/libraries
[Dart]: https://dart.dev
[Dart Cheatsheet]: https://dart.dev/codelabs/dart-cheatsheet
[Dart Overview]: https://dart.dev/overview
[Dart Packages]: https://dart.dev/guides/packages
[Effective Dart]: https://dart.dev/guides/language/effective-dart
[PR]: https://help.github.com/articles/github-glossary#pull-request
[pub.dev]: https://pub.dev


Here is the markdown file with the questions and answers:

Step 0: Become familiar with Dart basics
========================================

**Estimated time**: 1 day

Read and firmly study the [Dart Overview], provided by the [Dart] team. Learn about the language basics (syntax, types, functions, classes, asynchronous programming).

Be sure to check out the [Effective Dart] guidelines for writing consistent [Dart] code.

Investigate the [Core Libraries] available in [Dart], and learn how to enable [Dart Packages] and dependencies to use in your [Dart] project. You may explore the [pub.dev] for community made packages.

To practice the theory you may pass the [Dart Cheatsheet].

## Questions

### Q1: What runtime does Dart have? Does it use a GC (garbage collector) ?
**Answer:** Dart has a runtime called v8. Yes, it uses a GC (garbage collector).

### Q2: What is Dart VM? How does Dart work natively and in a browser, and why?
**Answer:** Dart VM (Virtual Machine) is a runtime environment for Dart language. Dart can work natively because it is compiled to machine code, and in a browser because it can be transpiled to JavaScript. 

### Q3: What is JIT and AOT compilation? Which one does Dart support?
**Answer:** JIT (Just-In-Time compilation) and AOT (Ahead-Of-Time compilation) are two types of compilation. Dart supports AOT compilation.

### Q4: What does statically typing mean? What is a benefit of using it?
**Answer:** Statically typing means that the type of a variable is known at compile time. The benefit is better error detection and prevention.

### Q5: What memory model does Dart have? Is it single-threaded or multiple-threaded?
**Answer:** Dart has a concurrent garbage collector, which means it can handle multiple threads. The language is designed to be single-threaded by default, but it can be extended to support multi-threading.

### Q6: Does Dart have asynchronous programming? Parallel programming?
**Answer:** Yes, Dart has built-in support for asynchronous programming using futures and streams. It also supports parallel programming using isolates and the async/await syntax.

### Q7: Is Dart an OOP language? Does it have inheritance?
**Answer:** Yes, Dart is an OOP language. It supports inheritance, abstract classes, and interfaces.

Once you're done, notify your mentor/lead in the appropriate [PR (pull request)][PR] (checkmark this step in [README](../README.md)), and he will examine what you have learned.

[Core Libraries]: https://dart.dev/guides/libraries
[Dart]: https://dart.dev
[Dart Cheatsheet]: https://dart.dev/codelabs/dart-cheatsheet
[Dart Overview]: https://dart.dev/overview
[Dart Packages]: https://dart.dev/guides/packages
[Effective Dart]: https://dart.dev/guides/language/effective-dart
[PR]: https://help.github.com/articles/github-glossary#pull-request
[pub.dev]: https://pub.dev