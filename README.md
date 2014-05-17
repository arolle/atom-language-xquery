# Atom XQuery Language

This package offers
 * XQuery Syntax highlighting
 * Snippets abbreviations
    * [XQuery Update](http://www.w3.org/TR/xquery-update-10/): `delete`, `insert`, `replace`, `rename`, `copy`
    * All [XPath 3.0 Functions](http://www.w3.org/TR/xpath-functions-30/):
      full signature,  e.g. `minutes-from-duration` completes to `fn:minutes-from-duration($arg as xs:duration?) as xs:integer?`
    * XPath axis step: `..`, `//`, `.`, `/`, `@`, `an`, `as`, `ch`, `de`, `ds`
    * XML entities:`tab`,`nl`, `cr`
    * Prologs: `declnl` (item-separator declaration), `variable`, `module`, `import`, `version`
    * FLOWR Expression: `order`, `group`, `let`, `for`,
    * [Quantified Expressions](http://www.w3.org/TR/xquery/#id-quantified-expressions): `some`, `every`
    * Further: `try`, `switch`, `typeswitch`, `ct` (contains text), `fn`, `function`, `(:` (XQuery doc), `(#` (pragma)

The snippets’ file (`snippets/xquery.cson`) is generated with the XQuery script `etc/fnlist.xq` using [BaseX](http://basex.org/) and improved manually.


## Credits

Highlighting is based on the
[XQuery TextMate Bundle](https://github.com/paxtonhare/xQuery.tmbundle).
Snippets are inspired by
[XQuery Code Completion in BaseX ](http://docs.basex.org/wiki/Shortcuts#Code_Completions)

---

Get the most out of those snippets with the autocomplete+ packages by [saschagehlich](https://atom.io/users/saschagehlich), namely
[autocomplete+](https://atom.io/packages/autocomplete-plus)
and
[autocomplete+ snippets](https://atom.io/packages/autocomplete-snippets)
