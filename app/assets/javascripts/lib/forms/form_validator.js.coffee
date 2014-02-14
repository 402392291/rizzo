define ["jquery", "lib/forms/form_input"], ($, FormInput) ->

  class FormValidator

    inputsSelector = "input, textarea, select"

    constructor: (target) ->
      @form = $(target)
      @_initialize() if @form.length is 1

    _initialize: ->
      @inputs = []
      @form.find(inputsSelector).not('[type="hidden"], [type="submit"]').each (index, elem) =>
        label = $(elem).closest('.js-field').find('.js-field-label').text()
        @inputs.push(new FormInput(elem, label))
      @_listen()

    _listen: ->
      $submit = @form.find('[type="submit"]')
      @form.on "submit", (e) =>

        if @isValid()
          $submit.removeAttr('disabled')
        else
          $submit.attr('disabled', 'disabled')
          e.preventDefault()

      for input in @inputs
        input.input.on "blur", (e) =>
          if @isValid(false, e.target)
            $submit.removeAttr('disabled')
          else
            $submit.attr('disabled', 'disabled')

      $submit.attr('disabled', 'disabled') unless @isValid(false)

    isValid: (triggerErrors, showErrorsFor) ->
      valid = true
      triggerErrors = (triggerErrors == undefined) || triggerErrors

      for input in @inputs
        triggerInputErrors = (showErrorsFor && showErrorsFor == input.input[0]) || triggerErrors
        valid = false unless input.isValid(triggerInputErrors)

      valid
