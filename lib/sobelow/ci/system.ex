defmodule Sobelow.CI.System do
  alias Sobelow.Utils
  use Sobelow.Finding
  @finding_type "Command Injection in `System.cmd`"

  def run(fun, meta_file) do
    severity = if meta_file.is_controller?, do: false, else: :low
    {findings, params, {fun_name, [{_, line_no}]}} = parse_def(fun)

    Enum.each(findings, fn {finding, var} ->
      Utils.add_finding(
        line_no,
        meta_file.filename,
        fun,
        fun_name,
        var,
        Utils.get_sev(params, var, severity),
        finding,
        @finding_type
      )
    end)
  end

  def parse_def(fun) do
    Utils.get_fun_vars_and_meta(fun, 0, :cmd, [:System])
  end

  def details() do
    Sobelow.CI.details()
  end
end
