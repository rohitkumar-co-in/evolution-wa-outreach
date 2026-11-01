# Leadomi WhatsApp Outreach

Standalone campaign dashboard for consent-based WhatsApp outreach. Designed for Coolify with persistent `/data` storage.

## Environment

- `ADMIN_PASSWORD`: dashboard login password; set this in Coolify, with at least 8 characters.
- `APP_SECRET`: legacy dashboard-password fallback until `ADMIN_PASSWORD` is set.
- `EVOLUTION_API_URL`: Evolution API base URL, e.g. `https://evo.leadomi.com`.
- `EVOLUTION_API_KEY`: Evolution global API key.
- `N8N_WEBHOOK_SECRET`: shared header secret for n8n callbacks and internal API requests.
- In n8n, configure `OUTREACH_APP_URL`, `OUTREACH_WEBHOOK_SECRET`, `EVOLUTION_API_URL`, and `EVOLUTION_API_KEY` for the new dispatch workflow. The n8n installation must allow these environment variables in expressions.
- `PORT`: defaults to 3000.
- `DATA_DIR`: defaults to `/data`.

The app refuses to start without secrets. Keep the database volume persistent and private. Never expose API keys to browser code. Mount a persistent volume at `/data`. The app listens on port 3000.

## CSV columns

Only the mobile number and WhatsApp message are required. During upload, map those two fields to whichever columns your CSV uses; the header names are not fixed. Business and owner name columns can also be mapped optionally. Enter the country calling code as digits in the campaign form (for example, `44` or `91`); it is added to local numbers, with a leading national `0` removed. Numbers already written with `+` or `00` keep their own country code. Final numbers must be valid E.164 international numbers. Blank messages, invalid numbers, duplicate campaign numbers, and suppressed numbers are held or skipped.

## Scheduling

Times use `Europe/London` and follow daylight-saving changes. The start date defaults to today; leaving it blank starts as soon as the campaign is started. An end date/time is optional. Each campaign also needs a daily count range and at least one sending window. Three configurable windows can be enabled independently. The server enforces campaign dates, enabled windows, the daily range, opt-out suppression, and a fixed 15-minute minimum interval. The interval is a conservative pacing control, not a way to evade platform enforcement.

## n8n

The new inactive workflow is also created in the connected n8n instance. It is named **Leadomi Outreach Dispatch (new)**. Configure the environment variables listed above and set the Evolution instance webhook URL to the workflow's `leadomi-evolution-events` production webhook, with message events enabled. Existing workflows are not changed. Activate only after configuration and review.
# evolution-wa-outreach

Standalone Coolify-ready dashboard and n8n workflow for consent-based WhatsApp outreach. See `outreach-dashboard/README.md` for setup and deployment details.
