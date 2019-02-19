# Listing 8.5  A basic DSL for CSS

css = (raw) ->
  hyphenate = (property) ->
    dashThenUpperAsLower = (match, pre, upper) ->
      "#{pre}-#{upper.toLowerCase()}"
    property.replace /([a-z])([A-Z])/g, dashThenUpperAsLower

  output = (for selector, rules of raw           #B
    rules = (for ruleName, ruleValue of rules
      "#{hyphenate ruleName}: #{ruleValue};"
    ).join '\n'
    """
    #{selector} {
      #{rules}
    }
    """
  ).join '\n'
