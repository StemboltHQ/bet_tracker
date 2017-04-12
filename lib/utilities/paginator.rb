module Utilities
  # Paginator should be a class that can be initialized with the params to
  # #items_to_display
  #
  # It should possibly be initialized with a view context, or build its own
  module Paginator
    # Im killing the ellipses, in favor of having > and >> symbols. Those
    # should be enough
    ELLIPSES = '...'.freeze
    OFFSET = 1
    FIRST_PAGE = 1
    DIVIDER = 2

    # Do we need to pass in items per page and current page here ....
    def items_to_display(model:, items_per_page: 5, current_page: 1)
      # We could
      @items_per_page = items_per_page
      @current_page = current_page
      @number_of_items = model.count
      @last_page = (@number_of_items.to_f / @items_per_page).ceil # #fdiv

      model.
        offset(items_per_page * (@current_page - OFFSET)).
        limit(items_per_page)
    end

    # lets make max_page blocks the number of blocks on either side of the
    # current page
    # Makes the number of blocks always odd
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

    # I'm not sure I like this class having tons of knowlege of front end classes
    # But I also dont have an alternative
    def page_item_css_class(page, current_page)
      # If statement with no body
      if page == current_page 'page-item active'
      elsif page.to_s == ELLIPSES
        'page-item disabled'
      end
    end

    private

    # Same as above
    def previous_link_css_class
      @current_page == FIRST_PAGE ? 'page-item disabled' : 'page-item'
    end

    # Same as above
    def next_link_css_class
      @current_page == @last_page ? 'page-item disabled' : 'page-item'
    end

    # Private method should have access to all of these values without them bing passed in
    def pages_to_display(current_page, max_page_blocks, number_of_pages)
      # Not sure that #all_pages_fit is a significant enough helper for it to be its own method
      # I kind of imaging this working like: Create the whole pagination, then trim off the parts we dont need
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

    # Private method should have access to all of these values without them bing passed in
    def all_pages_fit?(number_of_pages, max_page_blocks)
      number_of_pages < max_page_blocks
    end

    # Private method should have access to all of these values without them bing passed in
    def current_page_at_the_beginning?(current_page, max_page_blocks)
      current_page <= (max_page_blocks / DIVIDER)
    end

    # Private method should have access to all of these values without them bing passed in
    def current_page_at_the_end?(current_page, number_of_pages, max_page_blocks)
      current_page > (number_of_pages - (max_page_blocks / DIVIDER))
    end

    # Private method should have access to all of these values without them bing passed in
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

    # Private method should have access to all of these values without them bing passed in
    def beginning_pagination(max_page_blocks)
      start = FIRST_PAGE
      finish = max_page_blocks - OFFSET
      [*(start..finish), ELLIPSES]
   end

    # Private method should have access to all of these values without them bing passed in
    def end_pagination(max_page_blocks, number_of_pages)
      start = number_of_pages - max_page_blocks + OFFSET * 2
      finish = number_of_pages
      [ELLIPSES, *(start..finish)]
    end

    # Private method should have access to all of these values without them bing passed in
    def complete_pagination(last_page)
      [*FIRST_PAGE..last_page]
    end

    # Private method should have access to all of these values without them bing passed in
    def odd_pages(current_page, max_page_blocks)
      start = (current_page - (max_page_blocks - OFFSET) / DIVIDER) + OFFSET
      finish = (current_page + (max_page_blocks - OFFSET) / DIVIDER) - OFFSET
      [ELLIPSES, *(start..finish), ELLIPSES]
    end

    # Private method should have access to all of these values without them bing passed in
    def even_pages(current_page, max_page_blocks)
      start = (current_page - (max_page_blocks - OFFSET) / DIVIDER) + OFFSET
      finish = (current_page + (max_page_blocks / DIVIDER)) - OFFSET
      [ELLIPSES, *(start..finish), ELLIPSES]
    end
  end
end
