require 'openregister'
require 'zip'
require 'httparty'
require 'tempfile'

class HomeController < ApplicationController

  def index
    registers_without_name = %w(field government-service register datatype)

    @list_of_registers = OpenRegister.registers(:beta)
                                     .reject{ |r| registers_without_name.include?(r.register) || r._records.empty?}
                                     .sort_by(&:register)
  end

  def choose_field
    @register_name = params[:selected_register].split(":")[0]
    @register_phase = params[:selected_register].split(":")[1]

    @register = OpenRegister.register(@register_name, @register_phase.to_sym)
  end

  def generate_component_files
    @register_name = params[:selected_register]
    @register_phase = params[:selected_phase]

    @register_json = HTTParty.get('https://' + @register_name + '.' + @register_phase + '.openregister.org/records.json').body.force_encoding("UTF-8")
    @autocomplete_data = HTTParty.post('https://5cq56v9u9f.execute-api.eu-west-2.amazonaws.com/prod/generate/' + @register_name, body: @register_json).body.force_encoding("UTF-8")

    session[:autocomplete_data_file] = @autocomplete_data

    redirect_to controller: 'home', action: 'show_component'
  end

  def show_component
  end

  def download
    @component_html = File.read(Rails.root.join('app/assets/static/component.html'))
    @component_data = session[:autocomplete_data_file]
  end

  def download_zip
    component_html = File.new(Rails.root.join('app/assets/static/component.html'))

    component_json = Tempfile.new(['component', '.json'])
    component_json.write(session[:autocomplete_data_file])
    component_json.close

    files_to_zip = [component_json]
    zip_file_name = "autocomplete-code.zip"
    file = Tempfile.new(zip_file_name)

    ::Zip::File.open(file.path, Zip::File::CREATE) do |zip_file|
      files_to_zip.each do |filename|
        zip_file.add(filename, filename)
      end
    end

    zip_data = File.read(file.path)
    send_data(zip_data, type: 'application/zip', filename: zip_file_name)

    #session[:autocomplete_data_file] = ''
  end
end
