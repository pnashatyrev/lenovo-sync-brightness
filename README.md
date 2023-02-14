### Script for Lenovo laptop to sync display brightness across power plans (Fn+Q)

It's a simple powershell script that takes the current display brightness value and copies it to all 3 power schemes
With the help of Task Scheduler sync will happen every 15 minutes

GUIDs of power schemas are hardcoded so if you want it to work on a non-Lenovo laptop, you should replace those GUIDs with your own. Use `powercfg /list` to get them


How to use it:
- Save `sync-brightness-across-powerplans.ps1` to C:\Lenovo\ (or choose your own path)
- Save `Sync brightness - Scheduler Task.xml` anywhere
- Open Windows Task Scheduler and import a task from the XML file
- Choose "Run whether user is logged on or not", otherwise you'll see a console window for a moment every time script is executed
- Adjust period and path to the script if needed
