module WinnScriptatype
  # V1.7b
  # By; Greg Winn
  # This plugin is supported, all support is first come first serve
  # For Support/Help : http://rubyforge.org/projects/winnscriptatype/
  # Or for install help: http://rubyonrailsrailway.com/winnscriptatype
  # Just let me know what the problem is and what version your running.
  def countTheArray(thearray)
    thecount = 0
    for a in thearray
      thecount += 1
    end
    return count = thecount
  end
  
    # ===== TextLink
    def WinnScriptatype.define_link_effect(effect_type)
        class_eval %( def textlink_do_#{effect_type}(linktext, updateId, url = {}, urloptions = {})
                        textlink_do(linktext, updateId, '#{effect_type}', url, urloptions)
                      end )
    end
    
    # Effect support (textlink_do_'EFFECT')
    [:fade, :puff, :blindup, :dropout].each do |effect_type| 
      define_link_effect(effect_type)
    end
    # ===== TextLink
  
  def WinnScriptatype.define_specific_effect(effect_type)
      class_eval %( def checkbox_do_#{effect_type}(updateId, checkboxId, url = {}, urloptions = {})
                      checkbox_do('one', updateId, '', checkboxId, '#{effect_type}', url, urloptions)
                    end )
  end
  
  def WinnScriptatype.define_specific_effect_with_two(effect_type1,effect_type2)
      class_eval %( def checkbox_do_#{effect_type1}_and_#{effect_type2}(updateId, updateId2, checkboxId, url = {}, urloptions = {})
                      checkbox_do('two', updateId, updateId2, checkboxId, '#{effect_type1}=#{effect_type2}', url, urloptions)
                    end )
  end
  
    # Effect support (checkbox_do_'EFFECT')
    [:fade, :puff, :blindup, :dropout].each do |effect_type| 
      define_specific_effect(effect_type)
    end
    
    # Effect support with two effects (checkbox_do2_'EFFECT_and_EFFECT')
    [['fade','appear'],['fade','blindup'],['fade','blinddown'],
    ['fade','puff'],['puff','fade'],['puff','appear'],['puff','blindup'],
    ['puff','blinddown']].each do |effect_type1, effect_type2| 
      define_specific_effect_with_two(effect_type1,effect_type2)
    end
  
  # The main method checkbox_do
  def checkbox_do( effnum, updateId, updateId2, checkboxId, effect, url = {}, urloptions = {})
    
    mycount = 0
    pars = ''
    theRealnumer = countTheArray(urloptions)
    # Build the url options
    urloptions.each_pair do |key,value|
    mycount += 1
      if key != ''
        if mycount == theRealnumer
          pars += %{#{key}:'#{value}'}
        else
          pars += %{#{key}:'#{value}',}
        end
      end
     end
      
      url[:controller].nil? ? controller = '' : controller = '/' + url[:controller]
      url[:action].nil? ? action = 'index' : action = url[:action]
      url[:id].nil? ? id = '' : id = '/' + url[:id]
      controller == '' ? slash = '' : slash = '/'
      
      theRequestUrl = controller + slash + action + id
      
      if effnum == 'two'
        twoeffects = effect.split("=")
        theEffect1 = twoeffects[0].capitalize
        theEffect2 = twoeffects[1].capitalize
        
        # Effect list below, you may add others if you like
        theEffect1 == 'Blindup' ? theEffect1 = 'BlindUp' : theEffect1 = theEffect1
        theEffect1 == 'Dropout' ? theEffect1 = 'DropOut' : theEffect1 = theEffect1
        theEffect1 == 'Blinddown' ? theEffect1 = 'BlindDown' : theEffect1 = theEffect1
        
        theEffect2 == 'Blindup' ? theEffect2 = 'BlindUp' : theEffect2 = theEffect2
        theEffect2 == 'Dropout' ? theEffect2 = 'DropOut' : theEffect2 = theEffect2
        theEffect2 == 'Blinddown' ? theEffect2 = 'BlindDown' : theEffect2 = theEffect2
        # End Effect list
        
        theRequestCode = "new Ajax.Request('#{theRequestUrl}', {method: 'get', onSuccess: new Effect.#{theEffect1}('#{updateId}'), parameters: {#{pars}} });"
        buildeffect2 = " new Effect.#{theEffect2}('#{updateId2}');"
        # Return the checkbox to the view.
        return %{<input type="checkbox" id="#{checkboxId}" onclick="#{theRequestCode}#{buildeffect2}" />}
      else
        theEffect = effect.capitalize
        # Effect list below, you may add others if you like
        theEffect == 'Blindup' ? theEffect = 'BlindUp' : theEffect = theEffect
        theEffect == 'Dropout' ? theEffect = 'DropOut' : theEffect = theEffect
        
        # End Effect list
        
        theRequestCode = "new Ajax.Request('#{theRequestUrl}', {method: 'get', onSuccess: new Effect.#{theEffect}('#{updateId}'), parameters: {#{pars}} });"
        # Return the checkbox to the view.
        return %{<input type="checkbox" id="#{checkboxId}" onclick="#{theRequestCode}" />}
      end
    
  end
  
  # The second method textlink_do
  def textlink_do( linktext, updateId, effect, url = {}, urloptions = {})
    
    mycount = 0
    pars = ''
    theRealnumer = countTheArray(urloptions)
    # Build the url options
    urloptions.each_pair do |key,value|
    mycount += 1
      if key != ''
        if mycount == theRealnumer
          pars += %{#{key}:'#{value}'}
        else
          pars += %{#{key}:'#{value}',}
        end
      end
     end
      
      url[:controller].nil? ? controller = '' : controller = '/' + url[:controller]
      url[:action].nil? ? action = 'index' : action = url[:action]
      url[:id].nil? ? id = '' : id = '/' + url[:id]
      controller == '' ? slash = '' : slash = '/'
      
      theRequestUrl = controller + slash + action + id
      effnum = 'one'
      if effnum == 'two'
        #twoeffects = effect.split("=")
        #theEffect1 = twoeffects[0].capitalize
        #theEffect2 = twoeffects[1].capitalize
        
        # Effect list below, you may add others if you like
        #theEffect1 == 'Blindup' ? theEffect1 = 'BlindUp' : theEffect1 = theEffect1
        #theEffect1 == 'Dropout' ? theEffect1 = 'DropOut' : theEffect1 = theEffect1
        #theEffect1 == 'Blinddown' ? theEffect1 = 'BlindDown' : theEffect1 = theEffect1
        
        #theEffect2 == 'Blindup' ? theEffect2 = 'BlindUp' : theEffect2 = theEffect2
        #theEffect2 == 'Dropout' ? theEffect2 = 'DropOut' : theEffect2 = theEffect2
        #theEffect2 == 'Blinddown' ? theEffect2 = 'BlindDown' : theEffect2 = theEffect2
        # End Effect list
        
      else
        theEffect = effect.capitalize
        # Effect list below, you may add others if you like
        theEffect == 'Blindup' ? theEffect = 'BlindUp' : theEffect = theEffect
        theEffect == 'Dropout' ? theEffect = 'DropOut' : theEffect = theEffect
        
        # End Effect list
        
        theRequestCode = "new Ajax.Request('#{theRequestUrl}', {method: 'get', onSuccess: new Effect.#{theEffect}('#{updateId}'), parameters: {#{pars}} });"
        # Return the checkbox to the view.
        return %{<a href="javascript://" onclick="#{theRequestCode}">#{linktext}</a>}
      end
    
  end
end