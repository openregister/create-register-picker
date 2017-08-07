require 'openregister'
require 'zip'

class HomeController < ApplicationController
  def index
    @list_of_registers = initialize_registers()
  end

  def choose_field
    @register_name = params[:selected_register].split(":")[0]
    @register_phase = params[:selected_register].split(":")[1]

    @register = OpenRegister.register(@register_name, @register_phase.to_sym)
  end

  def show_picker
    @register_name = params[:selected_register]
    @register_phase = params[:selected_phase]
    @register_field = params[:selected_field]

    @register_records = OpenRegister.register(@register_name, @register_phase.to_sym)._all_records
  end

  def initialize_registers
    list_of_registers = OpenRegister.registers :beta
    list_of_registers
  end

  def download_picker
    compressed_filestream = Zip::OutputStream.write_buffer(::StringIO.new('')) do |zos|
      #First file
      zos.put_next_entry "test1.csv"
      csv = "lalala"
      zos.print csv

      #Second file
      zos.put_next_entry "test2.csv"
      zos.print "la la la 2"
    end
    compressed_filestream.rewind

    send_data compressed_filestream.read, filename: "test.zip"
  end
end
