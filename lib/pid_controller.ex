defmodule ControlLoop.PIDController do
  require Record

  Record.defrecord(:pid_controller,
                   derivative_state: 0,
                   integral_state: 0,
                   k_i: 0,
                   k_d: 0,
                   k_p: 0)

  # adapted from https://www.embeddedrelated.com/showarticle/943.php
  def update(pid_controller(derivative_state: ds, integral_state: is, k_i: k_i, k_d: k_d, k_p: k_p), error, value) do
    is = is + error
    p = k_p * error
    i = k_i * is
    d = k_d * (ds - value)
    ds = value
    { p+i+d, pid_controller(derivative_state: ds, integral_state: is, k_i: k_i, k_d: k_d, k_p: k_p) }
  end
end
