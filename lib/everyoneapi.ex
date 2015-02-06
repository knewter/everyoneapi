defmodule Everyoneapi do
  @moduledoc """

  Everyoneapi allows you to lookup a phone number and get back information such
  as Name, Address, Carrier, and more.

  ### Configuration

  Add configuration into your config/config.exs file:

      config :everyoneapi,
        account_sid: "ACCOUNT_SID_HERE",
        auth_token: "AUTH_TOKEN_HERE"

  It's based on HTTPoison, so you must first start the API client:

  iex> Everyoneapi.start

  This must be done once, and it starts the dependencies necessary to use the
  API client.  Then, looking up someone's information is as simple as:

      iex(2)> Everyoneapi.info! "2055551212"

      %HTTPoison.Response{
        body: %{
          "data" => %{
            "carrier" => %{
              "id" => "7475",
              "name" => "T-Mobile"
            },
            "carrier_o" => %{
              "id" => "6214",
              "name" => "AT&T Mobility"
            },
            "cnam" => "ADAMS,JOSHUA   ",
            "gender" => "M",
            "linetype" => "mobile",
            "location" => %{
              "city" => "Birmingham",
              "geo" => %{
                "latitude" => 33.51685254860801,
                "longitude" => -86.81075983815
              },
              "state" => "AL",
              "zip" => "35203"
            },
            "name" => "Joshua Adams"
          },
          "invalid" => [],
          "missed" => ["image", "address"],
          "number" => "+12052153957",
          "pricing" => %{
            "breakdown" => %{
              "carrier" => -0.006,
              "carrier_o" => 0,
              "cnam" => -0.005,
              "gender" => -0.001,
              "linetype" => -0.001,
              "location" => -0.005,
              "name" => -0.01
            },
            "total" => -0.028
          },
          "status" => true,
          "type" => "person"
        },
        headers: %{
          "Connection" => "keep-alive",
          "Content-Length" => "553",
          "Content-Type" => "application/json",
          "Date" => "Fri, 06 Feb 2015 00:46:22 GMT",
          "Server" => "nginx/1.4.7"
        },
        status_code: 200
      }
  """

  use HTTPoison.Base
  require Logger

  @base_url "https://api.everyoneapi.com"

  def info!(number) do
    get! "/v1/phone/#{number}"
  end

  def process_url(url) do
    @base_url <> url
  end

  def process_request_headers(headers) do
    Enum.into(headers, [{"Authorization", "Basic #{encoded_basic}"}])
  end

  defp encoded_basic do
    account_sid = Application.get_env :everyoneapi, :account_sid
    auth_token = Application.get_env :everyoneapi, :auth_token
    combined = "#{account_sid}:#{auth_token}"
    Base.encode64(combined)
  end

  def process_response_body(body) do
    Logger.warn body
    Poison.decode!(body)
  end
end
