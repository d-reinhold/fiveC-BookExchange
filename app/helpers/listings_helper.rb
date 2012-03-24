module ListingsHelper
  
  def school_abbreviation(school_name)
    case school_name
    when 'Pomona College'
      return 'PO'
    when 'Claremont McKenna College'
      return 'CM'
    when 'Harvey Mudd College'
      return 'HM'
    when 'Scripps College'
      return 'SC'
    when 'Pitzer College'
      return 'PZ'
    else
      return 'CUC'
    end    
  end
  
end
