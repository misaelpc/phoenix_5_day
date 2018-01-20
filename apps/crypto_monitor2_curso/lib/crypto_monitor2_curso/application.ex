defmodule CryptoMonitor2Curso.Application do
  @moduledoc """
  The CryptoMonitor2Curso Application Service.

  The crypto_monitor2_curso system business domain lives in this application.

  Exposes API to clients such as the `CryptoMonitor2CursoWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(CryptoMonitor2Curso.Repo, []),
      supervisor(CryptoMonitor.Bank, []),
      supervisor(CryptoMonitor.BTC, [10])
    ], strategy: :one_for_one, name: CryptoMonitor2Curso.Supervisor)
  end
end
