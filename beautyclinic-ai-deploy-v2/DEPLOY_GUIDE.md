# Beauty Clinic — Demo Deployment Guide (English)

This guide shows how to deploy the demo **Beauty Clinic** web application (Frontend on Vercel, Backend on Render, Database on PlanetScale). It includes step-by-step instructions and illustrative screenshots.

---
## Architecture Overview
- Frontend: React + Vite on Vercel
- Backend: Node.js + Express on Render
- Database: PlanetScale (MySQL)
- Chatbot: OpenAI (backend calls OpenAI API)

![Architecture diagram](assets/planetscale_setup.png)

---
## 1) Create a GitHub repository
1. Unzip the provided skeleton and push to GitHub:
```bash
git init
git add .
git commit -m "initial"
git branch -M main
git remote add origin https://github.com/<yourname>/beauty-clinic.git
git push -u origin main
```

---
## 2) Create PlanetScale Database
1. Visit https://planetscale.com and create a free database.
2. Choose a nearby region (Tokyo, Singapore) for lower latency.
3. Create a `main` branch and then create a passwordless connection or get a connection string for **Production**.
4. Copy the **Connection String** (format: `mysql://user:pass@host/dbname`) and save it for Render.

> Illustrated: PlanetScale create database and copy connection string.
![PlanetScale setup example](assets/planetscale_setup.png)

---
## 3) Deploy Backend to Render
1. Sign in to https://render.com and click **New Web Service** → **Connect a repository** → pick your GitHub repo.
2. For the service, point to the `/backend` directory (if monorepo) and set:
   - Build Command: `npm ci && npm run build || true`
   - Start Command: `node src/index.js`
3. Add Environment Variables in Render dashboard:
   - `DATABASE_URL` = your PlanetScale connection string
   - `OPENAI_API_KEY` = sk-...
   - `STRIPE_SECRET` = sk_test_...
   - `JWT_SECRET` = a secure secret
4. Deploy. After deployment you will get a public URL like `https://beautyclinic-api.onrender.com`

> Render deploy example:
![Render service example](assets/render_service.png)

---
## 4) Deploy Frontend to Vercel
1. Go to https://vercel.com → **New Project** → Import from GitHub → select the `frontend` directory.
2. Set Environment Variable in Vercel Project Settings:
   - `VITE_API_BASE_URL` = `https://<your-render-domain>/api`
3. Build & Output settings:
   - Build Command: `npm run build`
   - Output Directory: `dist`
4. Deploy. You will get a domain like `https://beautyclinic-demo.vercel.app`

> Vercel setup example:
![Vercel setup example](assets/vercel_setup.png)

---
## 5) Configure environment variables (example)
- On Render add `DATABASE_URL`, `OPENAI_API_KEY`, `JWT_SECRET`, `STRIPE_SECRET`.
- On Vercel add `VITE_API_BASE_URL`.
- Confirm both services can reach the database and backend.

> Example of editing env variables in Render / Vercel:
![Env variables example](assets/connect_env.png)

---
## 6) Run migrations & seeds
If PlanetScale supports direct schema execution via console, run the SQL from `init-db/migrations/002_full_schema.sql`. Alternatively, you can run migrations from a temporary local script that connects to the database and executes SQL files.

Example (local, using `mysql` CLI):
```bash
mysql --host=<host> --user=<user> --password=<pass> < db_dump.sql
```

---
## 7) Final tests
1. Visit the frontend URL and try booking flow.
2. Test chatbot on the website (calls `/api/chat`).
3. Inspect backend logs on Render for errors and database confirmations.

---
## Troubleshooting tips
- If you see `ER_ACCESS_DENIED_ERROR`, verify credentials and that the PlanetScale credentials have access to the correct branch.
- If backend cannot connect to OpenAI, ensure `OPENAI_API_KEY` is correct and not restricted by IP (use default API key).
- If slot conflicts occur on booking, ensure migrations applied and unique constraints exist.

---
## Notes
- For a production demo, consider adding HTTPS, CORS, rate limiting and stricter JWT expiry policies.
- If you want, I can create one-click deploy buttons (Render / Vercel) — let me know.
