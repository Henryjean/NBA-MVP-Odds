library(tidyverse)
library(duckdb)
library(DBI)
library(gt)
library(gtUtils)
library(gtExtras)

today <- Sys.Date()

con <- DBI::dbConnect(duckdb::duckdb())

dat <- dbGetQuery(
  con,
  "select playerID, name, team, logo, fanduel_odds, date from read_csv('data/*.csv')"
)

df <- dat %>%
  arrange(date) %>%
  mutate(mgm_odds = parse_number(mgm_odds)) %>%
  mutate(first_odds = first(mgm_odds)) %>%
  select(playerID, name, team, date, first_odds, mgm_odds) %>%
  mutate(
    ip = case_when(
      mgm_odds > 0 ~ 100 / (mgm_odds + 100),
      TRUE ~ abs(mgm_odds) / (abs(mgm_odds) + 100)
    )
  ) %>%
  group_by(date) %>%
  mutate(ip_novig = ip / sum(ip, na.rm = TRUE)) %>%
  ungroup() %>%
  group_by(playerID, name) %>%
  mutate(seven_day_change = ip_novig - lag(ip_novig, 6)) %>%
  ungroup() %>%
  filter(date == max(date))

top10 <- df %>%
  filter(date == max(date)) %>%
  arrange(-ip_novig) %>%
  ungroup() %>%
  filter(row_number() <= 10)
