# Leadomi WhatsApp Outreach

Standalone campaign dashboard for consent-based WhatsApp outreach. Designed for Coolify with persistent `/data` storage.

## Environment

- `APP_SECRET`: required, long random secret protecting dashboard and internal endpoints.
- `EVOLUTION_API_URL`: Evolution API base URL, e.g. `https://evo.leadomi.com`.
- `EVOLUTION_API_KEY`: Evolution global API key.
- `N8N_WEBHOOK_SECRET`: shared header secret for n8n callbacks and internal API requests.
- In n8n, configure `OUTREACH_APP_URL`, `OUTREACH_WEBHOOK_SECRET`, `EVOLUTION_API_URL`, and `EVOLUTION_API_KEY` for the new dispatch workflow. The n8n installation must allow these environment variables in expressions.
- `PORT`: defaults to 3000.
- `DATA_DIR`: defaults to `/data`.

The app refuses to start without secrets. Keep the database volume persistent and private. Never expose API keys to browser code. Mount a persistent volume at `/data`. The app listens on port 3000.

## CSV columns

Required: `owner_name,business_name,phone,whatsapp_message,consent,consent_date,consent_source`

`consent` must be `yes`, `true`, or `1`. Rows without affirmative consent or required consent evidence are imported as held and are never dispatched. `phone` must be a UK number in E.164 format beginning `+44`. An optional `subscriber_type` column accepts `corporate`, `sole_trader`, or `partnership`.

## Scheduling

Times use `Europe/London` and follow daylight-saving changes. A campaign requires a start date/time, optional end date/time, a daily count range, and at least one window. Three configurable windows can be enabled independently. The server enforces campaign dates, enabled windows, the daily range, opt-out suppression, and a fixed 15-minute minimum interval. The interval is a conservative pacing control, not a way to evade platform enforcement.

## n8n

The new inactive workflow is also created in the connected n8n instance. It is named **Leadomi Outreach Dispatch (new)**. Configure the environment variables listed above and set the Evolution instance webhook URL to the workflow's `leadomi-evolution-events` production webhook, with message events enabled. Existing workflows are not changed. Activate only after configuration and review.
# evolution-wa-outreach

Standalone Coolify-ready dashboard and n8n workflow for consent-based WhatsApp outreach. See `outreach-dashboard/README.md` for setup and deployment details.
