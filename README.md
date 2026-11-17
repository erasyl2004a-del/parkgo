# ParkGo

ParkGo is being rebuilt as a responsive, installable Progressive Web App (PWA) for iPhone, Android phones/tablets and desktop browsers.

## Current prototype
- Responsive Turkish interface for mobile, tablet and desktop
- Search by city, district or parking name
- City filters, sorting and available-space filter
- Parking detail, map directions and favorites
- Demo parking requests stored only in the current browser session
- PWA manifest and service-worker registration
- Initial Supabase database migration for operators, parking lots and reservations

**Important:** parking lots, prices, ratings and availability shown in the prototype are sample data, not verified live inventory. Demo park requests do not create a real reservation or charge a card. Real availability requires operator/municipality integrations; accounts, payments and confirmed reservations are not enabled yet.

## Run locally
Requires Node.js 20 or newer.

```bash
npm install
npm run dev
```

Build:
```bash
npm run build
npm run preview
```

## Deploy
The included GitHub Actions workflow publishes the app to GitHub Pages at:
https://erasyl2004a-del.github.io/parkgo/

Enable GitHub Pages in repository Settings → Pages → Build and deployment → Source: GitHub Actions. After the workflow completes, open the HTTPS address on the phone and choose “Add to Home Screen” (iPhone Safari) or “Install app” (Android Chrome).

## Live backend (next stage)
1. Create a Supabase project.
2. Apply `supabase/migrations/20261118000000_initial_schema.sql`.
3. Add `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` to deployment environment variables.
4. Integrate verified operator feeds and implement server-side reservation/payment flows before accepting real bookings.

Never put a Supabase service-role key or payment secret in frontend environment variables.
