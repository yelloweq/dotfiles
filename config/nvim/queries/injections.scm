((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language php))

; tree-sitter-comment injection
; if available
((comment) @injection.content
 (#set! injection.language "comment"))

; could be bash or zsh
; or whatever tree-sitter grammar you have.
((text) @injection.content
    (#has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language bash))


((php_only) @injection.content
    (#set! injection.language php_only))

((parameter) @injection.content
    (#set! injection.language "php-only")) 

;; extends

; AlpineJS attributes
(attribute
  (attribute_name) @_attr
    (#lua-match? @_attr "^x%-%l")
  (quoted_attribute_value
    (attribute_value) @injection.content)
  (#set! injection.language "javascript"))

; Blade escaped JS attributes
; <x-foo ::bar="baz" />
(element
  (_
    (tag_name) @_tag
      (#lua-match? @_tag "^x%-%l")
  (attribute
    (attribute_name) @_attr
      (#lua-match? @_attr "^::%l")
    (quoted_attribute_value
      (attribute_value) @injection.content)
    (#set! injection.language "javascript"))))

; Blade PHP attributes
; <x-foo :bar="$baz" />
(element
  (_
    (tag_name) @_tag
      (#lua-match? @_tag "^x%-%l")
    (attribute
      (attribute_name) @_attr
        (#lua-match? @_attr "^:%l")
      (quoted_attribute_value
        (attribute_value) @injection.content)
      (#set! injection.language "php_only"))))
