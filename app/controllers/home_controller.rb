require 'openregister'
require 'zip'
require 'httparty'
require 'tempfile'

class HomeController < ApplicationController

  def index
    @list_of_registers = OpenRegister.registers(:beta)
  end

  def choose_field
    @register_name = params[:selected_register].split(":")[0]
    @register_phase = params[:selected_register].split(":")[1]

    @register = OpenRegister.register(@register_name, @register_phase.to_sym)
  end

  def generate_picker_files
    @register_name = params[:selected_register]
    @register_phase = params[:selected_phase]

    @register_json = HTTParty.get('https://' + @register_name + '.' + @register_phase + '.openregister.org/records.json').body.force_encoding("UTF-8")
    @autocomplete_data = HTTParty.post('https://5cq56v9u9f.execute-api.eu-west-2.amazonaws.com/prod/generate/' + @register_name, body: @register_json).body.force_encoding("UTF-8")

    session[:autocomplete_data_file] = @autocomplete_data

    redirect_to controller: 'home', action: 'show_picker'
  end

  def show_picker
  end

  def download
    files_to_zip = ["#{Rails.root}/app/assets/static/picker.html", "#{data_file_url}"]
    zip_file_name = "picker-code.zip"
    file = Tempfile.new(zip_file_name)

    ::Zip::File.open(file.path, Zip::File::CREATE) do |zip_file|
      files_to_zip.each do |filename|
        zip_file.add(filename, filename)
      end
    end

    zip_data = File.read(file.path)
    send_data(zip_data, type: 'application/zip', filename: zip_file_name)

    session[:autocomplete_data_file] = ''
  end
end
