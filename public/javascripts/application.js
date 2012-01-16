// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function countChars(field, counter, limit) {
  if (field.value.length > limit)
    field.value = field.value.substring(0, limit);
  else
    counter.innerText = (limit - field.value.length).toString();
  return counter.innerText;
}
