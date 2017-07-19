/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import accessibleAutocomplete from 'accessible-autocomplete'
import 'accessible-autocomplete/dist/accessible-autocomplete.min.css'

const $listOfRegistersEl = document.querySelector('#list-of-registers')

if ($listOfRegistersEl) {
  accessibleAutocomplete.enhanceSelectElement({
    autoselect: false,
    selectElement: $listOfRegistersEl,
    showAllValues: true
  })
}
