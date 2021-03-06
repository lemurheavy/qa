module CountsHelper
  def views_formatted(count)
    case count
    when 0..999
      count.to_s
    when 1000..1749
      "1k"
    when 1750..9749
      (count + 250).to_s.first + "k"
    else
      # TODO: might as well work on cases up to ridiculous numbers I guess
      # 'k' version should be easy to adapt up to 1m.. might not even need changing
      count
    end
  end
end