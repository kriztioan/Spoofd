# Spoofd

`Spoofd` is a `launchd` service and script for automatically spoofing the WiFi MAC address on `MacOS` when near a predefined network. It relies on `osascript` to run `ifconfig` with elevated privileges to set the MAC address and will ask for an Administrator username/ password if needed.

## Usage

Move the folder containing `Spoofd` to `Library/Application Support` in your home directory. Next, check and update the configuration in `etc/config`. The four most important parameters and their meaning are listed in the table below.

|parameter|meaning|
--------|-----
|`INTERFACE`|WiFi interface|
|`HARDWARE`|hardware MAC address|
|`SOFTWARE`|spoof MAC address|
|`TRIGGER`|SSID of WiFi network that triggers spoofing|

Copy `net.ddns.christiaanboersma.spoofd.plist` from the `share` folder to `Library/LaunchAgents` in your home directory. Log out and back in.

## Notes

1. `Spoofd` relies on `unbuffer`, which can be installed via [Homebrew](https://brew.sh).
2. By default, logging is done to `Library/Logs/Spoofd.log` in your home directory.

## BSD-3 License

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
