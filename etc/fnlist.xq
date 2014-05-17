(:~
 : Returns CSON list of
 : convenient XQuery snippets.
 :)

declare option db:parser "html";
declare option output:item-separator "";

(:~
 : Generates a CSON Template $label
 : with $abbr and $expansion as children
 :
 :  @param  $label       how to label the entry
 :  @param  $abbr        abbreviation for tab expansion
 :  @return $expansion   what to do on expansion
 :)
declare function local:cson-template(
  $label as xs:string,
  $abbr as xs:string,
  $expansion as xs:string*
) as xs:string {
  string-join(
    ("'", $label, "':", out:nl(),
    out:tab(), "'prefix': '", $abbr, "'", out:nl(),
    out:tab(), "'body': '", string-join($expansion), "'", out:nl())
  )
};


(:
 : Generate convenient XQuery abbreviations in CSON format
 : based on http://docs.basex.org/wiki/Shortcuts
 :)
let $tables := (
  doc('http://docs.basex.org/wiki/Shortcuts')
  //*[@id = 'Code_Completions']
  /ancestor-or-self::div[1]//*:table
)[position() < 3]
(: function adding '${i}' for each underscore in given expression :)
let $underscore := function ($k as xs:string*) as xs:string {
  string-join(
    let $tok := tokenize(string-join($k, '\\n'),'_')
    for $x at $p in $tok
    return (('${'|| ($p -1) || '}')[$p > 1], $x)
  )
}
for $row in $tables//(*:tr[position() > 1])
return
  $row/td[1]//text()/normalize-space()[.]
  ! local:cson-template(
    ., ., $underscore($row/td[2]//text()/normalize-space()[.])
  )
,


(:
 : Generate list of XQuery Functions in CSON format
 : http://www.w3.org/TR/xpath-functions-30/
 :)
for $fn in
  doc('http://www.w3.org/TR/xpath-functions-30/')
  //*:dt[@class='label' and starts-with(.,'Signature')]
  /following-sibling::dd
let $sigs := $fn//*:div[@class='proto'],
    (: function name always is the same for all children in $sigs :)
    $ns-name := $sigs[1]//*:code[@class = 'function'],
    $name := fn:substring-after($ns-name, ':'),
    (: return type always is the same for all children in $sigs :)
    $return-type := $sigs[1]//*:code[@class = 'return-type'][1]

(: only take last function declaration :)
for $sig in $sigs[fn:last()]
(: arguments and their types :)
let $args := $sig//*:code[@class = 'arg'],
    $types := $sig//*:code[@class = 'type']
return local:cson-template(
  (: label is namespaced name with arity :)
  string-join(($ns-name, '#', string(count($args)))),
  (: abbreviation is name only :)
  $name,
  (:
   : the expansion
   : ns:function($args with $types) $return-type
   :)
  $ns-name || '(' || replace(string-join(
    for $arg at $p in $args
    return ('${', string($p),  ':',
      replace($arg/data(),'\$','\\\$'),
      ' as ', $types[$p]/string(), '}', ', '[$p != count($args)])
  ), out:nl(), ' ') || ')${' || string(count($args) + 1)
  || ': as ' || $return-type/string() || '}'
)
