module ApplicationHelper

  def bootstrap_flash_class(flash_type)
      { success: 'alert-success',
        error:   'alert-danger',
        alert:   'alert-warning',
        notice:  'alert-info'
      }[flash_type.to_sym] || flash_type.to_s
  end

  def to_words(number)
    number_in_words = I18n.with_locale(:en) { number.to_words }
    number_in_words = number_in_words.slice(0,1).capitalize + number_in_words.slice(1..-1)
    return number_in_words
  end

end
