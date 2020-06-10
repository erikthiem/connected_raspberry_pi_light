defmodule NetworkLed.Http do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/enable" do
    NetworkLed.Blinker.enable()
    send_resp(conn, 200, "LED enabled")
  end

  get "/disable" do
    NetworkLed.Blinker.disable()
    send_resp(conn, 200, "LED disabled")
  end

  get "/" do
    markup = """
    <html>
    <head>
      <title>Control the light</title>
    </head>
    <body>
      <h1>Control the light</h1>
      <a href="/enable">Enable</a>
      <a href="/disable">Disable</a>
      <img src="video.mjpg" />
      <script type="text/javascript">
        window.alert("testing");

      </script>
    </body>
    </html>
    """
    conn
    |> put_resp_header("Content-Type", "text/html")
    |> send_resp(200, markup)
  end

  get "/camera" do
    markup = """
    <html>
    <head>
      <title>Picam Video Stream</title>
    </head>
    <body>
      <img src="video.mjpg" />
    </body>
    </html>
    """
    conn
    |> put_resp_header("Content-Type", "text/html")
    |> send_resp(200, markup)
  end

  forward "/video.mjpg", to: NetworkLed.Streamer

  match(_, do: send_resp(conn, 404, "Oops!"))
end
