# Reverse shell Makefile toolkit

This toolkit provides a `Makefile`-based interface for easily testing a wide variety of reverse shell techniques. It was developed as part of a bachelor thesis on analyzing reverse shell techniques. Each target in the Makefile corresponds to a reverse shell method or a listener setup.

> For detailed technical explanation and background on each technique, refer to the associated thesis.

## Configuration

Before using the Makefile, configure it with your desired values using the provided `./configure` script.

### Supported variables

| Variable | Description | Default |
|----------|-------------|---------|
| `HOST`   | The IP address or domain name the reverse shell should connect to. | `127.0.0.1` |
| `PORT`   | The primary port to connect to. | `4444` |
| `SHELL`  | Shell binary used for executing commands (not used in all methods). | `/bin/bash` |
| `PORT2`  | A secondary port required by some techniques. Should differ from `PORT`. | `4445` |
| `TMP`    | Path to a temporary file or named pipe, used by some methods. Should not exist prior to use. | `/tmp/f` |

### Example usage

```bash
./configure HOST=192.168.0.10 PORT=9001 TMP=/tmp/myfifo
```

> Only passed arguments will be updated. Any values not provided will remain unchanged.

## Usage

### List available methods

```bash
make show
```

This displays:
- All available reverse shell and listener targets
- Currently active configuration values

### Run a reverse shell (listener) method

```bash
make <target>
```

Replace `<target>` with any listed method (e.g., `make curl`, `make php`, etc.).

### Preview a command without running it

```bash
make <target>-show
```

Useful for reviewing the generated shell command before execution.

### Start a basic listener

To set up a basic listener (useful for majority of reverse shell methods), issue:

```bash
make listener
```

> Most listener targets only require the `PORT` variable. This should match the port used by the reverse shell on the victim machine.

Additional listener types are also available. See the full list with `make show`.

## ⚠️ Additional Notes

Some methods may require extra parameters (e.g., a PID for GDB). If those are missing, the `-show` targets will include a warning. Always preview a command before executing to avoid undesired behavior.

---

This tool is intended for testing and demonstrating reverse shell techniques collected and analyzed in the associated thesis. For detailed explanations of each method, please refer to the thesis.
