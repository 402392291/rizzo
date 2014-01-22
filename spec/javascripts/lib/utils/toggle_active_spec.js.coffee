require ['public/assets/javascripts/lib/utils/toggle_active.js'], (ToggleActive) ->

  describe 'ToggleActive', ->

    describe 'Object', ->
      it 'is defined', ->
        expect(ToggleActive).toBeDefined()

    describe 'Initialisation', ->
      beforeEach ->
        loadFixtures('toggle_active.html')
        window.toggleActive = new ToggleActive()

      it 'Initially adds the is-not-active class', ->
        expect($('.foo')[0]).toHaveClass('is-not-active')

      it 'Toggles the is-active and is-not-active classes.', ->
        $('#normal').trigger('click')
        expect($('.foo')[0]).toHaveClass('is-active')
        expect($('.foo')[0]).not.toHaveClass('is-not-active')
        $('#normal').trigger('click')
        expect($('.foo')[0]).not.toHaveClass('is-active')
        expect($('.foo')[0]).toHaveClass('is-not-active')

      it 'Toggles a custom class.', ->
        $('#custom-class').trigger('click')
        expect($('.foo')[0]).toHaveClass('custom-class')
        $('#custom-class').trigger('click')
        expect($('.foo')[0]).not.toHaveClass('custom-class')

      it 'Toggles the is-active classes on both the clicked element and the target.', ->
        $('#both').trigger('click')
        expect($('#both')).toHaveClass('is-active')
        expect($('#both')).not.toHaveClass('is-not-active')
        $('#both').trigger('click')
        expect($('#both')).not.toHaveClass('is-active')
        expect($('#both')).toHaveClass('is-not-active')


    describe 'works with events', ->
      beforeEach ->
        loadFixtures('toggle_active.html')
        window.toggleActive = new ToggleActive()
        spyEvent = spyOnEvent($('#evented'), ':toggleActive/click')

      it 'on click it triggers :toggleActive/click', ->
        $('#evented').trigger('click')
        expect(':toggleActive/click').toHaveBeenTriggeredOn($('#evented'))

      it 'on update', ->
        target = document.querySelector('#evented')
        beforeState = $('#evented').hasClass('is-active')
        $('#js-card-holder').trigger(':toggleActive/update', target)
        expect($('#evented').hasClass('is-active')).not.toEqual(beforeState)