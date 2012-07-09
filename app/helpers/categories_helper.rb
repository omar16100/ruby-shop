module CategoriesHelper
  def category_link(cat)
    content_tag_for :li, cat, :style => "background-color: #{bg_color(cat)}" do
      link_to cat.name, cat
    end
  end

  def bg_color(cat)
    cat.color
  end
end
