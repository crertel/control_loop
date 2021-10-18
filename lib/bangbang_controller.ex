defmodule ControlLoop.BangBangController do
  require Record

  Record.defrecord(:bb_controller, setpoint: 0, output_off: 0, output_on: 0)

  def update( bb_controller(setpoint: setpoint, output_off: output_off, output_on: output_on) = controller, input) do
    output = if input > setpoint, do: output_on, else: output_off

    {output, controller}
  end
end
