# Flowroute SMS Forwarder

This tool will allow you to forward all messages received on your Flowroute phone numbers to a single phone number. I use this to receive messages on my cell phone.

NOTE: This tool works against the Flowroute 2.0 API.

### Usage

First start the container running somewhere with a port open on the internet. In this case I am using port 80, but you can use anything. Just be sure to set the URL with that port in the webhook on Flowroute.

    # See the next section for environment variables
    docker run \
      -p 80:4567 \
      -e FLOWROUTE_CALLBACK_PATH="/somstring" \
      -e FLOWROUTE_FROM_DID="18001234567" \
      -e FLOWROUTE_KEY="<keyid>" \
      -e FLOWROUTE_SECRET="<secret>" \
      -ti zmpeg/flowroute-sms-forwarder
  
Second, setup the SMS webhook endpoint in Flowroute to point to the port of this container. You can set it in Flowroute under Preferences > API Control > [Webhooks](https://manage.flowroute.com/accounts/preferences/api/)

### Environment Variables

| ENV Variable | Description |
|--|--|
| FLOWROUTE_FROM_DID | The full DID in Flowroute which you want to send the textmessage from. This must be a phone number which you own. |
| FLOWROUTE_CALLBACK_PATH | The path for your API. I set this to a random string so that any webcrawler will not accidentally send me a text message. |
| FLOWROUTE_ID<br>FLOWROUTE_SECRET | The credentials for the Flowroute API. You can fetch them Flowroute under Preferences > [API Control](https://manage.flowroute.com/accounts/preferences/api/). |
