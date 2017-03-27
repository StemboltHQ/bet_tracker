module Utilities
  module Paginator
    ELLIPSES = '...'.freeze
    OFFSET = 1
    FIRST_PAGE = 1
    DIVIDER = 2

    def items_to_display(model:, items_per_page: 5, current_page: 1)
      @items_per_page = items_per_page
      @current_page = current_page
      @number_of_items = model.count
      @last_page = (@number_of_items.to_f / @items_per_page).ceil
      model.offset(items_per_page * (@current_page - OFFSET))
           .limit(items_per_page)
    end

    def paginator(max_page_blocks: 7)
      render partial: 'shared/paginator',
             locals: { blocks: pages_to_display(@current_page,
                                                max_page_blocks,
                                                @last_page),
                       current_page: @current_page,
                       previous_link_css_class: previous_link_css_class,
                       next_link_css_class: next_link_css_class,
                       last_page: @last_page }
    end

    def page_item_css_class(page, current_page)
      if page == current_page
        'page-item active'
      elsif page.to_s == ELLIPSES
        'page-item disabled'
      end
    end

    private

    def previous_link_css_class
      @current_page == FIRST_PAGE ? 'page-item disabled' : 'page-item'
    end

    def next_link_css_class
      @current_page == @last_page ? 'page-item disabled' : 'page-item'
    end

    def pages_to_display(current_page, max_page_blocks, number_of_pages)
      if all_pages_fit?(number_of_pages, max_page_blocks)
        complete_pagination(number_of_pages)
      elsif current_page_at_the_beginning?(current_page, max_page_blocks)
        beginning_pagination(max_page_blocks)
      elsif current_page_at_the_end?(current_page, number_of_pages,
                                     max_page_blocks)
        end_pagination(max_page_blocks, number_of_pages)
      else
        general_pagination(current_page, max_page_blocks)
      end
    end

    def all_pages_fit?(number_of_pages, max_page_blocks)
      number_of_pages < max_page_blocks
    end

    def current_page_at_the_beginning?(current_page, max_page_blocks)
      current_page <= (max_page_blocks / DIVIDER)
    end

    def current_page_at_the_end?(current_page, number_of_pages, max_page_blocks)
      current_page > (number_of_pages - (max_page_blocks / DIVIDER))
    end

    def general_pagination(current_page, max_page_blocks)
      if max_page_blocks == 1
        [current_page]
      elsif max_page_blocks == 2
        [current_page, ELLIPSES]
      elsif max_page_blocks.odd?
        odd_pages(current_page, max_page_blocks)
      else
        even_pages(current_page, max_page_blocks)
      end
    end

    def beginning_pagination(max_page_blocks)
      start = FIRST_PAGE
      finish = max_page_blocks - OFFSET
      [*(start..finish), ELLIPSES]
    end

    def end_pagination(max_page_blocks, number_of_pages)
      start = number_of_pages - max_page_blocks + OFFSET * 2
      finish = number_of_pages
      [ELLIPSES, *(start..finish)]
    end

    def complete_pagination(last_page)
      [*FIRST_PAGE..last_page]
    end

    def odd_pages(current_page, max_page_blocks)
      start = (current_page - (max_page_blocks - OFFSET) / DIVIDER) + OFFSET
      finish = (current_page + (max_page_blocks - OFFSET) / DIVIDER) - OFFSET
      [ELLIPSES, *(start..finish), ELLIPSES]
    end

    def even_pages(current_page, max_page_blocks)
      start = (current_page - (max_page_blocks - OFFSET) / DIVIDER) + OFFSET
      finish = (current_page + (max_page_blocks / DIVIDER)) - OFFSET
      [ELLIPSES, *(start..finish), ELLIPSES]
    end
  end
end
