require 'rails_helper'

describe 'Importer' do

	subject { page }

	describe 'upload CSV file' do 
		before do 
			visit root_path
			attach_file('file', Rails.root + 'public/import_csv.csv')
			click_button 'Import'
		end

		it 'should import the file successfully' do
			page.should have_content('placeat school')
		end
	end

	describe 'upload JSON file' do 
		before do 
			visit root_path
			attach_file('file', Rails.root + 'public/import_json.json')
			click_button 'Import'
		end

		it 'should import the file successfully' do
			page.should have_content('ipsa school')
		end
	end

end