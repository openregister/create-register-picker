require 'openregister'

class HomeController < ApplicationController
  def index
    @list_of_registers = initializeRegisters()
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

  def initializeRegisters()
    list_of_registers = OpenRegister.registers :beta
    list_of_registers
  end

  def download
  end
end
