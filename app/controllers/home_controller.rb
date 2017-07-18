require 'openregister'

class HomeController < ApplicationController
  def index
    @list_of_registers = initializeRegisters()
  end
  
  def initializeRegisters()
    list_of_registers = OpenRegister.registers :beta
    list_of_registers.concat(OpenRegister.registers :alpha)
    list_of_registers.concat(OpenRegister.registers :discovery)
    list_of_registers
  end
end
