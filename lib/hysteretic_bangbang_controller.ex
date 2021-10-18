defmodule ControlLoop.HystereticBangBangController do
  require Record

  Record.defrecord(:hbb_controller, previous_state: :off, setpoint_start: 0, setpoint_end: 0,  output_off: 0, output_on: 0)

  def update( hbb_controller(previous_state: :off, setpoint_start: setpoint_start, setpoint_end: setpoint_end, output_off: output_off, output_on: output_on) = controller, input) do
    if input > setpoint_end do
      {output_on, hbb_controller(controller, previous_state: :on)}
    else
      {output_off, controller}
    end
  end
  def update( hbb_controller(previous_state: :on, setpoint_start: setpoint_start, setpoint_end: setpoint_end, output_off: output_off, output_on: output_on) = controller, input) do
    if input < setpoint_start do
      {output_off, hbb_controller(controller, previous_state: :off)}
    else
      {output_on, controller}
    end
  end
end
