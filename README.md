# The plan
Ledger : collection of credits & debits
  accound id 
  type: credit/debit
  amount
  source (payment, interest)
  destination
  datetime

Account : collection of ledger entries, ownership, account number (routing), amount

API - receive payment, make payment, list accounts, show account

Metrics: how many transactions, how much money, how long to credit/debit, how often are debits declined
         due to lack of funds?

Logs: given an id, tell me what happened and which system/component dit it
      tell me if anything goes wrong

Error handling (queueing): ability to retry transient errors; dlq and ability to retry

liveness and readiness

Migrations

Config & env vars


following John Cinnamond's playlist : https://www.youtube.com/playlist?list=PL_xLFzLxV97f3Osv2Fz3wzGuWrdEE9pa2
