defmodule HystereticBangBangControllerTest do
  use ExUnit.Case
  import ControlLoop.HystereticBangBangController, only: :macros
  alias ControlLoop.HystereticBangBangController, as: HBBC

  describe "setup" do
    test "basic creating and fetching" do
      c = hbb_controller(setpoint_start: 1, setpoint_end: 2, output_off: 2, output_on: 3)

      assert hbb_controller(c, :setpoint_start) == 1
      assert hbb_controller(c, :setpoint_end) == 2
      assert hbb_controller(c, :output_off) == 2
      assert hbb_controller(c, :output_on) == 3
    end
  end

  describe "updating" do
    setup do
     %{c:  hbb_controller(setpoint_start: 1, setpoint_end: 2, output_off: 2, output_on: 3)}
    end

    test "update returns off value for below setpoint start and sets state", %{c: controller} do
      {2, controller_next} = HBBC.update(controller, 0)
      assert :off == hbb_controller(controller_next, :previous_state)
    end

    test "update returns off value for in setpoint region but previously off", %{c: controller} do
      {2, controller_next} = HBBC.update(controller, 0)
      {2, controller_next} = HBBC.update(controller_next, 1.5)
      assert :off == hbb_controller(controller_next, :previous_state)
    end

    test "update returns on value for above setpoint end and sets state", %{c: controller} do
      {3, controller_next} = HBBC.update(controller, 3)
      assert :on == hbb_controller(controller_next, :previous_state)
    end

    test "update returns on value for in setpoint region but previously on", %{c: controller} do
      {3, controller_next} = HBBC.update(controller, 3)
      {3, controller_next} = HBBC.update(controller_next, 1.5)
      assert :on == hbb_controller(controller_next, :previous_state)
    end
  end

end
