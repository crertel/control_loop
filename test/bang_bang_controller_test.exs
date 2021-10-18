defmodule BangBangControllerTest do
  use ExUnit.Case
  import ControlLoop.BangBangController, only: :macros
  alias ControlLoop.BangBangController

  describe "setup" do
    test "basic creating and fetching" do
      c = bb_controller(setpoint: 1, output_off: 2, output_on: 3)

      assert bb_controller(c, :setpoint) == 1
      assert bb_controller(c, :output_off) == 2
      assert bb_controller(c, :output_on) == 3
    end
  end

  describe "updating" do
    setup do
     %{c:  bb_controller(setpoint: 1, output_off: 2, output_on: 3)}
    end
    test "update returns off value for below or at setpoint", %{c: controller} do
      assert { 2, controller } == BangBangController.update(controller, 0)
      assert { 2, controller } == BangBangController.update(controller, 1)
    end

    test "update returns on value for above setpoint", %{c: controller} do
      assert { 3, controller } == BangBangController.update(controller, 2)
    end
  end

end
