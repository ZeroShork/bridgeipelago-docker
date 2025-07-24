# Bridgeipelago Docker on TrueNAS SCALE

## Initial Setup

- Deployed using the `ghcr.io/zeroshork/bridgeipelago-docker` image
- Installed via TrueNAS SCALE's *Custom App* interface

## Bootloop on Startup

- On initial deployment, the container immediately crashed with no logs shown in the TrueNAS UI.
- Root cause: volume mounts targeting `/app/*` were overwriting the container's application code.

### Fix:
- All volume mounts were redirected from `/app/...` to `/data/...` to avoid interfering with the application code.

  **Example:**
  ```
  /mnt/data/apps/bridgeipelago/ArchData → /data/archdata
  ```

- After this change, application files (e.g., `bridgeipelago.py`) were visible again, and the container could start successfully when run manually.

## Debugging Strategy

To investigate startup failures:

- A temporary command override was added in the container configuration:

  ```
  tail
  -f
  /dev/null
  ```

- This kept the container running without executing the main application, allowing shell access via TrueNAS or `k3s kubectl`.
- From there, we were able to run the app manually and observe crash output (e.g., missing environment variables).

This override was removed once debugging was complete and the container was ready to run normally.

## Environment Variables

- The app expects several environment variables to be set (e.g., `DiscordBroadcastChannel`, `QueueOverclock`, `BridgeApiToken`, etc.)
- TrueNAS SCALE does not natively support `.env` files.
- These variables were initially entered manually via the app's *Environment Variables* section in the TrueNAS UI.

### Important:
- **Do not include quotes around values**. For example:
  - `1234567890` → correct
  - `"1234567890"` → incorrect (will cause crash in `int()`/`float()` parsing)

## Future-Proofing

We're exploring options to make the deployment less manual:

**Option A**: Mount a `.env` file and use a wrapper in `start.sh` to load it:

```sh
export $(grep -v '^#' /app/.env | xargs)
```

**Option B**: Switch to a JSON config file (e.g., `config.json`) mounted into the container and parsed by the application at runtime. The code would fall back to `os.getenv()` if no config file is found.

## Notes for Future Users

- **Do not mount folders to `/app/`** unless you are deliberately replacing the container's code — doing so will overwrite it.
- If the container crashes during startup, TrueNAS will not show logs or allow shell access.
  - In these cases, use the `tail -f /dev/null` override to keep the container alive long enough to inspect it.
- Be aware that TrueNAS will allow you to enter quotes around environment variable values, but this can break Python scripts that expect numeric input.
