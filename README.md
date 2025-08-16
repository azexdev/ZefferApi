# ZefferApi 👍🏿

## Installation

To use this API, you will need to have the following installed:

- PHP with the `ssh2` module enabled
- A server or VPS with the necessary DDoS attack scripts (e.g., `ERROR`, `STCP`, `SSDP`, etc.)
- or use .pl script 👍🏿

## Usage

The API can be accessed via HTTP GET requests with the following parameters:

- `host`: The target IP address or URL
- `port`: The target port (optional)
- `time`: The duration of the attack in seconds
- `method`: The type of DDoS attack to perform (e.g., `ERROR`, `STCP`, `SSDP`, etc.)

Example usage:

```
lol.php?host=example.com&port=80&time=60&method=STCP
```

This will initiate a 60-second STCP attack on the `example.com` website.

## API

The main class in the API is `API`, which has the following methods:

- `__construct(array $server)`: Initializes the API with the server connection details.
- `start()`: Validates the input parameters and initiates the DDoS attack.

The `ssh2` class is used to establish an SSH connection to the server and execute the attack commands.

## Contributing

If you would like to contribute to this project, please follow these steps:

1. Fork the repository
2. Create a new branch for your changes
3. Make your changes and commit them
4. Submit a pull request

## License

This project is licensed under the [MIT License](LICENSE).

## Testing

To test the API, you can use the provided example usage in the "Usage" section. Make sure to replace the parameter values with your desired target and attack type.
