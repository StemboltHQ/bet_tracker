require 'rails_helper'

RSpec.describe Utilities::Paginator, type: :module do
  let!(:paginator) { Class.new { extend Utilities::Paginator } }

  describe('#pages_to_display') do
    subject(:pages_to_display) do
      paginator.send(:pages_to_display,
                     current_page,
                     maximum_page_blocks,
                     number_of_pages)
    end

    context 'All pages fit within the pagination list' do
      let(:maximum_page_blocks) { 7 }
      let(:current_page) { 1 }
      let(:number_of_pages) { 5 }
      let(:expected_range_of_pages) { [1, 2, 3, 4, 5] }

      it 'displays correct range of pages' do
        expect(pages_to_display).to eq expected_range_of_pages
      end
    end

    context 'Current page is in the beginning and there are more pages towards the end of the pagination list' do
      let(:maximum_page_blocks) { 7 }
      let(:current_page) { 3 }
      let(:number_of_pages) { 11 }
      let(:expected_range_of_pages) { [1, 2, 3, 4, 5, 6, '...'] }

      it 'displays correct range of pages' do
        expect(pages_to_display).to eq expected_range_of_pages
      end
    end

    context 'Current page is at the end and there are more pages towards the beginning of the pagination list' do
      let(:maximum_page_blocks) { 7 }
      let(:current_page) { 9 }
      let(:number_of_pages) { 11 }
      let(:expected_range_of_pages) { ['...', 6, 7, 8, 9, 10, 11] }

      it 'displays correct range of pages' do
        expect(pages_to_display).to eq expected_range_of_pages
      end
    end

    context 'Current page is in the middle and there are more pages towards the beginning and the end of the pagination list' do
      context 'Maximum number of page blocks is 1' do
        let(:maximum_page_blocks) { 1 }
        let(:current_page) { 5 }
        let(:number_of_pages) { 11 }
        let(:expected_range_of_pages) { [5] }

        it 'displays correct range of pages' do
          expect(pages_to_display).to eq expected_range_of_pages
        end
      end

      context 'Maximum number of page blocks is 2' do
        let(:maximum_page_blocks) { 2 }
        let(:current_page) { 6 }
        let(:number_of_pages) { 11 }
        let(:expected_range_of_pages) { [6, '...'] }

        it 'displays correct range of pages' do
          expect(pages_to_display).to eq expected_range_of_pages
        end
      end

      context 'Maximum number of page blocks is odd' do
        let(:maximum_page_blocks) { 7 }
        let(:current_page) { 5 }
        let(:number_of_pages) { 11 }
        let(:expected_range_of_pages) { ['...', 3, 4, 5, 6, 7, '...'] }

        it 'displays correct range of pages' do
          expect(pages_to_display).to eq expected_range_of_pages
        end
      end

      context 'Maximum number of page blocks is even' do
        let(:maximum_page_blocks) { 6 }
        let(:current_page) { 5 }
        let(:number_of_pages) { 11 }
        let(:expected_range_of_pages) { ['...', 4, 5, 6, 7, '...'] }

        it 'displays correct range of pages' do
          expect(pages_to_display).to eq expected_range_of_pages
        end
      end
    end
  end
end
