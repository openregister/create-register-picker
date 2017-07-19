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

  def initializeRegisters()
    list_of_registers = OpenRegister.registers :beta
    list_of_registers.concat(OpenRegister.registers :alpha)
    list_of_registers.concat(OpenRegister.registers :discovery)
    list_of_registers
  end
end
