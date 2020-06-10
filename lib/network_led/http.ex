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
      <button id="enable">On</button>
      <button id="disable">Off</button>
      <br/>
      <img src="video.mjpg" />

      <script
        src="https://code.jquery.com/jquery-3.5.1.min.js"
        integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
        crossorigin="anonymous"></script>

      <script type="text/javascript">
        $(document).ready(function() {

          $("#enable").click(function() {
            $.ajax({url: "/enable", success: function(result){
              console.log("turning light on");
            }});
          });

          $("#disable").click(function() {
            $.ajax({url: "/disable", success: function(result){
              console.log("turning light off");
            }});
          });

        });


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
