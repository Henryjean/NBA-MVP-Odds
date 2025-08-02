# Rotowire NBA MVP Odds Archive

This repository automatically fetches daily NBA MVP odds from RotoWire and archives the data as CSV files via GitHub Action.

---

## What this repo does

- Uses an R script (`get_mvp_odds.R`) to scrape MVP odds data from [RotoWire](https://www.rotowire.com/betting/nba/tables/player-futures.php?future=MVP).
- Adds a timestamp to the data to track when it was pulled.
- Saves the data as a dated CSV file inside the `data/` folder.
- Runs daily and on-demand via GitHub Actions.
- Commits and pushes any new data back to the repository, creating a time-stamped archive of championship odds over time.

---

## How it works

1. The GitHub Actions workflow triggers either on a schedule (every day at 8:30 AM UTC) or manually via the "Run workflow" button.
2. It sets up R on a Linux runner, installs necessary packages (`jsonlite`, `dplyr`), and system dependencies.
3. Runs the R script to download and save the odds data.
4. Commits and pushes the new CSV file(s) back to the repo automatically.

---

## Folder structure

- `get_mvp_odds.R` — R script that fetches and saves the data.
- `data/` — Folder containing daily CSV files named like `mvp_odds_YYYY_MM_DD.csv`.
- `.github/workflows/` — Contains the GitHub Actions workflow YAML.

---
