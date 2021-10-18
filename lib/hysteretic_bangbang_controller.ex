defmodule ControlLoop.HystereticBangBangController do
  require Record

  Record.defrecord(:hbb_controller, previous_state: :off, setpoint_start: 0, setpoint_end: 0,  output_off: 0, output_on: 0)

  def update( hbb_controller(previous_state: :off, setpoint_end: setpoint_end, output_on: output_on) = controller, input)
    when input > setpoint_end  do {output_on, hbb_controller(controller, previous_state: :on)} end
  def update( hbb_controller(previous_state: :off, output_off: output_off) = controller, _) do
    {output_off, controller}
  end
  def update( hbb_controller(previous_state: :on, setpoint_start: setpoint_start, output_off: output_off) = controller, input)
    when input < setpoint_start do {output_off, hbb_controller(controller, previous_state: :off)} end
  def update( hbb_controller(previous_state: :on, output_on: output_on) = controller, _) do
    {output_on, controller}
  end
end
