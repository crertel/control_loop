defmodule ControlLoop.BangBangController do
  require Record

  Record.defrecord(:bb_controller, setpoint: 0, output_off: 0, output_on: 0)

  def update( bb_controller(setpoint: setpoint, output_off: output_off) = controller, input)
    when input <= setpoint do {output_off, controller} end
  def update( bb_controller(output_on: output_on) = controller, _),  do: {output_on, controller}
end
