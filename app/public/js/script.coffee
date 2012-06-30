$ ->
  $('#browserid').click (e) ->
    e.preventDefault()
    navigator.id.get(gotAssertion);
    @

gotAssertion = (assertion) ->
  console.log assertion
